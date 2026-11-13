-- LAG and LEAD: compare each month's revenue with the previous and next month.
WITH monthly_sales AS (
    SELECT DATE_TRUNC('month', s.sale_date)::date AS sales_month,
           SUM(si.quantity * si.unit_price) AS monthly_revenue
    FROM sales s
    JOIN sale_items si ON si.sale_id = s.sale_id
    WHERE s.status = 'COMPLETED'
    GROUP BY DATE_TRUNC('month', s.sale_date)::date
)
SELECT sales_month, monthly_revenue,
       LAG(monthly_revenue) OVER (ORDER BY sales_month) AS previous_month_revenue,
       LEAD(monthly_revenue) OVER (ORDER BY sales_month) AS next_month_revenue,
       monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY sales_month) AS change_from_previous
FROM monthly_sales
ORDER BY sales_month;

-- Consecutive transactions per customer.
WITH transaction_totals AS (
    SELECT s.customer_id, c.customer_name, s.sale_id, s.sale_date,
           SUM(si.quantity * si.unit_price) AS sale_total
    FROM sales s
    JOIN customers c ON c.customer_id = s.customer_id
    JOIN sale_items si ON si.sale_id = s.sale_id
    WHERE s.status = 'COMPLETED'
    GROUP BY s.customer_id, c.customer_name, s.sale_id, s.sale_date
)
SELECT customer_name, sale_date, sale_total,
       LAG(sale_total) OVER (PARTITION BY customer_id ORDER BY sale_date, sale_id) AS previous_purchase,
       LEAD(sale_total) OVER (PARTITION BY customer_id ORDER BY sale_date, sale_id) AS next_purchase
FROM transaction_totals
ORDER BY customer_name, sale_date;
