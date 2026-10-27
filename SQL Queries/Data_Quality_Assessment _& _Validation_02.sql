---DATA QUALITY ASSESSMENT & VALIDATION---
--Table 1:order_item_refunds--
SELECT * FROM order_item_refunds

--1.Checking the data types of columns--
SELECT
COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'order_item_refunds'

--2.Checking for nulls in primary key column--
SELECT COUNT(*) AS Null_Count
FROM order_item_refunds
WHERE order_item_refund_id IS NULL 

--3.Checking for duplicate records in primary key column--
SELECT order_item_refund_id,
COUNT(*) AS Duplicate_Count
FROM order_item_refunds
GROUP BY order_item_refund_id 
HAVING COUNT(*) >1

--4.Checking for any negative id in primary key column--
SELECT * 
FROM order_item_refunds
WHERE order_item_refund_id < 0

--5.Checking for nulls in  created_at column--
SELECT COUNT(*) AS Null_Counts
FROM order_item_refunds
WHERE created_at IS NULL 

--6.Check date range--
SELECT MAX(created_at) AS Latest_date,
MIN(created_at) AS Earliest_date
FROM order_item_refunds

--7.Checking for nulls in other columns--
SELECT
SUM(CASE WHEN order_item_id IS NULL THEN 1 ELSE 0 END) AS Null_Order_Item_ID,
SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS Null_Order_ID,
SUM(CASE WHEN refund_amount_usd IS NULL THEN 1 ELSE 0 END) AS Null_Refund_Amount
FROM order_item_refunds

--8.Checking invalid refund amount--
SELECT *
FROM order_item_refunds
WHERE refund_amount_usd <= 0 

--Table 2:order_items--
SELECT * FROM order_items

--1.Checking data types of different columns--
SELECT
COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'order_items'

--2.Checking for nulls in primary key column--
SELECT COUNT(*) AS Null_Counts
FROM order_items
WHERE order_item_id IS NULL 

--3.Checking for duplicated in primary key column--
SELECT order_item_id,
COUNT(*) AS Duplicate_Counts
FROM order_items
GROUP BY order_item_id
HAVING COUNT(*)>1

--4.Checking for any negative id in primary key column--
SELECT * 
FROM order_items
WHERE order_item_id < 0

--5.Checking for nulls in created_at column--
SELECT COUNT(*) Null_Counts 
FROM order_items
WHERE created_at IS NULL 

--6.Checking for date rangecolumn--
SELECT MAX(created_at) AS Latest_date,
MIN(created_at) AS Earliest_date
FROM order_items

--7.Checking for nulls in other columns--
SELECT
SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS Null_Order_ID,
SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS Null_Product_ID,
SUM(CASE WHEN is_primary_item IS NULL THEN 1 ELSE 0 END) AS Null_Is_Primary_Item,
SUM(CASE WHEN price_usd IS NULL THEN 1 ELSE 0 END) AS Null_Price,
SUM(CASE WHEN cogs_usd IS NULL THEN 1 ELSE 0 END) AS Null_COGS
FROM order_items
 
--8.Checking for negative values in price_usd and in cogs_usd--
SELECT *
FROM order_items
WHERE price_usd < 0 OR
cogs_usd < 0

--9.Check for COGS greater than selling price--
SELECT * 
FROM order_items
WHERE cogs_usd > price_usd

--Table 3:orders--
SELECT * FROM orders

--1.Checking data types of different columns--
SELECT
COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'orders'

--2.Checking for nulls in primary key column--
SELECT COUNT(*) AS Null_Counts
FROM orders
WHERE order_id IS NULL

--3.Checking for duplicates in primary key column--
SELECT order_id,
COUNT(*) AS Duplicate_Counts
FROM orders
GROUP BY order_id
HAVING COUNT(*)>1

--4.Checking for any negative values in primary key column--
SELECT * 
FROM orders
WHERE order_id<0

--5.Checking for nulls in created_at column--
SELECT COUNT(*) Null_Counts 
FROM orders
WHERE created_at IS NULL

--6.Checking date range--
SELECT MAX(created_at) AS Latest_date,
MIN(created_at) AS Earliest_date
FROM orders

--7.Checking for nulls in other columns--
SELECT
SUM(CASE WHEN website_session_id IS NULL THEN 1 ELSE 0 END) AS Null_Website_Session_ID,
SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS Null_User_ID,
SUM(CASE WHEN primary_product_id IS NULL THEN 1 ELSE 0 END) AS Null_Primary_Product_ID,
SUM(CASE WHEN items_purchased IS NULL THEN 1 ELSE 0 END) AS Null_Items_Purchased,
SUM(CASE WHEN price_usd IS NULL THEN 1 ELSE 0 END) AS Null_Price,
SUM(CASE WHEN cogs_usd IS NULL THEN 1 ELSE 0 END) AS Null_Cogs
FROM orders

--8.Checking for negative values in price_usd and in cogs_usd column--
SELECT * 
FROM orders
WHERE price_usd < 0 OR
cogs_usd < 0

--9.Check for COGS greater than selling price--
SELECT * 
FROM orders
WHERE cogs_usd > price_usd

--10. Check for invalid item quantities--
SELECT *
FROM orders
WHERE items_purchased <= 0

--Table 4:products--
--1.Checking for data types of different columns--
SELECT
COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'products'

SELECT * FROM products /* since the data is very limited  and is correct so no transformation steps is done */

--Table 5:website_pageviews--
SELECT * FROM website_pageviews

--1.Checking data types of different columns--
SELECT
COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'website_pageviews'

--2.Checking for nulls in primary key column--
SELECT COUNT(*) AS Null_Count
FROM website_pageviews
WHERE website_pageview_id IS NULL

--3.Checking for duplicate records in primary key column--
SELECT website_pageview_id,
COUNT(*) AS Duplicate_Count
FROM website_pageviews
GROUP BY website_pageview_id
HAVING COUNT(*) >1

--4.Checking for any negative id in primary key column--
SELECT * 
FROM website_pageviews
WHERE website_pageview_id < 0

--5.Checking for nulls in created_at column--
SELECT COUNT(*) AS Null_Counts
FROM website_pageviews
WHERE created_at IS NULL

--6.Checking date range--
SELECT MAX(created_at) AS Latest_date,
MIN(created_at) AS Earliest_date
FROM website_pageviews

--7.Checking for nulls or misssing data in other columns--
SELECT COUNT(*) Null_Counts 
FROM website_pageviews
WHERE website_session_id IS NULL

SELECT COUNT(*)  AS Missing_Counts 
FROM website_pageviews
WHERE pageview_url IS NULL OR
TRIM(pageview_url) = '' OR
UPPER(TRIM(pageview_url)) = 'NULL'

--8.Checking for inconsistencies in pageview_url column--
SELECT COUNT(*) AS Total_Rows
FROM website_pageviews

SELECT COUNT(*) AS Invalid_urls
FROM website_pageviews
WHERE pageview_url NOT LIKE '/%'

--Table 6:website_sessions--
SELECT * FROM website_sessions

--1.Checking for data types of different columns--
SELECT 
COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='website_sessions'

--2.Checking for nulls in primary key column--
SELECT COUNT(*) AS Null_Count
FROM website_sessions
WHERE website_session_id IS NULL

--3.Checking for duplicate records in primary key column--
SELECT website_session_id,
COUNT(*) AS Duplicate_Count
FROM website_sessions
GROUP BY website_session_id 
HAVING COUNT(*) >1

--4.Checking for any negative id in primary key column--
SELECT website_session_id AS Negative_ids
FROM website_sessions
WHERE website_session_id < 0

--5.Checking for nulls in created_at column--
SELECT COUNT(*) AS Null_Counts
FROM website_sessions
WHERE created_at IS NULL

--6.Checking date range--
SELECT MAX(created_at) AS Latest_date,
MIN(created_at) AS Earliest_date
FROM website_sessions

--7.Checking for distinct data inside other categorical columns--
SELECT DISTINCT(utm_source)
FROM website_sessions

SELECT DISTINCT(utm_campaign)
FROM website_sessions

SELECT DISTINCT(utm_content)
FROM website_sessions

SELECT DISTINCT(device_type)
FROM website_sessions

SELECT DISTINCT(http_referer)
FROM website_sessions

--8.To check whether nulls in other columns--
SELECT COUNT(*) AS Null_Counts
FROM website_sessions
WHERE user_id IS NULL 

SELECT COUNT(*) AS Null_Counts
FROM website_sessions
WHERE is_repeat_session IS NULL 

SELECT COUNT(*) AS Null_Counts
FROM website_sessions
WHERE utm_source IS NULL OR
utm_source = '' OR
TRIM(utm_source) = '' OR
UPPER(TRIM(utm_source)) = 'NULL'

SELECT COUNT(*) AS Null_Counts
FROM website_sessions
WHERE utm_campaign IS NULL OR
utm_campaign = '' OR
TRIM(utm_campaign) = '' OR
UPPER(TRIM(utm_campaign)) = 'NULL'

SELECT COUNT(*) AS Missing_Counts
FROM website_sessions
WHERE utm_content IS NULL OR
TRIM(utm_content) = '' OR
UPPER(TRIM(utm_content)) = 'NULL'

SELECT COUNT(*) AS Missing_Counts
FROM website_sessions
WHERE device_type IS NULL OR
TRIM(device_type) = '' OR
UPPER(TRIM(device_type)) ='NULL'

SELECT COUNT(*) AS Missing_Count
FROM website_sessions
WHERE http_referer IS NULL
OR TRIM(http_referer) = ''
OR UPPER(TRIM(http_referer)) = 'NULL';

--9..To check for any inconsistencies in http_referer column--
SELECT COUNT(*) AS Invalid_URLs
FROM website_sessions
WHERE http_referer  NOT LIKE 'https%'

--Relational Checks--
-- 1. Refund created before corresponding order item--
SELECT
r.order_item_refund_id,
r.order_item_id,
r.created_at AS Refund_Created_At,
oi.created_at AS Order_Item_Created_At
FROM order_item_refunds r
JOIN order_items oi
ON r.order_item_id = oi.order_item_id
WHERE r.created_at < oi.created_at

-- 2.Refunds with no corresponding order item--
SELECT r.*
FROM order_item_refunds r
LEFT JOIN order_items oi
ON r.order_item_id = oi.order_item_id
WHERE oi.order_item_id IS NULL

-- 3.Order items with no corresponding order--
SELECT oi.*
FROM order_items oi
LEFT JOIN orders o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- 4.Order item created before its corresponding order--
SELECT
oi.order_item_id,
oi.order_id,
oi.created_at AS Order_Item_Created_At,
o.created_at AS Order_Created_At
FROM order_items oi
JOIN orders o
ON oi.order_id = o.order_id
WHERE oi.created_at < o.created_at

-- 5. Orders with no corresponding website session
SELECT o.*
FROM orders o
LEFT JOIN website_sessions ws
ON o.website_session_id = ws.website_session_id
WHERE ws.website_session_id IS NULL

-- 6. Order created before corresponding website session
SELECT
o.order_id,
o.website_session_id,
o.created_at AS Order_Created_At,
ws.created_at AS Session_Created_At
FROM orders o
JOIN website_sessions ws
ON o.website_session_id = ws.website_session_id
WHERE o.created_at < ws.created_at

-- 7. Pageviews with no corresponding website session
SELECT wp.*
FROM website_pageviews wp
LEFT JOIN website_sessions ws
ON wp.website_session_id = ws.website_session_id
WHERE ws.website_session_id IS NULL

-- 8. Pageview created before corresponding session
SELECT wp.website_pageview_id,
wp.website_session_id,
wp.created_at AS Pageview_Created_At,
ws.created_at AS Session_Created_At
FROM website_pageviews wp
JOIN website_sessions ws
ON wp.website_session_id = ws.website_session_id
WHERE wp.created_at < ws.created_at

-- 9. Order items with no corresponding product
SELECT oi.*
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL

-- 10. Orders with no corresponding primary product
SELECT o.*
FROM orders o
LEFT JOIN products p
ON o.primary_product_id = p.product_id
WHERE p.product_id IS NULL



