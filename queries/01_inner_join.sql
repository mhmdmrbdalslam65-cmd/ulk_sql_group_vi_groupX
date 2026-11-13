-- INNER JOIN: list completed sales with customer, branch and region.
SELECT s.sale_id, s.sale_date, c.customer_name, b.branch_name,
       r.region_name, SUM(si.quantity * si.unit_price) AS sale_total
FROM sales s
INNER JOIN customers c ON c.customer_id = s.customer_id
INNER JOIN branches b ON b.branch_id = s.branch_id
INNER JOIN regions r ON r.region_id = b.region_id
INNER JOIN sale_items si ON si.sale_id = s.sale_id
WHERE s.status = 'COMPLETED'
GROUP BY s.sale_id, s.sale_date, c.customer_name, b.branch_name, r.region_name
ORDER BY s.sale_date, s.sale_id;
