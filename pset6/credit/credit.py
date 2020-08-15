credit = "string"
while not credit.isnumeric():
    credit = input("Number: ")
    if all(c.isdigit() for c in credit) and credit:
        break

if not 12 < len(credit) < 20:
    print("INVALID")
    exit(1)

twice = False
sum_ = 0
for character in credit[::-1]:
    if twice:
        temp = 2 * int(character)
        temp = temp if temp < 10 else temp - 9
        sum_ += temp
        twice = False
    else:
        sum_ += int(character)
        twice = True

if sum_ % 10:
    print("INVALID")
    exit(1)

if credit[0:2] in ('34', '37'):
    print("AMEX")
    exit(0)
elif credit[0:2] in (str(x) for x in range(51, 56)):
    print("MASTERCARD")
    exit(0)
elif credit[0] in '4':
    print("VISA")
    exit(0)
else:
    print("INVALID")
    exit(1)
