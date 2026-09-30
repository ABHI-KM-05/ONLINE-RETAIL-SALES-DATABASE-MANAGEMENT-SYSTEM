-- =========================================================
-- ONLINE RETAIL SALES DATABASE MANAGEMENT SYSTEM
-- STEP 1: DATABASE AND TABLE CREATION
-- =========================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS online_retail_db;

-- Select Database
USE online_retail_db;


-- =========================================================
-- 1. CATEGORIES TABLE
-- =========================================================

CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);


-- =========================================================
-- 2. CUSTOMERS TABLE
-- =========================================================

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(50),
    state VARCHAR(50),
    registration_date DATE NOT NULL
);


-- =========================================================
-- 3. PRODUCTS TABLE
-- =========================================================

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    supplier_name VARCHAR(100),
    
    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id)
        REFERENCES Categories(category_id),

    CONSTRAINT chk_product_price
        CHECK (price > 0),

    CONSTRAINT chk_stock_quantity
        CHECK (stock_quantity >= 0)
);


-- =========================================================
-- 4. ORDERS TABLE
-- =========================================================

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_status VARCHAR(30) NOT NULL DEFAULT 'Pending',
    total_amount DECIMAL(12,2) NOT NULL DEFAULT 0,

    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id),

    CONSTRAINT chk_order_amount
        CHECK (total_amount >= 0),

    CONSTRAINT chk_order_status
        CHECK (
            order_status IN
            ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')
        )
);


-- =========================================================
-- 5. ORDER DETAILS TABLE
-- =========================================================

CREATE TABLE Order_Details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_orderdetail_order
        FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_orderdetail_product
        FOREIGN KEY (product_id)
        REFERENCES Products(product_id),

    CONSTRAINT chk_order_quantity
        CHECK (quantity > 0),

    CONSTRAINT chk_unit_price
        CHECK (unit_price > 0)
);


-- =========================================================
-- 6. PAYMENTS TABLE
-- =========================================================

CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date DATE NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    payment_status VARCHAR(30) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,

    CONSTRAINT fk_payment_order
        FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),

    CONSTRAINT chk_payment_method
        CHECK (
            payment_method IN
            ('UPI', 'Credit Card', 'Debit Card', 'Net Banking', 'Cash on Delivery')
        ),

    CONSTRAINT chk_payment_status
        CHECK (
            payment_status IN
            ('Pending', 'Paid', 'Failed', 'Refunded')
        ),

    CONSTRAINT chk_payment_amount
        CHECK (amount >= 0)
);


-- =========================================================
-- CHECK ALL TABLES
-- =========================================================

SHOW TABLES;
USE online_retail_db;

-- =========================================================
-- 1. INSERT CATEGORIES
-- =========================================================

INSERT INTO Categories (category_name, description) VALUES
('Electronics', 'Electronic devices and accessories'),
('Clothing', 'Men and women clothing products'),
('Home & Kitchen', 'Home and kitchen products'),
('Beauty', 'Beauty and personal care products'),
('Sports', 'Sports and fitness products'),
('Books', 'Books and educational materials'),
('Grocery', 'Daily grocery and food products'),
('Footwear', 'Shoes and footwear products');


-- =========================================================
-- 2. INSERT CUSTOMERS
-- =========================================================

INSERT INTO Customers
(first_name, last_name, email, phone, city, state, registration_date)
VALUES
('Arun', 'Kumar', 'arun.kumar@gmail.com', '9876543210', 'Chennai', 'Tamil Nadu', '2025-01-10'),
('Priya', 'Sharma', 'priya.sharma@gmail.com', '9876543211', 'Coimbatore', 'Tamil Nadu', '2025-01-15'),
('Rahul', 'Raj', 'rahul.raj@gmail.com', '9876543212', 'Bangalore', 'Karnataka', '2025-01-20'),
('Divya', 'Krishnan', 'divya.krishnan@gmail.com', '9876543213', 'Madurai', 'Tamil Nadu', '2025-02-05'),
('Karthik', 'Ramesh', 'karthik.ramesh@gmail.com', '9876543214', 'Salem', 'Tamil Nadu', '2025-02-12'),
('Sneha', 'Patel', 'sneha.patel@gmail.com', '9876543215', 'Mumbai', 'Maharashtra', '2025-02-20'),
('Vijay', 'Kumar', 'vijay.kumar@gmail.com', '9876543216', 'Hyderabad', 'Telangana', '2025-03-01'),
('Anitha', 'Mohan', 'anitha.mohan@gmail.com', '9876543217', 'Trichy', 'Tamil Nadu', '2025-03-10'),
('Suresh', 'Babu', 'suresh.babu@gmail.com', '9876543218', 'Erode', 'Tamil Nadu', '2025-03-18'),
('Meena', 'Devi', 'meena.devi@gmail.com', '9876543219', 'Pune', 'Maharashtra', '2025-03-25'),
('Ravi', 'Shankar', 'ravi.shankar@gmail.com', '9876543220', 'Chennai', 'Tamil Nadu', '2025-04-02'),
('Nandhini', 'Selvam', 'nandhini.selvam@gmail.com', '9876543221', 'Coimbatore', 'Tamil Nadu', '2025-04-10'),
('Ajay', 'Kumar', 'ajay.kumar@gmail.com', '9876543222', 'Bangalore', 'Karnataka', '2025-04-18'),
('Lakshmi', 'Ravi', 'lakshmi.ravi@gmail.com', '9876543223', 'Madurai', 'Tamil Nadu', '2025-05-01'),
('Manoj', 'Prakash', 'manoj.prakash@gmail.com', '9876543224', 'Salem', 'Tamil Nadu', '2025-05-15');


-- =========================================================
-- 3. INSERT PRODUCTS
-- =========================================================

INSERT INTO Products
(product_name, category_id, price, stock_quantity, supplier_name)
VALUES
('Wireless Headphones', 1, 2499.00, 50, 'SoundTech'),
('Bluetooth Speaker', 1, 1899.00, 40, 'AudioWorld'),
('Smart Watch', 1, 3499.00, 35, 'TechGear'),
('Laptop Backpack', 2, 1299.00, 60, 'FashionHub'),
('Men Cotton Shirt', 2, 999.00, 80, 'StyleWear'),
('Women Kurti', 2, 1199.00, 70, 'FashionHub'),
('Mixer Grinder', 3, 3299.00, 25, 'HomeTech'),
('Electric Kettle', 3, 1499.00, 30, 'KitchenPro'),
('Non Stick Cookware Set', 3, 2499.00, 20, 'KitchenPro'),
('Face Wash', 4, 399.00, 100, 'BeautyCare'),
('Skin Care Kit', 4, 1299.00, 45, 'GlowCare'),
('Perfume', 4, 1599.00, 50, 'FragranceWorld'),
('Yoga Mat', 5, 799.00, 75, 'FitLife'),
('Cricket Bat', 5, 2499.00, 30, 'SportsWorld'),
('Running Shoes', 8, 2999.00, 40, 'SportStep'),
('Football', 5, 899.00, 55, 'SportsWorld'),
('Data Science Book', 6, 899.00, 35, 'BookHouse'),
('SQL Programming Book', 6, 699.00, 40, 'BookHouse'),
('Python Programming Book', 6, 799.00, 45, 'TechBooks'),
('Basmati Rice 5kg', 7, 649.00, 100, 'FreshMart'),
('Organic Honey', 7, 499.00, 80, 'NatureFoods'),
('Green Tea', 7, 299.00, 90, 'NatureFoods');


-- =========================================================
-- 4. INSERT ORDERS
-- =========================================================

INSERT INTO Orders
(customer_id, order_date, order_status, total_amount)
VALUES
(1, '2025-06-01', 'Delivered', 4398.00),
(2, '2025-06-03', 'Delivered', 3499.00),
(3, '2025-06-05', 'Shipped', 2598.00),
(4, '2025-06-08', 'Delivered', 2499.00),
(5, '2025-06-10', 'Processing', 3299.00),
(6, '2025-06-12', 'Delivered', 1598.00),
(7, '2025-06-15', 'Delivered', 2999.00),
(8, '2025-06-18', 'Shipped', 1798.00),
(9, '2025-06-20', 'Delivered', 1598.00),
(10, '2025-06-22', 'Delivered', 2499.00),
(11, '2025-06-25', 'Processing', 4498.00),
(12, '2025-06-27', 'Delivered', 1698.00),
(13, '2025-07-01', 'Delivered', 3299.00),
(14, '2025-07-03', 'Shipped', 3798.00),
(15, '2025-07-05', 'Delivered', 2499.00),
(1, '2025-07-08', 'Delivered', 3998.00),
(2, '2025-07-10', 'Processing', 1899.00),
(3, '2025-07-12', 'Delivered', 2498.00),
(4, '2025-07-15', 'Shipped', 2999.00),
(5, '2025-07-18', 'Delivered', 1499.00);


-- =========================================================
-- 5. INSERT ORDER DETAILS
-- =========================================================

INSERT INTO Order_Details
(order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 2499.00),
(1, 2, 1, 1899.00),

(2, 3, 1, 3499.00),

(3, 4, 2, 1299.00),

(4, 9, 1, 2499.00),

(5, 7, 1, 3299.00),

(6, 10, 1, 399.00),
(6, 11, 1, 1199.00),

(7, 15, 1, 2999.00),

(8, 13, 1, 799.00),
(8, 16, 1, 899.00),

(9, 10, 1, 399.00),
(9, 12, 1, 1199.00),

(10, 14, 1, 2499.00),

(11, 1, 1, 2499.00),
(11, 3, 1, 1999.00),

(12, 17, 1, 899.00),
(12, 18, 1, 699.00),
(12, 19, 1, 100.00),

(13, 7, 1, 3299.00),

(14, 15, 1, 2999.00),
(14, 13, 1, 799.00),

(15, 14, 1, 2499.00),

(16, 1, 1, 2499.00),
(16, 12, 1, 1499.00),

(17, 2, 1, 1899.00),

(18, 17, 1, 899.00),
(18, 18, 1, 699.00),
(18, 21, 1, 900.00),

(19, 15, 1, 2999.00),

(20, 8, 1, 1499.00);


-- =========================================================
-- 6. INSERT PAYMENTS
-- =========================================================

INSERT INTO Payments
(order_id, payment_date, payment_method, payment_status, amount)
VALUES
(1, '2025-06-01', 'UPI', 'Paid', 4398.00),
(2, '2025-06-03', 'Credit Card', 'Paid', 3499.00),
(3, '2025-06-05', 'Debit Card', 'Paid', 2598.00),
(4, '2025-06-08', 'UPI', 'Paid', 2499.00),
(5, '2025-06-10', 'Net Banking', 'Paid', 3299.00),
(6, '2025-06-12', 'UPI', 'Paid', 1598.00),
(7, '2025-06-15', 'Credit Card', 'Paid', 2999.00),
(8, '2025-06-18', 'Cash on Delivery', 'Paid', 1798.00),
(9, '2025-06-20', 'UPI', 'Paid', 1598.00),
(10, '2025-06-22', 'Debit Card', 'Paid', 2499.00),
(11, '2025-06-25', 'Credit Card', 'Paid', 4498.00),
(12, '2025-06-27', 'UPI', 'Paid', 1698.00),
(13, '2025-07-01', 'Net Banking', 'Paid', 3299.00),
(14, '2025-07-03', 'UPI', 'Paid', 3798.00),
(15, '2025-07-05', 'Debit Card', 'Paid', 2499.00),
(16, '2025-07-08', 'Credit Card', 'Paid', 3998.00),
(17, '2025-07-10', 'UPI', 'Paid', 1899.00),
(18, '2025-07-12', 'Net Banking', 'Paid', 2498.00),
(19, '2025-07-15', 'Credit Card', 'Paid', 2999.00),
(20, '2025-07-18', 'UPI', 'Paid', 1499.00);


-- =========================================================
-- 7. VERIFY THE DATA
-- =========================================================

SELECT * FROM Categories;

SELECT * FROM Customers;

SELECT * FROM Products;

SELECT * FROM Orders;

SELECT * FROM Order_Details;

SELECT * FROM Payments;

USE online_retail_db;

SELECT 'Categories' AS Table_Name, COUNT(*) AS Total_Records FROM Categories
UNION ALL
SELECT 'Customers', COUNT(*) FROM Customers
UNION ALL
SELECT 'Products', COUNT(*) FROM Products
UNION ALL
SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL
SELECT 'Order_Details', COUNT(*) FROM Order_Details
UNION ALL
SELECT 'Payments', COUNT(*) FROM Payments;

USE online_retail_db;

-- =========================================================
-- QUERY 1: DISPLAY ALL CUSTOMER ORDERS
-- =========================================================

SELECT
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS Customer_Name,
    o.order_date,
    o.order_status,
    o.total_amount
FROM Orders o
JOIN Customers c
    ON o.customer_id = c.customer_id
ORDER BY o.order_date;


-- =========================================================
-- QUERY 2: PRODUCT SALES DETAILS
-- =========================================================

SELECT
    p.product_name,
    c.category_name,
    od.quantity,
    od.unit_price,
    (od.quantity * od.unit_price) AS Sales_Amount
FROM Order_Details od
JOIN Products p
    ON od.product_id = p.product_id
JOIN Categories c
    ON p.category_id = c.category_id
ORDER BY Sales_Amount DESC;


-- =========================================================
-- QUERY 3: CUSTOMER-WISE TOTAL PURCHASE
-- =========================================================

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS Customer_Name,
    COUNT(o.order_id) AS Total_Orders,
    SUM(o.total_amount) AS Total_Purchase
FROM Customers c
JOIN Orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY Total_Purchase DESC;


-- =========================================================
-- QUERY 4: CATEGORY-WISE SALES
-- =========================================================

SELECT
    c.category_name,
    SUM(od.quantity) AS Units_Sold,
    SUM(od.quantity * od.unit_price) AS Total_Sales
FROM Categories c
JOIN Products p
    ON c.category_id = p.category_id
JOIN Order_Details od
    ON p.product_id = od.product_id
GROUP BY c.category_id, c.category_name
ORDER BY Total_Sales DESC;


-- =========================================================
-- QUERY 5: TOP SELLING PRODUCTS
-- =========================================================

SELECT
    p.product_id,
    p.product_name,
    SUM(od.quantity) AS Total_Quantity_Sold,
    SUM(od.quantity * od.unit_price) AS Total_Revenue
FROM Products p
JOIN Order_Details od
    ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY Total_Quantity_Sold DESC;


-- =========================================================
-- QUERY 6: PAYMENT METHOD ANALYSIS
-- =========================================================

SELECT
    payment_method,
    COUNT(payment_id) AS Total_Payments,
    SUM(amount) AS Total_Amount
FROM Payments
WHERE payment_status = 'Paid'
GROUP BY payment_method
ORDER BY Total_Amount DESC;


-- =========================================================
-- QUERY 7: ORDER STATUS ANALYSIS
-- =========================================================

SELECT
    order_status,
    COUNT(order_id) AS Total_Orders,
    SUM(total_amount) AS Total_Order_Value
FROM Orders
GROUP BY order_status
ORDER BY Total_Orders DESC;


-- =========================================================
-- QUERY 8: MONTHLY SALES
-- =========================================================

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS Sales_Month,
    COUNT(order_id) AS Total_Orders,
    SUM(total_amount) AS Total_Sales
FROM Orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY Sales_Month;


-- =========================================================
-- QUERY 9: HIGH-VALUE CUSTOMERS
-- =========================================================

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS Customer_Name,
    SUM(o.total_amount) AS Total_Purchase
FROM Customers c
JOIN Orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING SUM(o.total_amount) > 5000
ORDER BY Total_Purchase DESC;


-- =========================================================
-- QUERY 10: COMPLETE SALES REPORT
-- =========================================================

SELECT
    o.order_id,
    o.order_date,
    CONCAT(c.first_name, ' ', c.last_name) AS Customer_Name,
    p.product_name,
    cat.category_name,
    od.quantity,
    od.unit_price,
    (od.quantity * od.unit_price) AS Sales_Amount,
    o.order_status
FROM Orders o
JOIN Customers c
    ON o.customer_id = c.customer_id
JOIN Order_Details od
    ON o.order_id = od.order_id
JOIN Products p
    ON od.product_id = p.product_id
JOIN Categories cat
    ON p.category_id = cat.category_id
ORDER BY o.order_date, o.order_id;

USE online_retail_db;

-- =========================================================
-- VIEW 1: COMPLETE SALES REPORT
-- =========================================================

CREATE OR REPLACE VIEW sales_report AS
SELECT
    o.order_id,
    o.order_date,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    p.product_name,
    cat.category_name,
    od.quantity,
    od.unit_price,
    (od.quantity * od.unit_price) AS sales_amount,
    o.order_status
FROM Orders o
JOIN Customers c
    ON o.customer_id = c.customer_id
JOIN Order_Details od
    ON o.order_id = od.order_id
JOIN Products p
    ON od.product_id = p.product_id
JOIN Categories cat
    ON p.category_id = cat.category_id;


-- =========================================================
-- VIEW 2: CUSTOMER SALES REPORT
-- =========================================================

CREATE OR REPLACE VIEW customer_sales_report AS
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city,
    c.state,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_purchase
FROM Customers c
JOIN Orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    c.state;


-- =========================================================
-- VIEW 3: PRODUCT SALES REPORT
-- =========================================================

CREATE OR REPLACE VIEW product_sales_report AS
SELECT
    p.product_id,
    p.product_name,
    cat.category_name,
    SUM(od.quantity) AS total_quantity_sold,
    SUM(od.quantity * od.unit_price) AS total_revenue
FROM Products p
JOIN Categories cat
    ON p.category_id = cat.category_id
JOIN Order_Details od
    ON p.product_id = od.product_id
GROUP BY
    p.product_id,
    p.product_name,
    cat.category_name;


-- =========================================================
-- VIEW 4: CATEGORY SALES REPORT
-- =========================================================

CREATE OR REPLACE VIEW category_sales_report AS
SELECT
    cat.category_id,
    cat.category_name,
    SUM(od.quantity) AS total_units_sold,
    SUM(od.quantity * od.unit_price) AS total_sales
FROM Categories cat
JOIN Products p
    ON cat.category_id = p.category_id
JOIN Order_Details od
    ON p.product_id = od.product_id
GROUP BY
    cat.category_id,
    cat.category_name;


-- =========================================================
-- VIEW 5: MONTHLY SALES REPORT
-- =========================================================

CREATE OR REPLACE VIEW monthly_sales_report AS
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_sales,
    AVG(total_amount) AS average_order_value
FROM Orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m');


-- =========================================================
-- VERIFY ALL VIEWS
-- =========================================================

SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';


-- =========================================================
-- TEST THE VIEWS
-- =========================================================

SELECT * FROM sales_report;

SELECT * FROM customer_sales_report
ORDER BY total_purchase DESC;

SELECT * FROM product_sales_report
ORDER BY total_revenue DESC;

SELECT * FROM category_sales_report
ORDER BY total_sales DESC;

SELECT * FROM monthly_sales_report
ORDER BY sales_month;

USE online_retail_db;

-- =========================================================
-- 1. TOP CUSTOMERS USING RANK()
-- =========================================================

WITH CustomerSales AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(o.total_amount) AS total_purchase
    FROM Customers c
    JOIN Orders o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
)

SELECT
    customer_id,
    customer_name,
    total_purchase,
    RANK() OVER (ORDER BY total_purchase DESC) AS customer_rank
FROM CustomerSales
ORDER BY customer_rank;


-- =========================================================
-- 2. TOP PRODUCTS USING RANK()
-- =========================================================

WITH ProductSales AS (
    SELECT
        p.product_id,
        p.product_name,
        SUM(od.quantity) AS quantity_sold,
        SUM(od.quantity * od.unit_price) AS revenue
    FROM Products p
    JOIN Order_Details od
        ON p.product_id = od.product_id
    GROUP BY
        p.product_id,
        p.product_name
)

SELECT
    product_id,
    product_name,
    quantity_sold,
    revenue,
    RANK() OVER (ORDER BY revenue DESC) AS product_rank
FROM ProductSales
ORDER BY product_rank;


-- =========================================================
-- 3. CATEGORY RANKING
-- =========================================================

WITH CategorySales AS (
    SELECT
        cat.category_id,
        cat.category_name,
        SUM(od.quantity * od.unit_price) AS total_sales
    FROM Categories cat
    JOIN Products p
        ON cat.category_id = p.category_id
    JOIN Order_Details od
        ON p.product_id = od.product_id
    GROUP BY
        cat.category_id,
        cat.category_name
)

SELECT
    category_id,
    category_name,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS category_rank
FROM CategorySales
ORDER BY category_rank;


-- =========================================================
-- 4. AVERAGE ORDER VALUE
-- =========================================================

SELECT
    ROUND(AVG(total_amount), 2) AS Average_Order_Value
FROM Orders
WHERE order_status <> 'Cancelled';


-- =========================================================
-- 5. ORDERS ABOVE AVERAGE ORDER VALUE
-- =========================================================

SELECT
    order_id,
    customer_id,
    order_date,
    total_amount
FROM Orders
WHERE total_amount >
(
    SELECT AVG(total_amount)
    FROM Orders
)
ORDER BY total_amount DESC;


-- =========================================================
-- 6. CUSTOMER PURCHASE ABOVE 5000
-- =========================================================

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(o.total_amount) AS total_purchase
FROM Customers c
JOIN Orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING SUM(o.total_amount) > 5000
ORDER BY total_purchase DESC;


-- =========================================================
-- 7. RUNNING SALES TOTAL
-- =========================================================

SELECT
    order_date,
    order_id,
    total_amount,
    SUM(total_amount) OVER (
        ORDER BY order_date, order_id
    ) AS running_sales
FROM Orders
WHERE order_status <> 'Cancelled'
ORDER BY order_date, order_id;


-- =========================================================
-- 8. MONTHLY SALES WITH RUNNING TOTAL
-- =========================================================

WITH MonthlySales AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
        SUM(total_amount) AS monthly_sales
    FROM Orders
    WHERE order_status <> 'Cancelled'
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)

SELECT
    sales_month,
    monthly_sales,
    SUM(monthly_sales) OVER (
        ORDER BY sales_month
    ) AS cumulative_sales
FROM MonthlySales
ORDER BY sales_month;


-- =========================================================
-- 9. CUSTOMER ORDER RANKING
-- =========================================================

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_id,
    o.total_amount,
    RANK() OVER (
        PARTITION BY c.customer_id
        ORDER BY o.total_amount DESC
    ) AS customer_order_rank
FROM Customers c
JOIN Orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id, customer_order_rank;


-- =========================================================
-- 10. PRODUCTS WITH LOW STOCK
-- =========================================================

SELECT
    product_id,
    product_name,
    stock_quantity,
    price
FROM Products
WHERE stock_quantity < 40
ORDER BY stock_quantity ASC;

USE online_retail_db;

-- 1. Check tables
SHOW TABLES;

-- 2. Check number of records
SELECT 'Categories' AS Table_Name, COUNT(*) AS Records FROM Categories
UNION ALL
SELECT 'Customers', COUNT(*) FROM Customers
UNION ALL
SELECT 'Products', COUNT(*) FROM Products
UNION ALL
SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL
SELECT 'Order_Details', COUNT(*) FROM Order_Details
UNION ALL
SELECT 'Payments', COUNT(*) FROM Payments;

-- 3. Check views
SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';

-- 4. Total customers
SELECT COUNT(*) AS Total_Customers
FROM Customers;

-- 5. Total products
SELECT COUNT(*) AS Total_Products
FROM Products;

-- 6. Total orders
SELECT COUNT(*) AS Total_Orders
FROM Orders;

-- 7. Total revenue
SELECT
    SUM(total_amount) AS Total_Revenue
FROM Orders
WHERE order_status <> 'Cancelled';

-- 8. Average order value
SELECT
    ROUND(AVG(total_amount), 2) AS Average_Order_Value
FROM Orders
WHERE order_status <> 'Cancelled';

-- 9. Top customer
SELECT
    customer_name,
    total_purchase
FROM customer_sales_report
ORDER BY total_purchase DESC
LIMIT 1;

-- 10. Top product
SELECT
    product_name,
    total_quantity_sold,
    total_revenue
FROM product_sales_report
ORDER BY total_revenue DESC
LIMIT 1;

-- 11. Top category
SELECT
    category_name,
    total_sales
FROM category_sales_report
ORDER BY total_sales DESC
LIMIT 1;