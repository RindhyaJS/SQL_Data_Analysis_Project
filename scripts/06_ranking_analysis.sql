/*
====================================================================
🏆 RANKING ANALYSIS
====================================================================
Purpose:
    Identifies the best and worst performing products based on 
    revenue — answering "who's winning and who's not?"

What This Script Does:
    - Finds the top 5 products generating the highest revenue
    - Finds the worst performing products in terms of sales
    - Rebuilds the same top-5 ranking using ROW_NUMBER() for more 
      flexibility
    - (Planned/next steps) Rank top customers by revenue and 
      customers with the fewest orders

Concepts Used:
    - TOP N                          -> quick way to limit results 
                                         to the highest/lowest values
    - ROW_NUMBER() OVER (ORDER BY..) -> assigns a rank to each row, 
                                         more flexible than TOP 
                                         (works well inside 
                                         subqueries/CTEs)
    - Subqueries                     -> wrapping a ranked result set 
                                         to filter on rank afterward

Key Takeaway:
    There are multiple ways to rank data in SQL — TOP is quick and 
    simple, while window functions like ROW_NUMBER() give more 
    control, especially when ranking needs to be reused, filtered, 
    or combined with other logic.
====================================================================
*/

--which 5 products generate the highest revenue

select top 5 p.product_name , sum(f.sales_amount) as total_revenue
from gold.dim_products p left join gold.fact_sales f
on p.product_key = f.product_key
group by p.product_name
order by total_revenue desc;

--what are the worst performing product in terms of sales?
select top 5 p.product_name ,
sum(f.sales_amount) as total_revenue
from gold.dim_products p 
left join gold.fact_sales f
on p.product_key = f.product_key
group by p.product_name
order by total_revenue ;


select *
from (
	select
	p.product_name ,
	sum(f.sales_amount) as total_revenue,
	row_number() over (order by sum(f.sales_amount) desc) as rank_products
	from gold.dim_products p 
	left join gold.fact_sales f
	on p.product_key = f.product_key
	group by p.product_name
)t
where rank_products <=5

--find the top 10 customers who have generated the highest revenue
--top 3 customers with the fewest orders placed
