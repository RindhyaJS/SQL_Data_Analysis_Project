/*
====================================================================
📅 DATE EXPLORATION
====================================================================
Purpose:
    Explores the time boundaries of the dataset — both for orders 
    and for customers — to understand what time range the data 
    covers.

What This Script Does:
    - Finds the earliest and latest customer birthdates
    - Finds the first and last order dates, and the total order 
      range in months
    - Calculates the age of the oldest and youngest customers

Concepts Used:
    - MIN() / MAX()   -> find earliest/latest dates
    - DATEDIFF()      -> calculate the difference between two dates 
                          (in months or years)
    - GETDATE()       -> gets the current date, used to calculate age

Key Takeaway:
    Knowing the time span of your data (how many years/months of 
    orders you have, and the age range of your customers) is 
    essential before doing any trend or time-series analysis — it 
    tells you what's actually possible to analyze.
====================================================================
*/

select max( birthdate)
from gold.dim_customers

select min(birthdate)
from gold.dim_customers

select *,max(start_date)
from gold.dim_products

--find first and last order
--how many sales are aviable
select min(order_date) as first_order_date,
max(order_date) as last_order_date,
datediff(month,min(order_date),max(order_date)) as order_range_months
from gold.fact_sales

--find the youngest and older customer
select 
min(birthdate) as oldest_birthdate,
datediff(year,min(birthdate),getdate()) as oldest_age,
max(birthdate) as youngest_birthdate,
datediff(year,max(birthdate),getdate()) as youngest_age
from gold.dim_customers;
