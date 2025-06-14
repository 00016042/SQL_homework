--lesson - 7 
--1. Write a query to find the minimum (MIN) price of a product in the Products table.
--Here i have used Min agregate function to find the minimum price.
Select Min(Price) 
from Products; 

--2. Write a query to find the maximum (MAX) Salary from the Employees table.
--Here i have used Max agregate function to find the highest salary.
Select Max(Salary) as MaxSalary 
from Employees
Select * from Employees;

--3.Write a query to count the number of rows in the Customers table.
Select Count(*) as number_of_rows 
from Customers;
Select * from customers

--4.Write a query to count the number of unique product categories from the Products table.
Select Count(distinct Category) as UniqueCategory 
from Products;
Select * from Products

--5. Write a query to find the total sales amount for the product with id 7 in the Sales table.
Select * from Sales 
Select Sum(Quantity*PricePerUnit) as TotalSalesAmount; 
from Sales

--6. Write a query to calculate the average age of employees in the Employees table.
Select avg(age) as AvgAgeOfEmp 
from Employees;

--code for checking the table 
Select * from Employees

--7. Write a query to count the number of employees in each department.
Select DepartmentName, Count(*) 
from Employees; 
group by DepartmentName

--8. Write a query to show the minimum and maximum Price of products grouped by Category. 
--Use products table.
Select Category, Max(Price) as MaxPrice, Min(Price) as MinPrice 
from Products
group by Category;

Select * FROM Products

--9. Write a query to calculate the total sales per Customer in the Sales table.
Select * from  Sales

Select CustomerName, Sum(Quantity * PricePerUnit) as TotSalOfCustomer 
from Sales 
group by CustomerName;

--10. Write a query to filter departments having more than 5 employees from the 
--Employees table.(DeptID is enough, if you don't have DeptName).
Select DepartmentName, Count(EmployeeId) as NumOfEmp 
from Employees
group by DepartmentName
Having Count(EmployeeId) > 5;

Select * from Employees

--11. Write a query to calculate the total sales and average sales for each product 
-- category from the Sales table.
Select * from Sales
Select Category, Sum(Quantity * PricePerUnit) as TotalSal, Avg(Quantity * PricePerUnit) as AvgSal
from Sales 
group by Category;

--12. Write a query to count the number of employees from the Department HR.
Select DepartmentName, Count(EmployeeID) as EmpInHr
from Employees
Where DepartmentName = 'HR'
Group by DepartmentName;

--13. Write a query that finds the highest and lowest Salary by department in the 
-- Employees table.(DeptID is enough, if you don't have DeptName).
Select * from Employees
Select DepartmentName, Max(Salary) as MaxSal, Min(Salary) as MinSal
From Employees
Group by DepartmentName;

--14. Write a query to calculate the average salary per Department.(DeptID is enough, 
--if you don't have DeptName).
Select DepartmentName, Avg(Salary) as AvgSal
From Employees
Group by DepartmentName;

--15. Write a query to show the AVG salary and COUNT(*) of employees working in each
--department.(DeptID is enough, if you don't have DeptName).
Select DepartmentName, Avg(Salary) as AvgSal, Count(*) as NumOfEmp
From Employees
Group by DepartmentName;

--16. Write a query to filter product categories with an average price greater than 400.
Select Category, Avg(Price) as AvgPrice
from Products
group by Category
Having Avg(Price) > 400;

Select * from Products

--17. Write a query that calculates the total sales for each year in the Sales table.
Select * from Sales
Select Year(SaleDate) as SaleYear, Sum(Quantity * PricePerUnit) as TotAnnualSal
from Sales
group by Year(SaleDate);

--18. Write a query to show the list of customers who placed at least 3 orders.
Select * from Orders
Select CustomerID, Count(OrderID) as OrderCount
from Orders
group by CustomerID
Having Count(OrderID) >= 3;

--19. Write a query to filter out Departments with average salary expenses greater than
-- 60000.(DeptID is enough, if you don't have DeptName). 
Select DepartmentName, Avg(Salary) as AvgSal
from Employees
group by DepartmentName
Having Avg(Salary) > 60000;

Select * FROM Employees

--20. Write a query that shows the average price for each product category, and then 
-- filter categories with an average price greater than 150.
Select * from Products 
Select Category, Avg(Price) as AvgPrice 
from Products
group by Category
Having Avg(Price) > 150;

--21. Write a query to calculate the total sales for each Customer, then filter the 
-- results to include only Customers with total sales over 1500.
Select * from Orders
Select CustomerID, Sum(TotalAmount) as TotalSale
from Orders
group by CustomerID
Having Sum(TotalAmount) > 1500;

--22. Write a query to find the total and average salary of employees in each department,
--and filter the output to include only departments with an average salary greater than 65000.
Select * from Employees 
Select DepartmentName, Sum(Salary) as TotalSal, Avg(Salary) as AvgSal
from Employees
group by DepartmentName
Having Avg(Salary) > 65000;

--23. Write a query to find total amount for the orders which weights more than $50 for
--each customer along with their least purchases.(least amount might be lower than 50,
-- use tsql2012.sales.orders table,freight col, ask ur assistant to give the TSQL2012 
-- database).

SELECT 
    CustomerID,
    SUM(CASE WHEN Freight > 50 THEN Freight ELSE 0 END) AS Total_Freight_Over_50,
    MIN(Freight) AS Least_Purchase
FROM 
    TSQL2012.Sales.Orders
GROUP BY 
    CustomerID;


--24. Write a query that calculates the total sales and counts unique products sold in 
-- each month of each year, and then filter the months with at least 2 products sold.
Select * from Orders 
Select
    Year(OrderDate) as SalesYear,
    Month(OrderDate) as SalesMonth,
    Sum(TotalAmount) as TotalSales,
    Count(Distinct ProductID) as UniqueProductsSold
from
    Orders
group by 
    Year(OrderDate),
    Month(OrderDate)
Having 
    Count(Distinct ProductID) >= 2;

-- 25. Write a query to find the MIN and MAX order quantity per Year. From orders table.
Select * from Orders
Select Year(OrderDate) as SalesYear,
       Max(	Quantity) as MaxOrderQuantity,
	   Min(Quantity) as MinOrderQuantity
from Orders
group by Year(OrderDate);
