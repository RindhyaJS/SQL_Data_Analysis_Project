/*
====================================================================
👤 CUSTOMER REPORT (SUMMARY DOC)
====================================================================
Purpose:
    Builds a reusable VIEW that consolidates everything worth 
    knowing about a customer into a single row — behavior, 
    spending, segment, and KPIs — instead of recalculating it 
    every time.

What This Script Does:
    - Pulls core sales + customer fields into a base query
    - Aggregates each customer's orders, sales, quantity, 
      distinct products bought, and lifespan (in months)
    - Buckets customers into age groups (Under 20, 20-29, ..., 
      50 and above)
    - Segments customers into VIP / Regular / New based on 
      total spending and lifespan
    - Calculates recency (months since last order)
    - Calculates average order value and average monthly spend
    - Saves everything as a VIEW (gold.report_customers) so it 
      can be queried like a table anytime

Concepts Used:
    - CREATE VIEW / DROP VIEW IF EXISTS -> reusable, saved query
    - CTEs (base_query, customer_aggregation) -> break the logic 
                                                  into clean steps
    - CASE WHEN                         -> age grouping & customer 
                                            segmentation
    - DATEDIFF()                        -> lifespan & recency 
                                            calculations
    - Aggregate functions: COUNT(DISTINCT..), SUM(), MAX(), MIN()

Key Takeaway:
    This turns raw transactional data into a ready-to-use customer 
    profile — the exact kind of table a dashboard or CRM would 
    plug straight into. Building it as a VIEW means it always 
    reflects the latest data without re-writing the query.
====================================================================
*/

/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
===============================================================================
*/



IF OBJECT_ID('gold.report_customers', 'V') IS NOT NULL
    DROP VIEW gold.report_customers;
GO

CREATE VIEW gold.report_customers AS


--step 1 get all needed columns
with base_query as (
/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from tables
---------------------------------------------------------------------------*/
select
f.order_number,
f.order_date,
f.product_key,
f.sales_amount,
f.quantity,
c.customer_key,
c.customer_number,
concat(c.first_name,' ',
c.last_name) as customer_name,
datediff(year,
c.birthdate,getdate()) as age 
from gold.fact_sales f 
left join gold.dim_customers c
on f.customer_key = c.customer_key 
where order_date is not null)

, customer_aggregation as (
/*---------------------------------------------------------------------------
2) Customer Aggregations: Summarizes key metrics at the customer level
---------------------------------------------------------------------------*/

select 
		customer_key,
		customer_number,
		customer_name,
		age,
		count(distinct order_number) as total_order,
		sum(sales_amount) as total_sales,
		sum(quantity) as total_quantity,
		count(distinct product_key) as total_product,
		max(order_date) as last_order_date,
		datediff(month,min(order_date),max(order_date)) as life_span
from base_query
group by 
		customer_key,
		customer_number,
		customer_name,
		age )
select 
        customer_key,
		customer_number,
		customer_name,
		age,
		CASE 
			 WHEN age < 20 THEN 'Under 20'
			 WHEN age between 20 and 29 THEN '20-29'
			 WHEN age between 30 and 39 THEN '30-39'
			 WHEN age between 40 and 49 THEN '40-49'
			 ELSE '50 and above'
		END AS age_group,
	    case 
			 when total_sales > 5000 and life_span >=12 then 'VIP'
		     when total_sales <= 5000 and life_span >=12 then 'Regular'
			 else 'New'
	    end as Customer_Segment,
		last_order_date,
		datediff(month,last_order_date,getdate()) as recency ,
		total_order,
		total_sales,
		(total_sales / total_order) as average_order,
		total_quantity,
		total_product,
		life_span,
		-- Compuate average order value (AVO)
		CASE WHEN total_sales = 0 THEN 0
			 ELSE total_sales / total_order
		END AS avg_order_value,
		-- Compuate average monthly spend
		CASE WHEN life_span = 0 THEN total_sales
			 ELSE total_sales / life_span
		END AS avg_monthly_spend
from customer_aggregation

