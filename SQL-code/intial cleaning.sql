
SELECT * FROM customer_demo

SELECT job_title,job_industry_category FROM customer_demo
GROUP BY job_title, job_industry_category

SELECT COUNT(*) FROM customer_demo
WHERE job_industry_category IS NULL

SELECT COUNT(*) FROM customer_demo
WHERE job_title IS NULL

SELECT job_industry_category FROM customer_demo
GROUP BY job_industry_category

SELECT wealth_segment FROM customer_demo
GROUP BY wealth_segment

SELECT COUNT(customer_id) FROM customer_demo
WHERE wealth_segment = 'Mass Customer'
GROUP BY wealth_segment
-- 2000

SELECT COUNT(customer_id) FROM customer_demo
WHERE wealth_segment = 'Affluent Customer'
GROUP BY wealth_segment
-- 979

SELECT COUNT(customer_id) FROM customer_demo
WHERE wealth_segment = 'High Net Worth'
GROUP BY wealth_segment
-- 1021


SELECT age FROM customer_demo
WHERE wealth_segment = 'High Net Worth'

SELECT age FROM customer_demo
WHERE wealth_segment = 'Mass Customer'

SELECT age FROM customer_demo
WHERE wealth_segment = 'Affluent Customer'

SELECT job_title, job_industry_category FROM customer_demo
WHERE wealth_segment = 'High Net Worth' AND job_title IS NOT NULL 
AND job_industry_category != 'NA'
ORDER BY job_industry_category 


SELECT job_title, job_industry_category FROM customer_demo
WHERE wealth_segment = 'Mass Customer' AND job_title IS NOT NULL
AND job_industry_category != 'NA'
ORDER BY job_industry_category 

SELECT job_title, job_industry_category FROM customer_demo
WHERE wealth_segment = 'Affluent Customer' AND job_title IS NOT NULL
AND job_industry_category != 'NA'
ORDER BY job_industry_category