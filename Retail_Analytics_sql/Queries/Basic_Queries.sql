/* Fatturato Totale */

SELECT
SUM(quantity*unit_price) Total_Revenue
FROM order_items

/* Numero totali di ordini */

SELECT
COUNT(DISTINCT order_id) Total_Orders
FROM orders

/* Valore medio ordine */

SELECT
ROUND(SUM(unit_price*quantity)/COUNT(DISTINCT order_id),2) Average_Order_Value
FROM order_items

SELECT
SUM(quantity*(unit_price-cost)) tot
FROM order_items, products

/* Profitto Totale per prodotto */

SELECT
SUM((p.price-p.cost)*oi.quantity) Total_Profit_Product
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.product_id
GROUP BY oi.product_id
UNION

/* Profitto Totale */

SELECT
SUM((p.price-p.cost)*oi.quantity) Total_Profit
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.product_id