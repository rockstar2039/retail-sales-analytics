# 📊 Retail Sales Analytics

An end-to-end retail sales analytics project using **MySQL, SQL, Python, and Power BI** to analyze sales performance, customer purchasing behavior, regional performance, and product-level trends.

The project combines SQL-based analysis, Python data exploration, customer segmentation, and an interactive Power BI dashboard to convert raw retail transactions into actionable business insights.

---

## 📸 Dashboard Preview

![Retail Sales Analytics Dashboard](https://github.com/rockstar2039/retail-sales-analytics/blob/main/screenshots/Screenshot%202026-08-17%20202833.png)

---

## 🎯 Project Objective

The objective of this project is to analyze retail transaction data and answer key business questions such as:

- How are sales changing over time?
- Which regions generate the most revenue?
- Which categories and sub-categories drive sales?
- Which products have the highest and lowest sales?
- How frequently do customers place orders?
- Which customer segments contribute the most revenue?
- How does Average Order Value (AOV) vary across different groups?

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| **MySQL** | Data querying and business analysis |
| **SQL** | Aggregation, filtering, grouping and customer analysis |
| **Python** | Data analysis and visualization |
| **Pandas** | Data manipulation and aggregation |
| **Matplotlib** | Exploratory visualizations |
| **Power BI** | Interactive dashboard and reporting |
| **DAX** | KPI measures and analytical calculations |

---

## 📂 Project Structure
retail-sales-analytics/

├── powerbi/
│   └── Retail_Sales_Analytics_Dashboard.pbix

├── python/
│   └── sales_analysis.py

├── screenshots/
│   └── retail_sales_dashboard.png

├── sql/
│   └── superstore_analysis.sql
│
└── README.md

🔍 Analysis Performed
1. Sales Trend Analysis

Analyzed yearly and monthly sales performance to identify growth patterns and changes in revenue over time.

Key observations:

Sales declined slightly in 2016 compared with 2015.
Sales increased strongly in 2017.
2018 recorded the highest yearly sales.
2. Regional Sales Analysis

Compared sales and order performance across the four regions:

West
East
Central
South

West generated the highest overall sales, while South generated the lowest.

Regional performance was also analyzed using:

Total Sales
Unique Orders
Average Order Value
3. Category Analysis

The three major product categories were analyzed:

Technology
Furniture
Office Supplies

Technology generated the highest total sales.

4. Sub-Category Analysis

Sales were further analyzed at the sub-category level.

The leading sub-categories were:

Phones
Chairs
Storage
Tables
Binders

This analysis helped identify the major product groups contributing to overall revenue.

5. Customer Analysis

Customer purchasing behavior was analyzed using:

Unique Orders
Total Sales
Average Order Value

Customers were grouped according to their purchasing frequency.

| Unique Orders | Customer Segment    |
| ------------: | ------------------- |
|           1–3 | Low Frequency       |
|           4–7 | Regular             |
|          8–12 | High Frequency      |
|           13+ | Very High Frequency |

The segmentation showed that:

Regular customers represent the largest customer group and generate the highest total revenue.
High-frequency customers generate strong revenue and higher value per customer.
Low-frequency and very-high-frequency groups are considerably smaller.

📈 Key Business Insights
Sales Performance:
Sales experienced a small decline in 2016 before accelerating significantly in 2017 and 2018.

Regional Performance:
West is the strongest-performing region, while South has the lowest overall sales.

Category Performance:
Technology is the highest-performing category.

Product Performance:
Phones and Chairs are the leading sub-categories by sales.

Customer Behavior:
Regular customers generate the highest total revenue because of their larger customer base, while high-frequency customers demonstrate stronger value per customer.

📊 Power BI Dashboard

The interactive dashboard provides:

Total Sales KPI
Total Orders KPI
Total Customers KPI
Average Order Value KPI
Yearly Sales Trend
Regional Sales Performance
Category Sales Performance
Sub-Category Sales Analysis
Customer Segment Analysis
Year, Region and Category slicers
Key Business Insights

Users can interact with the slicers to investigate sales performance for specific years, regions, and product categories.

💡 Example Analysis
One example of the interactive analysis is filtering:
Year: 2018
Region: South
Category: Technology
This produces approximately $44.52K in sales, with Phones, Machines, Accessories, and Copiers contributing to the result.

🚀 Project Workflow
Raw Retail Data
       ↓
MySQL Database
       ↓
SQL Business Analysis
       ↓
Python / Pandas Analysis
       ↓
Customer Segmentation
       ↓
Power BI Data Model
       ↓
DAX Measures
       ↓
Interactive Dashboard
       ↓
Business Insights

📌 Key Skills Demonstrated
SQL querying
Data aggregation
GROUP BY and HAVING
Filtering and conditional logic
Customer segmentation
Sales trend analysis
Exploratory data analysis
Python/Pandas
Data visualization
Power BI
DAX
Dashboard design
Business interpretation


👤 Author

Chinmaya S
MCA Student | Data Analytics & Machine Learning Enthusiast

⭐ Project Summary
This project demonstrates an end-to-end data analytics workflow, from querying transactional data using SQL to building an interactive Power BI dashboard and translating analytical findings into business insights.
