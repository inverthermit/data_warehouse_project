insert into dw_final_data_warehouse.Time_Dimension
select  distinct * from dw_transactional.time ;

insert into dw_final_data_warehouse.Store_Dimension
select  distinct * from dw_transactional.store ;

insert into dw_final_data_warehouse.Product_Dimension
select  distinct * from dw_transactional.product ;

create temporary table dw_final_data_warehouse.New_SaleDate
as (
select *,
   (select  CostPerItem
    from dw_transactional.ProductOrder where ProductOrder.Date <= New_SaleDate.Date and ProductOrder.ID = New_SaleDate.ProductID
    order by  ProductOrder.Date desc  limit 1) as CostPerItem, (UnitPrice*Units) as dollar_sales
from 
	(
	select saledate.SaleID,Date,S.ProductID, S.Units, S.UnitPrice, Cust_Key, StoreID
	from dw_transactional.Sale as saledate inner join (select * from  dw_transactional.SaleItem) as S
	where saledate.SaleID = S.SaleID
	) as New_SaleDate
    );

create temporary table dw_final_data_warehouse.temp_all_except_version as(
select Customer_id, StoreID, ProductID, unit_sales, total_cost, dollar_sales, margin, Date_Key, fact_except_for_time.Date as Date
from
(
select Cust_Key as Customer_id, StoreID, ProductID, Units as unit_sales, total_cost, dollar_sales
, floor((dollar_sales*100-total_cost*100)+0.1)/100 as margin , Date
from(
select *, (Units*(CostPerItem*100))/100 as total_cost
from dw_final_data_warehouse.New_SaleDate) as temp3)as fact_except_for_time, dw_transactional.time
where fact_except_for_time.Date = dw_transactional.time.Date);


create temporary table dw_final_data_warehouse.unique_customerid_Date_customer_version_date as(
select t.Customer_id, Date,min(new_version_date) as customer_version_date
from
(select distinct customer_id,Date from dw_final_data_warehouse.temp_all_except_version) as t,
(SELECT Customer_Id,CASE WHEN version_date IS NULL THEN CURDATE() ELSE version_date END as new_version_date
			FROM dw_final_data_warehouse.customer_dimension) as table2

where t.Customer_id= table2.Customer_id and t.Date <= table2.new_version_date
group by t.Customer_id, Date);

create temporary table dw_final_data_warehouse.unique_customerid_Date_version as(
select table1.Customer_id, Date, Version from dw_final_data_warehouse.unique_customerid_Date_customer_version_date as table1,
			(SELECT Customer_Id,version,CASE WHEN version_date IS NULL THEN CURDATE() ELSE version_date END as new_version_date
			FROM dw_final_data_warehouse.customer_dimension) as table2
where table1.customer_id =  table2.Customer_Id
and table1.customer_version_date = table2.new_version_date
);


insert into dw_final_data_warehouse.sale_fact (Time_Id, Customer_Id, Version,Store_Id, Product_Id,Total_Cost, Unit_Sales,Dollar_Sales,Margin)
select Date_Key as Time_Id, t1.Customer_id, Version,
    StoreID, ProductID,  total_cost, unit_sales, dollar_sales, margin
from dw_final_data_warehouse.temp_all_except_version as t1, dw_final_data_warehouse.unique_customerid_Date_version as t2
where t1.Customer_id = t2.Customer_id and t1.Date = t2.Date	;

