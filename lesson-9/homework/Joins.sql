--Tasks should be solved using SQL Server.
--Case insensitivity applies.
--Alias names do not affect the score.
--Scoring is based on the correct output.
--One correct solution is sufficient.

-- Lesson-9
-- 1. Using Products, Suppliers table List all combinations of product 
-- names and supplier names.
Select ProductName, SupplierName
from Products p
 Cross Join Suppliers s where p.SupplierID=s.SupplierID;

--2. Using Departments, Employees table Get all combinations of 
-- departments and employees.
Select DepartmentName, Name 
from Departments 
Cross Join Employees; 
--3. Using Products, Suppliers table List only the combinations where 
-- the supplier actually supplies the product. Return supplier name and 
-- product name
Select ProductName, SupplierName
From Products p
Join Suppliers s on P.SupplierID=s.SupplierID;

--4.Using Orders, Customers table List customer names and their orders ID.
Select o.OrderID, c.FirstName, c.LastName
from Customers c
Join Orders o on c.CustomerID = o.CustomerID;
--5. Using Courses, Students table Get all combinations of students and 
--courses.
Select s.Name as StudentName, s.Major, s.Age, c.CourseName, c.Instructor
from Students s
Cross Join Courses c; 

--6. Using Products, Orders table Get product names and orders where 
-- product IDs match.
Select p.ProductName, o.OrderID 
from Products p
Join Orders o on p.ProductID=o.ProductID;

--7. Using Departments, Employees table List employees whose 
--DepartmentID matches the department.
Select e.Name as EmployeeName
From Departments d
Join Employees e on d.DepartmentID=e.DepartmentID;

--8. Using Students, Enrollments table List student names and their 
-- enrolled course IDs.
Select s.Name as StudentName, e.CourseID
from Students s
Join Enrollments e on s.StudentID=e.CourseID;

--9. Using Payments, Orders table List all orders that have matching 
-- payments.
Select o.OrderID, o.OrderDate, p.PaymentID, p.PaymentDate,p.Amount
from Orders o
Join Payments p on o.OrderID=p.OrderID;

--10. Using Orders, Products table Show orders where product price is 
-- more than 100.
SELECT 
    o.OrderID,
    o.ProductID,
    p.ProductName,
    p.Price,
    o.Quantity,
    o.TotalAmount,
    o.OrderDate
from Products p 
Join Orders o on p.ProductID=o.ProductID
Where p.Price > 100;

--11. Using Employees, Departments table List employee names and
-- department names where department IDs are not equal. It means:
-- Show all mismatched employee-department combinations.
Select 
e.Name as EmployeeNames,
d.DepartmentName,  
e.DepartmentID as EmployeeDeptID,
D.DepartmentID as DepartmentDeptID
from Departments d
Cross Join Employees e where d.DepartmentID <> e.DepartmentID; 

--12. Using Orders, Products table Show orders where ordered quantity 
-- is greater than stock quantity.
Select o.OrderID, p.ProductID, o.Quantity, p.ProductName, p.StockQuantity
From Products p
Join Orders o on p.productID=o.ProductID 
where o.Quantity > p.StockQuantity;
--13. Using Customers, Sales table List customer names and product IDs
-- where sale amount is 500 or more.
Select c.FirstName, c.LastName, s.ProductID
from Customers c
Join Sales s on c.CustomerID = s.CustomerID 
Where s.SaleAmount >= 500;

--14. Using Courses, Enrollments, Students table List student names and
-- course names they’re enrolled in.
Select s.Name as StudentName, c.CourseName, e.CourseID
from Courses c
Join Enrollments e on c.courseID=e.CourseID
Join Students s on e.StudentID=s.StudentID;

--15. Using Products, Suppliers table List product and supplier names
-- where supplier name contains “Tech”.
Select p.ProductName, s.SupplierName
from Suppliers s
Join Products p on s.SupplierID=p.SupplierID 
Where s.SupplierName Like '%Tech%';

--16. Using Orders, Payments table Show orders where payment amount is
-- less than total amount.
Select o.OrderID, p.PaymentID, o.TotalAmount, o.Quantity, p.Amount as PaymentAmount
from Orders o
Join Payments p on o.OrderID = p.OrderID
Where p.Amount  <o.TotalAmount;

--17. Using Employees and Departments tables, get the Department Name 
-- for each employee. 
Select d.DepartmentName, e.Name as EmployeeNames
From Departments d
Join Employees e on d.DepartmentID=e.DepartmentID;

--18. Using Products, Categories table Show products where category is 
-- either 'Electronics' or 'Furniture'. 
Select 
p.ProductName, 
p.Price,
c.CategoryName,
p.StockQuantity
from Products p
Join Categories c on p.Category = c.CategoryID
Where c.CategoryName in ('Electronics', 'Furniture');

--19. Using Sales, Customers table Show all sales from customers who 
-- are from 'USA'.
Select
c.FirstName, 
c.LastName,
c.Country,
s.SaleID, 
s.ProductID, 
s.SaleDate, 
s.SaleAmount
from Customers c
Join Sales s on c.CustomerID = s.CustomerID
Where c.Country Like 'USA';

--20. Using Orders, Customers table List orders made by customers from 
-- 'Germany' and order total > 100.
Select 
o.OrderID, 
o.OrderDate, 
o.Quantity, 
o.TotalAmount,
c.FirstName,
c.LastName,
c.Country
From Customers c
Join Orders o on c.CustomerID = o.CustomerID
Where c.Country like 'Germany' and o.TotalAmount > 100;

--21. Using Employees table List all pairs of employees from different 
-- departments.
Select 
e1.Name as Employee1,
e1.DepartmentID as Department1,
e2.Name as Employee2,
e2.DepartmentID as Department2
from Employees e1
Join Employees e2 on e1.EmployeeID <> e2.EmployeeID
Where e1.DepartmentID <> e2.DepartmentID;

--22. Using Payments, Orders, Products table List payment details where
-- the paid amount is not equal to (Quantity × Product Price).
Select p.PaymentID, p.PaymentDate, p.Amount,p.PaymentMethod, o.Quantity, pr.Price
From Products pr
Join Orders o on pr.ProductID=o.ProductID
Join Payments p on o.OrderID=p.OrderId
Where p.Amount <> o.Quantity*pr.Price;

--Using Students, Enrollments, Courses table Find students who are not
-- enrolled in any course.
Select s.Name as StudentName, e.CourseId, c.CourseName
from Students s 
Left Join Enrollments e on s.StudentID = e.StudentID
Left Join Courses c on c.CourseID=e.CourseID
Where e.CourseID is null;

--24. Using Employees table List employees who are managers of someone,
-- but their salary is less than or equal to the person they manage. 
Select 
e1.Name as StaffName, 
e2.Name as ManagerName,
e1.EmployeeID as StaffID, 
e2.EmployeeID as ManagerID,
e1.Salary as StaffSalary,
e2.Salary as ManagersSalary
From Employees e1
Join Employees e2 on e1.EmployeeID=e2.ManagerID
where e2.Salary<=e1.Salary;

--25. Using Orders, Payments, Customers table List customers who have 
-- made an order, but no payment has been recorded for it.
Select 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount
from Orders o
Join Customers c on o.CustomerID = c.CustomerID
Left Join Payments p on o.OrderID = p.OrderID
WHERE p.OrderID is null;
