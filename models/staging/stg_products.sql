{{config(materialized='table')}}

select 
PRODUCT_ID as productid,
PRODUCT_NAME as productname,
SUPPLIER_ID as supplierid,
CATEGORY_ID as categoryid,
QUANTITY_PER_UNIT as quantityperunit,
UNIT_COST as unitcost,
UNIT_PRICE as unitprice,
UNITS_IN_STOCK as unitsinstock,
UNITS_ON_ORDER as unitsonorder
from 
{{source('QWT_RAW','products')}}