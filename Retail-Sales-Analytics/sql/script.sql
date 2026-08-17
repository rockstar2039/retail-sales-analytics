USE retail_sales;
SELECT *
FROM superstore
LIMIT 10;

DESCRIBE superstore;

SELECT COUNT(*) AS total_rows
FROM superstore;

SELECT DISTINCT Region
FROM superstore;

SELECT DISTINCT Category
FROM superstore;

SELECT
    COUNT(DISTINCT `Customer ID`) AS total_customers
FROM superstore;

SELECT
    COUNT(DISTINCT `Order ID`) AS total_orders
FROM superstore;

SELECT
    MIN(`Order Date`),
    MAX(`Order Date`)
FROM superstore;

SELECT
    MIN(STR_TO_DATE(`Order Date`, '%d/%m/%Y')) AS earliest_date,
    MAX(STR_TO_DATE(`Order Date`, '%d/%m/%Y')) AS latest_date
FROM superstore;

SELECT
    SUM(CASE WHEN `Order ID` IS NULL THEN 1 ELSE 0 END)
        AS missing_order_id,

    SUM(CASE WHEN `Customer ID` IS NULL THEN 1 ELSE 0 END)
        AS missing_customer_id,

    SUM(CASE WHEN `Product Name` IS NULL THEN 1 ELSE 0 END)
        AS missing_product,

    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END)
        AS missing_sales,

    SUM(CASE WHEN `Order Date` IS NULL THEN 1 ELSE 0 END)
        AS missing_order_date

FROM superstore;

SELECT
    `Row ID`,
    COUNT(*) AS occurrences
FROM superstore
GROUP BY `Row ID`
HAVING COUNT(*) > 1;

ALTER TABLE superstore
ADD COLUMN Order_Date_Clean DATE,
ADD COLUMN Ship_Date_Clean DATE;

SET SQL_SAFE_UPDATES = 0;

UPDATE superstore
SET
    Order_Date_Clean =
        STR_TO_DATE(`Order Date`, '%d/%m/%Y'),

    Ship_Date_Clean =
        STR_TO_DATE(`Ship Date`, '%d/%m/%Y');
        
ALTER TABLE superstore
DROP COLUMN `Order Date`,
DROP COLUMN `Ship Date`;
ALTER TABLE superstore
RENAME COLUMN Order_Date_Clean TO Order_Date,
RENAME COLUMN Ship_Date_Clean TO Ship_Date;


SELECT
    Region,
    ROUND(SUM(Sales), 2) AS total_sales
FROM superstore
GROUP BY Region
ORDER BY total_sales DESC;

SELECT
    Region,
    COUNT(DISTINCT `Order ID`) AS number_of_orders
FROM superstore
GROUP BY Region
ORDER BY number_of_orders DESC;

SELECT
    Region,

    ROUND(SUM(Sales), 2)
        AS total_sales,

    COUNT(DISTINCT `Order ID`)
        AS number_of_orders,

    ROUND(
        SUM(Sales) /
        COUNT(DISTINCT `Order ID`),
        2
    ) AS avg_order_value

FROM superstore
GROUP BY Region
ORDER BY avg_order_value DESC;

SELECT
    Region,
    COUNT(DISTINCT `Customer ID`) AS number_of_customers
FROM superstore
GROUP BY Region
ORDER BY number_of_customers DESC;

SELECT
    Region,
    COUNT(DISTINCT `Customer ID`)
        AS number_of_customers,
    COUNT(DISTINCT `Order ID`)
        AS number_of_orders,
    ROUND(
        COUNT(DISTINCT `Order ID`) /
        COUNT(DISTINCT `Customer ID`),
        2
    ) AS orders_per_customer
FROM superstore
GROUP BY Region
ORDER BY orders_per_customer DESC;

desc superstore;

select Region , Category , round(sum(Sales),2) as Total_Sales , count(distinct(`Order ID`)) as Unique_Orders
from superstore
group by Region, Category
order by  Region, Total_Sales desc;

select Region , Category , round(sum(Sales),2) as Total_Sales , count(distinct(`Order ID`)) as Unique_Orders
from superstore
where Region in ('West','South')
group by Region, Category
order by  Region, Total_Sales desc;

select Region, `Sub-Category`, round(sum(Sales),2) as  Total_Sales,count(distinct(`Order ID`)) as Unique_Orders
from superstore
where Region in ('West','South')
group by Region,`Sub-Category`
ORDER BY Region, Total_Sales DESC;

select Region, `Sub-Category`, round(sum(Sales),2) as  Total_Sales,count(distinct(`Order ID`)) as Unique_Orders,
round(sum(Sales) / COUNT(DISTINCT `Order ID`),2) as Sales_per_order
from superstore
where Region in ('West','South')
group by Region,`Sub-Category`
ORDER BY Region, Total_Sales DESC;

select `Product Name`,round(sum(Sales),2) as Total_Sales 
from superstore
group by `Product Name` 
order by Total_Sales desc
limit 10;

select `Product Name`,round(sum(Sales),2) as Total_Sales , count(distinct(`Order ID`)) as Unique_Orders, 
sum(Sales) / count(distinct(`Order ID`)) as Sales_per_order
from superstore
group by `Product Name` 
order by Total_Sales desc
limit 10;

select year(Order_Date) as Years, sum(Sales) as Total_Sales, count(distinct(`Order ID`)) as Unique_Orders
from superstore
WHERE YEAR(Order_Date) BETWEEN 2015 AND 2018
group by year(Order_Date)
order by Years desc;


select year(Order_Date) as Years, sum(Sales) as Total_Sales, count(distinct(`Order ID`)) as Unique_Orders,
round(sum(Sales) / count(distinct(`Order ID`)),2) as Avg_Order_Value
from superstore
WHERE YEAR(Order_Date) BETWEEN 2015 AND 2016
group by year(Order_Date)
order by Years desc;


select year(Order_Date) as Years,monthname(Order_Date) as Months, sum(Sales) as Total_Sales, count(distinct(`Order ID`)) as Unique_Orders,
round(sum(Sales) / count(distinct(`Order ID`)),2) as Avg_Order_Value
from superstore
group by year(Order_Date) , month(Order_Date),monthname(Order_Date) 
order by year(Order_Date),Month(Order_Date);

select `Customer Name` , round(sum(Sales),2) as Total_Sales, count(distinct(`Order ID`)) as Unique_Order,
round(sum(Sales) / count(distinct(`Order ID`)),2) as Average_order_value
from superstore 
group by `Customer Name`
order by Total_Sales desc
limit 10;

desc superstore;

select `Customer ID`  , `Customer Name` , count(distinct(`Order ID`)) as Unique_Order, round(sum(Sales),2) as Total_Sales
from superstore
group by `Customer ID` ,`Customer Name`
having count(distinct `Order ID`) = 1;

select count(*) as One_Time_Customers,
round(sum(Total_Sales),2) as One_Time_Customer_Sales,
round(avg(Total_Sales),2) as Avg_Sales_Per_Customer
from(
select `Customer ID`,
sum(Sales) as Total_Sales
from superstore
group by `Customer ID`
having count(distinct `Order ID` ) =1
) as one_time_customers;

select  Number_Of_Orders,
count(*) as Number_Of_Customers
from (
select `Customer ID`,
count(distinct `Order ID`) as Number_Of_Orders
from superstore
group by `Customer ID`
) as customer_orders
group by Number_Of_Orders
order by Number_Of_Orders;

select `Customer ID` , `Customer Name` , count(distinct `Order ID`) as Unique_Orders,
round(sum(Sales),2) as Total_Sales,  
round(sum(Sales) / count(distinct `Order ID`)) as Average_Order_Value
from superstore
group by `Customer ID` , `Customer Name`
having count(distinct `Order ID`) >= 10
order by Total_Sales desc;

select `Customer ID` , Unique_Orders,
case 
when Unique_Orders <=3 then 'Low Frequency'
when Unique_Orders <=7 then 'Regular'
when Unique_Orders <=12 then 'High Frequency'
else 'Very High Frequency'
end as Customer_Segment
from (
select `Customer ID`,
count(distinct `Order ID`) as Unique_Orders
from superstore
group by `Customer ID` ) as customer_data; 

select `Customer ID` , Unique_Orders, Total_Sales,
case 
when Unique_Orders <=3 then 'Low Frequency'
when Unique_Orders <=7 then 'Regular'
when Unique_Orders <=12 then 'High Frequency'
else 'Very High Frequency'
end as Customer_Segment
from (
select `Customer ID`,
count(distinct `Order ID`) as Unique_Orders,
sum(Sales) as Total_Sales
from superstore
group by `Customer ID` ) as customer_data; 

select Customer_Segment , count(*) as Number_Of_Customers,
round(sum(Total_Sales),2) as Total_Sales,
round(avg(Total_Sales),2) as Avg_Sales_Per_Customer
from (
select `Customer ID` , Unique_Orders, Total_Sales,
case 
when Unique_Orders <=3 then 'Low Frequency'
when Unique_Orders <=7 then 'Regular'
when Unique_Orders <=12 then 'High Frequency'
else 'Very High Frequency'
end as Customer_Segment
from (
select `Customer ID`,
count(distinct `Order ID`) as Unique_Orders,
sum(Sales) as Total_Sales
from superstore
group by `Customer ID` ) as customer_data 
) as customer_data
group by Customer_Segment
order by Total_Sales desc;


select year(Order_Date) as year, Region , round(sum(Sales),2) as Total_Sales, count(distinct(`Order ID`)) as Unique_Orders
from superstore
group by year(Order_Date) , Region
order by year(Order_Date), Region;

select year(Order_Date) as year , Region , count(distinct `Customer ID`) as Customers, count(distinct `Order ID`) as Orders, round(sum(Sales),2 )  as Total_Sales,
round(sum(Sales) / count(distinct `Order ID`),2) as AOV
from superstore
where year(Order_Date) in (2015 , 2018)
group by year(Order_Date), Region ;

select year(Order_Date) as year, Category , round(sum(Sales),2) as Total_Sales,
count(distinct `Order ID`) as Unique_orders, 
round( sum(Sales) / count(distinct `Order ID`) ,2) as AOV
from superstore 
where year(Order_Date) in (2015 , 2018) and Region = 'South'
group by year(Order_Date),Category
order by year, Total_Sales desc;

select year(Order_Date) as year, `Product Name`, round(sum(Sales),2) as Total_Sales,
count(distinct `Order ID`) as Unique_orders, 
round( sum(Sales) / count(distinct `Order ID`) ,2) as AOV
from superstore 
where  Region = 'South' and Category = 'Technology' and `Sub-Category` = 'Machines' AND YEAR(Order_Date) IN (2015, 2018)
group by year(Order_Date),`Product Name`
order by year, Total_Sales desc;

SELECT
    YEAR(Order_Date) AS year,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    COUNT(DISTINCT `Order ID`) AS Unique_Orders
FROM superstore
WHERE Region = 'South'
  AND Category = 'Technology'
  AND `Sub-Category` = 'Machines'
  AND YEAR(Order_Date) IN (2015, 2018)
GROUP BY YEAR(Order_Date)
ORDER BY year;