# ERD and project notes

The diagram shows the seven-table retail sales model. A region has many branches and customers; a branch has many employees and sales; a sale has one or more sale-item rows; each sale item identifies one product. Employees may report to another employee through the self-referencing `manager_id`.

The database scripts are written for PostgreSQL. The setup script drops existing project tables, so use a dedicated empty database.
