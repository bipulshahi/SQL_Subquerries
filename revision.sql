-- CASE Statement for Categorization with Filter
-- Categorize bookings as ‘High’, ‘Medium’, or ‘Low’ based on total_amount and filter bookings above ₹50,000.
SELECT b.booking_id, c.first_name, c.last_name, t.tour_name, b.total_amount,
       CASE 
           WHEN b.total_amount >= 100000 THEN 'High'
           WHEN b.total_amount >= 50000 THEN 'Medium'
           ELSE 'Low'
       END AS booking_category
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id
JOIN Tours t ON b.tour_id = t.tour_id
WHERE b.total_amount > 50000;

-- ALTER + UPDATE with Two Conditions
-- Increase salary of employees in the 'Sales' department in Mumbai branch by 10%.
-- Ensure department & branch link
UPDATE Employees e
JOIN Branches b ON b.manager_id = e.emp_id
SET e.salary = e.salary * 1.10
WHERE e.department = 'Sales' AND b.city = 'Mumbai';

-- Verify
SELECT * FROM Employees WHERE department='Sales';

-- GROUP BY + HAVING (Two Conditions) + ORDER BY
-- Total sales per tour, only include tours with total sales > ₹100,000 and bookings count > 2, order by total sales descending.
SELECT t.tour_name, SUM(b.total_amount) AS total_sales, COUNT(b.booking_id) AS num_bookings
FROM Bookings b
JOIN Tours t ON b.tour_id = t.tour_id
GROUP BY t.tour_name
HAVING SUM(b.total_amount) > 100000 AND COUNT(b.booking_id) > 2
ORDER BY total_sales DESC;

-- Self Join
-- Find employees in the 'Sales' department who earn less than another employee in the same department.
SELECT e1.first_name AS Employee, e2.first_name AS Higher_Paid_Colleague, e1.salary AS Employee_Salary, e2.salary AS Colleague_Salary
FROM Employees e1
JOIN Employees e2 ON e1.department = e2.department
WHERE e1.salary < e2.salary AND e1.department = 'Sales';

-- Non-Correlated Subquery
-- Find customers who booked tours costing more than the average tour price.
SELECT customer_id, first_name, last_name
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Bookings
    WHERE total_amount > (SELECT AVG(price) FROM Tours)
);

-- Correlated Subquery
-- Find employees whose salary is greater than the average salary of their department.
SELECT e1.first_name, e1.department, e1.salary
FROM Employees e1
WHERE e1.salary > (
    SELECT AVG(e2.salary)
    FROM Employees e2
    WHERE e2.department = e1.department
);


-- Timestamp Add/Diff + CASE
-- Calculate tour duration and classify as 'Short', 'Medium', 'Long'.
SELECT tour_name, start_date, end_date,
       DATEDIFF(end_date, start_date) AS duration_days,
       CASE 
           WHEN DATEDIFF(end_date, start_date) <= 7 THEN 'Short'
           WHEN DATEDIFF(end_date, start_date) <= 15 THEN 'Medium'
           ELSE 'Long'
       END AS tour_length_category
FROM Tours;

-- Self Join + Date Function in WHERE + GROUP BY
-- Compare employees with hire_date before/after manager hire date (assume managers are also in Employees).
SELECT 
    e.first_name AS Employee,
    m.first_name AS Manager,
    e.hire_date AS Employee_Hire_Date,
    m.hire_date AS Manager_Hire_Date,
    CASE 
        WHEN e.hire_date > m.hire_date THEN 'After Manager'
        ELSE 'Before Manager'
    END AS Hire_Comparison
FROM Employees e
JOIN Employees m 
    ON e.manager_id = m.emp_id;


-- JOIN + GROUP BY + HAVING + CASE
-- Classify branches by total bookings in August 2023 as 'High', 'Medium', 'Low'.
SELECT br.branch_name,
       SUM(b.total_amount) AS total_bookings,
       CASE 
           WHEN SUM(b.total_amount) > 100000 THEN 'High'
           WHEN SUM(b.total_amount) > 50000 THEN 'Medium'
           ELSE 'Low'
       END AS branch_category
FROM Bookings b
JOIN TourAssignments ta ON b.tour_id = ta.tour_id
JOIN Branches br ON ta.branch_id = br.branch_id
WHERE MONTH(b.booking_date) = 8 AND YEAR(b.booking_date) = 2023
GROUP BY br.branch_name
HAVING SUM(b.total_amount) > 40000
ORDER BY total_bookings DESC;

-- Date Filtering Using YEAR Extraction
-- Find all bookings made in the year 2023.
SELECT booking_id, customer_id, tour_id, booking_date, total_amount
FROM Bookings
WHERE YEAR(booking_date) = 2023;

-- Subquery for Average Booking Amount Comparison
-- Customers whose bookings are above the average booking total (non-correlated).
SELECT first_name, last_name, customer_id
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Bookings
    WHERE total_amount > (SELECT AVG(total_amount) FROM Bookings)
);

-- Self Join Example with Branch Assignment
-- Find pairs of tours assigned to the same branch.
SELECT t1.tour_name AS Tour1, t2.tour_name AS Tour2, ta1.branch_id
FROM TourAssignments ta1
JOIN TourAssignments ta2 ON ta1.branch_id = ta2.branch_id AND ta1.tour_id < ta2.tour_id
JOIN Tours t1 ON ta1.tour_id = t1.tour_id
JOIN Tours t2 ON ta2.tour_id = t2.tour_id;

-- Aggregate + Conditional Filtering
-- Total revenue per tour where number of bookings > 2.
SELECT t.tour_name, SUM(b.total_amount) AS total_revenue, COUNT(b.booking_id) AS num_bookings
FROM Bookings b
JOIN Tours t ON b.tour_id = t.tour_id
GROUP BY t.tour_name
HAVING COUNT(b.booking_id) > 2;





