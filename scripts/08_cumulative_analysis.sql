  /*
====================================================================
📊 CUMULATIVE ANALYSIS
====================================================================
Purpose:
    Calculates running totals and moving averages of sales over 
    time — shifting the focus from "how did we do this month?" to 
    "how are we growing overall?"

What This Script Does:
    - Total sales per month, with a running total (per month)
    - Total sales per year, with a true running total across all 
      years (progressive growth)
    - Total sales per month combined with a moving average of 
      price over time

Concepts Used:
    - DATETRUNC()                         -> groups sales data by 
                                              month or year
    - SUM() OVER (ORDER BY ...)           -> running/cumulative 
                                              totals
    - SUM() OVER (PARTITION BY.. ORDER BY..) -> resets running 
                                              totals within a 
                                              partition
    - AVG() OVER (ORDER BY ...)           -> moving average 
                                              calculation

Key Takeaway:
    Individual period totals show performance in isolation, but 
    cumulative totals reveal growth and momentum — this is the 
    difference between "how did we do in June?" and "how far have 
    we come since day one?"
====================================================================
*/

--CALCULATE THE TOTAL SALES PER MONTH AND RUNNING TOTAL SALES OVER TIME

SELECT ORDER_DATE,TOTAL_SALES,
SUM(TOTAL_SALES) OVER (PARTITION  BY ORDER_DATE ORDER BY ORDER_DATE) AS RUNNING_TOTAL_SALES
FROM(
SELECT DATETRUNC(MONTH,ORDER_DATE) AS ORDER_DATE,
SUM(SALES_AMOUNT) AS TOTAL_SALES
FROM GOLD.fact_sales
WHERE ORDER_DATE IS NOT NULL
GROUP BY DATETRUNC(MONTH,ORDER_DATE)
)T

--NORMAL CALUCATION IS USED TO IDENTIFY EACH INDIVIDUAL PERFORMANCE BUT CUMULATIVE CALCULATION IS TO IDENTIFY YOUR PROGRESSION OR HOW ITS GROWING WE SHOULD GO TO CUMULATIVE

SELECT ORDER_DATE,TOTAL_SALES,
SUM(TOTAL_SALES) OVER (ORDER BY ORDER_DATE) AS RUNNING_TOTAL_SALES
FROM(
SELECT DATETRUNC(YEAR,ORDER_DATE) AS ORDER_DATE,
SUM(SALES_AMOUNT) AS TOTAL_SALES
FROM GOLD.fact_sales
WHERE ORDER_DATE IS NOT NULL
GROUP BY DATETRUNC(YEAR,ORDER_DATE)
)T

SELECT ORDER_DATE,
TOTAL_SALES,
SUM(TOTAL_SALES) OVER (PARTITION  BY ORDER_DATE ORDER BY ORDER_DATE) AS RUNNING_TOTAL_SALES,
AVG(AVG_PRICE) OVER (ORDER BY ORDER_DATE) AS MOVING_AVERAGE_PRICE
FROM(
SELECT DATETRUNC(MONTH,ORDER_DATE) AS ORDER_DATE,
SUM(SALES_AMOUNT) AS TOTAL_SALES,
AVG(PRICE) AS AVG_PRICE
FROM GOLD.fact_sales
WHERE ORDER_DATE IS NOT NULL
GROUP BY DATETRUNC(MONTH,ORDER_DATE)
)T
