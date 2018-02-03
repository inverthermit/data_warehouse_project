insert into dw_transactional.customer
select distinct * from dw_staging.customer ;

insert into dw_transactional.product
select  distinct * from dw_staging.product ;

insert into dw_transactional.store
select  distinct * from dw_staging.store ;

insert into dw_transactional.productorder
select  distinct * from dw_staging.productorder ;

insert into dw_transactional.productpricelist
select  distinct * from dw_staging.productpricelist ;

insert into dw_transactional.sale
select distinct * from dw_staging.sale ;

insert into dw_transactional.saleitem
select  distinct * from dw_staging.saleitem ;


insert into dw_transactional.time
select  distinct * from dw_staging.time ;
