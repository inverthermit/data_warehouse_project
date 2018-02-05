insert into dw_final.Time_Dimension
select  distinct * from dw_transactional.time ;

insert into dw_final.Store_Dimension
select  distinct * from dw_transactional.store ;

insert into dw_final.Product_Dimension
select  distinct * from dw_transactional.product ;

insert into dw_final.Sale_Dimension


select *,(Dollar_Sales*100 - Total_Cost*100)/100 as Margin from 
(select SaleItem.SaleID,LineID,SaleItem.Units, real_cost_per_item.CostPerItem,SaleItem.Units* real_cost_per_item.CostPerItem as Total_Cost
from dw_transactional.SaleItem, 
(select *,
   (select  CostPerItem
    from dw_transactional.ProductOrder where ProductOrder.Date <= New_SaleDate.Date and ProductOrder.ID = New_SaleDate.ProductID
    order by  ProductOrder.Date desc  limit 1) as CostPerItem
from 
(select saledate.SaleID,Date,S.ProductID from dw_transactional.Sale as saledate
inner join (select SaleID,ProductID from  dw_transactional.SaleItem) as S
where saledate.SaleID = S.SaleID) as New_SaleDate ) as real_cost_per_item

where dw_transactional.SaleItem.productID = real_cost_per_item.ProductID) as T,
(select SaleItem.SaleID,LineID,SaleItem.Units, SaleItem.UnitPrice,SaleItem.Units* UnitPrice as Dollar_Sales
from dw_transactional.SaleItem) as D where T.SaleID = D.saleID and T.LineID = D.LineID;

