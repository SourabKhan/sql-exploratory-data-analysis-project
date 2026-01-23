-- Date Range Exploration 
/* Identify the earliest and latest dates (boundaries).
   Understand the scope of date and the timespan */
   
-- Find the date of the first and last order
-- How many years of sales are available

SELECT
	MIN(order_date) AS first_order_date,
	MAX(order_date) AS last_order_date,
	DATEDIFF(year, MIN(order_date), MAX(order_date)) AS order_range_years,
	DATEDIFF(month, MIN(order_date), MAX(order_date)) AS order_range_months
FROM gold.fact_sales

-- Find the Youngst and the lowest customers

SELECT 
	MIN(birthdate) AS youngst_birthdate,
	DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_age,
	MAX(birthdate) AS lowest_birthdate,
	DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers
