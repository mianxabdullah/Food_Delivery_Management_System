-- 1. Customer Orders
SELECT c.name, o.order_id, o.status
FROM customer c, orders o
WHERE c.customer_id = o.customer_id;

-- 2. Restaurant Menu
SELECT r.restaurant_name, m.item_name, m.price
FROM restaurant r, menu_items m
WHERE r.restaurant_id = m.restaurant_id;

-- 3. Order Details
SELECT o.order_id, m.item_name, od.quantity, od.subtotal
FROM orders o, order_details od, menu_items m
WHERE o.order_id = od.order_id
AND od.item_id = m.item_id;

-- 4. Revenue by Restaurant
SELECT r.restaurant_name,
       SUM(od.subtotal) AS revenue
FROM restaurant r, menu_items m, order_details od
WHERE r.restaurant_id = m.restaurant_id
AND m.item_id = od.item_id
GROUP BY r.restaurant_name;

-- 5. Most Active Customer
SELECT c.name,
       COUNT(o.order_id) AS total_orders
FROM customer c, orders o
WHERE c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_orders DESC;

-- 6. Total Revenue
SELECT SUM(amount) AS total_revenue
FROM payments;

-- 7. Average Order Value
SELECT AVG(total_amount) AS average_order_value
FROM orders;

-- 8. Delivery Tracking
SELECT o.order_id,
       da.name AS delivery_agent,
       d.delivery_status
FROM orders o, deliveries d, delivery_agents da
WHERE o.order_id = d.order_id
AND d.agent_id = da.agent_id;

-- 9. Top Ordered Items
SELECT m.item_name,
       SUM(od.quantity) AS total_quantity
FROM menu_items m, order_details od
WHERE m.item_id = od.item_id
GROUP BY m.item_name
ORDER BY total_quantity DESC;

-- 10. Restaurant Ratings
SELECT r.restaurant_name,
       ROUND(AVG(rv.rating), 2) AS avg_rating
FROM restaurant r, reviews rv
WHERE r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_name;

-- 11. Delivery Agent Ratings
SELECT da.name,
       ROUND(AVG(rv.rating), 2) AS avg_rating
FROM delivery_agents da, reviews rv
WHERE da.agent_id = rv.agent_id
GROUP BY da.name;

-- 12. Customer Reviews
SELECT c.name,
       rv.rating,
       rv.comment
FROM customer c, reviews rv
WHERE c.customer_id = rv.customer_id;