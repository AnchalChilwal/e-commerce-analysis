--DATA ANALYSIS--
SELECT * FROM products_clean   --product and  order cant have anything common so cant be joined--
SELECT * FROM orders_clean           
SELECT * FROM order_items_clean        --join with orders_clean(order_id) and products_clean(product_id)--
SELECT * FROM order_item_refunds_clean  --can be join with orders_clean(order_id) and order_items_clean(order_items_id)--
SELECT * FROM website_sessions_clean     --can be join with orders_clean (user_id)--
SELECT * FROM website_pageviews_clean     --can join with website_pageview_clean(website_session_id)


--=====1.PRODUCT PERFORMANCE=====--
--Units Sold--
SELECT p.product_id,p.product_name,
COUNT(oi.order_item_id) AS Items_sold
FROM  products_clean p
LEFT JOIN order_items_clean oi
ON p.product_id=oi.product_id
GROUP BY p.product_id,p.product_name
ORDER BY items_sold DESC

--Price and Cogs per product--
SELECT p.product_id,p.product_name,
oi.item_price AS Price,
oi.cogs AS Cogs
FROM products p
LEFT JOIN order_items_clean oi
ON p.product_id=oi.product_id
GROUP BY p.product_id,p.product_name,oi.item_price,oi.cogs 
ORDER BY Price DESC

--Which products are driving revenue and profit, and which products need attention?--
SELECT p.product_id,
p.product_name,
SUM(oi.item_price) AS Total_revenue,
SUM(oi.cogs) AS Total_cost,
SUM(oi.item_price-oi.cogs) AS Gross_profit,
CAST(SUM(oi.item_price-oi.cogs)*100 /SUM(oi.item_price)AS DECIMAL(10,2)) AS Profit_margin
FROM products_clean p
LEFT JOIN order_items_clean oi
ON p.product_id=oi.product_id
GROUP BY p.product_id,p.product_name
ORDER BY Gross_profit DESC

--Number of times purchased as primary product--
SELECT p.product_id,p.product_name,
SUM(CASE WHEN oi.is_primary_item = 1 THEN 1 ELSE 0 END) AS Primary_item_count
FROM products_clean p
LEFT JOIN order_items_clean oi
ON p.product_id = oi.product_id
GROUP BY p.product_id,p.product_name
ORDER BY Primary_item_count DESC

--Refund by product--
SELECT p.product_id,p.product_name,      
COUNT(DISTINCT oi.order_item_id) AS Items_sold, -----since join can create duplicates so thats why used distinct--
COUNT(DISTINCT r.order_item_id) AS Refunded_items,
COALESCE(SUM(r.refund_amt), 0) AS Total_refund_amount
FROM products_clean p
LEFT JOIN order_items_clean oi
ON p.product_id = oi.product_id
LEFT JOIN order_item_refunds_clean r
ON oi.order_item_id = r.order_item_id
GROUP BY p.product_id,p.product_name
ORDER BY Total_refund_amount DESC


--=====2.ORDER PERFORMANCE=====--
--What does a typical customer order look like, and how much revenue and profit does each order generate?--

--Total Orders--
SELECT COUNT(*) AS Total_orders
FROM orders_clean

--Total Revenue--
SELECT 
SUM(item_price) AS  Total_revenue,
SUM(cogs) AS Total_cost,
SUM(item_price)-SUM(cogs) AS Total_profit,
CAST(
(SUM(item_price)-SUM(cogs))/SUM(item_price) *100
AS DECIMAL(10,2)
) 
AS Profit_margin
FROM orders_clean

--Average Order Value--
SELECT
SUM(item_price)/COUNT(*) AS Avg_order_value,
(SUM(item_price)-SUM(cogs))/COUNT(*) AS Avg_profit_per_order
FROM orders_clean

--=====3.CUSTOMER BEHAVIOUR=====--
--How does customer behavior differ between new and returning website visitors?--

--Unique users count(Users who have surely placed orders)--
SELECT COUNT(DISTINCT user_id) AS Unique_purchasing_users
FROM orders_clean

--Unique Website Visitor(Users who might or might not purchased items)--
SELECT COUNT(DISTINCT user_id) AS Unique_website_users
FROM website_sessions_clean

--Conversion Rate--
SELECT
CAST(
COUNT(DISTINCT o.order_id) * 100.0/
NULLIF(COUNT(DISTINCT ws.website_session_id), 0)
AS DECIMAL(10,2)
) AS Conversion_rate
FROM website_sessions_clean ws
LEFT JOIN orders_clean o
ON ws.website_session_id = o.website_session_id

--Sessions per user--
SELECT  CAST(
COUNT(website_session_id) * 1.0/
COUNT(DISTINCT user_id) 
AS DECIMAL(10,2)
)
AS Sessions_per_user
FROM website_sessions_clean

--Repeat session rate--
SELECT CAST(
SUM(CASE WHEN repeat_session = 1 THEN 1 ELSE 0 END) *100.00 /
NULLIF(COUNT(website_session_id),0) 
AS DECIMAL(10,2)
)
AS Repeat_session_rate
FROM website_sessions_clean

--Orders per user--
SELECT CAST(
COUNT(order_id)*1.0/
COUNT(DISTINCT user_id)
AS DECIMAL(10,2)
)
AS Orders_per_user
FROM orders_clean

--Revenue per user--
SELECT CAST(
SUM(item_price)*1.0/
COUNT(DISTINCT user_id)
AS DECIMAL(10,2)
)
AS Revenue_per_user
FROM orders_clean

--First time purchaser vs. Repeat purchaser customers--
SELECT
CASE
WHEN user_order_count = 1 THEN 'First-time Purchaser'
ELSE 'Repeat Purchaser'
END AS Customer_type,
COUNT(*) AS Customers
FROM (
SELECT
user_id,
COUNT(order_id) AS user_order_count
FROM orders_clean
GROUP BY user_id
) AS Customers
GROUP BY
CASE
WHEN user_order_count = 1 THEN 'First-time Purchaser'
ELSE 'Repeat Purchaser'
END

--======4.MARKETING CHANNNEL PERFORMANCE=====--
--Which acquisition sources and campaigns generate the most website traffic, orders, revenue, and profit?--

--Total orders per source--
SELECT ws.utm_source,COUNT(o.order_id) AS Total_orders
FROM website_sessions_clean ws
JOIN orders_clean o
ON ws.website_session_id=o.website_session_id
GROUP BY ws.utm_source
ORDER BY Total_orders DESC

--Total Revenue,Total Cogs, Total Profit and Profit Margin per source--
SELECT ws.utm_source,
SUM(o.item_price) AS Total_revenue,
SUM(O.cogs) AS Total_cogs,
SUM(o.item_price-o.cogs) AS Gross_profit,
CAST(SUM(o.item_price-o.cogs)*100 /SUM(o.item_price)AS DECIMAL(10,2)) AS Profit_margin
FROM website_sessions_clean ws
JOIN orders_clean o
ON ws.website_session_id=o.website_session_id
GROUP BY ws.utm_source
ORDER BY Total_revenue DESC

--Total orders per campaign--
SELECT ws.utm_campaign,COUNT(o.order_id) AS Total_orders
FROM website_sessions_clean ws
JOIN orders_clean o
ON ws.website_session_id=o.website_session_id
GROUP BY ws.utm_campaign
ORDER BY Total_orders DESC

--Total Revenue,Total Cogs, Total Profit and Profit Margin per campaign--
SELECT ws.utm_campaign,
SUM(o.item_price) AS Total_revenue,
SUM(O.cogs) AS Total_cogs,
SUM(o.item_price-o.cogs) AS Gross_profit,
CAST(SUM(o.item_price-o.cogs)*100 /SUM(o.item_price)AS DECIMAL(10,2)) AS Profit_margin
FROM website_sessions_clean ws
JOIN orders_clean o
ON ws.website_session_id=o.website_session_id
GROUP BY ws.utm_campaign
ORDER BY Total_revenue DESC

--Total orders per content--
SELECT ws.utm_content,COUNT(o.order_id) AS Total_orders
FROM website_sessions_clean ws
JOIN orders_clean o
ON ws.website_session_id=o.website_session_id
GROUP BY ws.utm_content
ORDER BY Total_orders DESC

--Total Revenue,Total Cogs, Total Profit and Profit Margin per content--
SELECT ws.utm_content,SUM(o.item_price) AS Total_revenue,
SUM(O.cogs) AS Total_cogs,
SUM(o.item_price-o.cogs) AS Gross_profit,
CAST(SUM(o.item_price-o.cogs)*100 /SUM(o.item_price)AS DECIMAL(10,2)) AS Profit_margin
FROM website_sessions_clean ws
JOIN orders_clean o
ON ws.website_session_id=o.website_session_id
GROUP BY ws.utm_content
ORDER BY Total_revenue DESC

--Total orders per device type--
SELECT ws.device_type,COUNT(o.order_id) AS Total_orders
FROM website_sessions_clean ws
JOIN orders_clean o
ON ws.website_session_id=o.website_session_id
GROUP BY ws.device_type
ORDER BY Total_orders DESC

--Total Revenue,Total Cogs, Total Profit and Profit Margin per device type--
SELECT ws.device_type,
SUM(o.item_price) AS Total_revenue,
SUM(O.cogs) AS Total_cogs,
SUM(o.item_price-o.cogs) AS Gross_Profit,
CAST(SUM(o.item_price-o.cogs)*100 /SUM(o.item_price)AS DECIMAL(10,2)) AS Profit_margin
FROM website_sessions_clean ws
JOIN orders_clean o
ON ws.website_session_id=o.website_session_id
GROUP BY ws.device_type
ORDER BY Total_revenue DESC

--Conversion Rate--
SELECT CAST(
COUNT(o.order_id) *100.0/
COUNT(ws.website_session_id) AS DECIMAL(10,2)
)
AS Conversion_rate
FROM website_sessions_clean ws
LEFT JOIN orders_clean o
ON ws.website_session_id=o.website_session_id

--=====5.Device Type=====--
--Does website and purchasing behavior differ across devices?--

--Session by device--
SELECT device_type,
COUNT(website_session_id) AS Session_count
FROM website_sessions_clean
GROUP BY device_type
ORDER BY Session_count DESC

--Order by device--
SELECT ws.device_type,
COUNT(o.website_session_id) AS orders_count
FROM orders_clean o
LEFT JOIN website_sessions_clean ws
ON o.website_session_id=ws.website_session_id
GROUP BY ws.device_type
ORDER BY orders_count DESC

--Conversion rate--
SELECT ws.device_type,
CAST
(COUNT(o.website_session_id)*100.0/
COUNT(ws.website_session_id)
AS DECIMAL(10,2)
)AS Conversion_rate   --1.0 when need decimal simple ,100.0 when need percentage--
FROM orders_clean o
RIGHT JOIN website_sessions_clean ws
ON o.website_session_id=ws.website_session_id
GROUP BY ws.device_type
ORDER BY Conversion_rate DESC

--Profit Margin,TotalProfit,TotalRevenue and  TotalCost by device type--
SELECT ws.device_type,
SUM(o.item_price) AS Total_Revenue,
SUM(o.cogs) AS Total_cost,
SUM(o.item_price-o.cogs) AS Total_Profit,
CAST(
SUM(o.item_price-o.cogs)/SUM(o.item_price)*100 AS DECIMAL(10,2)
)
AS Profit_margin
FROM orders_clean o
LEFT JOIN website_sessions_clean ws
ON  o.website_session_id=ws.website_session_id
GROUP BY ws.device_type

--AOV by device type--
SELECT ws.device_type,
CAST(
SUM(o.item_price)/COUNT(o.order_id)
AS DECIMAL(10,2)
)AS Average_order_value
FROM orders_clean o 
LEFT JOIN website_sessions_clean ws
ON o.website_session_id=ws.website_session_id
GROUP BY ws.device_type

--======6.REFUND ANALYSIS=====--
--How much revenue is being lost through refunds, and which products/orders contribute most to refund activity?--
--Total revenue--
SELECT CAST(
SUM(item_price) AS DECIMAL(10,2)
)
AS Total_revenue
FROM orders_clean

--Total Refund Amount or Revenue lost--
SELECT CAST(
SUM(refund_amt) AS DECIMAL(10,2)
)
AS Total_refund
FROM order_item_refunds_clean

--Which product contribute most to revenue lost?--
SELECT p.product_id,p.product_name,
SUM(r.refund_amt) AS Refund_amt
FROM order_items_clean oi
LEFT JOIN order_item_refunds_clean r
ON oi.order_item_id=r.order_item_id
LEFT JOIN products_clean p
ON oi.product_id=p.product_id
GROUP BY p.product_id,p.product_name
ORDER BY Refund_amt DESC

--Which order contribute most to revenue lost?--
SELECT o.order_id,
COALESCE(SUM(r.refund_amt),0) AS Refund_amt
FROM order_items_clean oi
LEFT JOIN order_item_refunds_clean r
ON oi.order_item_id=r.order_item_id
LEFT JOIN orders_clean o
ON oi.order_id=o.order_id
GROUP BY o.order_id
ORDER BY Refund_amt DESC

--Net Revenue--
SELECT
CAST(
(SELECT SUM(item_price) FROM orders_clean) -
(SELECT SUM(refund_amt) FROM order_item_refunds_clean)
AS DECIMAL(10,2)
) AS Net_Revenue

--Refund Rate--
SELECT
CAST(
COUNT(DISTINCT r.order_item_id) * 100.0/
NULLIF(COUNT(DISTINCT oi.order_item_id), 0)
AS DECIMAL(10,2)
) AS Refund_Rate
FROM order_items_clean oi
LEFT JOIN order_item_refunds_clean r
ON oi.order_item_id = r.order_item_id

--Product + Refund Analysis--
SELECT p.product_id,p.product_name,
COUNT(DISTINCT oi.order_item_id) AS Units_sold,
SUM(oi.item_price) AS Total_revenue,
SUM(oi.item_price-oi.cogs) AS Profit,
COALESCE(SUM(r.refund_amt),0) AS Refund_amount,
COUNT(DISTINCT r.order_item_id) AS Refunded_items,
CAST
(COUNT(DISTINCT r.order_item_id)*100.0/
NULLIF(COUNT(DISTINCT oi.order_item_id),0) AS DECIMAL(10,2)
) AS Refund_Rate
FROM order_items_clean oi
LEFT JOIN products_clean p
ON oi.product_id = p.product_id
LEFT JOIN order_item_refunds_clean r
ON oi.order_item_id = r.order_item_id
GROUP BY
p.product_id,
p.product_name
ORDER BY Refund_amount DESC

--======7.WEBSITE TRAFFIC & ACQUISITION ANALYSIS=====--
--How much website traffic is the business receiving, who are the visitors,and which acquisition sources bring them to the website?--
SELECT * FROM website_sessions_clean

--Session count--
SELECT COUNT(website_session_id) AS Total_sessions
FROM website_sessions_clean

--New vs. Returning sessions--
SELECT
SUM(CASE WHEN repeat_session = 0 THEN 1 ELSE 0 END) AS New_sessions,
SUM(CASE WHEN repeat_session = 1 THEN 1 ELSE 0 END) AS Returning_sessions
FROM website_sessions_clean

-- Users count--
SELECT 
COUNT(DISTINCT user_id) AS Total_users
FROM website_sessions_clean

--Returning users--
SELECT COUNT(*) AS Returning_users
FROM (
SELECT user_id
FROM website_sessions_clean
GROUP BY user_id
HAVING COUNT(*) > 1
) AS Returning_users_list

--Utm_source--
--Total sessions--
SELECT utm_source,
COUNT(website_session_id) AS Total_sessions
FROM website_sessions_clean
GROUP BY utm_source

--Repeated sessions--
SELECT utm_source,
COUNT(website_session_id) AS Repeated_sessions
FROM website_sessions_clean
WHERE repeat_session>0
GROUP BY utm_source

--New sessions--
SELECT utm_source,
COUNT(website_session_id) AS New_sessions
FROM website_sessions_clean
WHERE repeat_session=0
GROUP BY utm_source
ORDER BY New_sessions DESC

--Users count--
WITH user_sessions AS (
SELECT
user_id,
 COUNT(*) AS session_count
FROM website_sessions_clean
GROUP BY user_id
)
SELECT
ws.utm_source,
COUNT(DISTINCT ws.user_id) AS Total_users,
COUNT(DISTINCT CASE
WHEN us.session_count > 1 THEN ws.user_id
END) AS Returning_users,
COUNT(DISTINCT CASE
WHEN us.session_count = 1 THEN ws.user_id
END) AS New_users
FROM website_sessions_clean ws
JOIN user_sessions us
ON ws.user_id = us.user_id
GROUP BY ws.utm_source
ORDER BY Total_users DESC;

--Utm campaign--
--Sessions--
SELECT
utm_campaign,
COUNT(website_session_id) AS Total_sessions,
SUM(CASE WHEN repeat_session = 0 THEN 1 ELSE 0 END) AS New_sessions,
SUM(CASE WHEN repeat_session = 1 THEN 1 ELSE 0 END) AS Returning_sessions
FROM website_sessions_clean
GROUP BY utm_campaign
ORDER BY Total_sessions DESC

--Users--
WITH user_sessions AS (
SELECT
user_id,
COUNT(*) AS session_count
FROM website_sessions_clean
GROUP BY user_id
)
SELECT
ws.utm_campaign,
COUNT(DISTINCT ws.user_id) AS Total_users,
COUNT(DISTINCT CASE
WHEN us.session_count > 1 THEN ws.user_id
END) AS Returning_users,
COUNT(DISTINCT CASE
WHEN us.session_count = 1 THEN ws.user_id
END) AS New_users
FROM website_sessions_clean ws
JOIN user_sessions us
ON ws.user_id = us.user_id
GROUP BY ws.utm_campaign
ORDER BY Total_users DESC

--Utm content--
--Sessions--
SELECT utm_content,
COUNT(website_session_id) AS Total_sessions,
SUM(CASE WHEN repeat_session=0 THEN 1 ELSE 0 END) AS New_session,
SUM(CASE WHEN repeat_session>0 THEN 1 ELSE 0 END) AS Returning_sessions
FROM website_sessions_clean
GROUP BY utm_content;

--Users--
WITH user_sessions AS (
SELECT
user_id,
COUNT(*) AS session_count
FROM website_sessions_clean
GROUP BY user_id
)
SELECT
ws.utm_content,
COUNT(DISTINCT ws.user_id) AS Total_users,
COUNT(DISTINCT CASE
WHEN us.session_count > 1 THEN ws.user_id
END) AS Returning_users,
COUNT(DISTINCT CASE
WHEN us.session_count = 1 THEN ws.user_id
END) AS New_users
FROM website_sessions_clean ws
JOIN user_sessions us
ON ws.user_id = us.user_id
GROUP BY ws.utm_content
ORDER BY Total_users DESC;

--Utm url--
--Sessions--
SELECT utm_url,
COUNT(website_session_id) AS Total_sessions,
SUM(CASE WHEN repeat_session=0 THEN 1 ELSE 0 END) AS New_session,
SUM(CASE WHEN repeat_session>0 THEN 1 ELSE 0 END) AS Returning_sessions
FROM website_sessions_clean
GROUP BY utm_url;

--Users--
WITH user_sessions AS (
SELECT
user_id,
COUNT(*) AS session_count
FROM website_sessions_clean
GROUP BY user_id
)
SELECT
ws.utm_url,
COUNT(DISTINCT ws.user_id) AS Total_users,
COUNT(DISTINCT CASE
WHEN us.session_count > 1 THEN ws.user_id
END) AS Returning_users,
COUNT(DISTINCT CASE
WHEN us.session_count = 1 THEN ws.user_id
END) AS New_users
FROM website_sessions_clean ws
JOIN user_sessions us
ON ws.user_id = us.user_id
GROUP BY ws.utm_url
ORDER BY Total_users DESC;

--=====8.WEBSITE FUNNEL CONVERSION ANALYSIS=====--
--Total website sessions--
SELECT COUNT(website_session_id) AS Total_sessions
FROM website_sessions_clean

--Total website pageviews--
SELECT COUNT(website_pageview_id) AS Total_pageviews
FROM website_pageviews_clean

--Total pageviews by url--
SELECT pageview_url,
COUNT(*) AS Total_pageviews
FROM website_pageviews_clean
GROUP BY pageview_url
ORDER BY Total_pageviews DESC

--Sessions visting each url--
SELECT pageview_url,
COUNT(DISTINCT website_session_id) AS Total_sessions
FROM website_pageviews_clean
GROUP BY pageview_url
ORDER BY Total_sessions DESC

--Identifying actual urls--
SELECT DISTINCT pageview_url
FROM website_pageviews_clean

--Session-to-order-conversion rate--
SELECT COUNT(DISTINCT o.order_id) AS Total_orders,
COUNT(DISTINCT ws.website_session_id) AS Total_sessions,
CAST(
COUNT(DISTINCT o.order_id)*100.0/
NULLIF(COUNT(DISTINCT ws.website_session_id),0) AS DECIMAL(10,2)
)
AS Session_to_order_conversion
FROM website_sessions_clean ws
LEFT JOIN orders_clean o
ON ws.website_session_id=o.website_session_id

---Conversion rate: New vs Returning sessions--
SELECT CASE
WHEN repeat_session=0 THEN 'New'
ELSE 'Returning'
END Visitor_Type,
COUNT(DISTINCT o.order_id) AS Total_orders,
COUNT(DISTINCT ws.website_session_id) AS Total_sessions,
CAST(
COUNT(DISTINCT o.order_id)*100.0/
NULLIF(COUNT(DISTINCT ws.website_session_id),0) AS DECIMAL(10,2)
)
AS Session_to_order_conversion
FROM website_sessions_clean ws
LEFT JOIN orders_clean o
ON ws.website_session_id=o.website_session_id
GROUP BY CASE
WHEN repeat_session=0 THEN 'New'
ELSE 'Returning'
END

--Conversion by utm source--
SELECT utm_source,
COUNT(DISTINCT o.order_id) AS Total_orders,
COUNT(DISTINCT ws.website_session_id) AS Total_sessions,
CAST(
COUNT(DISTINCT o.order_id)*100.0/
NULLIF(COUNT(DISTINCT ws.website_session_id),0) AS DECIMAL(10,2)
)
AS Conversion_rate
FROM website_sessions_clean ws
LEFT JOIN orders_clean o
ON ws.website_session_id=o.website_session_id
GROUP BY utm_source
ORDER BY Conversion_rate  DESC

--Identify actual URLs--
SELECT DISTINCT pageview_url
FROM website_pageviews_clean;

-- Identifying Funnel Stage & Conversion Rates--
WITH funnel_stage AS (
SELECT
    COUNT(DISTINCT CASE
        WHEN pageview_url IN (
            '/home',
            '/lander-1',
            '/lander-2',
            '/lander-3',
            '/lander-4',
            '/lander-5'
        )
        THEN website_session_id
    END) AS Landing_page,

    COUNT(DISTINCT CASE
        WHEN pageview_url IN (
            '/the-hudson-river-mini-bear',
            '/the-forever-love-bear',
            '/the-original-mr-fuzzy',
            '/the-birthday-sugar-panda'
        )
        THEN website_session_id
    END) AS Product_page,

    COUNT(DISTINCT CASE
        WHEN pageview_url = '/cart'
        THEN website_session_id
    END) AS Cart_page,

    COUNT(DISTINCT CASE
        WHEN pageview_url = '/shipping'
        THEN website_session_id
    END) AS Shipping_page,

    COUNT(DISTINCT CASE
        WHEN pageview_url IN ('/billing', '/billing-2')
        THEN website_session_id
    END) AS Billing_page,

    COUNT(DISTINCT CASE
        WHEN pageview_url = '/thank-you-for-your-order'
        THEN website_session_id
    END) AS Order_page

FROM website_pageviews_clean
)

SELECT
Landing_page,
Product_page,
Cart_page,
Shipping_page,
Billing_page,
Order_page,

CAST(
Product_page * 100.0 /
NULLIF(Landing_page, 0)
AS DECIMAL(10,2)
) AS Landing_to_Product,

CAST(
Cart_page * 100.0 /
NULLIF(Product_page, 0)
AS DECIMAL(10,2)
) AS Product_to_Cart,

CAST(
Shipping_page * 100.0 /
NULLIF(Cart_page, 0)
AS DECIMAL(10,2)
) AS Cart_to_Shipping,

CAST(
Billing_page * 100.0 /
NULLIF(Shipping_page, 0)
AS DECIMAL(10,2)
) AS Shipping_to_Billing,

CAST(
Order_page * 100.0 /
NULLIF(Billing_page, 0)
AS DECIMAL(10,2)
) AS Billing_to_Order,

CAST(
Order_page * 100.0 /
NULLIF(Landing_page, 0)
AS DECIMAL(10,2)
) AS Overall_Funnel_Conversion
FROM funnel_stage;


