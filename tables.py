"""CREATE SCHEMA `dw_staging` ;"""

transactional_tables = {}
transactional_tables[''] = ("")
transactional_tables[''] = ("")
transactional_tables[''] = ("")
transactional_tables[''] = ("")
transactional_tables[''] = ("")
transactional_tables[''] = ("")
transactional_tables[''] = ("")
transactional_tables[''] = ("")
transactional_tables[''] = ("")





dw_tables = {}
dw_tables['a_Product_Dimension'] = ("create table Product_Dimension(Product_Id int primary key,Description varchar(50),"
"Product_Group  varchar(50));")
dw_tables['b_Store_Dimension'] = "create table Store_Dimension(Store_Id int primary key,Location varchar(50),Postcode varchar(20));"
dw_tables['c_Customer_Dimension'] = (
"create table Customer_Dimension(Customer_Id int, Version int, Version_Date date, Cutomer_Name varchar(50),"
"Date_Of_Birth date,Postcode int,primary key(Customer_Id,Version),"
"index index_Customer_Postcode (Postcode)"
");"
)
dw_tables['d_Time_Dimension'] = """create table Time_Dimension(Time_Id int primary key, `Month` int, Quarter int, `Year` int, Season varchar(20),Is_Sunday boolean);"""
#create table Time_Dimension(Time_Id int primary key, `Month` int, Quarter int, `Year` int, Season varchar(20),Is_Sunday boolean);
dw_tables['e_Sale_Fact'] = (
"create table Sale_Fact(Sale_Id int, Time_Id int, Customer_Id int, Version int,Store_Id int,"
"Line int, Product_Id int,Total_Cost double"
",Unit_Sales double,Dollar_Sales double,Margin double,"
"primary key(Sale_Id , Line,Time_Id , Customer_Id , Version ,Store_Id , Product_Id ),"
"foreign key(Time_Id) references Time_Dimension(Time_Id),"
"foreign key (Customer_Id,Version) references Customer_Dimension(Customer_Id,Version),"
"foreign key(Store_Id) references Store_Dimension(Store_Id),"
"foreign key(Product_Id) references Product_Dimension(Product_Id));"

)
# create index index_Year ON  Time_Dimension(`Year`);
# create index index_Month ON  Time_Dimension(`Year`,`Month`);
# create index index_Quarter ON  Time_Dimension(`Year`,`Quarter`);
# create index index_Season ON  Time_Dimension(`Year`,`Season`);
# create index index_Customer_Postcode ON  Customer_Dimension(`Postcode`);

def create_database(cursor, DB_NAME):
    try:
        cursor.execute(
            "CREATE DATABASE if not exists {}".format(DB_NAME))
    except mysql.connector.Error as err:
        print("Failed creating database: {}".format(err))
        exit(1)
