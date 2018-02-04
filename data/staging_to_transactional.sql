insert into dw_transactional.Customer_Code_Unique
select distinct CustCode from ( 
 select replace ( cidnowill,'SthMelb',' ') as CustCode,Name,Postcode,`Date of Birth` ,Validuntil from
((select *,replace( cidnocarl,'Will',' ') as cidnowill from
 
 ((select * , replace(CustCode,'Carl' ,' ') as cidnocarl from 
 
 dw_staging.customer) as C)) as W)) as newcustomer ;

insert into dw_transactional.customer
select distinct * from ( 
 select replace ( cidnowill,'SthMelb',' ') as CustCode,Name,Postcode,`Date of Birth` ,Validuntil from
((select *,replace( cidnocarl,'Will',' ') as cidnowill from
 
 ((select * , replace(CustCode,'Carl' ,' ') as cidnocarl from 
 
 dw_staging.customer) as C)) as W)) as newcustomer ;
 

insert into dw_transactional.product
select  distinct * from dw_staging.product ;

insert into dw_transactional.store
select  distinct * from dw_staging.store ;

insert into dw_transactional.productorder
select  distinct * from dw_staging.productorder ;

insert into dw_transactional.productpricelist
select  distinct * from dw_staging.productpricelist ;

insert into dw_transactional.sale
select distinct * from (select SaleID, replace ( cidnowill,'SthMelb',' ') as Cust_Key, StoreID,Date from

((select *,replace( cidnocarl,'Will',' ') as cidnowill from
 
 ((select *, replace(Cust_Key,'Carl' ,' ') as cidnocarl from 
 
 dw_staging.sale) as C)) as W)) as newsale;

insert into dw_transactional.saleitem
select  distinct * from dw_staging.saleitem ;


insert into dw_transactional.time
select  distinct * from dw_staging.time ;
