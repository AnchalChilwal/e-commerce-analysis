--Row Count Reconciliation--
SELECT 'products', COUNT(*) AS Total_rows FROM products 
UNION ALL
SELECT 'products_clean', COUNT(*) AS Total_rows FROM products_clean 
UNION ALL
SELECT 'orders', COUNT(*) AS Total_rows FROM orders 
UNION ALL
SELECT 'orders_clean', COUNT(*) AS Total_rows FROM orders_clean
UNION ALL
SELECT 'order_items', COUNT(*) AS Total_rows FROM order_items 
UNION ALL
SELECT 'order_items_clean', COUNT(*) AS Total_rows FROM order_items_clean 
UNION ALL
SELECT 'order_item_refunds', COUNT(*) AS Total_rows FROM order_item_refunds 
UNION ALL
SELECT 'order_item_refunds_clean', COUNT(*) AS Total_rows FROM order_item_refunds_clean 
UNION ALL
SELECT 'website_sessions', COUNT(*) AS Total_rows FROM website_sessions 
UNION ALL
SELECT 'website_sessions_clean', COUNT(*) AS Total_rows FROM website_sessions_clean 
UNION ALL
SELECT 'website_pageviews', COUNT(*) AS Total_rows FROM website_pageviews 
UNION ALL
SELECT 'website_pageviews_clean', COUNT(*) AS Total_rows FROM website_pageviews_clean 


