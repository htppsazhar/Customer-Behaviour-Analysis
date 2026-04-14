CREATE DATABASE customer_analysis ;

USE customer_analysis;

SELECT count(*) from customers;

----------------------------------------------------------------------------------------------------------
-- Business Insights Questions
----------------------------------------------------------------------------------------------------------

-- 1. Which category generates highest revenue?

SELECT category, 
       ROUND(SUM(purchase_amount)) AS highest_revenue
FROM customers
GROUP BY category
ORDER BY highest_revenue DESC;

-- Impact: 
		-- Helps prioritize high-performing categories.
        -- Optimizes inventory planning.
        -- Improves marketing ROI.
        
---------------------------------------------------------------------------------------------------------

-- 2. Are discounts actually increasing purchase value?

SELECT discount_applied, 
       ROUND(SUM(purchase_amount)) AS total_revenue,
       ROUND(AVG(purchase_amount)) AS avg_revenue
FROM customers
GROUP BY discount_applied
ORDER BY total_revenue DESC;

-- Impact: 
		-- Identify effectiveness of discounts.
        -- Reduce unnecessary discount costs.
        -- Improve profit margins.
        
---------------------------------------------------------------------------------------------------------

-- 3. What is the total revenue by male and female customer ? 

SELECT gender,
	   ROUND(SUM(purchase_amount)) AS Gender_wise_revenue
FROM customers
GROUP BY gender
ORDER BY Gender_wise_revenue DESC;       

-- Impact: 
		-- Helps design targeted marketing campaigns.
        -- Improves customer segmentation strategy.
        -- Enhances personalization efforts.
        
---------------------------------------------------------------------------------------------------------

-- 4. Which customer used a discount but still spent more then the average purchase amount ?

SELECT 
	  customer_id,
      ROUND(purchase_amount),
      discount_applied
FROM customers
WHERE discount_applied = 'Yes' AND purchase_amount > (SELECT AVG(purchase_amount) FROM customers) LIMIT 10; 

-- Impact: 
		-- Identifies premium discount-sensitive customers.
        -- Enables target discount campaigns.
        -- Improves customer retention and revenue.
        
---------------------------------------------------------------------------------------------------------

-- 5. Which are the top/bottom 5 products with the highest average review rating. 

-- TOP
SELECT item_purchased,
		ROUND(AVG(review_rating),2) AS Avg_ratings
FROM customers
GROUP BY item_purchased
ORDER BY Avg_ratings DESC
LIMIT 5;

-- Bottom 
SELECT item_purchased,
		ROUND(AVG(review_rating),2) AS Avg_ratings
FROM customers
GROUP BY item_purchased
ORDER BY Avg_ratings ASC
LIMIT 5;

-- Impact: 
		-- Promotes high-performing products.
        -- Improves low-rated products.
        -- Enhances customer experience.
        
---------------------------------------------------------------------------------------------------------

-- 6. Average purchase: Standard vs Express shipping 

SELECT shipping_type, 
		COUNT(distinct customer_id) as order_placed,
        ROUND(AVG(purchase_amount)) as avg_purchase
FROM customers 
WHERE shipping_type IN ('Standard', 'Express')
GROUP BY shipping_type ; 

-- Impact: 
		-- Helps optimize shipping pricing strategy.
        -- Encourages premium shipping adoption.
        -- Increases average order value.
        
---------------------------------------------------------------------------------------------------------

-- 7. Do subscribed customers spend more? Compare average speed and total revenue between subscribers and
--    non-subscribers.


SELECT subscription_status,
	   COUNT(customer_id) as Users,
	   ROUND(SUM(purchase_amount),2) AS Total_amount,
       ROUND(AVG(purchase_amount),2) AS Avg_amount
FROM customers
GROUP BY subscription_status
ORDER BY Total_amount DESC ; 

-- Impact: 
		-- Validates subscription model performance.
        -- Improves customer loyalty programs.
        -- Increases customer lifetime value (CLV).
        
---------------------------------------------------------------------------------------------------------

-- 8. Top 5 products with highest discount usage %

SELECT item_purchased,
	   COUNT(item_purchased) AS total_number_of_times_sold,
       COUNT(CASE WHEN discount_applied = 'Yes' THEN 1 END) AS Number_of_times_sold_when_discount_applied,
       COUNT(CASE WHEN discount_applied = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS discount_percent
FROM customers
GROUP BY item_purchased 
ORDER BY discount_percent DESC LIMIT 5; 




