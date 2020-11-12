import os
from time import gmtime, strftime

from cs50 import SQL
from flask import Flask, flash, redirect, render_template, request, session
from flask_session import Session
from tempfile import mkdtemp
from werkzeug.exceptions import default_exceptions, HTTPException, InternalServerError
from werkzeug.security import check_password_hash, generate_password_hash


from helpers import apology, login_required, usd, lookup


# Configure application
app = Flask(__name__)

# Ensure templates are auto-reloaded
app.config["TEMPLATES_AUTO_RELOAD"] = True


# Ensure responses aren't cached
@app.after_request
def after_request(response):
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response


# Custom filter
app.jinja_env.filters["usd"] = usd

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_FILE_DIR"] = mkdtemp()
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Configure CS50 Library to use SQLite database
db = SQL("sqlite:///finance.db")

# Make sure API key is set
if not os.environ.get("API_KEY"):
    raise RuntimeError("API_KEY not set")


@app.route("/")
@login_required
def index():
    """Show portfolio of stocks"""

    """
    stocks contains rows having the following data:
    -> user_id - the id of the user who owns the stock
    -> amount - the quantity of stocks they have of a particular company
    -> company - the company
    -> purchase_price - the price at which the stock was bought
    """
    raw_stocks = db.execute("SELECT * FROM stocks WHERE user_id = :user_id", user_id=session['user_id'])
    stocks = list()
    counter = 1
    total = 0.0
    for stock in raw_stocks:
        current_price = float(lookup(stock['symbol'])['price'])
        current_total = int(stock['amount']) * current_price
        stocks.append(
            (
                counter,
                stock['symbol'],
                stock['amount'],
                current_price,
                current_total
            )
        )
        counter += 1
        total = total + current_total

    cash = db.execute("SELECT cash FROM users WHERE id = :user_id", user_id=session['user_id'])
    cash = cash[0]['cash'] if cash else 0.0

    return render_template('index.html', cash=cash, stocks=stocks, total=total, usd=usd)


@app.route("/buy", methods=["GET", "POST"])
@login_required
def buy():
    """Buy shares of stock"""
    if request.method in ('POST',):
        symbol = request.form.get("symbol_name")
        quantity = int(request.form.get("quantity"))

        quote_symbol = lookup(symbol)
        if not quote_symbol:
            flash("No such symbol found, please check your input", "danger")
            return render_template('buy.html', bought=False)

        name = quote_symbol['name']
        price = quote_symbol['price']
        cash = db.execute("SELECT cash FROM users WHERE id = :user_id", user_id=session['user_id'])
        cash = cash[0]['cash'] if cash else 0.0

        transaction_amount = price * quantity
        if transaction_amount > cash:
            flash("Not enough cash", "danger")
            return render_template('buy.html', bought=False)

        exists = db.execute("SELECT * FROM stocks WHERE user_id = :user_id AND symbol = :symbol",
                            user_id=session['user_id'], symbol=symbol)
        exists = exists[0] if exists else None
        new_stocks = quantity
        if exists is None:
            db.execute(
                "INSERT INTO stocks (user_id, amount, symbol) VALUES (:user_id, :amount, :symbol)",
                user_id=session['user_id'],
                amount=quantity,
                symbol=symbol,
            )
        else:
            current_stocks = exists['amount']
            new_stocks = current_stocks + quantity
            db.execute(
                "UPDATE stocks SET amount = :amount WHERE user_id = :user_id AND symbol = :symbol",
                amount=new_stocks,
                user_id=session['user_id'],
                symbol=symbol
            )

        # record history
        db.execute(
            "INSERT INTO history (user_id, company, amount, price, action, total, time, symbol) "
            "VALUES (:user_id, :name, :amount, :price, :action, :total, :time, :symbol)",
            user_id=session['user_id'],
            name=name,
            amount=quantity,
            price=price,
            action="BUY",
            total=transaction_amount,
            time=strftime("%Y-%m-%d %H:%M:%S", gmtime()),
            symbol=symbol
        )

        # update cash
        db.execute(
            "UPDATE users SET cash = :cash WHERE id = :user_id",
            cash=(cash - transaction_amount),
            user_id=session['user_id']
        )
        return render_template(
            'buy.html',
            bought=True,
            name=name,
            transaction_amount=transaction_amount,
            cash=(cash - transaction_amount),
            price=price,
            quantity=quantity,
            total_shares=new_stocks,
            symbol=symbol,
            usd=usd
        )
    else:
        return render_template('buy.html', bought=False)


@app.route("/history")
@login_required
def history():
    """Show history of transactions"""
    raw_history = db.execute(
        "SELECT * FROM history WHERE user_id = :user_id",
        user_id=session['user_id']
    )
    if not raw_history:
        return render_template('history.html', no_history=True)

    counter = 1
    total = 0
    transaction_history = list()
    for item in raw_history:
        per_item_template = (
            counter,
            item['company'],
            item['symbol'],
            item['amount'],
            item['price'],
            item['action'],
            item['total'],
            item['time']
        )
        counter += 1
        total += item["total"]
        transaction_history.append(per_item_template)

    transactions = len(raw_history)
    return render_template(
        'history.html',
        history=transaction_history,
        no_history=False,
        transactions=transactions,
        usd=usd,
        total=total
    )


@app.route("/login", methods=["GET", "POST"])
def login():
    """Log user in"""

    # Forget any user_id
    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":

        # Ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username", 403)

        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 403)

        # Query database for username
        rows = db.execute("SELECT * FROM users WHERE username = :username",
                          username=request.form.get("username"))

        # Ensure username exists and password is correct
        if len(rows) != 1 or not check_password_hash(rows[0]["hash"], request.form.get("password")):
            flash("Invalid username and/or password", "danger")
            return render_template('login.html')

        # Remember which user has logged in
        session["user_id"] = rows[0]["id"]

        # Redirect user to home page
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")


@app.route("/logout")
def logout():
    """Log user out"""

    # Forget any user_id
    session.clear()

    # Redirect user to login form
    return redirect("/")


@app.route("/quote", methods=["GET", "POST"])
@login_required
def quote():
    """Get stock quote."""

    if request.method in ('POST',):
        stock_name = request.form.get("stock_name")
        data = lookup(stock_name)

        if data:
            return render_template(
                'quote.html',
                name=data['name'],
                price=data['price'],
                symbol=data['symbol'],
                usd=usd,
                quoted=True
            )
        else:
            flash("Symbol not found", "danger")
            return render_template('quote.html', quoted=False)
    else:
        return render_template('quote.html', quoted=False)


@app.route("/register", methods=["GET", "POST"])
def register():
    """Register user"""

    # if user is posting data
    if request.method in ('POST',):
        username = None if not request.form.get("username") else request.form.get("username")
        email = None if not request.form.get("email") else request.form.get("email")
        password = None if not request.form.get("password") else generate_password_hash(request.form.get("password"))
        confirm_password = True if password and request.form.get('confirm_password') else False

        # checking for empty values
        if None in (username, email, password):
            if all((_ is None for _ in (username, email, password))):
                flash("All fields are required", "danger")
                return render_template('register.html')
            elif username is None:
                flash("Username is required", "danger")
                return render_template('register.html')
            elif email is None:
                flash("Email is required", "danger")
                return render_template('register.html')
            elif password is None:
                flash("Password is required", "danger")
                return render_template('register.html')
        elif not confirm_password:
            flash("Confirm password cannot be empty", "danger")
            return render_template('register.html')

        # querying if username already exists
        db_username = db.execute(
            "SELECT * FROM users "
            "WHERE username = :username",
            username=username
        )

        # querying if email already exists
        db_email = db.execute(
            "SELECT * FROM users "
            "WHERE email = :email",
            email=email
        )

        # the username exists and thus this username cannot be chosen
        if db_username:
            flash("Username already exists", "danger")
            return render_template('register.html')

        # email is already registered
        elif db_email:
            flash("Email already registered", "danger")
            return render_template('register.html')

        # passwords do not match
        elif not check_password_hash(password, request.form.get('confirm_password')):
            flash("Confirm password should match the password", "danger")
            return render_template('register.html')

        # all checks passed so now we can pass on the information to our database
        db.execute(
            "INSERT INTO users (username, email, hash) "
            "VALUES (:username,:email,:password)",
            username=username,
            email=email,
            password=password
        )

        flash("Your account has been registered successfully. You can now login.", "success")
        return render_template('login.html')

    return render_template('register.html')


@app.route("/sell", methods=["GET", "POST"])
@login_required
def sell():
    """Sell shares of stock"""
    if request.method in ("POST",):
        symbol = request.form.get('symbol_name')
        quantity = int(request.form.get('quantity'))

        stock_info = lookup(symbol)
        if not stock_info:
            flash("No such symbol found, please check the input", "danger")
            return render_template('sell.html', sold=False)

        owned = db.execute(
            "SELECT * FROM stocks WHERE user_id = :user_id AND symbol = :symbol",
            user_id=session['user_id'],
            symbol=symbol
        )
        if not owned:
            flash("You do not own shares for That stock", "danger")
            return render_template('sell.html', sold=False)
        else:
            owned = owned[0]

        # checking if user has enough stocks to sell
        if owned['amount'] < quantity:
            flash(f"You do not own {quantity} shares!", "danger")
            return render_template('sell.html', sold=False)

        name = stock_info['name']
        price = stock_info['price']
        transaction_amount = quantity * float(price)
        total_stocks = owned['amount'] - quantity

        cash = db.execute(
            "SELECT * FROM users WHERE id = :user_id",
            user_id=session['user_id']
        )
        if cash:
            cash = cash[0]['cash']
        else:
            flash("There was an error trying to process your request, please try again", "danger")
            return render_template('login.html')

        cash_remaining = cash + transaction_amount

        db.execute(
            "UPDATE stocks SET amount = :total_stocks WHERE user_id = :user_id AND symbol = :symbol",
            user_id=session['user_id'],
            symbol=symbol,
            total_stocks=total_stocks
        )

        # record history
        db.execute(
            "INSERT INTO history (user_id, company, amount, price, action, total, time, symbol) "
            "VALUES (:user_id, :name, :amount, :price, :action, :total, :time, :symbol)",
            user_id=session['user_id'],
            name=name,
            amount=quantity,
            price=price,
            action="SELL",
            total=transaction_amount,
            time=strftime("%Y-%m-%d %H:%M:%S", gmtime()),
            symbol=symbol
        )

        # update cash
        db.execute(
            "UPDATE users SET cash = :cash WHERE id = :user_id",
            user_id=session['user_id'],
            cash=cash_remaining
        )
        return render_template(
            'sell.html',
            sold=True,
            name=name,
            transaction_amount=transaction_amount,
            cash=cash_remaining,
            price=price,
            quantity=quantity,
            total_shares=total_stocks,
            symbol=symbol,
            usd=usd
        )
    else:
        return render_template('sell.html', sold=False)


def errorhandler(e):
    """Handle error"""
    if not isinstance(e, HTTPException):
        e = InternalServerError()
    return apology(e.name, e.code)


@app.route('/add', methods=['GET', 'POST'])
@login_required
def add():
    """
    Add cash to your account
    """
    if request.method in ('POST',):
	    amount = float(request.form.get('amount'))
	    cash = db.execute(
	        "SELECT * FROM users WHERE id = :user_id",
	        user_id=session['user_id']
	    )
	    if not cash:
	        flash("Something went wrong somewhere. Please try again later.", "danger")
	        return render_template('add.html', added=False)
	    else:
	        cash = cash[0]['cash']

	    db.execute(
	        "UPDATE users SET cash = :total WHERE id = :user_id",
	        user_id=session['user_id'],
	        total=(cash + amount)
	    )
	    return render_template('add.html', cash=(cash + amount), transaction_amount=amount, added=True, usd=usd)
	else:
		return render_template('add.html', added=False)


# Listen for errors
for code in default_exceptions:
    app.errorhandler(code)(errorhandler)
