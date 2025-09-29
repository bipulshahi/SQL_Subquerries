-- Interview

/*
-- Which is better?
Performance:
EXISTS is usually more efficient than IN when the subquery returns a large set.

IN can be fine (or even faster) when the subquery result is small and well indexed.
Semantics:

EXISTS is often considered more robust (doesn’t get tripped up by NULLs).
Readability:
IN is simpler to read for “value in set”.
EXISTS is better for “does a match exist”.

Rule of Thumb
Use EXISTS for correlated subqueries (when checking row-by-row matches).
Use IN for static, small lists (e.g., WHERE country IN ('USA','UK','India')).

EXISTS is generally better, because:
Orders can have many rows.
DB can short-circuit after the first match.
*/

-- Customer details for the 2nd largest order

-- Uses ORDER BY … LIMIT
SELECT c.customer_id, c.name, o.order_id, o.total
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
ORDER BY o.total DESC
LIMIT 1 OFFSET 1;

-- Using subquery (generic SQL)
SELECT c.customer_id, c.name, o.order_id, o.total
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.total = (
    SELECT MAX(total) 
    FROM orders 
    WHERE total < (SELECT MAX(total) FROM orders)
);

-- Find products that were never ordered
SELECT p.product_id, p.name 
FROM products p
WHERE p.product_id NOT IN (SELECT DISTINCT product_id FROM orders);

-- Find customers who never placed an order
SELECT c.customer_id, c.name 
FROM customers c
WHERE c.customer_id NOT IN (SELECT DISTINCT customer_id FROM orders);

-- Show the order(s) with total equal to the overall average
SELECT o.order_id, o.total 
FROM orders o
WHERE o.total = (SELECT ROUND(AVG(total),2) FROM orders);


-- Get customers who placed an order for the most expensive product

select * from customers; -- customer_id, name, email, phone, password, address, city, state, zip_code, country
select * from orders;    -- order_id, customer_id, order_date, total, status
select * from products; -- product_id, name, description, price, stock, image_url, category_id

SELECT c.customer_id, c.name, o.order_id, o.total
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.total = (SELECT MAX(total) FROM orders);





