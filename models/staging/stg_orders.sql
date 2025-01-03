{{config(materialized='incremental', unique_key='orderid')}}

select 
ORDER_ID as orderid,
ORDER_DATE as orderdate,
CUSTOMER_ID as customerid,
EMPLOYEE_ID as employeeid,
SHIPPER_ID as shipperid,
FREIGHT  
from 
{{source('QWT_RAW','orders')}}

{% if is_incremental() %}

where orderdate > (select max(orderdate) from {{this}} )

{% endif %}