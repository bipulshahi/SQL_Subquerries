-- Orders above customer’s average order total
SELECT o.order_id, o.customer_id, o.total
FROM orders o
WHERE o.total > (
    SELECT AVG(o2.total) 
    FROM orders o2 
    WHERE o2.customer_id = o.customer_id
);

-- Customers with at least one pending payment
SELECT c.customer_id, c.name
FROM customers c
WHERE EXISTS (
    SELECT 1 
    FROM orders o 
    JOIN payments p ON o.order_id = p.order_id
    WHERE p.payment_status = 'Pending'
      AND o.customer_id = c.customer_id
);

-- List customers who have placed orders but none of them are pending.
SELECT c.customer_id, c.name
FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id)
  AND NOT EXISTS (
      SELECT 1 
      FROM orders o 
      WHERE o.customer_id = c.customer_id 
        AND o.status = 'Pending'
  );
  
-- Find the customer whose single order exceeded their average by the largest margin.
SELECT o.customer_id, c.name, o.order_id, 
       o.total - (SELECT AVG(o2.total) 
                  FROM orders o2 
                  WHERE o2.customer_id = o.customer_id) AS margin
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY margin DESC
LIMIT 1;







