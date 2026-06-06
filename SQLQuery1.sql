use test_env;

select * from new_table;

Create database PROD;

USE PROD;

select * from [dbo].[Prod+Env+Inventory+Dataset];

--1.Checking data issues
Select distinct Order_Date_DD_MM_YYYY 
from [dbo].[Prod+Env+Inventory+Dataset] 
Where Order_Date_DD_MM_YYYY is null or Order_Date_DD_MM_YYYY = '';

Select distinct Product_ID
from [dbo].[Prod+Env+Inventory+Dataset] order by Product_ID;


--The id in test env are 20 and in production data we have 22 prodduct id so we will email data engineering team and
--they said the id 22-->11 and id 21-->7 . so we will run update on both the product id

--data Cleaning and data updating
update [dbo].[Prod+Env+Inventory+Dataset] 
set Product_ID = 7 Where Product_ID = 21;

update [dbo].[Prod+Env+Inventory+Dataset] 
set Product_ID = 11 Where Product_ID = 22;

Select distinct availability from [dbo].[Prod+Env+Inventory+Dataset];

Select distinct demand from [dbo].[Prod+Env+Inventory+Dataset];

drop table new_table;

Select * into new_table from 
(Select a.[Order_Date_DD_MM_YYYY],a.product_id,a.demand,a.availability,b.product_name,b.unit_price 

from [dbo].[Prod+Env+Inventory+Dataset] as a
left join [dbo].[Products+(1)] as b on a.product_id=b.product_id) X

