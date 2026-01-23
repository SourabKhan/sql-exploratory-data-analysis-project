-- Dimensions Exploration
-- To explore the structure of dimension tables.

-- Explore All Countries our Customers comr from.
SELECT DISTINCT 
	country
FROM gold.dim_customers
ORDER BY country

-- Explore All Categories "The major division"
SELECT DISTINCT
	category,subcategory,product_name
FROM gold.dim_products
ORDER BY 1,2,3
