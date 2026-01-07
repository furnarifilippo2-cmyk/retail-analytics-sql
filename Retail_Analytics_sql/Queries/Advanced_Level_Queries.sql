/* Pareto 80/20 sui clienti, il 20% dei clienti (per vendite decrescenti),
genera l'80% del fatturato? */

WITH  cte_one AS(
SELECT
ord.customer_id,
SUM(oi.quantity * oi.unit_price) Customer_Revenue,
/* 
Somma interna: Calcola il fatturato per cliente
Somma esterna con OVER: Somma quei fatturati per avere il totale massimo
Non c'è conflitto col GROUP BY 
*/
SUM(SUM(oi.quantity * oi.unit_price)) OVER() AS Total_Rev,
CASE
	WHEN (SUM(oi.quantity * oi.unit_price) / (SUM(SUM(oi.quantity * oi.unit_price)) OVER()))*100 <= 80 THEN 'Not Enough'
	ELSE 'Yes'
END Total_Rev_pct,
/*
Assunzioni: si considerano clienti solo quelli che comprano effetivamente,
in questo caso quindi sono solo 4 e il 20% di 4 sarebbero 0,8 clienti, ma
siccome non ha senso realisticamente prendere 0,8 clienti, si arrotonda ad 1
(quindi si prende solo il primo per vendite).
Quest'ultimo non raggiunge l'80% delle vendite globali da solo
*/
PERCENT_RANK() OVER(ORDER BY (SUM(oi.quantity * oi.unit_price)) DESC) ranked_pct
FROM orders ord
LEFT JOIN order_items oi
ON ord.order_id = oi.order_id
GROUP BY ord.customer_id
)
SELECT
customer_id,
Customer_Revenue,
Total_Rev_pct
FROM cte_one
WHERE ranked_pct <= 0.2
GROUP BY customer_id, Customer_Revenue, Total_Rev_pct
ORDER BY Customer_Revenue DESC

/* Product Performance vs Returns */

SELECT
p.product_name,
SUM(oi.quantity) Total_Sold,
/* 
Conto quante volte si presennta ret.return_id ogni qualvolta
oi.order_item_id = ret.order_item_id
*/
COUNT(ret.return_id) Total_Return,
ROUND((COUNT(ret.return_id)* 100.0 / SUM(oi.quantity)),2) Return_Rate_pct
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.product_id
LEFT JOIN returns ret
ON oi.order_item_id = ret.order_item_id
GROUP BY p.product_name
ORDER BY Return_Rate_pct DESC

/* Campaign Effectiveness */

SELECT
mc.campaign_name,
COUNT(DISTINCT c.customer_id) Customer_Count,
COUNT(DISTINCT ord.order_id) Total_Orders,
SUM(oi.quantity * oi.unit_price) Total_Revenues
FROM customer_campaigns cc
LEFT JOIN customers c
ON cc.customer_id = c.customer_id
LEFT JOIN marketing_campaigns mc
ON cc.campaign_id = mc.campaign_id
LEFT JOIN orders ord
ON cc.customer_id = ord.customer_id
LEFT JOIN order_items oi
ON ord.order_id = oi.order_id
GROUP BY mc.campaign_name
ORDER BY Total_Revenues DESC

/* Time to First Purchase, first way */

WITH cte_one AS(
SELECT
c.customer_id, c.signup_date, orders.min_date,
DATEDIFF(DAY, c.signup_date, orders.min_date) Days_to_First_Purchase
FROM customers c
LEFT JOIN (
			SELECT
			customer_id,
			MIN(order_date) min_date
			FROM orders 
			GROUP BY customer_id
			) 
orders
ON c.customer_id = orders.customer_id
)
SELECT
*,
(SELECT ROUND(AVG(Days_to_First_Purchase),2) FROM cte_one) Avg_Days_to_First_Purch
FROM cte_one 
ORDER BY customer_id

/* Time to First Purchase, second way */

WITH cte_one AS(
SELECT
c.customer_id, c.signup_date, ord.order_date,
DATEDIFF(DAY, c.signup_date, ord.order_date) Days_to_First_Purchase,
ROW_NUMBER() OVER(PARTITION BY c.customer_id ORDER BY c.customer_id, ord.order_date ASC) Ranked
FROM customers c
LEFT JOIN orders ord
ON c.customer_id = ord.customer_id
GROUP BY c.customer_id, c.signup_date, ord.order_date
)
SELECT
customer_id, signup_date, order_date, Days_to_First_Purchase,
(SELECT ROUND(AVG(Days_to_First_Purchase),2) FROM cte_one WHERE ranked = 1) Avg_Days_to_First_Purch
FROM cte_one 
WHERE ranked = 1
ORDER BY customer_id

/* Churn Clients */

SELECT
c.customer_id,c.signup_date, orders.Last_Order_Date,
DATEDIFF(DAY, orders.Last_Order_Date, GETDATE()) Days_since_Last_Order,
CASE
	WHEN DATEDIFF(DAY, orders.Last_Order_Date, GETDATE()) > 60 THEN 'Inactive'
	ELSE 'Active'
END AS Churn_Flag
FROM customers c
INNER JOIN 
(
SELECT 
customer_id,
MAX(order_date) Last_Order_Date
FROM orders
GROUP BY customer_id 
)orders 
ON c.customer_id = orders.customer_id
