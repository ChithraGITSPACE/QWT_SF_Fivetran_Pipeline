{{config(materialized='incremental', unique_key=['orderid','lineno'])}}

select 
a.ORDER_ID as orderid,
a.LINE_NO as lineno,
a.PRODUCT_ID as productid,
a.QUANTITY,
a.UNIT_PRICE as unitprice,
a.DISCOUNT,
b.order_date as orderdate
from 
{{source('QWT_RAW','orderdetails')}} a
inner join {{source('QWT_RAW','orders')}} b
on a.order_id=b.order_id


{% if is_incremental() %}

where order_date > (select max(orderdate) from {{this}} )

{% endif %}