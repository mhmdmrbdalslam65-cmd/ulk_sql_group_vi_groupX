-- RIGHT JOIN: retain every branch, including branches with no sales.
SELECT b.branch_id, b.branch_name, s.sale_id, s.sale_date
FROM sales s
RIGHT JOIN branches b ON b.branch_id = s.branch_id
ORDER BY b.branch_id, s.sale_date;
