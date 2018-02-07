import mysql.connector as sql
from mysql.connector import errorcode
# pip install mysql-connector-python

from sqlalchemy import create_engine
# pip install Flask-SQLAlchemy
# pip install mysqlclient
import pandas as pd

from Util import Util


host = Util.getConfig('mysql_host')
transactionalDBSchema = Util.getConfig('transactional_schema')
dataWarehouseSchema = Util.getConfig('data_warehouse_schema')
username = Util.getConfig('username')
password = Util.getConfig('password')

db_connection = sql.connect(host = host, user = username, password = password)

df = pd.read_sql('SELECT * FROM '+transactionalDBSchema+'.customer', con=db_connection)
df = df.rename(columns={'CustCode': 'Customer_Id', 'Name': 'Cutomer_Name', 'Postcode': 'Postcode', 'Date of Birth': 'Date_Of_Birth'
, 'Validuntil': 'Version_Date'})
df['Postcode'] = df['Postcode'].astype(int)

df.sort_values(['Customer_Id', 'Version_Date'], ascending=[False, False])

# print(df[['Customer_Id', 'Version_Date']][::-1])

lastRowCustomerId = ''
versionNum = 1
df['Version'] = versionNum
versionColumnNum = df.columns.get_loc('Version')
for index, row in df[::-1].iterrows():
    cid = row['Customer_Id']
    # print(cid, lastRowCustomerId)
    # print(cid == lastRowCustomerId)
    if(cid == lastRowCustomerId):
        versionNum += 1
        # print(versionNum)
    else:
        versionNum = 1
    # row['Version']   = versionNum
    df.iloc[index, versionColumnNum] = versionNum
    lastRowCustomerId = cid

# print(df[['Customer_Id', 'Version_Date', 'Version']])
# df.to_sql(con=db_connection, schema = dataWarehouseSchema,name= 'Customer_Dimension', if_exists='append', index  = None)
df['Date_Of_Birth'] =  pd.to_datetime(df['Date_Of_Birth'], format='%d/%m/%Y')
df['Version_Date'] =  pd.to_datetime(df['Version_Date'], format='%d/%m/%Y')

# print(df)

db_connection.close()

engine = create_engine('mysql://'+username+':'+password+'@'+host+'/'+dataWarehouseSchema)
con = engine.connect()
df.to_sql(schema = dataWarehouseSchema, name='customer_dimension',con=con,if_exists='append', index = None)
con.close()
















"""End of file"""
