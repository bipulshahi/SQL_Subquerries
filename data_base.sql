CREATE DATABASE ecommerce_db;

USE ecommerce_db;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS shipping;

-- Create Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20) UNIQUE,
    password VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    country VARCHAR(50)
);

-- Create Categories table
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    name VARCHAR(50),
    description TEXT
);


-- Create Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2),
    stock INT,
    image_url VARCHAR(255),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
);

-- Create Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total DECIMAL(10, 2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- Create Order Items table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- Create Payments table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(20),
    payment_status VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

-- Create Shipping table
CREATE TABLE shipping (
    shipping_id INT PRIMARY KEY,
    order_id INT,
    shipping_date DATE,
    shipping_method VARCHAR(20),
    shipping_status VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

-- Insert data into Customers table
INSERT INTO customers (customer_id, name, email, phone, password, address, city, state, zip_code, country)
VALUES
(1, 'Aarav Sharma', 'aarav.sharma@example.com', '+91-9876543210', 'password123', '12 MG Road', 'Mumbai', 'Maharashtra', '400001', 'India'),
(2, 'Ishaan Verma', 'ishaan.verma@example.com', '+91-9876543211', 'password456', '15 Hill Street', 'Delhi', 'Delhi', '110001', 'India'),
(3, 'Riya Nair', 'riya.nair@example.com', '+91-9876543212', 'password789', '32 Victoria Lane', 'Kochi', 'Kerala', '682001', 'India'),
(4, 'Kabir Rao', 'kabir.rao@example.com', '+91-9876543213', 'password321', '10 Park Avenue', 'Bangalore', 'Karnataka', '560001', 'India'),
(5, 'Saanvi Patel', 'saanvi.patel@example.com', '+91-9876543214', 'password654', '45 Patel Street', 'Ahmedabad', 'Gujarat', '380001', 'India'),
(6, 'Meera Joshi', 'meera.joshi@example.com', '+91-9876543215', 'password987', '88 Residency Road', 'Pune', 'Maharashtra', '411001', 'India'),
(7, 'Vihaan Reddy', 'vihaan.reddy@example.com', '+91-9876543216', 'password1234', '21 Jubilee Hills', 'Hyderabad', 'Telangana', '500001', 'India'),
(8, 'Aditya Desai', 'aditya.desai@example.com', '+91-9876543217', 'password5678', '14 MG Road', 'Surat', 'Gujarat', '395003', 'India'),
(9, 'Tara Menon', 'tara.menon@example.com', '+91-9876543218', 'password9012', '9 Beach Road', 'Chennai', 'Tamil Nadu', '600001', 'India'),
(10, 'Aryan Singh', 'aryan.singh@example.com', '+91-9876543219', 'password3456', '19 Queensway', 'Lucknow', 'Uttar Pradesh', '226001', 'India'),
(11, 'Simran Kaur', 'simran.kaur@example.com', '+91-9876543220', 'password6789', '5 Bypass Road', 'Amritsar', 'Punjab', '143001', 'India'),
(12, 'Rohan Shetty', 'rohan.shetty@example.com', '+91-9876543221', 'password12345', '20 Bannerghatta Road', 'Mysore', 'Karnataka', '570001', 'India'),
(13, 'Nisha Gupta', 'nisha.gupta@example.com', '+91-9876543222', 'password54321', '35 Rose Street', 'Indore', 'Madhya Pradesh', '452001', 'India'),
(14, 'Dev Patel', 'dev.patel@example.com', '+91-9876543223', 'password98765', '67 Gandhi Avenue', 'Rajkot', 'Gujarat', '360001', 'India'),
(15, 'Aanya Khan', 'aanya.khan@example.com', '+91-9876543224', 'password11223', '78 Juhu Beach', 'Mumbai', 'Maharashtra', '400049', 'India'),
(16, 'Dhruv Kapoor', 'dhruv.kapoor@example.com', '+91-9876543225', 'password33445', '23 Ring Road', 'Nagpur', 'Maharashtra', '440001', 'India'),
(17, 'Sara Roy', 'sara.roy@example.com', '+91-9876543226', 'password55667', '39 Eden Gardens', 'Kolkata', 'West Bengal', '700001', 'India'),
(18, 'Rehan Jain', 'rehan.jain@example.com', '+91-9876543227', 'password77889', '56 Diamond Harbour Road', 'Kolkata', 'West Bengal', '700027', 'India'),
(19, 'Lakshmi Reddy', 'lakshmi.reddy@example.com', '+91-9876543228', 'password99001', '91 Koti Road', 'Hyderabad', 'Telangana', '500095', 'India'),
(20, 'Arjun Mehta', 'arjun.mehta@example.com', '+91-9876543229', 'password22334', '88 High Street', 'Jaipur', 'Rajasthan', '302001', 'India'),
(21, 'Ritika Sharma', 'ritika.sharma@example.com', '+91-9876543230', 'password44556', '75 Church Street', 'Delhi', 'Delhi', '110006', 'India'),
(22, 'Yash Aggarwal', 'yash.aggarwal@example.com', '+91-9876543231', 'password66778', '10 Palace Road', 'Bhopal', 'Madhya Pradesh', '462001', 'India'),
(23, 'Kavya Malhotra', 'kavya.malhotra@example.com', '+91-9876543232', 'password88990', '5 Residency Road', 'Dehradun', 'Uttarakhand', '248001', 'India'),
(24, 'Anika Iyer', 'anika.iyer@example.com', '+91-9876543233', 'password99012', '45 Mall Road', 'Coimbatore', 'Tamil Nadu', '641001', 'India'),
(25, 'Rajesh Pandey', 'rajesh.pandey@example.com', '+91-9876543234', 'password33456', '9 Rajpur Road', 'Patna', 'Bihar', '800001', 'India'),
(26, 'Anjali Rao', 'anjali.rao@example.com', '+91-9876543235', 'password12323', '16 Park Street', 'Bangalore', 'Karnataka', '560078', 'India'),
(27, 'Vikram Bhatt', 'vikram.bhatt@example.com', '+91-9876543236', 'password45332', '89 Old Airport Road', 'Surat', 'Gujarat', '395007', 'India'),
(28, 'Sneha Ghosh', 'sneha.ghosh@example.com', '+91-9876543237', 'password21342', '71 Main Road', 'Kolkata', 'West Bengal', '700045', 'India'),
(29, 'Krishna Yadav', 'krishna.yadav@example.com', '+91-9876543238', 'password67281', '12 Station Road', 'Gurgaon', 'Haryana', '122001', 'India'),
(30, 'Pooja Kulkarni', 'pooja.kulkarni@example.com', '+91-9876543239', 'password67489', '31 Brigade Road', 'Bangalore', 'Karnataka', '560025', 'India');

-- Insert data into Categories table
INSERT INTO categories (category_id, name, description)
VALUES
(1, 'Electronics', 'Devices, gadgets, and appliances'),
(2, 'Books', 'Fiction and non-fiction books'),
(3, 'Clothing', 'Apparel for men, women, and children'),
(4, 'Sports', 'Sporting goods and equipment'),
(5, 'Home & Kitchen', 'Home and kitchen appliances and tools');

-- Insert data into Products table
INSERT INTO products (product_id, name, description, price, stock, image_url, category_id)
VALUES
(1, 'Smartphone', 'Latest 5G smartphone with high performance', 700.00,0, 'img/smartphone.jpg', 1),
(2, 'Laptop', 'Powerful laptop with 16GB RAM and 512GB SSD', 1200.00, 30, 'img/laptop.jpg', 1),
(3, 'Microwave Oven', 'Compact microwave oven with smart features', 250.00, 20, 'img/microwave.jpg', 5),
(4, 'Running Shoes', 'Comfortable running shoes for all terrains', 80.00, 0, 'img/shoes.jpg', 3),
(5, 'Fiction Novel', 'Bestselling fiction novel by a renowned author', 15.00, 200, 'img/novel.jpg', 2),
(6, 'Basketball', 'Official size basketball for competitive play', 30.00, 150, 'img/basketball.jpg', 4),
(7, 'Blender', 'High-performance blender for smoothies and juices', 100.00, 70, 'img/blender.jpg', 5),
(8, 'T-Shirt', 'Cotton T-shirt in various colors', 20.00, 0, 'img/tshirt.jpg', 3),
(9, 'Headphones', 'Noise-cancelling wireless headphones', 150.00, 80, 'img/headphones.jpg', 1),
(10, 'Cookbook', 'Healthy recipes for daily meals', 25.00, 150, 'img/cookbook.jpg', 2);


-- Insert data into Orders table
INSERT INTO orders (order_id, customer_id, order_date, total, status)
VALUES
(1, 1, '2024-01-01', 500.00, 'Pending'),
(2, 1, '2024-01-05', 450.50, 'Shipped'),
(3, 3, '2024-01-10', 1200.00, 'Pending'),
(4, 3, '2024-01-12', 3300.75, 'Pending'),
(5, 3, '2024-01-15', 1450.25, 'Shipped'),
(6, 5, '2024-01-20', 1650.00, 'Completed'),
(7, 7, '2024-01-21', 2700.50, 'Pending'),
(8, 8, '2024-01-22', 1850.99, 'Pending'),
(9, 9, '2024-01-23', 1999.99, 'Pending'),
(10, 10, '2024-01-24', 150.00, 'Pending'),
(11, 11, '2024-01-25', 2200.10, 'Completed'),
(12, 12, '2024-01-26', 1450.00, 'Completed'),
(13, 13, '2024-01-27', 2600.75, 'Pending'),
(14, 14, '2024-01-28', 1700.80, 'Shipped'),
(15, 1, '2024-01-29', 2450.00, 'Pending'),
(16, 1, '2024-01-30', 2150.25, 'Shipped'),
(17, 1, '2024-02-01', 3100.00, 'Pending'),
(18, 1, '2024-02-02', 1400.99, 'Pending'),
(19, 1, '2024-02-03', 1900.00, 'Completed'),
(20, 2, '2024-02-04', 4200.15, 'Shipped'),
(21, 2, '2024-02-05', 1700.00, 'Pending'),
(22, 2, '2024-02-06', 3300.00, 'Shipped'),
(23, 23, '2024-02-07', 3500.25, 'Completed'),
(24, 24, '2024-02-08', 450.00, 'Completed'),
(25, 25, '2024-02-09', 1999.00, 'Pending'),
(26, 26, '2024-02-10', 2150.00, 'Shipped'),
(27, 27, '2024-02-11', 1700.10, 'Completed'),
(28, 28, '2024-02-12', 2900.00, 'Pending'),
(29, 29, '2024-02-13', 1100.50, 'Completed'),
(30, 30, '2024-02-14', 2750.75, 'Shipped');


-- Insert data into Order Items table
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, subtotal)
VALUES
(1, 1, 1, 4, 1400.00),
(2, 2, 1, 1, 1200.00),
(3, 3, 3, 1, 250.00),
(4, 4, 1, 3, 240.00),
(5, 5, 5, 10, 150.00),
(6, 6, 1, 5, 150.00),
(7, 7, 7, 3, 200.00),
(8, 8, 8, 4, 80.00),
(9, 9, 9, 1, 150.00),
(10, 10, 10, 1, 50.00),
(11, 11, 1, 3, 2100.00),
(12, 12, 3, 1, 2400.00),
(13, 13, 3, 1, 300.00),
(14, 14, 4, 1, 160.00),
(15, 15, 5, 5, 75.00),
(16, 16, 6, 1, 30.00),
(17, 17, 7, 1, 100.00),
(18, 18, 5, 1, 40.00),
(19, 19, 9, 1, 150.00),
(20, 20, 5, 1, 25.00);


-- Insert data into Payments table
INSERT INTO payments (payment_id, order_id, payment_date, payment_method, payment_status)
VALUES
(1, 1, '2024-01-01', 'Credit Card', 'Completed'),
(2, 2, '2024-01-05', 'Credit Card', 'Completed'),
(3, 3, '2024-01-10', 'PayPal', 'Pending'),
(4, 4, '2024-01-12', 'Credit Card', 'Completed'),
(5, 5, '2024-01-15', 'Debit Card', 'Completed'),
(6, 6, '2024-01-20', 'PayPal', 'Completed'),
(7, 7, '2024-01-21', 'Credit Card', 'Pending'),
(8, 8, '2024-01-22', 'Debit Card', 'Completed'),
(9, 9, '2024-01-23', 'Credit Card', 'Completed'),
(10, 10, '2024-01-24', 'PayPal', 'Pending'),
(11, 11, '2024-01-25', 'Credit Card', 'Completed'),
(12, 12, '2024-01-26', 'Debit Card', 'Completed'),
(13, 13, '2024-01-27', 'Credit Card', 'Pending'),
(14, 14, '2024-01-28', 'PayPal', 'Completed'),
(15, 15, '2024-01-29', 'Credit Card', 'Pending'),
(16, 16, '2024-01-30', 'Debit Card', 'Completed'),
(17, 17, '2024-02-01', 'Credit Card', 'Completed'),
(18, 18, '2024-02-02', 'PayPal', 'Pending'),
(19, 19, '2024-02-03', 'Debit Card', 'Completed'),
(20, 20, '2024-02-04', 'Credit Card', 'Completed');

-- Insert data into Shipping table
INSERT INTO shipping (shipping_id, order_id, shipping_date, shipping_method, shipping_status)
VALUES
(1, 1, '2024-01-02', 'Courier', 'Pending'),
(2, 2, '2024-01-06', 'Courier', 'Shipped'),
(3, 3, '2024-01-11', 'Courier', 'Pending'),
(4, 4, '2024-01-13', 'Courier', 'Delivered'),
(5, 5, '2024-01-16', 'Courier', 'Shipped'),
(6, 6, '2024-01-21', 'Courier', 'Delivered'),
(7, 7, '2024-01-22', 'Courier', 'Pending'),
(8, 8, '2024-01-23', 'Courier', 'Pending'),
(9, 9, '2024-01-24', 'Courier', 'Shipped'),
(10, 10, '2024-01-25', 'Courier', 'Pending'),
(11, 11, '2024-01-26', 'Courier', 'Delivered'),
(12, 12, '2024-01-27', 'Courier', 'Delivered'),
(13, 13, '2024-01-28', 'Courier', 'Pending'),
(14, 14, '2024-01-29', 'Courier', 'Shipped'),
(15, 15, '2024-01-30', 'Courier', 'Pending'),
(16, 16, '2024-01-31', 'Courier', 'Shipped'),
(17, 17, '2024-02-02', 'Courier', 'Delivered'),
(18, 18, '2024-02-03', 'Courier', 'Pending'),
(19, 19, '2024-02-04', 'Courier', 'Delivered'),
(20, 20, '2024-02-05', 'Courier', 'Shipped'),
(21, 21, '2024-02-06', 'Courier', 'Pending'),
(22, 22, '2024-02-07', 'Courier', 'Shipped'),
(23, 23, '2024-02-08', 'Courier', 'Delivered'),
(24, 24, '2024-02-09', 'Courier', 'Delivered'),
(25, 25, '2024-02-10', 'Courier', 'Pending'),
(26, 26, '2024-02-11', 'Courier', 'Shipped'),
(27, 27, '2024-02-12', 'Courier', 'Delivered'),
(28, 28, '2024-02-13', 'Courier', 'Pending'),
(29, 29, '2024-02-14', 'Courier', 'Delivered'),
(30, 30, '2024-02-15', 'Courier', 'Shipped');

show tables;

select * from categories;
select * from customers;
select * from order_items;
select * from orders;
select * from payments;
select * from products;
select * from shipping;



















