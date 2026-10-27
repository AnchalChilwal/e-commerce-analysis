--Creating cleaned table for each table--
--Table 1:products_clean--
DROP TABLE IF EXISTS products_clean
GO

CREATE TABLE products_clean(                     
product_id INT PRIMARY KEY,
created_at DATETIME2,
product_name VARCHAR(50)
)

--Table 2:orders_clean--
DROP TABLE IF EXISTS orders_clean
GO

CREATE TABLE orders_clean(
order_id INT PRIMARY KEY,
created_at DATETIME2,
website_session_id INT,
user_id INT,
primary_product_id INT,
items_purchased INT,
item_price DECIMAL(10,2),
cogs DECIMAL(10,2)
)

--Table 3:order_items_clean--
DROP TABLE IF EXISTS order_items_clean
GO

CREATE TABLE order_items_clean(
order_item_id INT PRIMARY KEY,
created_at DATETIME2,
order_id INT,
product_id INT,
is_primary_item INT,
item_price DECIMAL(10,2),
cogs DECIMAL(10,2)
)

--Table 4:order_item_refunds_clean--
DROP TABLE IF EXISTS order_item_refunds_clean
GO

CREATE TABLE order_item_refunds_clean(
refund_id INT PRIMARY KEY,
created_at DATETIME2,
order_item_id INT,
order_id INT,
refund_amt DECIMAL(10,2)
)

--Table 5:website_sessions_clean--
DROP TABLE IF EXISTS website_sessions_clean
GO

CREATE TABLE website_sessions_clean(
website_session_id INT PRIMARY KEY,
created_at DATETIME2,
user_id INT,
repeat_session INT,
utm_source VARCHAR(50),
utm_campaign VARCHAR(50),
utm_content VARCHAR(50),
device_type VARCHAR(50),
utm_url VARCHAR(100)
)
--Table 6:website_pageviews_clean--
DROP TABLE IF EXISTS website_pageviews_clean
GO

CREATE TABLE website_pageviews_clean(
website_pageview_id INT PRIMARY KEY,
created_at DATETIME2,
website_session_id INT,
pageview_url VARCHAR(100)
)











