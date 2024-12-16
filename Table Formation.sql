-- Library System Management SQL Project

Create Table Branch (
Branch_Id varchar(10) Primary key,
Manager_Id varchar(10),
Branch_Address varchar(20),
Contact_No varchar(15)
);
Alter table Branch
Alter column Branch_Address type varchar(100);

Create Table Employees (
Emp_Id varchar(10) Primary key,
Emp_Name varchar(20),
Position varchar(20),
Salary float(10),
Branch_Id varchar(10)--FK
);
Alter table Employees
Alter column Emp_Name type varchar(50);
Alter table Employees
Alter column Position type varchar(50);

Create Table Members (
Member_Id varchar(10) Primary key,
Member_Name varchar(50),
Member_Address varchar(100),
Reg_Date Date
);

Create Table Books(
Isbn varchar(10) Primary key,
Book_Title varchar(100),
Category varchar(30),
Rental_Price float(10),
Status varchar(10),
Author varchar(20),
Publisher varchar(50)
);
Alter table Books
Alter column Isbn type varchar(30);
Alter table Books
Alter column Author type varchar(50);

Create Table Issued_Status (
Issued_Id varchar(10) Primary key,
Issued_Member_Id varchar(10),--FK
issued_book_name varchar(100),
Issued_Date date,
Issued_Book_Isbn varchar(50),
Issued_Emp_Id varchar(10) --FK
);

Create Table  Return_Status (
Return_Id varchar(10) Primary key,
Issued_Id varchar(10),
Return_Book_name varchar(100),--FK
Return_Date date,
Return_Book_Isbn varchar(10) --FK
);
--Foregin Key
Alter Table issued_status
Add Constraint fk_Members
FOREIGN key (Issued_Member_Id)
REFERENCES  Members(Member_Id);

Alter Table issued_status
Add Constraint fk_Books
FOREIGN key (Issued_Book_Isbn)
REFERENCES  Books(Isbn);

Alter Table issued_status
Add Constraint fk_Emp
FOREIGN key (Issued_Emp_Id)
REFERENCES  Employees(Emp_Id);

Alter Table Return_Status
Add Constraint fk_Book_id
FOREIGN key (Return_Book_Isbn)
REFERENCES  Books(Isbn);

Alter Table Employees
Add Constraint fk_Branch_id
FOREIGN key (Branch_Id)
REFERENCES  Branch(Branch_Id);





