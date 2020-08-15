import sys
import re
import csv

# if there are too many or too few arguments
if len(sys.argv) != 3:
    print("Usage: python dna.py database.csv sequence.txt")
    exit(1)

# reading the database (csv) file
with open(sys.argv[1], "r", newline='') as database_file:
    reader = csv.reader(database_file)
    # converting the read data to lists for easier processing
    raw_database = [row for row in reader]

# reading the sequence file
with open(sys.argv[2], "r") as sequence_file:
    sequence = sequence_file.read()

# headers are the first row of the csv file which define the name of the field like name, and the STR of the DNA
header = raw_database.pop(0)


# given a DNA STR label this function finds the maximum number of times it occurs consecutively  in a given string
def max_repeats(pattern: str, string: str) -> int:
    _pattern = re.compile(f'(({pattern})+)')
    matches = [match[0] for match in re.findall(_pattern, string)]
    repeats = max((len(match) // len(pattern) for match in matches), default=0)
    return repeats


match_counts = [max_repeats(label, sequence) for label in header[1:]]
match_string = ','.join((str(i) for i in match_counts))

for row in raw_database:
    if match_string in ','.join((str(i) for i in row)):
        print(row[0])
        exit(0)

print("No match")
exit(0)
