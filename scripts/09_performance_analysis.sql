-- Performance Analysis (Year-over-Year, Month-over-Month)

/* Analyze the yearly performance of products by comparing their sales 
   to both the average sales performance of the product and the previous year's sales */

WITH CTE_yearly_product_sales AS (
SELECT 
	YEAR(s.order_date) AS order_date,
	p.product_name,
	SUM(sales_amount) AS current_sales
FROM gold.fact_sales  AS s
left JOIN gold.dim_products AS p
ON s.product_key = p.product_key
WHERE order_date IS NOT NULL 
GROUP BY
	YEAR(s.order_date),
	p.product_name
)

SELECT 
	order_date,
	product_name,
	current_sales,
	AVG(current_sales) OVER(PARTITION BY product_name) AS avg_sales,
	current_sales - AVG(current_sales) OVER(PARTITION BY product_name) AS diff_avg,
    CASE 
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
        ELSE 'Avg'
    END AS avg_change,
 -- Year-over-Year Analysis
    LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_date) AS py_sales,
    current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_date) AS diff_py,
    CASE 
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_date) > 0 THEN 'Increase'
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_date) < 0 THEN 'Decrease'
        ELSE 'No Change'
    END AS py_change
FROM CTE_yearly_product_sales
ORDER BY product_name, order_date
