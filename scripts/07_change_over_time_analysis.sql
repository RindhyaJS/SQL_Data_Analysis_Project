/*
====================================================================
⏳ CHANGES OVER TIME ANALYSIS
====================================================================
Purpose:
    Tracks how key metrics — sales, quantity, and customers — 
    change across years and months, revealing seasonality and 
    long-term trends.

What This Script Does:
    - Total sales, quantity, and customers grouped by year
    - Total sales, quantity, and customers grouped by month 
      (across all years combined)
    - Same monthly analysis using DATETRUNC() to properly group 
      by calendar month instead of just the month number

Concepts Used:
    - YEAR() / MONTH()  -> extract year or month from a date
    - DATETRUNC()       -> truncates a date to the start of a given 
                            period (e.g., start of the month), 
                            useful for accurate time-series grouping
    - GROUP BY + ORDER BY -> aggregates and sorts trend data

Key Takeaway:
    Looking at raw totals alone hides trends. Breaking sales down 
    by year and month shows growth patterns, seasonal spikes, or 
    slow periods — the first step toward any real trend analysis.
====================================================================
*/

--select * from gold.fact_sales
--changes over time analysis

select year(order_date) as order_date,
--month(order_date) as month_no ,
sum(sales_amount) as total_sales,
sum(quantity) as total_quantity,
count(customer_key) as total_customers
from gold.fact_sales
where year(order_date) is not null --and month(order_date) is not null
group by year(order_date) --,month(order_date)
order by total_sales desc

select month(order_date) as order_date,
--month(order_date) as month_no ,
sum(sales_amount) as total_sales,
sum(quantity) as total_quantity,
count(customer_key) as total_customers
from gold.fact_sales
where month(order_date) is not null --and month(order_date) is not null
group by month(order_date) --,month(order_date)
order by total_sales desc

select datetrunc(month,order_date) as order_date,
sum(sales_amount) as total_sales,
sum(quantity) as total_quantity,
count(customer_key) as total_customers
from gold.fact_sales
where datetrunc(month,order_date) is not null 
group by datetrunc(month,order_date)
order by total_sales desc

  
