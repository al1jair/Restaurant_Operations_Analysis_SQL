- View everything from the table

SELECT *
FROM menu_items;


-- Locate blank/null values

SELECT *
FROM order_details
WHERE order_details_id IS NULL;

SELECT *
FROM order_details
WHERE order_id IS NULL;

SELECT *
FROM order_details
WHERE order_date IS NULL;

SELECT *
FROM order_details
WHERE order_time IS NULL;


-- Located and updated null values to 0

SELECT *
FROM order_details
WHERE item_id IS NULL;

SELECT COUNT(*) AS nulls
FROM order_details
WHERE item_id IS NULL;

UPDATE order_details
SET item_id = 0
WHERE item_id IS NULL;

SELECT *
FROM order_details
WHERE item_id = 0;


-- How many items on the menu?

SELECT COUNT(item_name)
FROM menu_items;


-- What are the least and most expensive items on the menu?

SELECT *
FROM menu_items
ORDER BY price ASC;

SELECT *
FROM menu_items
ORDER BY price DESC;


-- Items below $10

SELECT item_name, category, price
FROM menu_items
WHERE price <= 10
ORDER BY price ASC;


-- Items above $10

SELECT item_name, category, price
FROM menu_items
WHERE price >= 10
ORDER BY price DESC;


-- How many dishes are in each category?

SELECT category, COUNT(category) AS dishes_per_cat
FROM menu_items
GROUP BY category
ORDER BY dishes_per_cat DESC;


-- View the order details table.

SELECT *
FROM order_details;


-- Check for orders missing a date or a time

SELECT *
FROM order_details
WHERE order_date IS NULL OR order_time IS NULL;


-- What is the date range of the table?

SELECT MIN(order_date) AS older_ord, MAX(order_date) AS newest_ord
FROM order_details;


-- How many orders were made within this date range?

SELECT COUNT(DISTINCT order_id)
FROM order_details;


-- How many items were ordered within this date range?

SELECT COUNT(*)
FROM order_details;


-- Which orders had the most number of items?

SELECT order_id, COUNT(item_id) AS num_items 
FROM order_details
GROUP BY order_id
ORDER BY num_items DESC;


-- How many orders had more than 10 items?

SELECT order_id, COUNT(item_id) AS num_items 
FROM order_details
GROUP BY order_id
HAVING num_items > 10;


-- Most common items?

SELECT item_id, COUNT(*) AS times_ordered
FROM order_details
GROUP BY item_id
ORDER BY times_ordered DESC;


-- Most orders placed throughout the day?

SELECT order_time, COUNT(DISTINCT order_id) AS num_orders
FROM order_details
GROUP BY order_time
ORDER BY num_orders DESC;


-- Combine the menu items table and the order details table into one.

SELECT *
FROM menu_items;

SELECT * 
FROM order_details;

SELECT *
FROM order_details od LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id;


-- What were the least and most ordered items? 

SELECT item_name, COUNT(order_details_id) AS num_purchases
FROM order_details od LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY item_name
ORDER BY num_purchases ASC;

SELECT item_name, COUNT(order_details_id) AS num_purchases
FROM order_details od LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY item_name
ORDER BY num_purchases DESC;


-- Based on results from above, what were the top 10 most ordered categories? 

SELECT item_name, category, COUNT(order_details_id) AS num_purchases
FROM order_details od LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY num_purchases DESC
LIMIT 10;


-- Who was the top spender?

SELECT order_id, price, COUNT(order_id) AS amount_ords
FROM order_details od LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY order_id, price
ORDER BY amount_ords DESC;


-- More information on the top spender?

SELECT *
FROM order_details od LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE order_id = 440;

SELECT SUM(price) as total_spent
FROM order_details od LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE order_id = 440;


-- Which menu items sold the most?

SELECT item_name, COUNT(*) AS times_ordered
FROM order_details od LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY item_name
ORDER BY times_ordered DESC;


