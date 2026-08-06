# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `retail_sales_project`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `retail_sales_project`.
- **Table Creation**: A table named `retail_sales_tb` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE retail_sales_project;

create table retail_sales_tb(
			transactions_id	int,
			sale_date date,
			sale_time time,	
			customer_id	int,
			gender varchar(15),	
			age	int,
			category varchar(25),	
			quantiy	int,
			price_per_unit float,	
			cogs float,	
			total_sale float
		);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
select* from retail_sales_tb ;
select count(*) from retail_sales_tb;


select* from retail_sales_tb
where
	transactions_id is null or 
    sale_date is null or 
    sale_time is null or 
    customer_id is null or 
    gender is null or 
    age is null or 
    category is null or 
    quantiy is null or 
    price_per_unit is null or 
    cogs is null or 
    total_sale is null ;

describe retail_sales_tb;

select count(*)
from retail_sales_tb 
where age  is null;

-- total sales we have 
select count(*) from retail_sales_tb;
-- unique customers we have?
select count(distinct customer_id) as toal_customers from retail_sales_tb;

-- total category 
select distinct category from retail_sales_tb;

```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **check for all the sales made on 2022-22-05**:
```sql
select * from retail_sales_tb 
where sale_date = '2022-11-05';

select count(*) as total_sale from retail_sales_tb
group by sale_date 
having sale_date = '2022-11-05';
```

2. **check for transaction having category is clothing ,quantity more than 3 and made in month of nov in 2022**:
```sql
select* from retail_sales_tb
where category = 'Clothing' 
and quantiy >=3 
and date_format(sale_date ,'%Y-%m') = '2022-11';
```

3. **Total sale made for each category.**:
```sql
select category,
 sum(total_sale) as net_sale,
 count(*) as Total_orders
 from retail_sales_tb
group by category;

```

4. **Average age of customers who purchased items from beauty category.**:
```sql
select round(avg(age),2) as avg_age 
from retail_sales_tb 
where category ='Beauty';
```

5. **All the transactions where Total Sale is more than 1000.**:
```sql
select * from retail_sales_tb 
where total_sale > 1000;
```

6. **Total number of transacton(transactions_id) made by each gender in each category.**:
```sql
select category,
		gender,
        count(*) as total_trans
	from retail_sales_tb
group by category,
		gender
	order by category;
    
```

7. **Calculate average sale for each month and find out best selling month in each year.**:
```sql
select 
	year,
    month,
    avg_sale
from(
	select 
		year(sale_date) as year,
		month(sale_date) as month,
		round(avg(total_sale),2) as Avg_sale,
		rank() over(partition by year(sale_date) order by avg(total_sale)) as rankk
	from retail_sales_tb
	group by year,month
)as t1
where rankk = 1;
```

8. **Top 5 customer based on the highest total_sale.**:
```sql
select customer_id,
		sum(total_sale) as sale
	from retail_sales_tb
group by customer_id
order by sale desc
limit 5;
```

9. **Number of unique customer who purchased items from each category.**:
```sql
select category,
        count(distinct customer_id) as Total_unique_customer
	from retail_sales_tb
    group by category;
```

10. **create shift and number of orderes (ex: morning <=12, afternoon between 12 and 17 and evening >=17)**:
```sql
with hourly_sale as( 
	select *,
		case
			when hour(sale_time) < 12 then 'Morning'
			when hour(sale_time) >=17 then 'Evening'
			else 'afternoon'
			end as shift
	from retail_sales_tb
)
select shift,
count(*) as total_orders
from hourly_sale 
group by shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Manoj Suthar

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!


Thank you for your support, and I look forward to connecting with you!
