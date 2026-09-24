CREATE DATABASE IF NOT EXISTS automated_reporting;
USE automated_reporting;

CREATE TABLE sales (
    Order_ID VARCHAR(10),
    Order_Date DATE,
    Customer VARCHAR(50),
    Product VARCHAR(50),
    Category VARCHAR(30),
    Region VARCHAR(20),
    Salesperson VARCHAR(30),
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Discount DECIMAL(5,2),
    Cost_Per_Unit DECIMAL(10,2)
);

INSERT INTO sales VALUES
('ORD001','2026-01-05','Customer 1','Laptop','Electronics','South','Arun',2,55000.00,0.05,42000.00),
('ORD002','2026-01-08','Customer 2','Mouse','Accessories','North','Rahul',5,1200.00,0.10,750.00),
('ORD003','2026-01-12','Customer 3','Keyboard','Accessories','West','Anu',3,2500.00,0.05,1600.00),
('ORD004','2026-01-18','Customer 4','Monitor','Electronics','East','Vishnu',2,18000.00,0.08,13500.00),
('ORD005','2026-01-22','Customer 5','Printer','Electronics','South','Arun',1,22000.00,0.05,17000.00),
('ORD006','2026-02-03','Customer 6','Laptop','Electronics','North','Rahul',1,60000.00,0.10,45000.00),
('ORD007','2026-02-07','Customer 7','Mouse','Accessories','West','Anu',8,1100.00,0.05,700.00),
('ORD008','2026-02-11','Customer 8','Keyboard','Accessories','East','Vishnu',4,2700.00,0.10,1700.00),
('ORD009','2026-02-17','Customer 9','Monitor','Electronics','South','Anu',3,17500.00,0.05,13000.00),
('ORD010','2026-02-25','Customer 10','Printer','Electronics','North','Rahul',2,21000.00,0.08,16500.00),
('ORD011','2026-03-02','Customer 11','Laptop','Electronics','West','Anu',2,58000.00,0.05,43000.00),
('ORD012','2026-03-06','Customer 12','Mouse','Accessories','East','Vishnu',10,1150.00,0.10,720.00),
('ORD013','2026-03-10','Customer 13','Keyboard','Accessories','South','Arun',5,2600.00,0.05,1650.00),
('ORD014','2026-03-19','Customer 14','Monitor','Electronics','North','Rahul',2,18500.00,0.08,14000.00),
('ORD015','2026-03-27','Customer 15','Printer','Electronics','West','Anu',1,22500.00,0.05,17200.00),
('ORD016','2026-04-04','Customer 16','Laptop','Electronics','East','Vishnu',3,57000.00,0.10,42500.00),
('ORD017','2026-04-09','Customer 17','Mouse','Accessories','South','Arun',6,1250.00,0.05,760.00),
('ORD018','2026-04-14','Customer 18','Keyboard','Accessories','North','Rahul',4,2800.00,0.08,1750.00),
('ORD019','2026-04-21','Customer 19','Monitor','Electronics','West','Anu',2,19000.00,0.05,14200.00),
('ORD020','2026-04-28','Customer 20','Printer','Electronics','East','Vishnu',2,21500.00,0.10,16800.00),
('ORD021','2026-05-03','Customer 1','Laptop','Electronics','South','Arun',1,59000.00,0.05,44000.00),
('ORD022','2026-05-08','Customer 2','Mouse','Accessories','North','Rahul',7,1180.00,0.10,730.00),
('ORD023','2026-05-13','Customer 3','Keyboard','Accessories','West','Anu',3,2750.00,0.05,1700.00),
('ORD024','2026-05-20','Customer 4','Monitor','Electronics','East','Vishnu',3,18200.00,0.08,13700.00),
('ORD025','2026-05-26','Customer 5','Printer','Electronics','South','Arun',1,23000.00,0.05,17500.00),
('ORD026','2026-06-04','Customer 6','Laptop','Electronics','North','Rahul',2,61000.00,0.10,46000.00),
('ORD027','2026-06-10','Customer 7','Mouse','Accessories','West','Anu',6,1200.00,0.05,750.00),
('ORD028','2026-06-16','Customer 8','Keyboard','Accessories','East','Vishnu',5,2650.00,0.08,1650.00),
('ORD029','2026-06-22','Customer 9','Monitor','Electronics','South','Arun',2,18800.00,0.05,14000.00),
('ORD030','2026-06-29','Customer 10','Printer','Electronics','North','Rahul',2,21800.00,0.10,16800.00);

CREATE OR REPLACE VIEW sales_report AS
SELECT
    Order_ID,
    Order_Date,
    Customer,
    Product,
    Category,
    Region,
    Salesperson,
    Quantity,
    Unit_Price,
    Discount,
    Cost_Per_Unit,
    ROUND(Quantity * Unit_Price * (1 - Discount), 2) AS Revenue,
    ROUND(Quantity * Cost_Per_Unit, 2) AS Total_Cost,
    ROUND(
        (Quantity * Unit_Price * (1 - Discount))
        - (Quantity * Cost_Per_Unit), 2
    ) AS Profit
FROM sales;

CREATE OR REPLACE VIEW reporting_summary AS
SELECT
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Quantity) AS Total_Quantity,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Total_Cost), 2) AS Total_Cost,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Revenue), 4) AS Profit_Margin
FROM sales_report;