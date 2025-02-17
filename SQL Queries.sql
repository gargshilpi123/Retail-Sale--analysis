
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
SELECT * 
FROM 
	retail_sale 
WHERE 
	sale_date='2022-11-05';
    
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
SELECT * 
FROM 
	retail_sale
WHERE 
	category='clothing' and sale_date<='2022-11-30' and sale_date>='2022-11-30' and quantity>2;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category ,SUM(total_sale)	as total_sale
FROM 
	retail_Sale
GROUP BY
	category;
    
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT AVG(age)
FROM
	retail_Sale
WHERE
	category='Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * 
FROM
	retail_Sale
WHERE 
	total_sale>1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category,gender,count(*)as  number_of_tansactions
FROM
	retail_sale
GROUP BY 
	category,gender;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
SELECT 
    year,
    month,
    avg_sale
FROM 
(    
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS ranking
    FROM retail_sale
    GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
) AS t1
WHERE ranking = 1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.
SElECT Customer_id,SUM(total_sale) as net_sale
FROM retail_Sale 
GROUP BY customer_id
ORDER BY net_sale DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category, COUNT(DISTINCT customer_id) as customer
FROM retail_Sale
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT 
	CASE
		WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time)BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as shift,
    count(*) as number_orders
FROM retail_sale
GROUP BY Shift
ORDER BY FIELD(Shift,'Morning','Afternoon','Evening');
