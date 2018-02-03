import mysql.connector as sql
from mysql.connector import errorcode
# pip install mysql-connector-python
import pandas as pd

from Util import Util
import tables


def createDatawarehouseTables():
    host = Util.getConfig('mysql_host')
    transactionalDBSchema = Util.getConfig('transactional_schema')
    dataWarehouseSchema = Util.getConfig('data_warehouse_schema')
    username = Util.getConfig('username')
    password = Util.getConfig('password')

    db_connection = sql.connect(host = host, user = username, password = password)
    cursor = db_connection.cursor()

    DB_NAME = dataWarehouseSchema
    try:
        db_connection.database = DB_NAME
    except sql.Error as err:
        if err.errno == errorcode.ER_BAD_DB_ERROR:
            tables.create_database(cursor, DB_NAME)
            db_connection.database = DB_NAME
        else:
            print(err)
            exit(1)
    for name, ddl in sorted(tables.dw_tables.items()):
        try:
            print("Creating table {}: ".format(name), end='')
            cursor.execute(ddl)
        except sql.Error as err:
            if err.errno == errorcode.ER_TABLE_EXISTS_ERROR:
                print("already exists.")
            else:
                print(err.msg)
        else:
            print("OK")

    cursor.close()
    db_connection.close()

createDatawarehouseTables()
# df = pd.read_sql('SELECT * FROM dw_workshop5.customer1', con=db_connection)
# print(df)





















"""End of file"""
