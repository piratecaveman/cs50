cash: str = "number"
while not cash.isnumeric():
    cash: str = input("Change owed: ")
    if all((c.isdigit() or (c == '.')) for c in cash) and cash:
        break

cash: int = int(float(cash) * 100)
change: int = 0

while 25 <= cash:
    change: int = change + cash // 25
    cash: int = cash % 25

while 10 <= cash:
    change: int = change + cash // 10
    cash: int = cash % 10

while 5 <= cash:
    change: int = change + cash // 5
    cash: int = cash % 5

change: int = change + cash
print(change)
