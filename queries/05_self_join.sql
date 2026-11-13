-- SELF JOIN: show employees together with their managers.
SELECT e.employee_name AS employee,
       e.job_title,
       m.employee_name AS manager
FROM employees e
LEFT JOIN employees m ON m.employee_id = e.manager_id
ORDER BY e.employee_id;
