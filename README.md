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
Desktop Revenue Dominance: Desktop users drive $1.67M in revenue across 27,805 orders, serving as the core conversion engine compared to mobile's $0.27M.

Top-of-Funnel Drop-Off: Out of 472.87K total sessions, only 108.18K users advance past the landing page to view specific products (44.45% product discovery rate).

Customer Retention Gap: Out of 394.3K unique users, 87% (343.05K) are one-time purchasers, leaving a massive opportunity for email remarketing to lift the 13% repeat rate.

Improving Refund Trends: Multi-year tracking reveals a positive downward trend in unit refund rates from an early peak of 6.88% (2012) down to an all-time low of 4.23% (2015).

## Data Transformation
![Fact_ComplaintTable](Financial%20Consumer%20Complaint%20Analysis/Data%20Transformation%20Steps/Fact_Complaint%20Table.png)
![Dim_ChannelTable](Financial%20Consumer%20Complaint%20Analysis/Data%20Transformation%20Steps/Dim_Channel.png)
![Dim_LocationTable](/Financial%20Consumer%20Complaint%20Analysis/Data%20Transformation%20Steps/Dim_Location.png)
![Dim_ProductTable](Financial%20Consumer%20Complaint%20Analysis/Data%20Transformation%20Steps/Dim_Product.png)
![Dim_IssueTable](Financial%20Consumer%20Complaint%20Analysis/Data%20Transformation%20Steps/Dim_Issue.png)
![Dim_DateTable](Financial%20Consumer%20Complaint%20Analysis/Data%20Transformation%20Steps/Dim_Date.png)
![Dim_ResponseTable](Financial%20Consumer%20Complaint%20Analysis/Data%20Transformation%20Steps/Dim_Response.png)

## Data Modeling
![Executive Summary](Financial%20Consumer%20Complaint%20Analysis/Data%20Transformation%20Steps/Data%20Model.png)

## Dashboard
![Executive Summary](Financial%20Consumer%20Complaint%20Analysis/Dashboard/Executive%20Summary.png)
![Product & Issue Insight](Financial%20Consumer%20Complaint%20Analysis/Dashboard/Product%20%26%20Issue%20Insight.png)
![Response Insight](Financial%20Consumer%20Complaint%20Analysis/Dashboard/Response%20Insight.png)
![Deeper Analysis 1](Financial%20Consumer%20Complaint%20Analysis/Dashboard/Deeper%20Analysis%201.png)
![Deeper Analysis 2](Financial%20Consumer%20Complaint%20Analysis/Dashboard/Deeper%20Analysis%202.png)

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



