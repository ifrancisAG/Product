select 
  CASE  WHEN c.orders_count = 1 then 'new_customer'
        WHEN c.orders_count between 2 and 4 then 'repeat customer'
        when c.orders_count >= 5 then   'Loyal_customer'
 END as customer_distinction, 
split_part(title, '-',1) as item,  
count( DISTINCT o.id) as order_count,
SUM (i.quantity) as items
from shopify.customers AS c
join shopify.orders o on o.customer__id = c.id 
join shopify.orders__line_items i on o.id = i._sdc_source_key_id
where o.order_number IN (select o.order_number 
			  from shopify.orders__line_items i
			  join shopify.orders o on o.id = i._sdc_source_key_id
			  where sku = 'A1-Facemask-1')
group by 1,2  
order by items DESC ; 
