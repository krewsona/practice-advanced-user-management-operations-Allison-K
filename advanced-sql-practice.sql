-- Task 1: JOIN customers and orders to list all orders with customer info
SELECT o.id AS order_id, o.order_date, o.total_amount,
       c.first_name, c.last_name, c.email
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.id;

-- Task 2: Total amount spent by each customer
SELECT c.id, c.first_name, c.last_name,
       SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id;

-- Task 3: Number of orders per customer
SELECT c.id, c.first_name, c.last_name,
       COUNT(o.id) AS order_count
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id;

-- Task 4: Customers who have spent more than $300
SELECT c.id, c.first_name, c.last_name,
       SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id
HAVING total_spent > 300;

-- Task 5: Orders without an associated customer
SELECT * FROM orders
WHERE customer_id IS NULL;

-- Task 6: Most recent order for each customer
SELECT o.*
FROM orders o
JOIN (
    SELECT customer_id, MAX(order_date) AS latest_order
    FROM orders
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
) latest ON o.customer_id = latest.customer_id AND o.order_date = latest.latest_order;

-- Task 7: Customers who placed more than one order (using subquery)
SELECT * FROM customers
WHERE id IN (
    SELECT customer_id
    FROM orders
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
    HAVING COUNT(*) > 1);
