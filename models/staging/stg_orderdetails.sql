{{config(materialized='incremental', unique_key=['orderid','lineno'])}}

select a.*,b.orderdate from 
{{source('QWT_RAW','orderdetails')}} a
inner join {{source('QWT_RAW','orders')}} b
on a.orderid=b.orderid


{% if is_incremental() %}

where orderdate > (select max(orderdate) from {{this}} )

{% endif %}