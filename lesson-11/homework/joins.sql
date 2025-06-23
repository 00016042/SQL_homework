--Lesson - 11.
--1. Return: OrderID, CustomerName, OrderDate
--Task: Show all orders placed after 2022 along with the names of the 
--customers who placed them.
Select o.OrderId, c.FirstName + ' ' + c.LastName as CustomerName,o.OrderDate
From Customers c
Join Orders o on c.CustomerID=o.CustomerID
Where Year(o.OrderDate) > 2022;

--2. Display the names of employees who work in either the Sales or 
-- Marketing department.
Select e.Name as EmployeeName, d.DepartmentName
from Departments d
Join Employees e on d.DepartmentID=e.DepartmentID
Where d.DepartmentName in ('Sales', 'Marketing' );

--3. Show the highest salary for each department.
Select d.DepartmentName, Max(e.Salary) as MaxSalary
from Departments d
Join Employees e on d.DepartmentID=e.DepartmentID
Group by d.DepartmentName;

--4. List all customers from the USA who placed orders in the year 2023.
Select c.FirstName + ' ' + c.LastName as CustomerName, o.OrderID, o.OrderDate
From Customers c
Join Orders o on c.CustomerID=o.CustomerID
Where c.Country = 'USA' and Year(o.OrderDate) = 2023;

--5. Show how many orders each customer has placed.
Select c.FirstName + ' ' + c.LastName as CustomerNames, Count(o.OrderID) as TotalOrders
from Customers c
Join Orders o on c.CustomerID=o.CustomerID
Group by c.FirstName, c.LastName;

--6. Display the names of products that are supplied by either Gadget 
--Supplies or Clothing Mart.
Select p.ProductName, s.SupplierName
from Suppliers s
Join Products p on s.SupplierID=p.SupplierID
Where s.SupplierName in ('Gadget Supplies', 'Clothing Mart');

--7. For each customer, show their most recent order. Include customers
--who haven't placed any orders.
Select c.FirstName + ' ' + c.LastName as CustomerName, Max(o.OrderDate) as MostRecentOrderDate
from Customers c
Left Join Orders o on c.CustomerID=o.CustomerID
Group by c.FirstName, c.LastName;

--8. Show the customers who have placed an order where the total amount
-- is greater than 500.
Select c.FirstName + ' ' + c.LastName as CustomerName, o.TotalAmount as OrderTotal
from Customers c
Join Orders o on c.CustomerID=o.CustomerID
where o.TotalAmount>500;

--9. List product sales where the sale was made in 2022 or the sale
-- amount exceeded 400.
Select p.ProductName, s.SaleDate, s.SaleAmount
from Products p
Join Sales s on p.ProductID=s.ProductID
Where Year(SaleDate) = 2022 or s.SaleAmount > 400;

--10. Display each product along with the total amount it has been sold for.
Select p.ProductName, Sum(s.SaleAmount) as TotalSaleAmount
from Products p 
Join Sales s on p.ProductID=s.ProductID
Group by p.ProductName;

--11. Show the employees who work in the HR department and earn a salary 
--greater than 60000.
Select e.Name as EmployeeName, d.DepartmentName, e.Salary
from Departments d 
Join Employees e on d.DepartmentID=e.DepartmentID
Where d.DepartmentName = 'Human Resources' and e.Salary > 60000;

--12. List the products that were sold in 2023 and had more than 100 
--units in stock at the time.
Select p.ProductName, s.SaleDate, p.StockQuantity
From Products p
Join Sales s on p.ProductID=s.ProductID
where Year(s.SaleDate) = 2023 and p.StockQuantity>100;

--13. Show employees who either work in the Sales department or were
--hired after 2020.
Select e.Name as EmployeeName, d.DepartmentName, e.HireDate
from Departments d
Join Employees e on d.DepartmentID=e.DepartmentID
Where DepartmentName = 'Sales' or year(e.HireDate) > 2020;

--14. List all orders made by customers in the USA whose address starts
--with 4 digits.
Select c.FirstName + ' ' + c.LastName as CustomerName, o.OrderID, c.Address,o.OrderDate
from Customers c
Join Orders o on c.CustomerID=o.CustomerID
Where c.Country = 'USA' and c.Address like '[1-9][1-9][1-9][1-9]%';

--15. Display product sales for items in the Electronics category or 
--where the sale amount exceeded 350.
Select p.ProductName, p.Category, s.SaleAmount
from Products p 
Join Sales s on p.ProductID=s.ProductID
where p.Category=1 or s.SaleAmount >350;

--16. Show the number of products available in each category.
Select c.CategoryName, Count(p.ProductID) as ProductCount
from Categories c
Join Products p on c.CategoryID=p.Category
Group by c.CategoryName;

--17. List orders where the customer is from Los Angeles and the order
--amount is greater than 300.
Select c.FirstName + ' ' + c.LastName as CustomerName, c.City, o.OrderID, TotalAmount as Amount
from Customers c
Join Orders o on c.CustomerID=o.CustomerID
Where c.City = 'Los Angeles' and o.TotalAmount > 300;

--18. Display employees who are in the HR or Finance department, or 
--whose name contains at least 4 vowels.
Select e.Name as EmployeeName, d.DepartmentName
from Departments d
Join Employees e on d.DepartmentID=e.DepartmentID
Where d.DepartmentName in ('Human Resources', 'Finance') 
or -- count the number of vowels in the name:
    -- subtract the length of the name with vowels removed from the original length
	(
    len(lower(e.name)) 
    - len(replace(replace(replace(replace(replace(lower(e.name), 'a', ''), 'e', ''), 'i', ''), 'o', ''), 'u', ''))
    >= 4
  );

--19. Show employees who are in the Sales or Marketing department and 
--have a salary above 60000.
Select e.Name as EmployeeName,d.DepartmentName, e.Salary
from Departments d
Join Employees e on d.DepartmentID=e.DepartmentID
Where d.DepartmentName in ('Sales', 'Marketing') and e.Salary > 60000;
