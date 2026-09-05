CREATE DATABASE IF NOT EXISTS superstore_new;
USE superstore_new;
Task 3
CREATE TABLE Orders (
    `Row ID` INT,
    `Order ID` VARCHAR(20),
    `Order Date` DATE,
    `Customer ID` VARCHAR(20),
    `Product Category` VARCHAR(50),
    `Sales` DECIMAL(10,2),
    `Quantity` INT,
    `Discount` DECIMAL(5,2),
    `Profit` DECIMAL(10,4)
);
CREATE TABLE Customers (
    `Row ID` INT,
    `Customer ID` VARCHAR(20),
    `Customer Name` VARCHAR(100),
    `Region` VARCHAR(50),
    `Segment` VARCHAR(50)
);
SELECT * FROM Orders LIMIT 5;
SELECT * 
FROM Customers
LIMIT 5;
SELECT
    YEAR(`Order Date`) AS Year,
    MONTH(`Order Date`) AS Month,
    SUM(Sales) AS Monthly_Sales,
    SUM(Profit) AS Monthly_Profit
FROM Orders
GROUP BY Year, Month
ORDER BY Year, Month;

SELECT
    t1.Month,
    t1.Monthly_Sales,
    (t1.Monthly_Sales - t2.Monthly_Sales) / t2.Monthly_Sales * 100 AS Growth_Percentage
FROM
    (SELECT MONTH(`Order Date`) AS Month, SUM(Sales) AS Monthly_Sales
     FROM Orders GROUP BY Month) t1
JOIN
    (SELECT MONTH(`Order Date`) AS Month, SUM(Sales) AS Monthly_Sales
     FROM Orders GROUP BY Month) t2
ON t1.Month = t2.Month + 1;

SELECT
    `Order ID`,
    Sales,
    CASE
        WHEN Sales > 1000 THEN 'High Value'
        WHEN Sales BETWEEN 500 AND 1000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Order_Type
FROM Orders;

SELECT
    c.Region,
    SUM(o.Profit) AS Total_Profit
FROM Orders o
JOIN Customers c 
    ON o.`Customer ID` = c.`Customer ID`
GROUP BY c.Region
HAVING SUM(o.Profit) < 10000;

SELECT
    c.Region,
    SUM(o.Profit) AS Total_Profit
FROM Orders o
JOIN Customers c
    ON o.`Customer ID` = c.`Customer ID`
GROUP BY c.Region
ORDER BY Total_Profit ASC;

