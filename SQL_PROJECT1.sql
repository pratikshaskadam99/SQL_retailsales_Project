-- SQL RETAIL SALES PROJECT 

-- CREATE DATABASE 
CREATE DATABASE Retail_sales_project;

-- CREATE TABLE
DROP TABLE IF EXISTS Retail_Sales;
CREATE TABLE Retail_Sales 
(
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    customer_id VARCHAR(20),
    gender VARCHAR(15),
    age INT,
    product_category VARCHAR(15),
    quantity INT,
    price_per_unit Float,
    total_sale Float

);

-- Check created table 
Select * FROM Retail_Sales;

-- 1. DATA CLEANING

-- Check null values IF ANY
SELECT * FROM Retail_Sales
WHERE
transaction_id IS NULL
OR
sale_date IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR
age IS NULL 
OR
product_category IS NULL 
OR
quantity IS NULL 
OR 
price_per_unit IS NULL
OR
total_sale IS NULL
;

-- Are there any duplicate values?
SELECT *,
       COUNT(*) AS Duplicate_Count
FROM Retail_Sales
GROUP BY transaction_id, sale_date, customer_id, gender, age, product_category, product_quantity, Price_per_product, total_amount
HAVING COUNT(*) > 1;




-- 2. DATA EXPLORATION 

-- 1. What’s the total number of transactions/customers?
SELECT COUNT(transaction_id) AS Total_transaction FROM Retail_Sales;

SELECT COUNT(customer_id) AS Total_customer FROM Retail_Sales;


-- 2. How many unique customer we have?
SELECT COUNT(DISTINCT customer_id) AS Unique_customer FROM Retail_Sales;


-- 3. How many categories we have ?/ which categories we have ?
SELECT COUNT(DISTINCT product_category) AS total_category FROM Retail_Sales;
SELECT DISTINCT product_category AS total_category FROM Retail_Sales;


-- 4. What’s the average, min, max age of customers?
SELECT 
    AVG(Age) AS Average_Age,   -- gives the average age of all customers
    MIN(Age) AS Min_Age,      -- gives youngest customer
    MAX(Age) AS Max_Age       -- gives oldest customer
FROM Retail_Sales;


-- 5. Which categories sell the most by quantity?
SELECT 
    product_category,
    SUM(product_quantity) AS Total_Quantity_Sold
FROM Retail_Sales
GROUP BY product_category
ORDER BY Total_Quantity_Sold DESC;      -- Shows the highest-selling categories at the top.

-- 6. How do sales vary over time ?
SELECT 
    sale_date,
    SUM(total_sale) AS Total_Sales
FROM Retail_Sales
GROUP BY sale_date
ORDER BY sale_date;  
-- Shows total sales for each day.

SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS Month,
    SUM(total_sale) AS Total_Sales
FROM Retail_Sales
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY Month;
-- Shows sales trends month by month.





-- DATA ANALYSIS & BUSINESS KEY PROBLEMS 

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2023-11-05'. (sales made on a particular date )
SELECT * 
FROM Retail_Sales
WHERE sale_date = '2023-11-05';



-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2023.

SELECT *
FROM Retail_Sales
WHERE 
      product_category = 'Clothing'
      AND
	  product_quantity > 3
      AND 
      sale_date >= '2023-11-01'
      AND 
      sale_date < '2023-12-01';
      
   

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
       product_category, 
       SUM(total_sale) AS total_sale_category
FROM Retail_Sales
GROUP BY product_category;



-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
      ROUND(AVG(age),2) AS average_age
FROM  Retail_Sales
WHERE product_category = 'Beauty';


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT *
FROM Retail_Sales
WHERE total_sale > 1000;



-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
       product_category,
       gender,
       COUNT(transaction_id) AS total_transactions
FROM Retail_Sales
GROUP BY product_category, gender
ORDER BY product_category, gender ;



-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.


SELECT 
      year,
      month,
      avg_sale

FROM  
(   
          SELECT 
                 YEAR(sale_date) as year,
                 MONTH(sale_date) as month,
				 AVG(total_sale) as avg_sale,
                 RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS Ranking
     
 
		  FROM retail_sales
		  GROUP BY year, month
) AS T1
WHERE Ranking = 1;



-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.

SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;



-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT
      product_category, 
      COUNT(DISTINCT customer_id) AS unique_customer
      
FROM Retail_Sales
GROUP BY product_category;

	

-- Q.10 Write a SQL query to find which customer segment (age group: <25, 25–40, >40) spends the most?

SELECT 
    CASE 
        WHEN age < 25 THEN '<25'
        WHEN age BETWEEN 25 AND 40 THEN '25-40'
        ELSE '>40'
    END AS Age_Group,
    SUM(total_sale) AS Total_Spending
FROM Retail_sales
GROUP BY Age_Group
ORDER BY Total_Spending DESC;



-- END OF PROJECT





























