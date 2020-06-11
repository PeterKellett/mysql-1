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
    # SELECT
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

    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        sql = "SELECT * FROM Genre;"
        cursor.execute(sql)
        print("----This is a dictionary object showing key-value pairs---")
        for row in cursor:
            print(row)

    # CREATE Table
    with connection.cursor() as cursor:
        cursor.execute("CREATE TABLE IF NOT EXISTS Friends \
                        (Name char(20), age int, DOB datetime);")
        """Note that the above will display a warning(not error) \
        if the table already exists"""

    # INSERT INTO
    """with connection.cursor() as cursor:
        row = ("Bob", 21, "1999-04-04 23:04:34")
        cursor.execute("INSERT INTO Friends VALUES (%s, %s, %s);", row)
        connection.commit()"""

    with connection.cursor() as cursor:
        rows = [("Jim", 21, "1999-04-04 23:04:34"),
                ("Fred", 100, "1920-02-01 12:11:45"),
                ("Peter", 45, "1974-08-12 09:45:01")]
        cursor.executemany("INSERT INTO Friends VALUES (%s, %s, %s);", rows)
        connection.commit()

    # UPDATE
    with connection.cursor() as cursor:
        cursor.execute("UPDATE Friends SET age = 22 where Name = 'Bob'")
        connection.commit()

    # ALTERNATIVE UPDATE
    with connection.cursor() as cursor:
        cursor.execute("UPDATE Friends SET age = %s where Name = %s;",
                       (23, 'Bob'))
        connection.commit()

    # UPDATE MANY
    with connection.cursor() as cursor:
        rows = [(24, 'Bob'),
                (25, 'Jim'),
                (26, 'Fred')]
        cursor.executemany("UPDATE Friends SET age = %s where Name = %s;",
                           rows)
        connection.commit()

    # DELETE
    """with connection.cursor() as cursor:
        cursor.execute("DELETE FROM Friends WHERE Name = 'Bob';")
        connection.commit()"""

    # Alternate DELETE
    """with connection.cursor() as cursor:
        cursor.execute("DELETE FROM Friends WHERE Name = %s;", 'Bob')
        connection.commit()"""

    # DELETE Many
    """with connection.cursor() as cursor:
        cursor.executemany("DELETE FROM Friends WHERE Name = %s;",
                           ['Bob', 'Jim'])
        connection.commit()"""

    # DELETE WHERE IN
    with connection.cursor() as cursor:
        list_of_names = ['Jim', 'Bob']
        # Prepare string with same number of placeholders as in list_of_names
        format_strings = ','.join(['%s']*len(list_of_names))
        cursor.execute("DELETE FROM Friends WHERE name in ({});"
                       .format(format_strings), list_of_names)
        connection.commit()
finally:
    # Close the connection regardless of whether the above was successful.
    connection.close()
