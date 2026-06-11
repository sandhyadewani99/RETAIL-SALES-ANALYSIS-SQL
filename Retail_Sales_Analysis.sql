 -- ## RETAIL_SALES_ANALYSIS_SQL_PROJECT ##
 -- =========================================================================================================================================================
CREATE DATABASE Retail_Sales_Analysis_SQL_Project;

 use Retail_Sales_Analysis_SQL_Project;
 
 create table Retail_Sales_Analysis(
 transactions_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(30),
age int,
category  varchar(30),
quantity int,
price_per_unit decimal (10,2),
cogs decimal (10,2),
total_sale decimal (10,2));

 -- ### DATA VALIDATION ##
 
select count(*) AS Total_Rows from Retail_Sales_Analysis;
select * from Retail_Sales_Analysis limit 1000;


 -- ### DATA CLEANING ##

 -- (1): Null Values Check
select * from Retail_Sales_Analysis where
transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs  is null
or total_sale is null ;

 -- (2): Duplicate Records Check
select transactions_id, count(*) as duplicate_counts from Retail_Sales_Analysis
group by transactions_id having  count(*) >1;

 -- (3): Negative Values Check
 
select * from Retail_Sales_Analysis where
 quantity < 0
or price_per_unit < 0
or cogs  < 0
or total_sale < 0;

 -- (4): Invalid Age Check
select * from Retail_Sales_Analysis where age <0 or age > 100;

 -- (5): Categories Check
select distinct category from Retail_Sales_Analysis;

 -- (6): Gender Check
select distinct gender from Retail_Sales_Analysis;

 -- (7): Date Range Check
select min(total_sale) as first_sale, max(total_sale) as last_sale from  Retail_Sales_Analysis;


 -- ### EDA (EXPLORATORY DATA ANALYSIS) ##
 
 -- (1): Total number of transactions
select count(*) as total_transaction_number from Retail_Sales_Analysis;

 -- (2): Total sales generated
select sum(total_sale) as total_sales_genrated from Retail_Sales_Analysis;

 -- (3): Average sales value
select round(avg(total_sale),2) as total_sales_generated from Retail_Sales_Analysis;

-- (4): Unique product categories
select count(distinct customer_id) as  total_customers from Retail_Sales_Analysis;

 -- (5): Male vs Female customers
select gender, count(*) as tota_coustomers from Retail_Sales_Analysis group by gender;


 -- ### THESE ARE BUSINESS KEY PROBLEMS ##
 -- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from Retail_Sales_Analysis where sale_date = '05-11-2022';


 -- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
 select * from Retail_Sales_Analysis where category = 'Clothing'
 and quantity > 1 and sale_date between '30-11-2022' and '01-11-2022';

 -- 3. Write a SQL query to calculate the total sales (total_sale) for each category.
select category, SUM(total_sale) as total_sales from Retail_Sales_Analysis
group by category 
order by total_sales DESC;

 -- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
 select  round(avg(age),2) as avg_customer_age from Retail_Sales_Analysis where category = 'Beauty';

 -- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from Retail_Sales_Analysis where total_sale > 1000;

 -- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select gender, category, count(transactions_id) as total_number_transactions from Retail_Sales_Analysis
 group by gender, category 
 order by gender, category;

 -- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select *
from (
        select
            extract(year from sale_date) as year,
            extract(month from sale_date) as month,
            round(avg(total_sale), 2) as avg_sale,
            rank() over (
                partition by extract(year from sale_date)
                order by round(avg(total_sale), 2) desc
            ) as ranks
        from Retail_Sales_Analysis
        group by 1, 2
     ) t1
where ranks = 1;

 -- 8. Write a SQL query to find the top 5 customers based on the highest total sales
 select customer_id, sum(total_sale) as  highest_total_sales from Retail_Sales_Analysis
 group by customer_id  
 order by  highest_total_sales desc limit 5;
 
 -- 9. Write a SQL query to find the number of unique customers who purchased items from each category.
select category, count(distinct(customer_id)) as unique_customers from Retail_Sales_Analysis
 group by category
order by unique_customers desc;

 -- 10.Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
select case when hour(sale_time)  < 12 then  'Morning'
when hour(sale_time) Between 12 and 17 then  'Afternoon'
else 'Evening'
end shift,
count(*) as number_of_orders from Retail_Sales_Analysis
group by shift
order by number_of_orders desc;

 -- ===================================================================================================================================================================================================================








 

 
