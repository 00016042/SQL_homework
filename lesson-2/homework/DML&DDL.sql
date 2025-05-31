--Lesson - 2
--1.Create a table Employees with columns: EmpID INT, Name (VARCHAR(50)), 
-- and Salary (DECIMAL(10,2)).
Create table Employees (EmpId int, Name varchar(50), Salary decimal (10,2))

-- code checking the Employees table
select * from Employees 

--2. Insert three records into the Employees table using different INSERT INTO 
-- approaches (single-row insert and multiple-row insert).
-- for single-row insert
Insert into Employees (EmpId, Name, Salary) values (1, 'Antony', 5500)

-- Truncate table Employees

-- multiple-row insert
Insert into Employees (EmpId, Name, Salary) values 
(2, 'Sancho', 3570)
,(3, 'Diego', 4650)
,(4, 'John', 8660)

--3. Update the Salary of an employee to 7000 where EmpID = 1.
Update Employees 
set Salary = 7000
where EmpId = 1

--4. Delete a record from the Employees table where EmpID = 2.
delete from Employees 
where EmpId = 2

-- 5. Give a brief definition for difference between DELETE, TRUNCATE, and DROP.
/* "Delete" is an example of DML comands and it is used to delete the data inside table, namely it delets rows inside table.
"Truncate" is an example of DDL comands and it is used to clear the table. When "Truncate" function is used it will delete all rows inside table at once, but the table will not be deleted and it will be empty, without any data inside.
"Drop" is also an example of DDL comands. Drop is used for "SQL objects", for example "Drop table Employees" or "Drop database Students". */

--6. Modify the Name column in the Employees table to VARCHAR(100).
Alter table Employees 
alter column Name varchar(100)

--7. Add a new column Department (VARCHAR(50)) to the Employees table.
Alter table Employees
add Department varchar (50)

--8. Change the data type of the Salary column to FLOAT.
Alter table Employees 
alter column Salary Float
--9. Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) 
-- and DepartmentName (VARCHAR(50)).
Create table Departments (DepartmentId int primary key, DepartmentName varchar(50))
-- code for selecting Departments table
Select * from Departments

--10. Remove all records from the Employees table without deleting its structure.
Truncate table Employees

--code for check 
Select * from Employees

--11. Insert five records into the Departments table using INSERT INTO SELECT method
-- (you can write anything you want as data).
Insert into Departments (DepartmentId, DepartmentName)
Select 1, 'It' UNION ALL
Select 2, 'Management' UNION ALL
Select 3, 'HR' UNION ALL
Select 4, 'Finance' UNION ALL
Select 5, 'Education';

--12. Update the Department of all employees where Salary > 5000 to 'Management'.
Update Employees 
set Department = 'Managenent'
where Salary > 5000

--13. Write a query that removes all employees but keeps the table structure intact.
--option one 
Truncate table Employees

--option two
delete from Employees

--14. Drop the Department column from the Employees table.
Alter table Employees 
drop column Department

--15. Rename the Employees table to StaffMembers using SQL commands.
EXEC sp_rename 'Employees', 'StaffMembers';
-- for columns ->  EXEC sp_rename 'table_name.old_name',  'new_name', 'COLUMN';

--16. Write a query to completely remove the Departments table from the database.
Drop table Departments

--17. Create a table named Products with at least 5 columns, including: 
--ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)
Create table Products (ProductID int primary key, ProductName varchar(50), 
Category varchar (50), Price decimal, Quantity int)

-- code for check
Select * from Products

--18. Add a CHECK constraint to ensure Price is always greater than 0.
-- drop existing products table first 
drop table Products

Create table Products (ProductID int primary key, ProductName varchar(50), 
Category varchar (50), Price decimal, Quantity int, 
CONSTRAINT chk_Price_Positive CHECK (Price > 0));

--19. Modify the table to add a StockQuantity column with a DEFAULT value of 50.
Alter table Products 
Add StockQuantity int default 50;

--20. Rename Category to ProductCategory
EXEC sp_rename 'Products.Category', 'ProductCategory', 'Column';

--21. Insert 5 records into the Products table using standard INSERT INTO queries.
Insert into Products (ProductID, ProductName, ProductCategory, Price, Quantity) values 
(1, 'Apple', 'Fruit', 10, 100)
,(2, 'Banana', 'Fruit', 20, 100)
,(3, 'Pear', 'Fruit', 15, 100)
,(4, 'Grape', 'Fruit', 25, 100)
,(5, 'Peach', 'Fruit', 12, 100);

--22. Use SELECT INTO to create a backup table called Products_Backup 
--containing all Products data.
Select * into Products_Backup from Products

--23. Rename the Products table to Inventory.
EXEC sp_rename 'Products', 'Inventory';

--for check
Select * from Inventory

--24. Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.
Alter table Inventory
alter column Price Float

--25. Add an IDENTITY column named ProductCode that starts from 1000 and increments 
--by 5 to Inventory table. 
-- 1. Create new table with ProductCode as IDENTITY
CREATE TABLE Inventory_New (
    ProductCode INT IDENTITY(1000, 5) PRIMARY KEY,
    ProductID INT NOT NULL,
    ProductName VARCHAR(100) NOT NULL,
    ProductCategory VARCHAR(50),
    Price DECIMAL(10, 2) NOT NULL CHECK (Price > 0),
    StockQuantity INT DEFAULT 50
);

-- 2. Copy data from old Inventory to new table
INSERT INTO Inventory_New (ProductID, ProductName, ProductCategory, Price, StockQuantity)
SELECT ProductID, ProductName, ProductCategory, Price, StockQuantity
FROM Inventory;

-- 3. Drop old Inventory table
DROP TABLE Inventory;

-- 4. Rename new table to Inventory
EXEC sp_rename 'Inventory_New', 'Inventory';
