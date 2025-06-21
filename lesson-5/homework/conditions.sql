--Lesson - 5.
--1. Write a query that uses an alias to rename the ProductName column as Name in the Products table.
Select ProductName as Name 
from Products;

--2.Write a query that uses an alias to rename the Customers table as Client for easier reference.
Select *
from Customers as Client;

--3. Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted.
Select ProductName from Products
Union 
Select ProductName from Products_Discounted;

--4. Write a query to find the intersection of Products and Products_Discounted tables using INTERSECT.
Select ProductID, ProductName from Products
Intersect
Select ProductID, ProductName  from Products_Discounted;

--5. Write a query to select distinct customer names and their corresponding Country using SELECT DISTINCT.
Select Distinct FirstName, LastName, Country
from Customers;

--6. Write a query that uses CASE to create a conditional column that displays 'High' if Price > 1000, and 'Low' if Price <= 1000 from Products table.
Select Price, ProductName,ProductID, 
Case 
when Price > 1000 then 'High' 
else 'Low' 
end as PriceCategory
from Products;

--7. Use IIF to create a column that shows 'Yes' if Stock > 100, and 'No' 
-- otherwise (Products_Discounted table, StockQuantity column). 
Select StockQuantity, IIF(StockQuantity>100, 'Yes', 'No')
from Products_Discounted;

--8. Use UNION to combine results from two queries that select ProductName 
-- from Products and ProductName from Products_Discounted tables.
Select ProductName from Products 
Union 
Select ProductName from Products_Discounted;

--9. Write a query that returns the difference between the Products and
-- Products_Discounted tables using EXCEPT.
Select * from Products 
Except 
Select * from Products_Discounted;

--10. Create a conditional column using IIF that shows 'Expensive' if 
-- the Price is greater than 1000, and 'Affordable' if less, from Products table.
Select Price, IIF(Price > 1000, 'Expensive', 'Affrodable')
from Products;

--11. Write a query to find employees in the Employees table who have
-- either Age < 25 or Salary > 60000.
Select * 
from Employees
Where Age < 25 or Salary > 60000;

--12. Update the salary of an employee based on their department, 
-- increase by 10% if they work in 'HR' or EmployeeID = 5 
Update Employees
set Salary = Salary * 1.10
Where DepartmentName = 'HR' or EmployeeID = 5;

--13. Write a query that uses CASE to assign 'Top Tier' if
-- SaleAmount > 500, 'Mid Tier' if SaleAmount BETWEEN 200 AND 500, 
-- and 'Low Tier' otherwise. (From Sales table)
Select SaleAmount,
Case 
when SaleAmount > 500 then 'Top Tier' 
When SaleAmount BETWEEN 200 AND 500 then 'Mid Tier'
else 'Low Tier'
end as TierType
From Sales;

--14. Use EXCEPT to find customers' ID who have placed orders but do not
-- have a corresponding record in the Sales table.
Select CustomerID from Orders
Except
Select CustomerID from Sales;

--15. Write a query that uses a CASE statement to determine the discount 
-- percentage based on the quantity purchased. Use orders table. 
-- Result set should show customerid, quantity and discount percentage. 
-- The discount should be applied as follows: 1 item: 3% Between 1 and 
-- 3 items : 5% Otherwise: 7%
Select CustomerID,	Quantity,
Case 
when Quantity = 1 then '3%'
when Quantity Between 1 and 3 then '5%'
else '7%'
end as DiscountPercentage
from Orders;
