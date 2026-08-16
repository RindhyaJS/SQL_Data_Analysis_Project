/*
====================================================================
🚀 PERFORMANCE ANALYSIS
====================================================================
Purpose:
    Compares each product's sales performance against two 
    benchmarks: its own average performance, and its performance 
    in the previous period — a classic year-over-year (YoY) and 
    month-over-month (MoM) analysis.

What This Script Does:
    - Calculates each product's yearly sales and compares it to 
      its own average sales across all years
    - Flags each year as "Above Average", "Below Average", or 
      "Average"
    - Compares each year's sales to the previous year's sales 
      using LAG(), flagging it as "Increase", "Decrease", or 
      "No Change"
    - Repeats the same logic at a monthly level for short-term 
      performance tracking

Concepts Used:
    - CTEs (Common Table Expressions) -> pre-aggregate sales by 
                                          product and year/month
    - AVG() OVER (PARTITION BY ...)   -> average benchmark per 
                                          product
    - LAG() OVER (PARTITION BY.. ORDER BY..) -> access the previous 
                                          period's value for 
                                          comparison
    - CASE WHEN                       -> convert numeric 
                                          differences into readable 
                                          labels

Key Takeaway:
    This is where the analysis becomes truly actionable — instead 
    of just showing numbers, it tells a story: is this product 
    improving or declining, and how does it stack up against its 
    own historical average?
====================================================================
*/

/*ANALYSE THE YEARLY PERFORMANCE OF THE PRODUCTS BY COMPARING EACH PRODUCTS SALES TO 
BOTH THE AVERAGE SALES PERFORMANCE AND THE PREVIOUS SALES PERFORMANCE */
-- WE ARE USING CTE METHOD
WITH YEARLY_PRODUCT_SALE AS(
SELECT YEAR(F.ORDER_DATE) AS ORDER_YEAR,
P.PRODUCT_NAME,
SUM(F.SALES_AMOUNT) AS CURRENT_SALES
FROM GOLD.fact_sales  F LEFT JOIN GOLD.dim_products P
ON F.PRODUCT_KEY = P.PRODUCT_KEY
WHERE YEAR(F.ORDER_DATE) IS NOT NULL
GROUP BY YEAR(F.ORDER_DATE),
P.product_name)
--year-over-year Analysis
SELECT 
Order_year,
Product_Name,
Current_Sales,
AVG(CURRENT_SALES) OVER (PARTITION BY PRODUCT_NAME) AS Avg_Sales,
CURRENT_SALES-AVG(CURRENT_SALES) OVER (PARTITION BY PRODUCT_NAME) AS Diff_Avg,
CASE WHEN CURRENT_SALES-AVG(CURRENT_SALES) OVER (PARTITION BY PRODUCT_NAME) > 0 THEN 'Above Average'
     WHEN CURRENT_SALES-AVG(CURRENT_SALES) OVER (PARTITION BY PRODUCT_NAME) < 0 THEN 'Below Average'
     ELSE 'Average'
END 'Average_Change',
lag(current_sales) over(partition by product_name order by order_year) as py_sales,
case when current_sales - lag(current_sales) over(partition by product_name order by order_year) > 0 then 'Increase'
     when current_sales - lag(current_sales) over(partition by product_name order by order_year) < 0 then 'Decrease'
     ELSE 'No Change'
end 'Py_change'
FROM YEARLY_PRODUCT_SALE
order by product_name,order_year ;


--month-over-month analysis for short term 

WITH YEARLY_PRODUCT_SALE AS(
SELECT MONTH(F.ORDER_DATE) AS ORDER_MONTH,
P.PRODUCT_NAME,
SUM(F.SALES_AMOUNT) AS CURRENT_SALES
FROM GOLD.fact_sales  F LEFT JOIN GOLD.dim_products P
ON F.PRODUCT_KEY = P.PRODUCT_KEY
WHERE MONTH(F.ORDER_DATE) IS NOT NULL
GROUP BY MONTH(F.ORDER_DATE),
P.product_name)

SELECT 
Order_Month,
Product_Name,
Current_Sales,
AVG(CURRENT_SALES) OVER (PARTITION BY PRODUCT_NAME) AS Avg_Sales,
CURRENT_SALES-AVG(CURRENT_SALES) OVER (PARTITION BY PRODUCT_NAME) AS Diff_Avg,
CASE WHEN CURRENT_SALES-AVG(CURRENT_SALES) OVER (PARTITION BY PRODUCT_NAME) > 0 THEN 'Above Average'
     WHEN CURRENT_SALES-AVG(CURRENT_SALES) OVER (PARTITION BY PRODUCT_NAME) < 0 THEN 'Below Average'
     ELSE 'Average'
END 'Average_Change',
lag(current_sales) over(partition by product_name order by order_Month) as py_sales,
case when current_sales - lag(current_sales) over(partition by product_name order by order_Month) > 0 then 'Increase'
     when current_sales - lag(current_sales) over(partition by product_name order by order_Month) < 0 then 'Decrease'
     ELSE 'No Change'
end 'Py_change'
FROM YEARLY_PRODUCT_SALE
order by product_name,order_Month ;
