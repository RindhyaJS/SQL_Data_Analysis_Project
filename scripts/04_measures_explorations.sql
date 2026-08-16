/*
====================================================================
📈 MEASURES REPORT (BIG NUMBERS)
====================================================================
Purpose:
    Calculates the core high-level KPIs of the business — the 
    "big numbers" that summarize overall performance at a glance.

What This Script Does:
    - Total sales generated
    - Total items/quantity sold
    - Average selling price
    - Total number of orders (and total unique orders)
    - Total number of products (and total unique products)
    - Total number of customers, and how many actually placed 
      an order
    - A consolidated summary report combining all measures into 
      a single result using UNION ALL

Concepts Used:
    - Aggregate functions: SUM(), AVG(), COUNT(), COUNT(DISTINCT ...)
    - UNION ALL -> combines multiple single-value queries into one 
                   clean report table

Key Takeaway:
    Every analysis starts with knowing the baseline numbers. This 
    script builds a mini KPI dashboard in plain SQL — the same 
    numbers you'd expect to see at the top of any BI dashboard.
====================================================================
*/

--find the total sales
select sum(sales_amount) as total_sales 
  from gold.fact_sales

--find how many items are sold
select sum(quantity) as total_items_sales 
  from gold.fact_sales

--find the average selling price
select avg(price) as avg_selling_price 
  from gold.fact_sales

--find the total number of orders
select count(order_number) as number_of_order 
  from gold.fact_sales
select count(distinct order_number) as total_order 
  from gold.fact_sales

--find the total number of products
select count(product_number) as number_of_product 
  from gold.dim_products
select count(distinct product_number) as total_product 
  from gold.dim_products

--find the total number of customers
select count(customer_id) as total_number_of_customers 
  from gold.dim_customers

--find the total number of customers that has placed an order
select count(customer_key) as customer_who_placed_order 
from gold.fact_sales
select count(distinct customer_key) as total_cust_placed_order 
from gold.fact_sales

--generate a report

select 'Total Sales' as measure_name,sum(sales_amount) as measure_value from gold.fact_sales
union all
select 'Total Quantity' as measure_name,sum(quantity) as measure_value from gold.fact_sales
union all
select 'Average Price' as measure_name,sum(price) as measure_value from gold.fact_sales
union all
select 'Total number of Orders' as measure_name,count(distinct order_number) as measure_value from gold.fact_sales
union all
select 'Total number of Products' as measure_name,count(distinct product_number) as total_product from gold.dim_products
union all
select 'Total number of customers' as measure_name,count(customer_id) as total_number_of_customers from gold.dim_customers
