import sys
import sqlite3
import pathlib


if len(sys.argv) != 2:
    print("Usage: python roster.py House Name")
    exit(1)

db_file = pathlib.Path(sys.argv[0]).parent / 'students.db'
if not db_file.exists():
    print(f"{db_file} does not exist")
    exit(1)

connection = sqlite3.connect(db_file)
cursor = connection.cursor()

cursor.execute(
    "SELECT students.first, students.middle,students.last,students.birth FROM students "
    "WHERE students.house = ? "
    "ORDER BY students.last ASC, students.first ASC;",
    (sys.argv[1],)
)
data = cursor.fetchall()
for item in data:
    if item[1] is not None:
        name = f'{item[0]} {item[1]} {item[2]}'
    else:
        name = f'{item[0]} {item[2]}'

    birth = item[3]
    string = f'{name}, born {birth}'
    print(string)

cursor.close()
connection.close()
