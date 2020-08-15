import csv
import sys
import pathlib
import sqlite3


if len(sys.argv) != 2:
    print("Usage: python import.py database.csv")
    exit(1)

with open(sys.argv[1], "r", newline='') as database_file:
    reader = csv.reader(database_file)
    raw_data = list(reader)

headers = raw_data.pop(0)
db_path = pathlib.Path(sys.argv[0]).parent / 'students.db'

with open(db_path, "w") as file:
    pass

connection = sqlite3.connect(db_path)
cursor = connection.cursor()
cursor.execute(
    "CREATE TABLE students"
    "("
    "   id INTEGER,"
    "   first TEXT,"
    "   middle TEXT,"
    "   last TEXT,"
    "   house TEXT,"
    "   birth INTEGER,"
    "   PRIMARY KEY(id)"
    ");"
)
_id = 1
for item in raw_data:
    _name = item[0].split(' ')
    name = {
        'first': _name[0],
        'last': _name[-1],
        'middle': None
    }
    if len(_name) == 3:
        name['middle'] = _name[1]

    house = item[1]
    birth = item[2]

    cursor.execute(
        "INSERT INTO students"
        " (id, first, middle, last, house, birth) "
        "VALUES (?, ?, ?, ?, ?, ?);",
        (_id, name['first'], name['middle'], name['last'], house, birth)
    )
    _id += 1

cursor.close()
connection.commit()
connection.close()
