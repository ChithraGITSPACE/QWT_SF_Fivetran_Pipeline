{{config(materialized='table', schema='transforming')}}

select 
e.productid,
e.productname,
e.supplierid,
s.CompanyName as suppliercompanyname,
s.ContactName as suppliercontactname,
s.city as suppliercity,
s.country as suppliercountry,
f.categoryname,
e.quantityperunit,
e.unitcost,
e.unitprice,
e.unitsinstock,
e.unitsonorder,
to_number((e.unitprice-e.unitcost),20, 2) as profit,
case when e.unitsinstock < e.unitsonorder  then 'No'
    when e.unitsinstock >= e.unitsonorder then 'Yes'
end
as availablity

from 
{{ref('stg_products')}} as e left join
{{ref('lkp_categories')}} as f on e.categoryid=f.categoryid
left join 
{{ref('trf_suppliers')}} as s on e.supplierid=s.supplierid

