{{config(materialized='table')}}

select 
LINE_NO as lineno,
ORDER_ID as orderid,
SHIPPER_ID as supplierid,
CUSTOMER_ID as customerid,
PRODUCT_ID as productid,
EMPLOYEE_ID as employeeid,
SHIPMENT_DATE as shipmentdate,
STATUS
from 
{{source('QWT_RAW','shipments')}}