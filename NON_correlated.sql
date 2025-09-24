USE ecommerce_db;

-- Non-correlated
-- Runs once and its result is used by the outer query.
-- It does not refer to columns from the outer query.

-- Get all products that belong to the Electronics category.
-- Non-correlated subquery in WHERE
-- Why non-correlated? The inner query SELECT category_id FROM categories ... runs once and returns 1 (for 'Electronics') and outer query uses that value.

SELECT c.category_id FROM categories c WHERE name = 'Electronics';

SELECT p.product_id, p.name, p.category_id FROM products p;

SELECT product_id, name, category_id FROM products 
where category_id = (SELECT category_id FROM categories WHERE name = 'Electronics');

-- List products in categories other than Electronics
SELECT product_id, name, category_id FROM products 
where category_id in (SELECT category_id FROM categories WHERE name <> 'Electronics');

SELECT product_id, name, category_id FROM products 
where category_id <> (SELECT category_id FROM categories WHERE name = 'Electronics');


-- Non-correlated subquery in FROM (derived table)
-- Find customers who have more than 2 orders.
-- Why non-correlated? The inner grouped query builds a temporary table once; the outer query joins against it.

select customer_id, count(*) from orders group by customer_id;

select * from customers;

select * from customers c
join (select customer_id, count(*) as order_count from orders group by customer_id) as t
on t.customer_id = c.customer_id
where t.order_count > 2;

-- Non-correlated subquery in SELECT
-- Show overall average order total (single value) — not per customer.

select (select avg(total) from orders) as overall_average_order_total;

select avg(total) as overall_average_order_total from orders;

-- calculate the overall average once in a subquery, then compare it against each row

SELECT 
    o.order_id, 
    o.total,
    (SELECT AVG(total) FROM orders) AS overall_average,
    CASE 
        WHEN o.total > (SELECT AVG(total) FROM orders) THEN 'Above Average'
        ELSE 'Below or Equal to Average'
    END AS comparison
FROM orders o;


-- List customer names who placed at least one order with total greater than the overall average order total.

select * from customers;
select * from orders;

select * from orders where total > (select avg(total) from orders);

select customer_id from orders where total > (select avg(total) from orders);

select name from customers c where c.customer_id in
(select customer_id from orders where total > (select avg(total) from orders));

select name from customers c 
join orders o on c.customer_id=o.customer_id
where total > (select avg(total) from orders);


-- Find the most expensive product
select * from products;
select max(price) from products;

select name from products where price = (select max(price) from products);


-- Show orders that match the largest order total
select * from orders;
select max(total) from orders;

select * from orders where total = (select max(total) from orders);

select * from customers c join orders o on c.customer_id = o.customer_id where o.total = (select max(total) from orders);


-- Products that cost more than the average product price
select * from products;

select name,price from products where price > (select avg(price) from products);





