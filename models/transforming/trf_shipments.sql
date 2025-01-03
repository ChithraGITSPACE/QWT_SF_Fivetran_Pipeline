{{config(materialized='table', schema='transforming')}}

select 
ss.orderid,
ss.lineno,
ss.shipmentdate,
ss.status,
sh.companyname as shipmentcompany_name
from 
    {{ref('shipments_snapshot')}} as ss 
    inner join 
    {{ref('lkp_shipments')}} as sh
        on sh.shipperid=ss.SUPPLIERID