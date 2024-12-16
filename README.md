# Library-Management-System-with-SQL-Stored-Procedures

### Project Title: **Library Management System with SQL Stored Procedures**

#### **Project Description:**
This project involves the design and implementation of a comprehensive library management system using SQL for a relational database. The system efficiently manages books, members, employees, and branch operations. Key features include issuing books, tracking returns, and generating performance reports for branches and employees. Advanced functionality was added using stored procedures for automated status updates, overdue tracking, and real-time record management.

#### **Tasks Performed:**

1. **Database Setup:**
   - Designed and created tables for **Books**, **Branches**, **Employees**, **Members**, **Issued_Status**, and **Return_Status**.
   - Populated tables with realistic data to simulate a functioning library.

2. **Book Management:**
   - Implemented tasks to **insert, update, and delete records** from the books table.
   - Added functionality to retrieve books based on category, rental income, and availability.

3. **Issue and Return Tracking:**
   - Developed SQL queries to track book issuance and return details.
   - Automated updates to book status (`available` or `not available`) based on issuance and returns using stored procedures.

4. **Member and Employee Operations:**
   - Updated member addresses and identified active members who issued books in the last two months.
   - Queried and displayed employees with the most processed book issues and their respective branch details.

5. **Branch Performance Analysis:**
   - Created a summary report for each branch displaying:
     - Total books issued.
     - Total books returned.
     - Revenue generated from book rentals.

6. **Automated Stored Procedures:**
   - Designed stored procedures for:
     - **Issuing books:** Automatically updates the status of books and inserts records into the Issued_Status table.
     - **Returning books:** Updates book availability and adds return records to the Return_Status table.
     - **Error handling:** Ensures a proper message is raised if a requested book is unavailable.

7. **Overdue Tracking:**
   - Queried members with overdue books by calculating the difference between the current date and the issued date.
   - Displayed member details, book titles, and overdue days for books not returned within a 30-day period.

8. **Advanced Data Aggregation:**
   - Used **GROUP BY** to summarize rental income by category.
   - Built derived tables for:
     - Books rented above a specific price.
     - Active members based on recent activity.

9. **CTAS (Create Table As):**
   - Generated summary tables like `Book_Cnts` and `Branch_Report` using complex joins and aggregations to store analytical insights.

---

#### **Project Outcomes:**
- **Efficiency:** The stored procedures streamlined book issuance and return processes, minimizing manual errors.
- **Data Insights:** Summarized reports and overdue tracking provided actionable insights for library operations.
- **Automation:** Automated updates to the book status reduced the need for manual tracking.
- **Scalability:** Modular design allows easy extension to support additional features like fines or reservations.
- **Real-time Tracking:** Enabled real-time monitoring of branch performance and employee contributions.

#### **Key Learnings:**
- Mastery of SQL concepts like **joins**, **CTAS**, **stored procedures**, and **error handling**.
- Enhanced understanding of database design, maintenance, and optimization.
- Practical experience in managing real-world scenarios such as overdue penalties, availability checks, and revenue reporting.

This project demonstrates the integration of SQL programming for building a robust, scalable, and user-friendly library management system.
