-- =========================
-- DATABASE: Retail Analytics
-- =========================

-- CREA DATABASE (SQL Server)
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'retail_analytics')
BEGIN
    CREATE DATABASE retail_analytics;
END
GO

USE retail_analytics;
GO

-- =========================
-- DROP TABLES (ordine corretto)
-- =========================
IF OBJECT_ID('customer_campaigns', 'U') IS NOT NULL DROP TABLE customer_campaigns;
IF OBJECT_ID('returns', 'U') IS NOT NULL DROP TABLE returns;
IF OBJECT_ID('order_items', 'U') IS NOT NULL DROP TABLE order_items;
IF OBJECT_ID('orders', 'U') IS NOT NULL DROP TABLE orders;
IF OBJECT_ID('marketing_campaigns', 'U') IS NOT NULL DROP TABLE marketing_campaigns;
IF OBJECT_ID('products', 'U') IS NOT NULL DROP TABLE products;
IF OBJECT_ID('customers', 'U') IS NOT NULL DROP TABLE customers;
GO

-- =========================
-- CUSTOMERS
-- =========================
CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender CHAR(1),
    birth_date DATE,
    country VARCHAR(50),
    city VARCHAR(50),
    signup_date DATE
);

-- =========================
-- PRODUCTS
-- =========================
CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    price DECIMAL(10,2),
    cost DECIMAL(10,2)
);

-- =========================
-- MARKETING CAMPAIGNS
-- =========================
CREATE TABLE marketing_campaigns (
    campaign_id INT IDENTITY(1,1) PRIMARY KEY,
    campaign_name VARCHAR(100),
    channel VARCHAR(50),
    start_date DATE,
    end_date DATE
);

-- =========================
-- ORDERS
-- =========================
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),
    payment_method VARCHAR(30),
    CONSTRAINT fk_orders_customers
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- =========================
-- ORDER ITEMS
-- =========================
CREATE TABLE order_items (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    CONSTRAINT fk_orderitems_orders
        FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_orderitems_products
        FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- =========================
-- RETURNS
-- =========================
CREATE TABLE returns (
    return_id INT IDENTITY(1,1) PRIMARY KEY,
    order_item_id INT,
    return_date DATE,
    reason VARCHAR(100),
    CONSTRAINT fk_returns_orderitems
        FOREIGN KEY (order_item_id) REFERENCES order_items(order_item_id)
);

-- =========================
-- CUSTOMER CAMPAIGNS (M:N)
-- =========================
CREATE TABLE customer_campaigns (
    customer_id INT,
    campaign_id INT,
    CONSTRAINT pk_customer_campaigns PRIMARY KEY (customer_id, campaign_id),
    CONSTRAINT fk_cc_customers
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_cc_campaigns
        FOREIGN KEY (campaign_id) REFERENCES marketing_campaigns(campaign_id)
);
GO
USE retail_analytics;
SELECT name FROM sys.tables;
