create database if not exists dw_final_data_warehouse;

create table dw_final_data_warehouse.Product_Dimension(Product_Id int primary key,Description TINYTEXT,
Product_Group  varchar(50));

create table dw_final_data_warehouse.Store_Dimension(Store_Id int primary key,Location varchar(50),Postcode varchar(20));

create table dw_final_data_warehouse.Customer_Dimension(Customer_Id varchar(50), Version int, Version_Date date, Cutomer_Name varchar(50),
Date_Of_Birth date,Postcode int,primary key(Customer_Id,Version),
index index_Customer_Postcode (Postcode));

CREATE TABLE dw_final_data_warehouse.Time_Dimension
(
  Time_Id int primary key
, Date DATE
, DayOfWeek varchar(50)
, Month varchar(50)
, Quarter int
, Year int
, Day int
, Season varchar(50)
)
;

create table dw_final_data_warehouse.Sale_Fact(Sale_Id int NOT NULL AUTO_INCREMENT, Time_Id int, Customer_Id varchar(50), Version int,Store_Id int,
Product_Id int,Total_Cost double
,Unit_Sales double,Dollar_Sales double,Margin double,
primary key(Sale_Id, Time_Id , Customer_Id , Version ,Store_Id , Product_Id ),
foreign key(Time_Id) references dw_final_data_warehouse.Time_Dimension(Time_Id),
foreign key (Customer_Id,Version) references dw_final_data_warehouse.Customer_Dimension(Customer_Id,Version),
foreign key(Store_Id) references dw_final_data_warehouse.Store_Dimension(Store_Id),
foreign key(Product_Id) references dw_final_data_warehouse.Product_Dimension(Product_Id));
