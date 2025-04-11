# Retail_Sales_Analysis

📊 Retail Sales Analysis – Cell Force Store (MySQL Project)
Welcome to the Cell Force Store Retail Sales Analysis project! This project focuses on cleaning, exploring, and analyzing a fictional retail sales dataset using MySQL. It simulates a real-world scenario of sales operations in a retail store selling items in categories like Beauty, Clothing, and Electronics.

🗂️ Project Structure
Database Name: cell_force_db

Main Table: sales

Data Columns:

transactions_id (Primary Key)

sale_date, sale_time

customer_id, gender, age

category, quantity, price_per_unit

cogs, total_sale

🔧 Tasks Performed
✅ 1. Database Setup
Created the database and sales table.

Imported the dataset into MySQL.

✅ 2. Data Cleaning
Checked for null values.

Removed incomplete or corrupted rows.

✅ 3. Data Exploration
Total number of sales and unique customers.

Categories available and their distribution.

Validated data integrity after cleaning.

✅ 4. Sales Analysis with SQL
🧮 Key Insights Extracted:
Question	Description
Q1	Sales on a specific date (2022-11-05)
Q2	High-volume clothing purchases in November
Q3	Total sales by category
Q4	Average age of beauty product buyers
Q5	Transactions over $1000
Q6	Transaction count by gender and category
Q7	Best performing month each year by avg. sale
Q8	Top 5 customers by total purchase
Q9	Unique customers per category
Q10	Shift-wise sales breakdown (Morning, Afternoon, Evening)
📈 Sample Analysis – Shift-Based Sales
sql
Copy
Edit
SELECT
  CASE
    WHEN HOUR(sale_time) < 12 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift,
  COUNT(*) AS num_of_orders
FROM sales
GROUP BY shift;
🧠 Skills Demonstrated
SQL for Data Cleaning, Aggregation, and Analysis

Window Functions (ROW_NUMBER)

CTEs and Subqueries

Grouping and Filtering

Real-world scenario simulation for retail analytics

🗃️ Tools Used
MySQL (for all SQL queries and data handling)

GitHub (to track project progress)

🚀 Next Steps (Optional Ideas)
Visualize sales trends with Power BI or Tableau

Extend the database with staff or inventory tables

Analyze profit margins and promotional effectiveness

📎 License
This project uses fake data for educational purposes and is open-sourced under the MIT license.
