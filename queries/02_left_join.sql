-- LEFT JOIN: identify all customers, including customers with no purchases.
SELECT c.customer_id, c.customer_name, COUNT(DISTINCT s.sale_id) AS number_of_sales
FROM customers c
LEFT JOIN sales s ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY c.customer_id;
