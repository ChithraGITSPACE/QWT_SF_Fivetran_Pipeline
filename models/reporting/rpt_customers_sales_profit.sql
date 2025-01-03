{{config(materialized='table', schema='reporting')}}

select 
o.companyname,
o.contactname,
min(n.orderdate) as first_order_date,
max(n.orderdate) as recent_order_date,
count(m.productid) as no_of_products,
sum(n.quantity) as total_quantity,
sum(n.linesalesamount) as total_sales,
avg(n.margin) as avg_margin
from 
{{ref('dim_products')}} as m left join
{{ref('fct_orders')}} as n 
    on m.productid=n.productid left join
{{ref('dim_customers')}} as o 
    on n.customerid=o.customerid
group by o.companyname,o.contactname
order by total_sales desc