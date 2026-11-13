-- Additional integrity rules (the primary/foreign keys and basic checks
-- are defined in 01_create_tables.sql).
ALTER TABLE sales
    ADD CONSTRAINT chk_sale_date_not_future CHECK (sale_date <= CURRENT_DATE + INTERVAL '1 day');

ALTER TABLE sale_items
    ADD CONSTRAINT chk_line_total_positive CHECK (quantity * unit_price >= 0);

-- Verify table row counts after loading sample data.
SELECT 'regions' AS table_name, COUNT(*) AS row_count FROM regions
UNION ALL SELECT 'branches', COUNT(*) FROM branches
UNION ALL SELECT 'employees', COUNT(*) FROM employees
UNION ALL SELECT 'customers', COUNT(*) FROM customers
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'sales', COUNT(*) FROM sales
UNION ALL SELECT 'sale_items', COUNT(*) FROM sale_items;
