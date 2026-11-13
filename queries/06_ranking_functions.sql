-- Ranking functions over completed sales revenue.
WITH product_revenue AS (
    SELECT p.product_id, p.product_name, r.region_name,
           SUM(si.quantity * si.unit_price) AS revenue
    FROM sale_items si
    JOIN sales s ON s.sale_id = si.sale_id AND s.status = 'COMPLETED'
    JOIN products p ON p.product_id = si.product_id
    JOIN branches b ON b.branch_id = s.branch_id
    JOIN regions r ON r.region_id = b.region_id
    GROUP BY p.product_id, p.product_name, r.region_name
)
SELECT region_name, product_name, revenue,
       ROW_NUMBER() OVER (PARTITION BY region_name ORDER BY revenue DESC) AS row_num,
       RANK() OVER (PARTITION BY region_name ORDER BY revenue DESC) AS sales_rank,
       DENSE_RANK() OVER (PARTITION BY region_name ORDER BY revenue DESC) AS dense_sales_rank,
       PERCENT_RANK() OVER (PARTITION BY region_name ORDER BY revenue DESC) AS percent_rank
FROM product_revenue
ORDER BY region_name, sales_rank, product_name;

-- Top three customers in each region (ties may return more than three rows).
WITH customer_spending AS (
    SELECT c.customer_id, c.customer_name, r.region_name,
           COALESCE(SUM(si.quantity * si.unit_price),0) AS total_spending
    FROM customers c
    JOIN regions r ON r.region_id = c.region_id
    LEFT JOIN sales s ON s.customer_id = c.customer_id AND s.status = 'COMPLETED'
    LEFT JOIN sale_items si ON si.sale_id = s.sale_id
    GROUP BY c.customer_id, c.customer_name, r.region_name
)
SELECT *
FROM (
    SELECT *, RANK() OVER (PARTITION BY region_name ORDER BY total_spending DESC) AS customer_rank
    FROM customer_spending
) ranked
WHERE customer_rank <= 3
ORDER BY region_name, customer_rank;
