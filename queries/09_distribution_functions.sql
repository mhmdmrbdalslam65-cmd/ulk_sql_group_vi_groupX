-- NTILE(4): divide customers into four spending groups.
WITH customer_spending AS (
    SELECT c.customer_id, c.customer_name,
           COALESCE(SUM(CASE WHEN s.status = 'COMPLETED'
                             THEN si.quantity * si.unit_price END),0) AS total_spending
    FROM customers c
    LEFT JOIN sales s ON s.customer_id = c.customer_id
    LEFT JOIN sale_items si ON si.sale_id = s.sale_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT customer_id, customer_name, total_spending,
       NTILE(4) OVER (ORDER BY total_spending DESC, customer_id) AS spending_quartile,
       CUME_DIST() OVER (ORDER BY total_spending) AS cumulative_distribution
FROM customer_spending
ORDER BY spending_quartile, total_spending DESC;
