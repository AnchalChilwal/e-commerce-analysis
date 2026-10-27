--Inserting data in clean tables--
--Table 1:products_clean--
INSERT INTO products_clean(
product_id,
created_at,
product_name
)
SELECT 
product_id,
created_at,
product_name
FROM products

--Table 2:orders_clean
INSERT INTO orders_clean(
order_id,
created_at,
website_session_id,
user_id,
primary_product_id,
items_purchased,
item_price,
cogs
)
SELECT 
order_id,
created_at,
website_session_id,
user_id,
primary_product_id,
items_purchased,
price_usd,
cogs_usd
FROM orders

--Table 3:order_items_clean--
INSERT INTO order_items_clean(
order_item_id,
created_at,
order_id,
product_id,
is_primary_item,
item_price,
cogs
)
SELECT order_item_id,
created_at,
order_id,
product_id,
is_primary_item,
price_usd,
cogs_usd
FROM order_items

--Table 4:order_item_refunds_clean--
INSERT INTO order_item_refunds_clean(
refund_id,
created_at,
order_item_id,
order_id,
refund_amt
)
SELECT
order_item_refund_id,
created_at,
order_item_id,
order_id,
refund_amount_usd
FROM order_item_refunds

--Table 5:website_sessions_clean--
INSERT INTO website_sessions_clean(
website_session_id,
created_at,
user_id,
repeat_session,
utm_source,
utm_campaign,
utm_content,
device_type,
utm_url
)
SELECT 
website_session_id,
created_at,
user_id,
is_repeat_session,

--Clean utm_source--
CASE WHEN utm_source IS NULL OR
utm_source = '' OR
TRIM(utm_source) = '' OR
UPPER(TRIM(utm_source)) = 'NULL'
THEN 'Not Available'
ELSE utm_source
END  AS utm_source,

--Clean utm_campaign--
CASE WHEN utm_campaign IS NULL OR 
utm_campaign = '' OR
TRIM(utm_campaign) = '' OR
UPPER(TRIM(utm_campaign)) = 'NULL'
THEN 'Not Available'
ELSE utm_campaign
END  AS utm_campaign,

--Clean utm_content--
CASE WHEN utm_content IS NULL OR
utm_content = '' OR
TRIM(utm_content) = '' OR
UPPER(TRIM(utm_content)) = 'NULL'
THEN 'Not Available'
ELSE utm_content
END AS utm_content,

--Clean device_type--
CASE WHEN device_type IS NULL OR
device_type = '' OR
TRIM(device_type) = '' OR
UPPER(TRIM(device_type)) = 'NULL'
THEN 'Not Available'
ELSE device_type
END  AS device_type,

--Clean http_referer--
CASE WHEN http_referer IS NULL OR
http_referer = '' OR
TRIM(http_referer ) = '' OR
UPPER(TRIM(http_referer)) = 'NULL' OR
http_referer  NOT LIKE 'https%'
THEN 'Not Available'
ELSE http_referer 
END  AS http_referer 

FROM website_sessions

--Table 6:website_pageviews_clean--
INSERT INTO website_pageviews_clean(
website_pageview_id,
created_at,
website_session_id,
pageview_url
)
SELECT 
website_pageview_id,
created_at,
website_session_id,

--Clean pageview_url--
CASE WHEN pageview_url IS NULL OR
TRIM(pageview_url) = '' OR
UPPER(TRIM(pageview_url)) = 'NULL' OR
pageview_url NOT LIKE '/%'
THEN 'Not Available'
ELSE pageview_url
END AS pageview_url

FROM website_pageviews