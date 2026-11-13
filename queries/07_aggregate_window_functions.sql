-- Aggregate window functions: running totals, averages, minimum, maximum, count.
WITH monthly_sales AS (
    SELECT DATE_TRUNC('month', s.sale_date)::date AS sales_month,
           b.branch_name, SUM(si.quantity * si.unit_price) AS monthly_revenue
    FROM sales s
    JOIN branches b ON b.branch_id = s.branch_id
    JOIN sale_items si ON si.sale_id = s.sale_id
    WHERE s.status = 'COMPLETED'
    GROUP BY DATE_TRUNC('month', s.sale_date)::date, b.branch_name
)
SELECT sales_month, branch_name, monthly_revenue,
       SUM(monthly_revenue) OVER (
           PARTITION BY branch_name ORDER BY sales_month
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS running_branch_revenue,
       AVG(monthly_revenue) OVER (PARTITION BY branch_name) AS branch_average,
       MIN(monthly_revenue) OVER (PARTITION BY branch_name) AS branch_minimum,
       MAX(monthly_revenue) OVER (PARTITION BY branch_name) AS branch_maximum,
       COUNT(*) OVER (PARTITION BY branch_name) AS observed_months
FROM monthly_sales
ORDER BY branch_name, sales_month;

-- RANGE frame: three-calendar-month moving revenue window.
WITH monthly_sales AS (
    SELECT DATE_TRUNC('month', s.sale_date)::date AS sales_month,
           SUM(si.quantity * si.unit_price) AS monthly_revenue
    FROM sales s
    JOIN sale_items si ON si.sale_id = s.sale_id
    WHERE s.status = 'COMPLETED'
    GROUP BY DATE_TRUNC('month', s.sale_date)::date
)
SELECT sales_month, monthly_revenue,
       SUM(monthly_revenue) OVER (
           ORDER BY sales_month
           RANGE BETWEEN INTERVAL '2 months' PRECEDING AND CURRENT ROW
       ) AS rolling_three_month_revenue,
       AVG(monthly_revenue) OVER (
           ORDER BY sales_month
           RANGE BETWEEN INTERVAL '2 months' PRECEDING AND CURRENT ROW
       ) AS rolling_three_month_average
FROM monthly_sales
ORDER BY sales_month;

-- Compare each transaction with overall average; demonstrates OVER() without partition.
WITH sale_totals AS (
    SELECT s.sale_id, s.sale_date, SUM(si.quantity * si.unit_price) AS sale_total
    FROM sales s JOIN sale_items si ON si.sale_id = s.sale_id
    WHERE s.status = 'COMPLETED'
    GROUP BY s.sale_id, s.sale_date
)
SELECT sale_id, sale_date, sale_total,
       AVG(sale_total) OVER () AS overall_average,
       MIN(sale_total) OVER () AS smallest_sale,
       MAX(sale_total) OVER () AS largest_sale,
       COUNT(*) OVER () AS completed_sale_count
FROM sale_totals
ORDER BY sale_date;
