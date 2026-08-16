/*
====================================================================
🔎 DATABASE EXPLORATION
====================================================================
Purpose:
    This is the very first step of the EDA — getting familiar with 
    the database itself before touching any actual sales data. 
    It answers the basic question: "What am I even working with?"

What This Script Does:
    - Explores all tables/objects available in the database
    - Explores all columns of a specific table (dim_customers) to 
      understand its structure before analysis

Concepts Used:
    - INFORMATION_SCHEMA.TABLES   -> lists all tables in the database
    - INFORMATION_SCHEMA.COLUMNS  -> lists all columns of a table, 
                                      along with their data types

Key Takeaway:
    Before running any analysis, it's important to know the shape 
    of the data — what tables exist, what columns they hold, and 
    how they connect. This script is the foundation everything 
    else builds on.
====================================================================
*/

--explore all the objects in database
select * from INFORMATION_SCHEMA.tables

--explore all the columns in the database
select * from information_schema.columns
where table_name = 'dim_customers'
