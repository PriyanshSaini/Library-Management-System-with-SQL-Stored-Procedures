-- Problem Solution
SELECT * FROM Books;
SELECT * FROM Branch;
SELECT * FROM Employees;
SELECT * FROM Issued_Status;
SELECT * FROM Return_Status;
SELECT * FROM Members;

-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

Insert into Books(Isbn,Book_Title,Category,Rental_Price,Status,Author,Publisher)
values
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee','J.B. Lippincott & Co.');
select from Books;

-- Task 2: Update a Member's Address C101 to 125 Main
update Members
set Member_Address ='125_Main'
where Member_id = 'C101';
select * from Members;

-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

Delete from Issued_Status
where Issued_Id = 'IS121';
Select * from Issued_Status

-- Task 4: Retrieve All Books Issued by a Specific Employee 
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
select * from Issued_Status
where Issued_Emp_Id = 'E101'

-- Task 5: List Members Who Have Issued More Than One Book 
-- Objective: Use GROUP BY to find members who have issued more than one book.

Select Issued_Emp_Id,
count(Issued_Id) as total_book_Issued
from Issued_Status
group by Issued_Emp_Id;

-- Task 6: Create Summary Tables: 
--Used CTAS to generate new tables based on query results - each book and total book_issued_cnt
CREATE TABLE Book_Cnts AS
SELECT
    b.isbn,
    b.book_title,
    COUNT(ist.issued_id) AS no_issued
FROM Books AS b
JOIN Issued_status AS ist
    ON ist.Issued_Book_Isbn = b.isbn
GROUP BY b.isbn, b.book_title

select * from Book_Cnts;

-- Task 7. Retrieve All Books in a Specific Category:

select * from Books
where Category = 'Classic'

-- Task 8: Find Total Rental Income by Category:

Select 
b.Category,
Sum(b.Rental_Price) as Total_income,
count(*)
from Books as b
Join 
issued_status as ist
on ist.issued_book_isbn = b.isbn
group by 1

-- Task 9 List Employees with Their Branch Manager's Name and their branch details:
Select e1.*,
b.manager_id,
e2.emp_name as manager
from Employees as e1
join
branch as b
on b.branch_id = e1.branch_id
join Employees as e2
on b.manager_id = e2.Emp_id

-- Task 10. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:
create table Books_by_renratl_price
as
select * from Books
where Rental_Price >=7

select * from Books_by_renratl_price;

-- Task 11: Retrieve the List of Books Not Yet Returned
Select 
distinct ist.Issued_Book_Name
from Issued_Status as ist
Left join
Return_Status as rs
on ist.issued_id = rs.issued_id
where rs.return_id is null

Select * from Return_Status

 /*
Task 12: 
Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 30-day return period). 
Display the member's_id, member's name, book title, issue date, and days overdue.
*/

Select 
ist.issued_member_id,
m.member_name,
bk.book_title,
ist.issued_date,
current_date - ist.issued_date as over_dues_days
from Issued_status as ist
Join
Members as m
on m.Member_Id = ist.issued_member_id
Join 
Books as bk
on bk.Isbn = ist.Issued_Book_isbn
Left Join 
Return_Status as rs
on rs.Issued_id = ist.Issued_Id

Where rs.return_date  is null
And 
(current_date - ist.issued_date)>=250
Order by 1

/*    
Task 13: Update Book Status on Return
Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).
*/
Select * from Issued_Status;

Select * from Books
where isbn ='978-0-330-25864-8';
update Books
Set Status = 'no'
where isbn = '978-0-330-25864-8';

insert into Return_Status(return_id,issued_id,return_date)
values
('RS125','IS130',Current_date);
select * from return_status
where issued_id='IS130';

update Books
set status = 'yes'
where isbn = '978-0-330-25864-8';

--Automatic function
create or replace procedure add_return_records(p_return_id varchar(10),p_issued_id varchar(10),p_return_date date)
language plpgsql
as $$
declare
 v_ISBN_DATA VARCHAR(50);
   v_Book_name VARCHAR(100);
begin
	insert into Return_Status(return_id,issued_id,return_date)
	values
	(p_return_id,p_return_id,current_date);

	select 
	issued_book_isbn
	issued_book_name
	into v_ISBN_DATA,v_Book_name
	from issued_status
	where issued_id = p_issued_id;
	update Books
	set status = 'yes'
	where isbn = 'v_ISBN_DATA' ;

	Raise notice 'Thank you for returning the book%', v_Book_name;
		
end;
$$

-- Testing FUNCTION add_return_records
call add_return_records();

issued_id = IS135
ISBN = where isbn = '978-0-307-58837-1'

select * from Books
where isbn = '978-0-307-58837-1';

select * from issued_status
where issued_book_isbn = '978-0-307-58837-1';

select * from return_status
where issued_id = 'IS135';
	
call add_return_records('RS18','IS135',current_date);


/*
Task 14: Branch Performance Report
Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.
*/
select * from Branch;
select * from Issued_status;
select *from employees;
select * from Books;
select * from return_status;

create table Branch_report
as
select
 b.branch_id,
   b.manager_id,
   COUNT(ist.issued_id) as number_book_issued,
   COUNT(rs.return_id) as number_of_book_return,
   SUM(bk.rental_price) as total_revenue 
from Issued_status as ist
join
employees as e
on e.emp_id = ist.issued_emp_id
join 
branch as b
on e.branch_id = b.branch_id
left join 
return_status as rs
on rs.issued_id = ist.issued_id
join
books as bk
on ist.issued_book_isbn = bk.isbn
group by 1,2;
select * from Branch_report

-- Task 15: CTAS: Create a Table of Active Members
-- Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.

CREATE TABLE active_members as
select * from members
where member_id in(select 
distinct issued_member_id
from issued_status
where issued_date >= current_date - Interval '9 months')

select * from active_members;


-- Task 16: Find Employees with the Most Book Issues Processed
-- Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.

select 
e.emp_name,
b.*,
count(ist.issued_id) as number_of_books
from issued_status as ist 
join 
employees as e
on ist.issued_emp_id = e.emp_id
join branch as b
 on e.branch_id = b.branch_id
 group by 1,2;


/*
Task 17: Stored Procedure Objective: 

Create a stored procedure to manage the status of books in a library system. 

Description: Write a stored procedure that updates the status of a book in the library based on its issuance. 

The procedure should function as follows: 

The stored procedure should take the book_id as an input parameter. 

The procedure should first check if the book is available (status = 'yes'). 

If the book is available, it should be issued, and the status in the books table should be updated to 'no'. 

If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.
*/

select * from books
select * from issued_status

CREATE OR REPLACE PROCEDURE issue_book(p_issued_id VARCHAR(10), p_issued_member_id VARCHAR(30), p_issued_book_isbn VARCHAR(30), p_issued_emp_id VARCHAR(10))
LANGUAGE plpgsql
AS $$

DECLARE
-- all the variabable
    v_status VARCHAR(10);

BEGIN
-- all the code
    -- checking if book is available 'yes'
    SELECT 
        status 
        INTO
        v_status
    FROM books
    WHERE isbn = p_issued_book_isbn;

    IF v_status = 'yes' THEN

        INSERT INTO issued_status(issued_id, issued_member_id, issued_date, issued_book_isbn, issued_emp_id)
        VALUES
        (p_issued_id, p_issued_member_id, CURRENT_DATE, p_issued_book_isbn, p_issued_emp_id);

        UPDATE books
            SET status = 'no'
        WHERE isbn = p_issued_book_isbn;

        RAISE NOTICE 'Book records added successfully for book isbn : %', p_issued_book_isbn;


    ELSE
        RAISE NOTICE 'Sorry to inform you the book you have requested is unavailable book_isbn: %', p_issued_book_isbn;
    END IF;

    
END;
$$


 SELECT * FROM books;
-- "978-0-14-118776-1" -- yes
-- "978-0-375-41398-8" -- no
SELECT * FROM issued_status;
 CALL issue_book('IS158', 'C108', '978-0-14-118776-1', 'E104');
 CALL issue_book('IS156', 'C108', '978-0-375-41398-8', 'E104');

 SELECT * FROM books
WHERE isbn = '978-0-14-118776-1'

