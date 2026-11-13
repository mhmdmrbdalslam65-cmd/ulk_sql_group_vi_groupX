-- FULL OUTER JOIN: show all customers and all sales, matched where possible.
-- With the declared FK, sales cannot refer to a missing customer; customers
-- without sales still appear with NULL sale columns.
SELECT c.customer_id, c.customer_name, s.sale_id, s.sale_date
FROM customers c
FULL OUTER JOIN sales s ON s.customer_id = c.customer_id
ORDER BY c.customer_id NULLS LAST, s.sale_id;
