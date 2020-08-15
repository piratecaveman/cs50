text: str = input("Text: ")

# the alphabets
alpha: str = 'abcdefghijklmnopqrstuvwxyz'
letters: int = 0
words: int = 1
sentences: int = 0
for char in text:
    if (char in alpha) or (char in alpha.upper()):
        letters += 1
    elif char in (' ',):
        words += 1
    elif char in ('!', '.', '?'):
        sentences += 1
    else:
        continue

L: float = 100 * letters / words
S: float = 100 * sentences / words

index: int = round(0.0588 * L - 0.296 * S - 15.8)
if index < 1:
    print("Before Grade 1")
elif index > 16:
    print("Grade 16+")
else:
    print(f"Grade {index}")
