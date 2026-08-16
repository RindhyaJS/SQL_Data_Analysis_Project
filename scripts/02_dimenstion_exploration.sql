/*
====================================================================
🌍 DIMENSION EXPLORATION
====================================================================
Purpose:
    Explores the dimension tables to understand what categorical 
    (non-numeric) values exist in the data — like countries and 
    product categories.

What This Script Does:
    - Lists all distinct countries where customers are located
    - Lists all distinct product categories, subcategories, and 
      product names to understand the product hierarchy

Concepts Used:
    - SELECT DISTINCT           -> pulls unique values from a column
    - ORDER BY (column position) -> sorts by category -> subcategory 
                                     -> product name

Key Takeaway:
    Understanding your dimensions early helps you know what 
    groupings are possible later — you can't analyze sales "by 
    country" or "by category" properly if you don't first know 
    what values those columns actually contain.
====================================================================
*/

-- explore all countries of the customers

select distinct country
from gold.dim_customers

-- explore all the product categories the major difference

select distinct category,subcategory,product_name
from gold.dim_products
order by 1,2,3;
