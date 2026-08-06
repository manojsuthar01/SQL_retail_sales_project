create database retail_sales_project;

use retail_sales_project;

drop table if exists retail_sales_tb;
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

-- unique customers we hve?
select count(distinct customer_id) as toal_customers from retail_sales_tb;

-- total category 
select distinct category from retail_sales_tb;


-- check for all the sales made on 2022-22-05:
select * from retail_sales_tb 
where sale_date = '2022-11-05';

select count(*) as total_sale from retail_sales_tb
group by sale_date 
having sale_date = '2022-11-05';


-- check for transaction having category is clothing ,quantity more than 3 and made in month of nov in 2022;

select* from retail_sales_tb
where category = 'Clothing' 
and quantiy >=3 
and date_format(sale_date ,'%Y-%m') = '2022-11';

-- total sale made for each category

select category,
 sum(total_sale) as net_sale,
 count(*) as Total_orders
 from retail_sales_tb
group by category;


-- average age of customers who purchased items from beauty category 

select round(avg(age),2) as avg_age 
from retail_sales_tb 
where category ='Beauty';


-- All the transactions where Total Sale is more than 1000

select * from retail_sales_tb 
where total_sale > 1000;

-- Total number of transacton(transactions_id) made by each gender in each category;

select category,
		gender,
        count(*) as total_trans
	from retail_sales_tb
group by category,
		gender
	order by category;
    
-- Calculate average sale for each month and find out best selling month in each year

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

-- top 5 customer based on the highest total_sale

select customer_id,
		sum(total_sale) as sale
	from retail_sales_tb
group by customer_id
order by sale desc
limit 5;

-- number of unique customer who purchased items from each category 

select category,
        count(distinct customer_id) as Total_unique_customer
	from retail_sales_tb
    group by category;
    
    
-- create shift and number of orderes (ex: morning <=12, afternoon between 12 and 17 and evening >=17 

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


