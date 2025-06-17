--Lesson 8 - Practise
--Notes before doing the tasks:

--Tasks should be solved using SQL Server.
--Case insensitivity applies.
--Alias names do not affect the score.
--Scoring is based on the correct output.
--One correct solution is sufficient.

--1. Using Products table, find the total number of products available in each category.
Select Category, Count(*) 
from Products
Group by Category

--2. Using Products table, get the average price of products in the 'Electronics' category.
Select Avg(Price)
from Products
Where Category = 'Electronics'

--3. Using Customers table, list all customers from cities that start with 'L'.
Select * from Customers
where City LIKE 'L%'

--4. Using Products table, get all product names that end with 'er'.
Select * from Products 
Where ProductName LIKE '%er'

--5. Using Customers table, list all customers from countries ending in 'A'.
Select * from Customers 
Where Country LIKE '%A'

--6. Using Products table, show the highest price among all products.
Select Max(Price) 
from Products

--7. Using Products table, label stock as 'Low Stock' if quantity < 30, else 'Sufficient'.
Select ProductName,StockQuantity, Case when StockQuantity < 30 then 'Low Stock' 
else 'Sufficient' 
end as StockStatus
from Products;

--8. Using Customers table, find the total number of customers in each country.
Select Country, COUNT(*) as	TotalCustomers 
from Customers
Group by Country;

--9. Using Orders table, find the minimum and maximum quantity ordered.
Select MAX(Quantity) as MaxQuantityOrdered, MIN(Quantity) as MinQuantityOrderd 
from Orders;

--10. Using Orders and Invoices tables, list customer IDs who placed orders in 2023
-- January to find those who did not have invoices.
Select distinct o.CustomerID
from Orders o
   join Invoices i
  on o.CustomerID = i.CustomerID
  and i.InvoiceDate >= '2023-01-01' and i.InvoiceDate < '2023-02-01'
where o.OrderDate >= '2023-01-01' and o.OrderDate < '2023-02-01'
  and i.CustomerID is null;

--11. Using Products and Products_Discounted table, Combine all product names from 
--Products and Products_Discounted including duplicates.
Select ProductName from Products
Union All
Select ProductName from Products_Discounted

--12. Using Products and Products_Discounted table, Combine all product names from 
--Products and Products_Discounted without duplicates.
Select ProductName from Products
Union 
Select ProductName from Products_Discounted

--13. Using Orders table, find the average order amount by year.
Select Year(OrderDate) as Year, AVG(TotalAmount) as AverageOrderAmount
from Orders
Group by Year(OrderDate);

--14. Using Products table, group products based on price: 'Low' (<100), 'Mid' (100-500)
--, 'High' (>500). Return productname and pricegroup.
Select ProductName, 
    Case 
	    When Price < 100 then 'Low'
		When Price between 100 and 500 then 'Mid'
		else 'High'
	end as PriceGroup
from Products;

--15. Using City_Population table, use Pivot to show values of Year column in seperate 
-- columns ([2012], [2013]) and copy results to a new Population_Each_Year table.
Select district_id, district_name, [2012], [2013]
into Population_Each_Year 
from  (Select district_id, district_name, Year, population from City_Population) as SourceTable
pivot ( sum(population) for Year in ([2012], [2013])) as PivotTable;

--16. Using Sales table, find total sales per product Id.
Select ProductID, Sum(SaleAmount) as TotalSalePerProduct 
from Sales 
Group by ProductID;

--17. Using Products table, use wildcard to find products that contain 'oo' in 
-- the name. Return productname.
Select ProductName
from Products 
where ProductName Like '%oo%';

--18. Using City_Population table, use Pivot to show values of City column in 
-- seperate columns (Bektemir, Chilonzor, Yakkasaroy) and copy results to a 
--new Population_Each_City table.
Select district_id,Year, Bektemir, Chilonzor, Yakkasaroy
into  Population_Each_City
From (Select district_id, district_name, Year, population from City_Population) as SourceTable
pivot(sum(Population) for district_name in (Bektemir, Chilonzor, Yakkasaroy)) as PivotTable;
--19. Using Invoices table, show top 3 customers with the highest total invoice
-- amount. Return CustomerID and Totalspent.
Select top 3 CustomerID, Sum(TotalAmount) as TotalSpent
from Invoices
Group by CustomerID
Order by TotalSpent desc;

--20. Transform Population_Each_Year table to its original format 
-- (City_Population).
select district_id, district_name, [Year], population
from Population_Each_Year
unpivot (
    population for [Year] in ([2012], [2013])
) as UnpivotedTable;

--21. Using Products and Sales tables, list product names and the number
-- of times each has been sold. (Research for Joins)
Select p.ProductName, Count(s.SaleID) as ProductSaleTimes
from Products p
join Sales s On p.ProductID=s.ProductID
Group by p.ProductName;

--22. Transform Population_Each_City table to its original format (City_Population).
Select district_id, [district_name], population, Year 
from Population_Each_City
unpivot(population for [district_name] in (Bektemir, Chilonzor, Yakkasaroy)) as UnpivotedTable;








