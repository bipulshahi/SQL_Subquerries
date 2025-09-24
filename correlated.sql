-- Correlated subquery
-- Refers to a column from the outer query, so it must be evaluated for each row of the outer query.
-- Think: “For this outer row, compute something specific to it.”


-- Execution order & performance tip (beginner)
-- Non-correlated subqueries: MySQL executes inner query first (once), then outer query uses results. Simple and usually fast.
-- Correlated subqueries: Might run the inner query many times — once per outer row — can be slower. 
-- If you see performance issues, consider rewriting as a JOIN or derived table (FROM (SELECT ...)), or ensure there are proper indexes on the columns used in the WHERE clause (e.g., orders.customer_id).

-- Goal: For each order, find orders that are greater than the average order total for the same customer.
-- Why correlated? The inner query references o.customer_id from the outer query, so it’s evaluated per each o row — the average is computed per customer.

select * from orders;
select * from customers;

select customer_id from orders;
select avg(total) from orders;
select customer_id,avg(total) from orders group by customer_id;

select o.order_id, o.customer_id, o.total from orders o
where o.total > (select avg(total) from orders);

select o.order_id, o.customer_id, o.total from orders o
where o.total > (select avg(o2.total) from orders o2 where o.customer_id=o2.customer_id);


-- EXISTS (typical correlated pattern) — real e-commerce use case
-- Goal: Return customers who currently have at least one Pending payment.
-- EXISTS is usually correlated (uses c.customer_id), and stops searching once it finds a matching row — efficient for “does at least one exist?” logic.
select * from customers c;
select * from orders;
select * from payments;
select 1 from orders where status = 'Pending';

select * from orders o join payments p on o.order_id=p.order_id where p.payment_status='Pending' ;

select customer_id,name from customers c
where exists
(select 1 from orders o join payments p on o.order_id=p.order_id where p.payment_status='Pending' and c.customer_id = o.customer_id);

-- NOT EXISTS (anti-join) — find products never sold
-- List products that have no order_items (i.e., never sold).
select 1 from order_items oi;

select * from products p
where not exists
(select 1 from order_items oi
where oi.product_id = p.product_id);

-- For each customer who has any orders, show the customer name and their average order total (one row per customer). Use a subquery in the SELECT (i.e., correlated subquery).
select * from customers;
select * from orders;

select * from customers c join orders o on c.customer_id = o.customer_id;

select name,total from customers c join orders o on c.customer_id = o.customer_id;

select name,avg(total),count(*) from customers c join orders o on c.customer_id = o.customer_id group by name;

SELECT c.name,
       (SELECT AVG(o.total) FROM orders o WHERE o.customer_id = c.customer_id) AS avg_order_total
FROM customers c
WHERE (SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.customer_id) > 0;


-- List order IDs where any order_item subtotal is greater than the price of the respective product 
-- (i.e., detect suspicious data where subtotal > product.price * quantity — a data anomaly). Use a subquery or join as you see fit.
select * from orders;
select * from products;
select * from order_items;

select * from order_items oi join products p on oi.product_id = p.product_id;

select * from orders o join order_items oi on o.order_id = oi.order_id;

select * from orders o 
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id;

select * from orders o 
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
where oi.subtotal > oi.quantity * p.price;


select * from order_items oi
join products p on oi.product_id = p.product_id
where oi.subtotal > oi.quantity * p.price;

select order_id from order_items oi
join products p on oi.product_id = p.product_id
where oi.subtotal > oi.quantity * p.price;





