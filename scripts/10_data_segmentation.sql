/*
====================================================================
🧩 DATA SEGMENTATION
====================================================================
Purpose:
    Groups both products and customers into meaningful buckets 
    based on cost/spending behavior, instead of looking at them 
    as one big, undivided list.

What This Script Does:
    - Segments products into cost ranges (Below 100, 100-500, 
      500-1000, Above 1000) and counts how many products fall 
      into each range
    - Segments customers into VIP / Regular / New based on their 
      total spending and how long they've been ordering (lifespan)
    - Counts how many customers fall into each segment

Concepts Used:
    - CTEs (product_segment, customer_spending) -> pre-calculate 
                                                    values before 
                                                    segmenting
    - CASE WHEN                -> defines the segment boundaries 
                                   for both products and customers
    - DATEDIFF()                -> calculates customer lifespan in 
                                   months
    - GROUP BY + COUNT()        -> counts how many fall into each 
                                   segment

Key Takeaway:
    Segmentation turns a flat list of products/customers into 
    actionable groups — e.g., knowing "how many VIP customers do 
    we have?" is far more useful for decision-making than just 
    knowing total customer count.
====================================================================
*/

--segment products into cost ranges and count 
--how many products falls into each segment
with product_segment as (
select product_key,
product_name , 
cost,
case when cost < 100 then 'Below 100'
	 when cost between 100 and 500 then '100-500'
	 when cost between 500 and 1000 then '500-1000'
	 else 'above 1000'
end as cost_range 
from gold.dim_products
)

select 
cost_range,
count(product_key) as total_product
from product_segment
group by cost_range
order by total_product desc;


/* group customers into three segments based on their
spending behaviours 

-VIP : at least 12 months of history and spending more than $5000.
-Regular : at least 12 months of history but spending $ 5000 or less.
-New : lifepan less than 12 months.

and find the total number of customers by each group.
*/
with customer_spending as (
select 
c.customer_key as customer_key,
sum(f.sales_amount) as total_spending,
min(order_date) as first_order,
max(order_date)as last_order,
datediff(month,min(order_date),max(order_date)) as life_span
from gold.dim_customers as c left join gold.fact_sales as f
on c.customer_key = f.customer_key
group by c.customer_key)

/* this is just for analysing purpose
select 
customer_key,
total_spending,
life_span,
case when total_spending > 5000 and life_span >=12 then 'VIP'
	 when total_spending <= 5000 and life_span >=12 then 'Regular'
	 else 'New'
end as Customer_Segment
from customer_spending ;*/
select 
customer_segment,
count(customer_key) as total_customers
from (select 
	  customer_key,
	  case when total_spending > 5000 and life_span >=12 then 'VIP'
			when total_spending <= 5000 and life_span >=12 then 'Regular'
			else 'New'
	  end as Customer_Segment
	  from customer_spending)t
group by customer_segment
order by total_customers desc;
