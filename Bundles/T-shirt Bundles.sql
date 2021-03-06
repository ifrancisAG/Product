
split_part(title, '-', 1), 
count (case when tags like '%T-shirt Bundle%' THEN i.id  ELSE NULL end) as bundle, 
count (case when tags NOT like '%T-shirt Bundle%' THEN i.id ELSE NULL end) as Individual,
(bundle + individual) as total,
ROUND(bundle/total::float,2)  * 100 || '%'  as Percent_Bundle, 
ROUND(individual/total::float,2) * 100 || '%' as Percent_Individual
from shopify.orders__line_items i
left join shopify.orders o on  o.id = i._sdc_source_key_id

where processed_at >= '2019-09-1'
and o.id in (select _sdc_source_key_id
			 from shopify.orders__line_items
			 where sku like 'W2-2J-1A%'
			 or sku like 'W2-2J-3A%'	
			 or sku like 'M1-2B-1%'
			 or sku like 'M1-2B-3%'
			 or sku like'W2-2N-1%'	
			 or sku like'W2-2N-14%'	
			 or sku like'W2-2N-16%'
			 or sku like'W2-2F-14%'	
			 or sku like'M2-9E-1%')
and sku like 'W2-2J-1A%'
			 or sku like 'W2-2J-3A%'	
			 or sku like 'M1-2B-1%'
			 or sku like 'M1-2B-3%'
			 or sku like'W2-2N-1%'	
			 or sku like'W2-2N-14%'	
			 or sku like'W2-2N-16%'
			 or sku like'W2-2F-14%'	
			 or sku like'M2-9E-1%' 
group by 1 
