--lesson-3 
--1. Define and explain the purpose of BULK INSERT in SQL Server.
/*BULK INSERT is a Transact-SQL command in SQL Server used to efficiently load large 
volumes of data from a data file into a database table. It’s designed for high-performance, 
bulk data import, allowing you to quickly move data from external files into SQL Server 
tables without the overhead of row-by-row insertions.*/

--2. List four file formats that can be imported into SQL Server.
/*Four File Formats That Can Be Imported into SQL Server
CSV (Comma-Separated Values) — plain text files with values separated by commas.

TXT (Text Files) — plain text files with data separated by delimiters like tabs or other characters.

XML (Extensible Markup Language) — structured text files that can represent hierarchical data.

JSON (JavaScript Object Notation) — lightweight data-interchange format that can be imported using specific JSON functions or tools.*/

--3. Create a table Products with columns: ProductID (INT, PRIMARY KEY),
-- ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).
Create table Products (ProductId int Primary Key, ProductName varchar (50), 
Price Decimal (10,2))

Select * from products

--4. Insert three records into the Products table using INSERT INTO.
Insert into Products values 
  (1, 'Toys', 250)
, (2, 'Bikes', 790)
, (3, 'Shoes', 580)

--5. Explain the difference between NULL and NOT NULL.
/*NULL in SQL means that the value for a column is missing or unknown. It represents 
the absence of any data in that field, which is different from having a zero or an 
empty string. When a column is defined to allow NULLs, it means you can leave that 
field empty when inserting or updating a record. On the other hand, NOT NULL means the
column must always have a value. It cannot be left empty or undefined. If you try to 
insert or update a row without providing a value for a NOT NULL column, SQL Server 
will throw an error. Essentially, NULL indicates optional data, while NOT NULL enforces
that data must be present in the column.*/

--6. Add a UNIQUE constraint to the ProductName column in the Products table.
Alter table Products 
Add constraint UQ_ProductName unique (ProductName)

--7. Write a comment in a SQL query explaining its purpose.
-- This query retrieves all products with a price greater than 100
SELECT * 
FROM Products 
WHERE Price > 100;

--8. Add CategoryID column to the Products table.
Alter table Products 
Add CategoryID int

--9. Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName 
-- as UNIQUE.
Create table Categories (CategoryID int Primary Key, CategoryName varchar(30) Unique)

-- code for check 
select * from Categories

--10. Explain the purpose of the IDENTITY column in SQL Server.
/*The purpose of the IDENTITY column in SQL Server is to automatically generate unique
numeric values for new rows in a table. It is typically used to create an 
auto-incrementing primary key. When you define a column as an IDENTITY, SQL Server 
automatically assigns a sequential number to that column for each new row inserted,
without you having to specify the value manually. This helps ensure each row has a 
unique identifier, which is important for indexing, relationships, and data integrity.
You can specify the starting value (seed) and the increment value for the IDENTITY 
column.*/

--11. Use BULK INSERT to import data from a text file into the Products table.
BULK INSERT Products
FROM 'C:\Data\products.txt'
WITH
(
    FIELDTERMINATOR = ',',  -- Assuming the fields are comma-separated
    ROWTERMINATOR = '\n',   -- Each row ends with a newline
    FIRSTROW = 2            -- If the first row contains column headers, start from the second row
);

--12. Create a FOREIGN KEY in the Products table that references the Categories table.
Alter table Products 
add constraint fk_CategoryId Foreign Key (CategoryID) references Categories (CategoryId)

--13. Explain the differences between PRIMARY KEY and UNIQUE KEY.
/*The main differences between a PRIMARY KEY and a UNIQUE KEY in SQL Server are:

A PRIMARY KEY uniquely identifies each row in a table and enforces both uniqueness and 
NOT NULL constraints, meaning the primary key column(s) cannot contain NULL values. 
There can be only one primary key defined per table, and it’s often used as the main 
identifier for records.

A UNIQUE KEY also enforces uniqueness of the column(s), ensuring no duplicate values,
but unlike the primary key, it allows NULLs (depending on the database, usually one 
NULL is allowed per unique column). A table can have multiple unique keys.

In summary, the primary key uniquely identifies records and does not allow NULLs,
while unique keys enforce uniqueness but allow NULL values and multiple unique 
constraints can exist in a table.*/

--14 Add a CHECK constraint to the Products table ensuring Price > 0.
Alter table Products
add constraint chk_price check (Price > 0)

--for check
select * from Products

--15. Modify the Products table to add a column Stock (INT, NOT NULL).
Alter table Products 
add Stock int not null default 0

--16. Use the ISNULL function to replace NULL values in Price column with a 0.
SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;

--UPDATE Products
--SET Price = 0
--WHERE Price IS NULL;

--17. Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.
/*A FOREIGN KEY constraint in SQL Server enforces a link between data in two tables by 
ensuring that the values in a column (or columns) in one table match values in the 
primary key or unique key of another table. Its purpose is to maintain referential 
integrity, preventing invalid data and ensuring consistency across related tables. 
It can also support cascading actions like updating or deleting related records 
automatically when the referenced data changes.*/

--18. Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
Create Table Customers (Id int, Name varchar(50),Age int check (Age>=18))
--example 
INSERT INTO Customers (Id, Name, Age) VALUES (1, 'John Doe', 25);
INSERT INTO Customers (Id, Name, Age) VALUES (2, 'Jane Smith', 30);
-- This insert will fail because Age is less than 18
INSERT INTO Customers (Id, Name, Age) VALUES (3, 'Tom Brown', 17);
 
 select * from Customers

--19. Create a table with an IDENTITY column starting at 100 and incrementing by 10.

Create table Music (Id int, Singer varchar (30), stock int identity (100,10))

--for checking purposes:
INSERT INTO Music (Id, Singer) VALUES (1, 'Adele');
INSERT INTO Music (Id, Singer) VALUES (2, 'Beyonce');
INSERT INTO Music (Id, Singer) VALUES (3, 'Ed Sheeran');

Select * from Music

--20. Write a query to create a composite PRIMARY KEY in a new table OrderDetails.
Create table OrderDetails (OrderId int, OrderDate date, OrderedBy varchar(50), 
Constraint pk_orderDetails Primary Key (OrderId, OrderedBy))

--21. Explain the use of COALESCE and ISNULL functions for handling NULL values.
/*Both COALESCE and ISNULL functions are used to handle NULL values in SQL Server by 
returning the first non-NULL value from their arguments. The key difference is that 
ISNULL takes exactly two arguments and returns the second if the first is NULL, while 
COALESCE can take two or more arguments and returns the first non-NULL value among them.
COALESCE is more flexible and follows the ANSI SQL standard, whereas ISNULL is 
specific to SQL Server. Both are useful for replacing NULLs with default values in 
queries.*/

--22. Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
Create table Employees (EmpID int primary key, Name varchar (50), Email varchar (100) unique)

--23 Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.
ALTER TABLE ChildTable
ADD CONSTRAINT FK_Child_Parent
FOREIGN KEY (ParentID)
REFERENCES ParentTable (ID)
ON DELETE CASCADE
ON UPDATE CASCADE;
