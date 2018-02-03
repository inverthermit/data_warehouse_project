CREATE SCHEMA if not exists `dw_staging`; 

CREATE TABLE dw_staging.Product
(
  ID DOUBLE
, Description TINYTEXT
, `Group` TINYTEXT
)
;
CREATE TABLE dw_staging.ProductOrder
(
  ID DOUBLE
, Date DATETIME
, Description TINYTEXT
, Quantity DOUBLE
, CostPerItem DOUBLE
)
;

CREATE TABLE dw_staging.ProductPriceList
(
  ID DOUBLE
, Description TINYTEXT
, UnitPrice DOUBLE
, ValidUntilDate DATETIME
)
;

CREATE TABLE dw_staging.Sale
(
  SaleID TINYTEXT
, Cust_Key TINYTEXT
, StoreID DOUBLE
, Date DATETIME
)
;

CREATE TABLE dw_staging.SaleItem
(
  SaleID TINYTEXT
, LineID DOUBLE
, ProductID DOUBLE
, Units DOUBLE
, UnitPrice DOUBLE
)
;

CREATE TABLE dw_staging.Store
(
  StoreID DOUBLE
, Description TINYTEXT
, Postcode DOUBLE
)
;

CREATE TABLE dw_staging.Customer
(
  CustCode VARCHAR(100)
, Name VARCHAR(100)
, Postcode DECIMAL(65)
, `Date of Birth` TINYTEXT
, Validuntil TINYTEXT
)
;

CREATE TABLE dw_staging.Time
(
  Date_Key DOUBLE
, Date TINYTEXT
, DayOfWeek TINYTEXT
, Month TINYTEXT
, Quarter TINYTEXT
, Year DOUBLE
, Day DOUBLE
, Season TINYTEXT
)
;