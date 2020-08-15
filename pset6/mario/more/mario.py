height: str = "string"
while not height.isdigit():
    height: str = input("Height: ")
    if height.isdigit():
        while not 0 < int(height) < 9:
            height: str = "string"
            break

height: int = int(height)
for i in range(height):
    current = "#" * (i + 1)
    print(current.rjust(height, ' '), end='  ')
    print(current)
