{{config(materialized='table', schema='transforming')}}

select 
o.orderid,
o.orderdate,
o.customerid,
o.employeeid,
g.productid,
g.productname,
h.quantity,
((h.unitprice*h.quantity)*(1-h.discount))as linesalesamount,
to_number((g.unitcost * h.quantity),20, 2) as cost_of_goods_sold,
to_number(((h.unitprice*h.quantity) * ((1-h.discount)-(g.unitcost*h.quantity))),20, 2)as  margin
from 
{{ref('stg_products')}} as g inner join
{{ref('stg_orderdetails')}} as h on g.productid=h.productid inner join
{{ref('stg_orders')}} as o on h.orderid=o.orderid
