import os
import datetime
import pymysql

# Get username from GitHub
username = os.getenv('C9_USER')

# Connect to the database
connection = pymysql.connect(host='localhost',
                            user=username,
                            password='',
                            db='Chinook')

try:
    with connection.cursor() as cursor:
        sql = "SELECT * FROM Artist;"
        cursor.execute(sql)
        result = cursor.fetchall()
        print(result)

    with connection.cursor() as cursor:
        sql = "SELECT * FROM Genre;"
        cursor.execute(sql)
        for row in cursor:
            print(row)

    with connection.cursor() as cursor:
        cursor.execute("CREATE TABLE IF NOT EXISTS Friends(Name char(20), age int, DOB datetime);")
        # Note that the above will display a warning(not error) if the table already exists

    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        sql = "SELECT * FROM Genre;"
        cursor.execute(sql)
        print("----This returns the query as a dictionary object showing key-value pairs---")
        for row in cursor:
            print(row)

finally:
    # Close the connection regardless of whether the above was successful.
    connection.close()
