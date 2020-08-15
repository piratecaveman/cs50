height = "string"
while not height.isdigit():
    height = input("Height: ")
    if height.isdigit():
        while not 0 < int(height) < 9:
            height = "string"
            break

height = int(height)
for i in range(height):
    current = "#" * (i + 1)
    print(current.rjust(height, ' '))
