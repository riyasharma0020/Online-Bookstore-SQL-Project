📚 Online Bookstore SQL Project
🔹 Overview

The Online Bookstore SQL Project is a database-driven project designed to manage a virtual bookstore.
It demonstrates the use of SQL for database creation, management, and querying.

This project focuses on:

Managing books, customers, and orders.

Performing sales analysis.

Tracking customer behavior.

Monitoring inventory and revenue insights.

🗄 Database Design

The project includes the following core tables:

Books – Stores book details (ID, title, author, genre, year, price, stock).

Customers – Stores customer information (ID, name, email, phone, city, country).

Orders – Tracks purchases, linking customers and books with date & quantity.

Each table has primary keys, foreign keys, and constraints to ensure referential integrity.

🚀 Features & Queries

This project covers multiple SQL use cases, including:

Data Definition (DDL): Creating and managing tables.

Data Manipulation (DML): Inserting, updating, and deleting records.

Data Retrieval (DQL): Querying books, sales, and customers.

Joins & Aggregations: Combining tables for advanced insights.

Reports & Analytics:

Top-selling books.

Customers with multiple purchases.

Monthly and yearly sales reports.

Genre-based revenue contribution.

Inventory tracking and stock updates.

📝 Example Queries

1. Retrieve all books by a specific author

SELECT Title, Published_Year, Price
FROM Books
WHERE Author = 'J.K. Rowling';


2. Find top 5 best-selling books

SELECT b.Title, SUM(o.Quantity) AS Total_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Title
ORDER BY Total_Sold DESC
LIMIT 5;


3. Monthly sales revenue report

SELECT DATE_TRUNC('month', Order_Date) AS Month, 
       SUM(o.Quantity * b.Price) AS Total_Revenue
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY Month
ORDER BY Month;

⚙️ Tools & Technologies

Database: PostgreSQL / MySQL (adaptable to both)

SQL Concepts: DDL, DML, Joins, Group By, Subqueries, Aggregations

Environment: pgAdmin / MySQL Workbench / SQL CLI

🛠 How to Use

Clone the repository

git clone https://github.com/riyasharma0020/Online-Bookstore-SQL-Project.git
cd Online-Bookstore-SQL-Project


Import the SQL file into your database

For PostgreSQL:

psql -U your_username -d your_database -f Online_Bookstore.sql


For MySQL:

mysql -u your_username -p your_database < Online_Bookstore.sql


Run the provided queries for analysis.

📊 Project Insights

This project demonstrates:

Database schema design for real-world scenarios.

Efficient query writing for analytics and reporting.

Problem-solving with SQL in e-commerce & business domains.

🔮 Future Enhancements

Add triggers & stored procedures for automation.

Integrate with a frontend UI for bookstore simulation.

Visualize sales reports in Power BI / Tableau.

📜 License

This project is licensed under the MIT License – free to use and modify.

👩‍💻 Author

Riya Sharma

🎓 BCA Student | Data Science Specialization

💡 Passionate about Data, SQL, and Analytics

🌐 [GitHub Profile](https://github.com/riyasharma0020)
