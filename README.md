# E-Commerce Performance & Customer Behavior Analysis
## Brief Summary
An end-to-end business intelligence solution analyzing over 472,000+ web sessions, 32,000+ customer orders, 
and post-purchase activities for an online toy e-commerce business using SQL Server and Power BI.

## Problem Statement
* High reliance on continuous new user acquisition contrasted with a low repeat customer rate (13.00%).
* Severe mid-to-late funnel leakage, highlighted by a 55.55% initial landing page bounce rate and a 65.97% checkout abandonment rate.
* Significant gross margin erosion due to product refund losses totaling over $85.3K across 1,723 refunded orders.

## Dataset
* Source: Maven Analytics-Toy Store E-Commerce Database.
* E-Commerce database for Maven Fuzzy Factory, an online retailer that sells teddy bears. It includes detailed marketing data on
website sessions and pageviews by user, as well as their orders and returns. Perfect for analyzing and optimizing marketing channels,
measuring and testing website conversion performance,and understanding the impact of new product launches.

## Tools 
* SQL Server (T-SQL)
* Power BI
* Power Query
* DAX

## Methods
* Data Hygiene & ETL: Executed systematic checks in SQL Server for primary key uniqueness, 
negative value validation, and referential integrity across all entity tables, building cleaned staging tables (*_clean).
* Data Modeling: Implemented a robust star-schema architecture connecting fact tables (orders_clean, order_items_clean, website_sessions_clean,
website_pageviews_clean,order_item_refunds_clean) to dimension tables (products_clean) via one-to-many relationships.
* Advanced DAX Metrics: Developed calculated measures for user cohort segmentation (First-time Purchaser vs. Repeat Purchaser),
funnel conversion rates, gross profit margins, and average order value (AOV).

## Key Insights
** Executive Baseline
* Solid Financial Core: The e-commerce business generated $1.94M in total revenue across 32.31K orders, achieving an impressive 62.74% gross profit margin and an Average Order Value (AOV) of $59.99.  
** Product Performance & Revenue Drivers
* Profit Concentration: The Original Mr. Fuzzy is the primary profit driver, generating $7.38M in gross profit across 24,226 units sold with a 61.01% profit margin.
* Refund Leakage: The Original Mr. Fuzzy also accounts for the highest absolute refund losses at $61,837.63 (5.11% return rate), whereas The Birthday Sugar Panda exhibits the highest overall refund rate at 6.04%.   
** Marketing & Acquisition Channel Efficiency
* Channel Volume Dominance: Paid search (gsearch) is the primary acquisition driver, generating $12.76M in revenue across 316,035 total sessions and 21,333 orders (6.75% conversion rate).
* Conversion Differences: Organic/Direct traffic (Not Available) achieves the highest overall conversion rate at 7.34%, while social channel traffic (socialbook) lags severely at a 3.21% conversion rate and $22.25K in total revenue.
**Funnel Bottlenecks & Conversion Rates
* Top-of-Funnel Drop-Off: Out of 472.87K total landing sessions, only 210.21K users navigate to product pages, resulting in a 44.45% Product Discovery Rate and an immediate drop-off of over 55% of site traffic.
* Severe Checkout Abandonment: The highest mid-funnel loss occurs between cart addition and order completion, where the checkout abandonment rate reaches 65.97% as cart sessions drop from 94.95K to 32.31K final orders.
* High Payment Intent: Users who reach the final checkout stages convert effectively, achieving a 62.07% Billing Completion Rate.
** Customer Retention Dynamics
* Heavy Acquisition vs. Low Retention: Out of 394.31K total unique visitors, 87% (343.05K) are one-time visitors who never return, leading to a low 13.00% Repeat Customer Rate.
* Revenue Impact of Repeat Buyers: The 51.27K repeat users generate $0.58M (29.97%) of total revenue, demonstrating that repeat buyers carry significantly higher long-term lifetime value.
** Device Platform & Refund Trends
* Desktop Conversion Dominance: Desktop users represent the core revenue engine, generating $1.67M in revenue across 27,805 orders compared to mobile's $0.27M across 4,508 orders.
* Matched Device Return Rates: Return rates remain tightly aligned across platforms (5.30% for desktop vs. 5.50% for mobile), ruling out mobile-specific UI issues as a driver for product returns.
* Improving Multi-Year Refund Trend: Historical tracking shows a positive long-term decline in unit return rates, dropping from an early peak of 6.88% in 2012 to an all-time low of 4.23% in 2015. 

## SQL Queries
![Landing_Page](Financial%20Consumer%20Complaint%20Analysis/Data%20Transformation%20Steps/Fact_Complaint%20Table.png)
![Executive_Summary](Financial%20Consumer%20Complaint%20Analysis/Data%20Transformation%20Steps/Dim_Channel.png)
![Product_Performance](/Financial%20Consumer%20Complaint%20Analysis/Data%20Transformation%20Steps/Dim_Location.png)
![Website_Funnel&Conversion_Breakdown](Financial%20Consumer%20Complaint%20Analysis/Data%20Transformation%20Steps/Dim_Product.png)
![Marketing&Acquisition_Channel](Financial%20Consumer%20Complaint%20Analysis/Data%20Transformation%20Steps/Dim_Issue.png)
![Customer_Retention](Financial%20Consumer%20Complaint%20Analysis/Data%20Transformation%20Steps/Dim_Date.png)
![Device&Refunds](Financial%20Consumer%20Complaint%20Analysis/Data%20Transformation%20Steps/Dim_Response.png)

## Data Modeling
![Executive Summary](Financial%20Consumer%20Complaint%20Analysis/Data%20Transformation%20Steps/Data%20Model.png)

## Dashboard
![Landing Page](./Dashboard/Landing%20Page(Page%201).png)
![Executive Summary](./Dashboard/Executive%20Summary(Page%202).png)
![Product Performance](./Dashboard/Product%20Performance(Page%203).png)
![Marketing & Acquisition Channel](./Dashboard/Marketing%20%26%20Acquisition%20Channel(Page%204).png)
![Website Funnel & Conversion Breakdown](./Dashboard/Website%20Funnel%20%26%20Conversion%20Breakdown(Page%205).png)
![Customer Retention](./Dashboard/Customer%20Retention(Page%206).png)
![Device & Refunds](./Dashboard/Device%20%26%20Refunds(Page%207).png)

## PowerBI 
![Dashboard](Financial%20Consumer%20Complaint%20Analysis/Dashboard/Financial%20Complaint%20Dashboard.pbix)

### Recommendations
* Since **Managing an Account** is the top issue, banks should improve customer support workflows to reduce recurring complaints.
* Focused should be on reducing complaints on California and other high‑volume states better branch training.
* Since complaints peaked in 2022 and declined after 2023, institutions should analyze what drove the decline and reinforce those improvements.
* Bank apps should be designed to provide easy account access while allowing customers to monitor all activity — including when, where, how, and who accessed their account — ensuring convenience without compromising security.
* Customer support teams should receive regular training so they are well‑prepared to handle peak complaint periods effectively, ensuring consistent service quality even during high volumes.
  

  
## Author
**ANCHAL CHILWAL**

## Contact Info
* LinkedIn:(https://linkedin.com/in/anchal-chilwal-30b359408)
* GitHub:(https://github.com/AnchalChilwal)



