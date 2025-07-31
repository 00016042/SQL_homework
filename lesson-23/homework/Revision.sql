Create database Lesson23
use lesson23

--Lesson-23
--1. In this puzzle you have to extract the month from the dt column and then append zero single digit month if any.
-- Please check out sample input and expected output.
select 
    id,
    dt,
    format(dt, 'mm') as monthprefixedwithzero
from dates;

--2.  In this puzzle you have to find out the unique Ids present in the table. You also have to find out the SUM of Max 
 -- values of vals columns for each Id and RId. For more details please see the sample input and expected output.
 select 
    count(distinct id) as distinct_ids,
    rid,
    sum(max_vals) as totalofmaxvals
from (
    select 
        id,
        rid,
        max(vals) as max_vals
    from mytabel
    group by id, rid
) as sub
group by rid;

--3.  In this puzzle you have to get records with at least 6 characters and maximum 10 characters. 
--    Please see the sample input and expected output.
select 
    id,
    vals
from testfixlengths
where len(vals) between 6 and 10;

--4. In this puzzle you have to find the maximum value for each Id and then get the Item for that Id and Maximum value. 
-- Please check out sample input and expected output. 
select 
    t.id,
    t.item,
    t.vals
from testmaximum t
join (
    select 
        id,
        max(vals) as max_val
    from testmaximum
    group by id
) m on t.id = m.id and t.vals = m.max_val;

--5. In this puzzle you have to first find the maximum value for each Id and DetailedNumber, and then Sum the data 
 -- using Id only. Please check out sample input and expected output.
 select 
    id,
    sum(max_vals) as sumofmax
from (
    select 
        id,
        detailednumber,
        max(vals) as max_vals
    from sumofmax
    group by id, detailednumber
) as sub
group by id;

--6. In this puzzle you have to find difference between a and b column between each row and if the difference is not equal 
-- to 0 then show the difference i.e. a – b otherwise 0. Now you need to replace this zero with blank.Please check the 
-- sample input and the expected output.
select 
    id,
    a,
    b,
    case 
        when a - b = 0 then ''
        else cast(a - b as varchar)
    end as output
from thezeropuzzle;

--7. What is the total revenue generated from all sales?
Select Sum( UnitPrice * QuantitySold) as TotalRevenue 
from Sales;
--8. What is the average unit price of products?
Select Avg(UnitPrice) as AvgPrice 
from Sales; 

--9. How many sales transactions were recorded?
Select Count(SaleId) as NumOfSalesTransactions 
from Sales;

--10. What is the highest number of units sold in a single transaction?
Select Max(QuantitySold) as HighestSoldInOneTransaction 
from Sales;

-- 11. How many products were sold in each category?
 Select Category,
 Sum(QuantitySold) as ProductsSoldInEachCategory 
 from Sales
 Group by Category;

--12. What is the total revenue for each region?
Select Region, Sum(QuantitySold * UnitPrice) as TotalRevenue
from Sales 
group by Region;

--13. Which product generated the highest total revenue?
Select Top 1 Product, Sum(QuantitySold * UnitPrice) as HighTotalRevenue 
from Sales 
Group by Product
order by Max(QuantitySold * UnitPrice) desc;

--14. Compute the running total of revenue ordered by sale date.
select 
    saleid,
    saledate,
    product,
    quantitysold,
    unitprice,
    quantitysold * unitprice as revenue,
    sum(quantitysold * unitprice) over (order by saledate) as running_total
from sales
order by saledate;

--15. How much does each category contribute to total sales revenue?
select 
    category,
    sum(quantitysold * unitprice) as category_revenue,
    round(
        100.0 * sum(quantitysold * unitprice) / 
        (select sum(quantitysold * unitprice) from sales), 2
    ) as percent_of_total
from sales
group by category;

--17. Show all sales along with the corresponding customer names.
Select c.CustomerName, s.* 
from Customers c
Join Sales s on c.CustomerId = s.CustomerId;

--18. List customers who have not made any purchases
Select c.CustomerId, c.CustomerName
From Customers c 
Left Join Sales s on c.CustomerId = s.CustomerId
where s.SaleId is null;

--19. Compute total revenue generated from each customer
select 
    customerid,
    sum(quantitysold * unitprice) as total_revenue
from sales
group by customerid
order by total_revenue desc;

--20. Find the customer who has contributed the most revenue
Select top 1 CustomerId, sum(QuantitySold * UnitPrice) as MostRevenueContributed 
from Sales 
Group by CustomerId
Order by sum(QuantitySold * UnitPrice) Desc;

--21. Calculate the total sales per customer
Select CustomerId, Count(SaleID) as TotalBought 
from Sales 
Group by CustomerId;

--22. List all products that have been sold at least once
Select p.* 
from  Products p 
Join Sales s on p.ProductName = s.Product
Where s.SaleID is not null;

--23. Find the most expensive product in the Products table
select top 1 *
from products
order by sellingprice desc;

--24. Find all products where the selling price is higher than the average selling price in their category
Select * 
from Products p
Where SellingPrice > (Select Avg(SellingPrice) from Products where Category = p.Category);





