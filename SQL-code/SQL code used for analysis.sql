 -- Transaction table and cutomers_demo table

SELECT * FROM Transactions

SELECT * FROM customer_demo

SELECT * FROM Transactions t
INNER JOIN customer_demo c
ON t.customer_id = c.customer_id
ORDER BY c.customer_id ASC

SELECT  
     c.customer_id, 
     first_name, c.last_name, 
     ROUND(t.list_price, 2) as lis_price, 
     t.standard_cost 
FROM Transactions t
INNER JOIN customer_demo c
ON t.customer_id = c.customer_id
ORDER BY list_price DESC,t.standard_cost DESC, c.customer_id ASC

-- finding the repeated customers
SELECT  
    t.customer_id, 
    first_name, c.last_name,
    COUNT(*) AS rep_customer
FROM Transactions t
INNER JOIN customer_demo c
ON t.customer_id = c.customer_id 
GROUP BY t.customer_id, c.first_name, c.last_name
ORDER BY rep_customer DESC

-- customers who's product_class is higher
SELECT 
    c.customer_id, 
    first_name, last_name, 
    product_class 
FROM Transactions t
INNER JOIN customer_demo c
ON t.customer_id = c.customer_id 
WHERE product_class = 'high'
GROUP BY c.customer_id, first_name, product_class, last_name
ORDER BY c.customer_id ASC

-- Using with clause selecting the tables that can be used for analysing and driving insights.
-- selecting customers who's list pricing is greater $1000
-- This is the main query used for making decision and drawing visualization.

WITH k_product AS (
SELECT 
         c.customer_id, 
	   first_name,
	   last_name,
	   gender,
	   age,
	   product_class,
	   product_size,
	   list_price,
	   standard_cost,
	   profit,
	   online_order,
	   order_status,
	   brand,
	   product_line,
	   job_title,
	   job_industry_category,
	   wealth_segment,
	   deceased_iNodicator,
	   tenure,
	   past_3_years_bike_related_purchases
FROM Transactions t
INNER JOIN customer_demo c
ON t.customer_id = c.customer_id
WHERE list_price >= 1000 
),

-- Removing all the null values 

null_values as (

SELECT * FROM k_product
  WHERE brand IS NOT NULL AND 
        product_class IS NOT NULL AND 
	  product_size IS NOT NULL AND
	  job_title IS NOT NULL AND 
	  job_industry_category IS NOT NULL AND
	  online_order IS NOT null AND
	  tenure IS NOT NULL AND
	  last_name IS NOT null
	  AND job_industry_category != 'NA'
	  )

-- finding the repeated customers who age is 50 or below.
-- customers who have purchased or ordered the product 3 or more time are taken.

SELECT 
     customer_id, 
	 first_name,
	 last_name, 
	 age,
	 gender,
	 past_3_years_bike_related_purchases,
	 job_title,
	 job_industry_category,
	 wealth_segment,
	 deceased_iNodicator,
	 tenure
FROM null_values
WHERE AGE <= 50
GROUP BY customer_id, 
            first_name, 
		 last_name, 
		 age,
		 gender,
		 past_3_years_bike_related_purchases,
		 job_title,
	       job_industry_category,
		 wealth_segment,
	       deceased_iNodicator,
	       tenure
HAVING COUNT(*) >= 3



-- checking the brands

SELECT brand 
FROM Transactions
GROUP BY brand

SELECT brand, count(*) as count
FROM Transactions
WHERE brand IS NOT NULL
GROUP BY brand
ORDER BY count DESC

-- count of brands as per the job industry.
SELECT 
    job_industry_category, 
    COUNT(*) as count_brand
FROM Transactions t
INNER JOIN customer_demo c
ON c.customer_id = t.customer_id
WHERE brand IS NOT NULL AND job_industry_category != 'NA'
GROUP BY job_industry_category, brand
ORDER BY count_brand DESC


-- customers who tenure is greater or equal to 4
SELECT * FROM age_50 A
inner join customer_address C
ON A.customer_id = C.customer_id
WHERE tenure >= 4 AND deceased_iNodicator != 1
ORDER BY age ASC
-- 1036

SELECT TOP (1000) * FROM age_50 A
inner join customer_address C
ON A.customer_id = C.customer_id
WHERE tenure >= 4 AND deceased_iNodicator != 1
ORDER BY age ASC
-- 1000 customers

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- Querying using window functions.
-- this queries are used for data exploration and are not considered for final dashboard 
SELECT  
    customer_id, brand, 
    ROW_NUMBER() OVER (PARTITION BY brand ORDER BY customer_id) AS RN
FROM Transactions
WHERE brand IS NOT NULL
group by customer_id, brand

-- coustomer who bought same brand 3 times
SELECT 
    t.customer_id, 
    brand, COUNT(*) AS CN, 
    ROW_NUMBER() OVER (PARTITION BY brand ORDER BY t.customer_id) as rn
FROM Transactions t
INNER JOIN customer_demo c
ON t.customer_id = c.customer_id
WHERE brand IS NOT NULL
GROUP BY t.customer_id, brand
HAVING COUNT(*) >= 3
-- coustomer who bought same brand 3 times