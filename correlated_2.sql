-- List customers who have placed orders with at least two different statuses (e.g., "Completed", "Pending").
SELECT c.customer_id, c.name,
       COUNT(DISTINCT o.status) AS num_statuses
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

select a.name from
(SELECT c.customer_id, c.name,
       COUNT(DISTINCT o.status) AS num_statuses
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name) a
where a.num_statuses > 1;

-- correlated
SELECT c.name
FROM customers c
WHERE (
    SELECT COUNT(DISTINCT o.status)
    FROM orders o
    WHERE o.customer_id = c.customer_id
) > 1;

-- non-correlated
SELECT c.customer_id, c.name
FROM customers c
JOIN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(DISTINCT status) >= 2
) t ON c.customer_id = t.customer_id;


-- Retrieve the orders that have  amount higher than the average amount of all orders placed by the same customer.
-- correlated
SELECT o.order_id, o.customer_id, o.total, c.name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.total > (
    SELECT AVG(o2.total)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id);
    
-- non-correlated 
SELECT o.order_id, o.customer_id, o.total, c.name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN (
    SELECT customer_id, AVG(total) AS avg_total
    FROM orders
    GROUP BY customer_id
) t ON o.customer_id = t.customer_id
WHERE o.total > t.avg_total;

-- Find products that have been ordered by customers from multiple cities.
select * from orders;
select * from order_items;
select * from products;
select * from customers;
-- correlated
SELECT p.name FROM products p
WHERE (
    SELECT COUNT(DISTINCT c.city)
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE oi.product_id = p.product_id
) > 1;

-- non correlated
SELECT p.name
FROM products p
JOIN (
    SELECT oi.product_id, COUNT(DISTINCT c.city) AS city_count
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY oi.product_id
    HAVING COUNT(DISTINCT c.city) > 1
) t ON p.product_id = t.product_id;


SELECT o.customer_id, c.name, o.order_id, 
       o.total - (SELECT AVG(o2.total) 
                  FROM orders o2 
                  WHERE o2.customer_id = o.customer_id) AS margin
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;


-- Find products that have been ordered by customers from multiple cities.
select * from orders;
select * from order_items;
select * from products;
select * from customers;
-- correlated

SELECT 
    p.product_id,
    p.name,
    (
        SELECT COUNT(DISTINCT c.city)
        FROM customers c
        JOIN orders o ON c.customer_id = o.customer_id
        JOIN order_items oi ON o.order_id = oi.order_id
        WHERE oi.product_id = p.product_id
    ) AS city_count
FROM products p;

SELECT p.name FROM products p
WHERE (
    SELECT COUNT(DISTINCT c.city)
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE oi.product_id = p.product_id
) > 1;

SELECT 
    p.product_id,
    p.name,
    (
        SELECT COUNT(DISTINCT c.city)
        FROM customers c
        JOIN orders o ON c.customer_id = o.customer_id
        JOIN order_items oi ON o.order_id = oi.order_id
        WHERE oi.product_id = p.product_id
    ) AS city_count
FROM products p
WHERE (
    SELECT COUNT(DISTINCT c.city)
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE oi.product_id = p.product_id
) > 1;


-- non correlated
SELECT p.name
FROM products p
JOIN (
    SELECT oi.product_id, COUNT(DISTINCT c.city) AS city_count
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY oi.product_id
    HAVING COUNT(DISTINCT c.city) > 1
) t ON p.product_id = t.product_id;

SELECT 
    p.product_id,
    p.name,
    COUNT(DISTINCT c.city) AS city_count
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY p.product_id, p.name
HAVING COUNT(DISTINCT c.city) > 1;


/* generate a report that shows, for each order, 
how much higher or lower its total amount is compared to the average order total of the same customer.
*/

SELECT o.customer_id, c.name, o.order_id, 
       o.total - (SELECT AVG(o2.total) 
                  FROM orders o2 
                  WHERE o2.customer_id = o.customer_id) AS margin
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;


SELECT 
    o.customer_id,
    c.name,
    o.order_id,
    o.total - t.avg_total AS margin
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN (
    SELECT customer_id, AVG(total) AS avg_total
    FROM orders
    GROUP BY customer_id
) t ON o.customer_id = t.customer_id;

/*
Modify the query to classify each order using a CASE expression:
'Above Average' if margin > 0
'Below Average' otherwise.
*/

SELECT 
    o.customer_id, 
    c.name, 
    o.order_id, 
    o.total - (
        SELECT AVG(o2.total)
        FROM orders o2
        WHERE o2.customer_id = o.customer_id
    ) AS margin,
    CASE 
        WHEN o.total - (
            SELECT AVG(o2.total)
            FROM orders o2
            WHERE o2.customer_id = o.customer_id
        ) > 0 THEN 'Above Average'
        ELSE 'Below Average'
    END AS order_classification
FROM orders o
JOIN customers c 
    ON o.customer_id = c.customer_id;




