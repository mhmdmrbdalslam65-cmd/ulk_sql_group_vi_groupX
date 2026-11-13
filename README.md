# ULK SQL Group VI — Retail Sales Analytics

**Course:** SQL Database | **Programme:** Data Science, Year 2  
**Institution:** Kigali Independent University (ULK)  
**Topic:** SQL JOINs and Window Functions  
**DBMS:** PostgreSQL (run with pgAdmin 4)

>

## 1. Group members
1. [Mohamed Omer — 202513481]
2. [Moayed Elrashed — 202512280]



## 2. Business context
This project models a fictional retail company operating branches in Kigali, Northern and Eastern regions. It sells electronics, furniture and stationery to registered customers.

## 3. Problem statement
Management needs a consistent way to record branches, employees, customers, products and sales. It also needs to compare branch and product performance, identify valuable customers, monitor monthly revenue, and understand changes over time.

## 4. Five measurable analytical objectives
1. Rank products by revenue within each region using `RANK()`, identifying leading products.
2. Calculate cumulative monthly revenue using `SUM() OVER()` to monitor progress over time.
3. Compare monthly revenue with the previous and next month using `LAG()` and `LEAD()`.
4. Divide customers into four spending groups using `NTILE(4)` for customer segmentation.
5. Calculate three-month moving average revenue using `AVG() OVER()` with a `RANGE` frame.

These objectives support product planning, performance monitoring, customer targeting and revenue forecasting. The results are descriptive indicators, not proof of why a change occurred.

## 5. Database design
Seven related tables are used:

| Table | Purpose | Key relationships |
|---|---|---|
| `regions` | Geographic sales regions | One region has many branches and customers |
| `branches` | Retail outlets | Each branch belongs to one region |
| `employees` | Staff and reporting hierarchy | Each employee works at a branch; `manager_id` references another employee |
| `customers` | Registered buyers | Each customer belongs to a region |
| `products` | Product catalogue | Referenced by sale items |
| `sales` | Sales headers | Each sale references one customer, branch and employee |
| `sale_items` | Products and quantities on each sale | Each row references one sale and one product |

See [`documentation/ERD.png`](documentation/ERD.png).



## 7. JOIN implementations
| File | JOIN | Purpose |
|---|---|---|
| `queries/01_inner_join.sql` | INNER JOIN | Completed sales with matching customer, branch and region |
| `queries/02_left_join.sql` | LEFT JOIN | Includes customers with no purchases |
| `queries/03_right_join.sql` | RIGHT JOIN | Includes branches with no sales |
| `queries/04_full_outer_join.sql` | FULL OUTER JOIN | Includes matched sales and customers without sales |
| `queries/05_self_join.sql` | SELF JOIN | Employee-to-manager hierarchy |

**Interpretation guide:** The sample data deliberately includes a customer with no purchases and a branch with no sales. These unmatched rows make the outer joins meaningful. The foreign keys prevent orphan sales from referencing nonexistent customers.

## 8. Window function implementations
| File | Required functions / concepts |
|---|---|
| `06_ranking_functions.sql` | `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `PERCENT_RANK`; regional product ranking and top customers |
| `07_aggregate_window_functions.sql` | `SUM`, `AVG`, `MIN`, `MAX`, `COUNT` with `OVER`, `PARTITION BY`, `ORDER BY`, `ROWS` and `RANGE` frames |
| `08_navigation_functions.sql` | `LAG`, `LEAD` for monthly and customer transaction comparisons |
| `09_distribution_functions.sql` | `NTILE(4)`, `CUME_DIST` for customer segmentation |

PostgreSQL does not support the `QUALIFY` clause used by some other database systems. The top-customer query therefore uses a subquery and filters its calculated rank in the outer query.

## 9. Three practical business problems addressed
1. **Which products should be promoted?** Regional revenue rankings identify products with the strongest recorded sales.
2. **Is revenue increasing or decreasing?** Monthly totals, running totals, `LAG`, `LEAD` and moving averages show the direction and scale of changes.
3. **Which customers may need targeted engagement?** `NTILE(4)` groups customers by recorded completed spending; the business can design different retention campaigns for each group.

## 10. Results analysis — complete after execution
Do not invent findings. After running the SQL, add evidence from your result grids:

- **Descriptive (what happened?):** State the highest-revenue product/region, monthly revenue pattern, and customer spending groups shown by your actual outputs.
- **Diagnostic (why might it have happened?):** Discuss plausible explanations such as product mix, branch activity or number of transactions. These are hypotheses; the supplied tables do not record marketing, stock-outs or customer reasons.
- **Prescriptive (what next?):** Recommend actions supported by the results, such as reviewing low-performing products, checking branch operations, and tailoring customer offers. Validate recommendations with more data.

## 11. Screenshots
Place genuine pgAdmin query execution screenshots in:
- `screenshots/joins/`
- `screenshots/window_functions/`


Screenshots are not generated by this repository; capture them after running the scripts on your computer.

## 12. References
- PostgreSQL Global Development Group. *PostgreSQL Documentation — SELECT / Window Functions*. https://www.postgresql.org/docs/current/tutorial-window.html
- PostgreSQL Global Development Group. *PostgreSQL Documentation — Table Expressions*. https://www.postgresql.org/docs/current/queries-table-expressions.html
- pgAdmin Development Team. *pgAdmin 4 Documentation*. https://www.pgadmin.org/docs/pgadmin4/latest/
