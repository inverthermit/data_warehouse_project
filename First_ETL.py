import mysql.connector as sql
# pip install mysql-connector-python
import pandas as pd

from Util import Util

host = Util.getConfig('mysql_host')
database = Util.getConfig('staging_schema')
username = Util.getConfig('username')
password = Util.getConfig('password')

db_connection = sql.connect(host=host, database=database,
                            user=username, password=password)
df = pd.read_sql('SELECT * FROM dw_workshop5.customer1', con=db_connection)
print(df)




















"""End of file"""
