insert into dw_final.Time_Dimension
select  distinct * from dw_transactional.time ;

insert into dw_final.Store_Dimension
select  distinct * from dw_transactional.store ;

insert into dw_final.Product_Dimension
select  distinct * from dw_transactional.product ;