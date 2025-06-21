--Lesson - 10

--1. Using the Employees and Departments tables, write a query to return 
--the names and salaries of employees whose salary is greater than 50000,
--along with their department names.
--🔁 Expected Columns: EmployeeName, Salary, DepartmentName
Select e.Name as EmployeeName, e.Salary, d.DepartmentName
from Departments d
Join Employees e on d.DepartmentID=e.DepartmentID
where e.Salary>50000;

--2. Using the Customers and Orders tables, write a query to display customer names and 
--order dates for orders placed in the year 2023. Expected Columns: FirstName, LastName, OrderDate
Select c.FirstName, c.LastName, o.OrderDate
from Customers c 
Join Orders o on c.CustomerID=o.CustomerID
Where Year(o.OrderDate) = 2023;

--3. Using the Employees and Departments tables, write a query to show all employees along 
--with their department names. Include employees who do not belong to any department.
--Expected Columns: EmployeeName, DepartmentName
Select e.Name as EmployeeName, d.DepartmentName 
from Departments d
Left Join Employees e on d.DepartmentID = e.DepartmentID;

--4 Using the Products and Suppliers tables, write a query to list all suppliers and the
--products they supply. Show suppliers even if they don’t supply any product.
--Expected Columns: SupplierName, ProductName
Select s.SupplierName, p.ProductName
from Suppliers s
Left Join Products p on s.SupplierID=p.SupplierID;

--5. Using the Orders and Payments tables, write a query to return all orders and their 
-- corresponding payments. Include orders without payments and payments not linked to any
-- order. Expected Columns: OrderID, OrderDate, PaymentDate, Amount
Select o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
From Orders o 
Full Join Payments p on o.OrderID=p.OrderID;

--6. Using the Employees table, write a query to show each employee's name along with the
--name of their manager. Expected Columns: EmployeeName, ManagerName 
Select e1.Name as EmployeeName, e2.Name as ManagerName
from Employees e1
Left Join Employees e2 on e1.ManagerID = e2.EmployeeID;

--7. Using the Students, Courses, and Enrollments tables, write a query to list the names
-- of students who are enrolled in the course named 'Math 101'. Expected Columns: StudentName, CourseName
Select s.Name as StudentName, c.CourseName
from Students s
Join Enrollments e on s.StudentID=e.StudentID
Join Courses c on e.CourseID=c.CourseID
Where c.CourseName = 'Math 101';

--8. Using the Customers and Orders tables, write a query to find customers who have 
-- placed an order with more than 3 items. Return their name and the quantity they 
-- ordered. Expected Columns: FirstName, LastName, Quantity
Select c.FirstName, c.LastName, o.Quantity
from Customers c
Join Orders o on c.CustomerID=o.CustomerID
Where o.Quantity > 3;

--9. Using the Employees and Departments tables, write a query to list employees working
-- in the 'Human Resources' department. Expected Columns: EmployeeName, DepartmentName
Select e.Name as EmployeeName, d.DepartmentName
from Departments d 
Join Employees e on d.DepartmentID=e.DepartmentID
where d.DepartmentName  = 'Human Resources';

--10. Using the Employees and Departments tables, write a query to return department 
-- names that have more than 5 employees. Expected Columns: DepartmentName, EmployeeCount 
Select d.DepartmentName, Count(e.EmployeeID) as EmployeeCount
from Departments d 
Join Employees e on d.DepartmentID=e.DepartmentID
Group by d.DepartmentName
Having Count(e.EmployeeID)> 5;

--11. Using the Products and Sales tables, write a query to find products that have never
-- been sold.Expected Columns: ProductID, ProductName 
Select p.ProductID, p.ProductName
From Products p
Left Join Sales s on p.ProductID=s.ProductID
Where s.SaleID is null;

--12. Using the Customers and Orders tables, write a query to return customer names who
-- have placed at least one order. Expected Columns: FirstName, LastName, TotalOrders
Select c.FirstName, c.LastName, o.Quantity as TotalOrders
from Customers c
Join Orders o on c.CustomerID=o.CustomerID
Where o.Quantity > 0;

--13. Using the Employees and Departments tables, write a query to show only those records
-- where both employee and department exist (no NULLs). Expected Columns: EmployeeName,DepartmentName
Select e.Name as EmployeeName,d.DepartmentName
From Departments d
Join Employees e on d.DepartmentID=e.DepartmentID;

--14. Using the Employees table, write a query to find pairs of employees who report to 
-- the same manager. Expected Columns: Employee1, Employee2, ManagerID
Select e1.Name as Employee1, e2.Name as Employee2, e1.ManagerID
From Employees e1 
Join Employees e2 on e1.ManagerID=e2.ManagerID and e1.EmployeeID < e2.EmployeeID
Where e1.ManagerID is not null;

--15. Using the Orders and Customers tables, write a query to list all orders placed in
-- 2022 along with the customer name.Expected Columns: OrderID, OrderDate, FirstName, LastName
Select o.OrderID, o.OrderDate, c.FirstName, c.LastName
From Customers c
Join Orders o on c.CustomerID=o.CustomerID
Where Year(OrderDate) = 2022;

--16. Using the Employees and Departments tables, write a query to return employees from 
-- the 'Sales' department whose salary is above 60000. Expected Columns: EmployeeName, Salary, DepartmentName
Select e.Name as EmployeeName, e.Salary, d.DepartmentName 
From Departments d
Join Employees e on d.DepartmentID=e.DepartmentID
Where d.DepartmentName = 'Sales' and e.Salary > 60000;

--17. Using the Orders and Payments tables, write a query to return only those orders that
-- have a corresponding payment.Expected Columns: OrderID, OrderDate, PaymentDate, Amount
Select o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
From Orders o
Join Payments p on o.OrderID=p.OrderID;

--18. Using the Products and Orders tables, write a query to find products that were never
-- ordered. Expected Columns: ProductID, ProductName
Select p.ProductID, p.ProductName
From Products p 
Left Join Orders o on p.ProductID=o.ProductID
Where o.OrderID is null;

--19. Using the Employees table, write a query to find employees whose salary is greater 
-- than the average salary in their own departments. Expected Columns: EmployeeName, Salary
Select e.Name as EmployeeName, e.Salary
From Employees e
Where  e.Salary > (Select Avg(Salary) from Employees where DepartmentID = e.DepartmentID); 

--20. Using the Orders and Payments tables, write a query to list all orders placed before 
-- 2020 that have no corresponding payment. Expected Columns: OrderID, OrderDate
Select o.OrderID, o.OrderDate
From Orders o 
Left Join Payments p on o.OrderID=p.OrderID 
where Year(o.OrderDate) < 2020 and p.PaymentID is null;

--21. Using the Products and Categories tables, write a query to return products that do
-- not have a matching category. Expected Columns: ProductID, ProductName
Select * from Products 
Select * from Categories
Select p.ProductID, p.ProductName
From Products p
Left Join Categories c on c.CategoryID=p.Category
Where c.CategoryID is null;

--22. Using the Employees table, write a query to find employees who report to the same 
-- manager and earn more than 60000. Expected Columns: Employee1, Employee2, ManagerID,
-- Salary
Select e1.Name as Employee1, e2.Name as Employee2, e1.ManagerID, e1.Salary as Salary1, e2.Salary as Salary2
From Employees e1 
Join Employees e2 on e1.ManagerID = e2.ManagerID and e1.EmployeeID < e2.EmployeeID
Where e1.Salary > 60000 and e2.Salary > 60000;

--23. Using the Employees and Departments tables, write a query to return employees who
-- work in departments which name starts with the letter 'M'. Expected Columns: EmployeeName, DepartmentName
Select e.Name as EmployeeName, d.DepartmentName
From Departments d
Join Employees e on d.DepartmentID=e.DepartmentID
Where d.DepartmentName LIKE 'M%';

--24. Using the Products and Sales tables, write a query to list sales where the amount
-- is greater than 500, including product names. Expected Columns: SaleID, ProductName, SaleAmount
Select s.SaleID, p.ProductName, s.SaleAmount
from Products p 
Join Sales s on p.ProductID=s.ProductID
Where s.SaleAmount > 500;

--25. Using the Students, Courses, and Enrollments tables, write a query to find students 
-- who have not enrolled in the course 'Math 101'.Expected Columns: StudentID, StudentName
Select s.StudentID, s.Name as StudentName
from Students s
where not exists (
    select 1
    from Enrollments e
    join Courses c on e.CourseID = c.CourseID
    where e.StudentID = s.StudentID
      and c.CourseName = 'Math 101'
);

--26. Using the Orders and Payments tables, write a query to return orders that are missing 
-- payment details.Expected Columns: OrderID, OrderDate, PaymentID
Select o.OrderID, o.OrderDate, p.PaymentID
from Orders o 
Left Join Payments p on o.OrderID=p.OrderID
Where p.PaymentID is null;

--27. Using the Products and Categories tables, write a query to list products that belong 
-- to either the 'Electronics' or 'Furniture' category. Expected Columns: ProductID, ProductName, CategoryName 
Select p.ProductID, p.ProductName, c.CategoryName 
from Categories c
Join Products p on c.CategoryID=p.Category
Where c.CategoryName = 'Electronics' or c.CategoryName = 'Furniture';
