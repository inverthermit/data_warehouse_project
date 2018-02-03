CREATE SCHEMA if not exists `dw_transactional`; 

CREATE TABLE dw_transactional.Product
(
  ID DOUBLE
, Description TINYTEXT
, `Group` TINYTEXT
,primary key (ID)
)
;
CREATE TABLE dw_transactional.ProductOrder
(
  ID DOUBLE
, Date DATETIME
, Description TINYTEXT
, Quantity DOUBLE
, CostPerItem DOUBLE
, foreign key(ID)references dw_transactional.Product(ID) 
)
;

CREATE TABLE dw_transactional.ProductPriceList
(
  ID DOUBLE
, Description TINYTEXT
, UnitPrice DOUBLE
, ValidUntilDate DATETIME
, primary key(ID, ValidUntilDate)
, foreign key(ID)references dw_transactional.Product(ID)
)
;


CREATE TABLE dw_transactional.Customer
(
  CustCode VARCHAR(100)
, Name VARCHAR(100)
, Postcode DECIMAL(65)
, `Date of Birth` VARCHAR(100)
, Validuntil VARCHAR(100)
, primary key(CustCode, Name, Postcode, `Date of Birth`)
)
;


CREATE TABLE dw_transactional.Store
(
  StoreID DOUBLE primary key
, Description TINYTEXT
, Postcode DOUBLE
)
;


CREATE TABLE dw_transactional.Sale
(
  SaleID VARCHAR(100) primary key
, Cust_Key VARCHAR(100) 
, StoreID DOUBLE
, Date DATETIME
, foreign key(Cust_Key) references dw_transactional.Customer(CustCode)
, foreign key(StoreID) references dw_transactional.Store(StoreID)
)
;

CREATE TABLE dw_transactional.SaleItem
(
  SaleID VARCHAR(100)
, LineID DOUBLE
, ProductID DOUBLE
, Units DOUBLE
, UnitPrice DOUBLE
, primary key (SaleID, LineID)
, foreign key(SaleID) references dw_transactional.Sale(SaleID)
, foreign key(ProductID) references dw_transactional.Product(ID)
)
;



CREATE TABLE dw_transactional.Time
(
  Date_Key DOUBLE primary key
, Date TINYTEXT
, DayOfWeek TINYTEXT
, Month TINYTEXT
, Quarter TINYTEXT
, Year DOUBLE
, Day DOUBLE
, Season TINYTEXT
)
;