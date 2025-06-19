-- Lesson - 4

--1. Write a query to select the top 5 employees from the Employees table.
Select top 5 * 
from Employees
Order by Salary Desc;

--2. Use SELECT DISTINCT to select unique Category values from the
-- Products table.
Select distinct Category 
from Products

--3.Write a query that filters the Products table to show products 
-- with Price > 100. 
Select * from Products 
where Price > 100;

--4. Write a query to select all Customers whose FirstName start with
-- 'A' using the LIKE operator.
Select * from Customers 
where FirstName LIKE 'A%';

--5. Order the results of a Products table by Price in ascending order.
Select * from Products 
Order by Price asc;

--6. Write a query that uses the WHERE clause to filter for employees 
-- with Salary >= 60000 and Department = 'HR'.
Select * from Employees 
Select * from Employees 
where Salary > 60000 and DepartmentName LIKE 'HR'

--7. Use ISNULL to replace NULL values in the Email column with the
-- text "noemail@example.com".From Employees table
Select * From Employees 
Select FirstName, LastName , ISNULL(Email, 'noemail@example.com') as Email
From Employees;

--8. Write a query that shows all products with Price BETWEEN 50 AND 100. 
Select * 
from Products 
Where Price BETWEEN 50 AND 100;

--9. Use SELECT DISTINCT on two columns (Category and ProductName) in 
-- the Products table.
Select distinct Category, ProductName
from Products;

--10. After SELECT DISTINCT on two columns (Category and ProductName)
-- Order the results by ProductName in descending order.
Select distinct Category, ProductName
from Products
Order by ProductName desc;

--11. Write a query to select the top 10 products from the Products table, 
-- ordered by Price DESC.
Select Top 10 *
from Products
Order by Price desc;

--12. Use COALESCE to return the first non-NULL value from FirstName or
-- LastName in the Employees table.
Select Coalesce (FirstName,LastName) as EmployeeName
from Employees;

--13. Write a query that selects distinct Category and Price from the 
-- Products table.
Select distinct Category, Price
from Products;

--14. Write a query that filters the Employees table to show employees
-- whose Age is either between 30 and 40 or Department = 'Marketing'.
Select FirstName, LastName, DepartmentName, Age
from Employees
Where Age between 30 and 40 or DepartmentName LIKE 'Marketing';

--15. Use OFFSET-FETCH to select rows 11 to 20 from the Employees table,
-- ordered by Salary DESC.
Select * 
from Employees
Order by Salary desc
Offset 10 rows
Fetch next 10 rows only;

--16. Write a query to display all products with Price <= 1000 and 
-- Stock > 50, sorted by Stock in ascending order.
Select * from Products 
where Price <= 1000 and StockQuantity > 50
Order by StockQuantity asc; 

--17. Write a query that filters the Products table for ProductName 
-- values containing the letter 'e' using LIKE.
Select *
from Products
Where ProductName LIKE '%e%';

--18. Use IN operator to filter for employees who work in either 'HR', 
-- 'IT', or 'Finance'.
Select * 
From Employees 
where DepartmentName IN ('HR', 'IT','Finance');

--19. Use ORDER BY to display a list of customers ordered by City in 
-- ascending and PostalCode in descending order.Use customers table
Select * 
from Customers 
Order by City asc, PostalCode desc;

--20. Write a query that selects the top 5 products with the highest 
-- sales, using TOP(5) and ordered by SalesAmount DESC. 
Select Top 5 *
from Sales
Order by SaleAmount desc;

--21. Combine FirstName and LastName into one column named FullName in 
-- the Employees table. (only in select statement)
Select FirstName + ' ' + LastName as FullName
from Employees;

--22. Write a query to select the distinct Category, ProductName, and 
-- Price for products that are priced above $50, using DISTINCT on
-- three columns.
Select distinct Category, ProductName, Price 
from Products
Where Price > 50;

--23. Write a query that selects products whose Price is less than 10%
-- of the average price in the Products table. (Do some research on 
-- how to find average price of all products)
Select * 
from Products 
where Price  < (Select Avg(Price)*0.10 from Products);

--24. Use WHERE clause to filter for employees whose Age is less than 
-- 30 and who work in either the 'HR' or 'IT' department.
Select * 
from Employees
where Age < 30 and DepartmentName in ('HR', 'IT');

--25. Use LIKE with wildcard to select all customers whose Email
-- contains the domain '@gmail.com'.
Select * 
from Customers 
Where Email LIKE '%@gmail.com%';

--26. Write a query that uses the ALL operator to find employees whose
-- salary is greater than all employees in the 'Sales' department.
Select * 
from Employees
where Salary > ALL (
Select Salary 
from Employees 
where DepartmentName = 'Sales');

--27. Write a query that filters the Orders table for orders placed in
-- the last 180 days using BETWEEN and LATEST_DATE in the table.
-- (Search how to get the current date and latest date) 
select * 
from Orders
where OrderDate between dateadd(day, -180, (select max(OrderDate)from Orders))
and (select max(OrderDate) from Orders);








