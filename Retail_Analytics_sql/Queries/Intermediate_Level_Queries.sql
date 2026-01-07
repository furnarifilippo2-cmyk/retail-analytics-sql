/* Fatturato per mese */

SELECT
FORMAT(ord.order_date,'yyyy-MM') Order_by_Month,
SUM(oi.unit_price*oi.quantity) Monthly_Revenue
FROM orders ord
LEFT JOIN order_items oi
ON ord.order_id = oi.order_id
GROUP BY FORMAT(ord.order_date,'yyyy-MM')

/* Numero ordini per mese */

SELECT
FORMAT(order_date,'yyyy-MM') Order_by_Month,
COUNT(order_id) Number_Orders_Month
FROM orders
GROUP BY FORMAT(order_date,'yyyy-MM')

/* Crescita mese su mese */

SELECT
FORMAT(ord.order_date,'yyyy-MM') Order_by_Month,
SUM(oi.unit_price*oi.quantity) Monthly_Revenue,
LAG(SUM(oi.unit_price*oi.quantity)) OVER(ORDER BY FORMAT(ord.order_date,'yyyy-MM')) Previous_MR,
(ROUND((SUM(oi.unit_price*oi.quantity) / LAG(SUM(oi.unit_price*oi.quantity)) OVER(ORDER BY FORMAT(ord.order_date,'yyyy-MM'))*100),2))-100 Increment_pct
FROM orders ord
LEFT JOIN order_items oi
ON ord.order_id = oi.order_id
GROUP BY FORMAT(ord.order_date,'yyyy-MM')

/* Customer Lifetime Value CLV */

SELECT
cu.customer_id, cu.first_name + ' ' + cu.last_name AS Full_Name,
COUNT(DISTINCT ord.order_id) Total_Orders,
SUM(oi.quantity*oi.unit_price) Lifetime_Revenue,
MIN(ord.order_date) First_Date,
MAX(ord.order_date) Last_Date,
ROW_NUMBER() OVER(ORDER BY SUM(oi.quantity*oi.unit_price) DESC) Ranked
FROM orders ord
LEFT JOIN customers cu
ON cu.customer_id = ord.customer_id
LEFT JOIN order_items oi
ON ord.order_id = oi.order_id
GROUP BY cu.customer_id, cu.first_name + ' ' + cu.last_name
ORDER BY Lifetime_Revenue DESC

/* Repeat vs One-time Customers */

SELECT
cu.customer_id,
COUNT(DISTINCT ord.order_id) Total_Orders,
cu.first_name + ' ' + cu.last_name AS Full_Name,
CASE
	WHEN COUNT(DISTINCT ord.order_id) > 1 THEN 'Repeatitive'
	WHEN COUNT(DISTINCT ord.order_id) = 1 THEN 'One_Time'
	ELSE NULL
END AS Customer_Type
FROM customers cu
LEFT JOIN orders ord
ON cu.customer_id = ord.customer_id
GROUP BY cu.customer_id, cu.first_name + ' ' + cu.last_name