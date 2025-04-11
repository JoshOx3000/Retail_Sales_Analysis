-- Creation of the Database
CREATE Database cell_force_db;

USE cell_force_db;

-- Create table
DROP TABLE IF EXISTS sales;
CREATE TABLE sales(
	transactions_id int PRIMARY KEY,
	sale_date DATE,
    sale_time TIME,
	customer_id INT,
    gender VARCHAR(15),	
    age INT,
    category VARCHAR(15),
	quantity INT,
	price_per_unit DECIMAL(10,2),
	cogs DECIMAL(10,2),
	total_sale DECIMAL(10,2)
);

show tables;


-- imported data testing for data inserted properly
SELECT *
FROM sales
LIMIT 10
;

-- Checking for null values
SELECT *
FROM sales
WHERE transactions_id IS NULL
	OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR 
    customer_id IS NULL
    OR
    gender IS NULL
    OR
    age IS NULL
    OR
    category IS NULL
    OR 
    quantity IS NULL
    OR
    price_per_unit IS NULL
    OR 
    cogs IS NULL
    OR 
    total_sale IS NULL
;

-- Removing null values from the table

DELETE FROM Sales 
WHERE transactions_id IS NULL
	OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR 
    customer_id IS NULL
    OR
    gender IS NULL
    OR
    age IS NULL
    OR
    category IS NULL
    OR 
    quantity IS NULL
    OR
    price_per_unit IS NULL
    OR 
    cogs IS NULL
    OR 
    total_sale IS NULL
;

-- quality check to ensure null values were deleted
SELECT *
FROM sales
WHERE transactions_id IS NULL
	OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR 
    customer_id IS NULL
    OR
    gender IS NULL
    OR
    age IS NULL
    OR
    category IS NULL
    OR 
    quantity IS NULL
    OR
    price_per_unit IS NULL
    OR 
    cogs IS NULL
    OR 
    total_sale IS NULL
;

-- Data exploration

-- How many sales we have?
SELECT COUNT(*) AS total_sales
FROM sales
;
-- output: 1987 Total Sales

-- How many customer(unique) do we have?
SELECT 
	COUNT( DISTINCT customer_id) AS Customer_count
FROM sales
;

-- output: 155 Customers


-- How many categories do we have?
SELECT 
	COUNT( DISTINCT category) AS Categories_count
FROM sales
;

-- output: 3 Categories

-- What are the categories for sales
SELECT 
	DISTINCT category AS Categories
FROM sales
;

-- output: categories: Beauty, Clothing, Electronics


-- Data Analysis

-- Q1.  Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT *
FROM sales
WHERE sale_date  = '2022-11-05'
;

-- Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' 
--     and the quantity sold is more than 4 in the month of Nov-2022:
SELECT *
FROM sales
WHERE category = 'Clothing'
	AND quantity >= 4
    AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
;


-- 
-- Q3. Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT
	category,
    SUM(total_sale) AS total_sale_per_category,
    COUNT(*) AS total_orders
FROM sales
GROUP BY category
;

-- Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

SELECT
	category,
	ROUND(AVG(age), 2) AS avg_age
FROM sales
GROUP BY category
HAVING category = 'Beauty'
;
-- average age 40.42 

-- Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * 
FROM sales
WHERE total_sale > 1000
;

-- Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT
	category,
	gender,
    COUNT(*) AS total_transaction
FROM Sales
GROUP BY category, gender
ORDER BY category
;

-- Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

WITH monthly_avg AS 
(
	SELECT 
		year(sale_date) AS sale_year,
		month(sale_date) AS sale_month,
		AVG(total_sale) AS avg_monthly_sale
FROM sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
),
ranked_months AS(
	SELECT *,
		ROW_NUMBER() OVER(PARTITION BY sale_year ORDER BY avg_monthly_sale DESC) AS rn
	FROM monthly_avg
)
SELECT 
	sale_year,
    sale_month,
    ROUND(avg_monthly_sale, 2)
FROM ranked_months
WHERE rn = 1
;

-- Q8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT
	customer_id,
    SUM(total_sale)
FROM sales
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5
;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT
	category,
    COUNT(DISTINCT customer_id) AS count_unique_cust
FROM sales
GROUP BY category
;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
SELECT
	
	CASE
		WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
	END AS shift,
    COUNT(*) AS num_of_orders
FROM sales
GROUP BY shift
;

