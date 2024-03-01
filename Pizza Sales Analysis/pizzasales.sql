SELECT SUM(total_price) AS Total_Revenue 
FROM pizza_sales;

SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_value
FROM pizza_sales;

SELECT SUM(quantity) AS Total_Pizza_Sold 
FROM pizza_sales;

SELECT COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales;

SELECT 
	CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizza_Order
FROM pizza_sales;

-- Daily Trend for Total Orders
SELECT 
	DATENAME(DW, order_date) AS Order_day,
	COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales
GROUP BY
	DATENAME(DW, order_date);

--Monthly Trend for Orders
SELECT 
	DATENAME(MONTH, order_date) AS Month_Name,
	COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales
GROUP BY
	DATENAME(MONTH, order_date);

--% of Sales by Pizza Category
SELECT
	pizza_category,
	CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS Percentage_Sales
FROM pizza_sales
GROUP BY
	pizza_category;

--% of Sales by Pizza Size
SELECT
	pizza_size,
	CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS Percentage_Sales
FROM pizza_sales
GROUP BY
	pizza_size
ORDER BY
	pizza_size;

--Total Pizzas Sold by Pizza Category
SELECT
	pizza_category,
	SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
WHERE
	MONTH(order_date) = 2
GROUP BY
	pizza_category
ORDER BY
	Total_Quantity_Sold DESC

--Top 5 Pizzas by Revenue
SELECT
	TOP 5 pizza_name,
	SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY
	pizza_name
ORDER BY
	Total_Revenue DESC

--Bottom 5 Pizzas by Revenue
SELECT
	TOP 5 pizza_name,
	SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY
	pizza_name
ORDER BY
	Total_Revenue ASC

--Top 5 Pizzas by Quantity
SELECT
	TOP 5 pizza_name,
	SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY
	pizza_name
ORDER BY
	Total_Pizza_Sold DESC

--Bottom 5 Pizzas by Quantity
SELECT
	TOP 5 pizza_name,
	SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY
	pizza_name
ORDER BY
	Total_Pizza_Sold ASC

--Top 5 Pizzas by Total Orders
SELECT
	TOP 5 pizza_name,
	COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales
GROUP BY
	pizza_name
ORDER BY
	Total_Order DESC

--Bottom 5 Pizzas by Total Orders
SELECT
	TOP 5 pizza_name,
	COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales
GROUP BY
	pizza_name
ORDER BY
	Total_Order ASC

--pizza_category or pizza_size filters  Top 5 Pizzas by Total Orders
SELECT
	TOP 5 pizza_name,
	COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY
	pizza_name
ORDER BY
	Total_Order DESC