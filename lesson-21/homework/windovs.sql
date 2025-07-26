--Lesson-21
--1. Write a query to assign a row number to each sale based on the SaleDate.
Select *, Row_Number() over(order by SaleDate ) as RowNumber
from ProductSales;

--2. Write a query to rank products based on the total quantity sold. give the same rank for the 
--same amounts without skipping numbers.
Select * from  ProductSales
Select ProductName, Sum(Quantity) as TotalQuantity,  Dense_Rank() over( Order by sum(Quantity) desc) as RankedTotalQuantity
from ProductSales
Group by ProductName;

--3. Write a query to identify the top sale for each customer based on the SaleAmount.
Select *, Row_Number() over(partition by CustomerID order by SaleAmount desc) as TopSaleOfCustomers
from ProductSales 

--4. Write a query to display each sale's amount along with the next sale amount in the order of 
--SaleDate.
select 
    saleid,
    saledate,
    saleamount,
    lead(saleamount) over (order by saledate) as nextsaleamount
from 
    ProductSales;

--5. Write a query to display each sale's amount along with the previous sale amount in the order
--of SaleDate.
Select * from ProductSales 
Select ProductName, SaleDate, Quantity, CustomerID, SaleAmount,  Lag(SaleAmount) over(order by SaleDate) as PreviousSaleAmount
from ProductSales;

--6. Write a query to identify sales amounts that are greater than the previous sale's amount
with sales_with_prev as (
    select 
        saleid,
        saleamount,
        lag(saleamount) over (order by saleid) as previoussaleamount
    from productsales
)
select 
    saleid,
    saleamount,
    previoussaleamount
from 
    sales_with_prev
where 
    saleamount > previoussaleamount;

--7. Write a query to calculate the difference in sale amount from the previous sale for every product
select 
    ProductName,
    saleid,
    saledate,
    saleamount,
    saleamount - lag(saleamount) over (partition by ProductName order by saledate) as amount_difference
from 
    productsales;

--8. Write a query to compare the current sale amount with the next sale amount in terms of percentage change.
select 
    saleid,
    saledate,
    saleamount,
    lead(saleamount) over (order by saledate) as next_saleamount,
    round(
        ((lead(saleamount) over (order by saledate) - saleamount) / saleamount) * 100, 2
    ) as percent_change
from 
    productsales;

--9. Write a query to calculate the ratio of the current sale amount to the previous sale amount within the 
-- same product.
select 
    productName,
    saleid,
    saledate,
    saleamount,
    lag(saleamount) over (partition by productName order by saledate) as previous_saleamount,
    round(
        cast(saleamount as decimal) / nullif(lag(saleamount) over (partition by productName order by saledate), 0), 2
    ) as sale_ratio
from 
    productsales;

--10 Write a query to calculate the difference in sale amount from the very first sale of that product.
select 
    productName,
    saleid,
    saledate,
    saleamount,
    first_value(saleamount) over (partition by productName order by saledate) as first_saleamount,
    saleamount - first_value(saleamount) over (partition by productName order by saledate) as amount_difference
from 
    productsales;

--11. Write a query to find sales that have been increasing continuously for a product 
-- (i.e., each sale amount is greater than the previous sale amount for that product).
with sales_with_lag as (
    select 
        productname,
        saleid,
        saledate,
        saleamount,
        lag(saleamount) over (partition by productname order by saledate) as previous_saleamount
    from 
        productsales
)
select 
    productname,
    saleid,
    saledate,
    saleamount,
    previous_saleamount
from 
    sales_with_lag
where 
    saleamount > previous_saleamount;

--12. Write a query to calculate a "closing balance"(running total) for sales amounts which adds the current 
-- sale amount to a running total of previous sales.
select 
    saleid,
    saledate,
    saleamount,
    sum(saleamount) over (order by saledate rows between unbounded preceding and current row) as closing_balance
from 
    productsales;

--13. Write a query to calculate the moving average of sales amounts over the last 3 sales.
select 
    saleid,
    saledate,
    saleamount,
    avg(saleamount) over (
        order by saledate
        rows between 2 preceding and current row
    ) as moving_avg_3_sales
from 
    productsales;

--14. Write a query to show the difference between each sale amount and the average sale amount.
select 
    saleid,
    saledate,
    saleamount,
    avg(saleamount) over () as average_saleamount,
    saleamount - avg(saleamount) over () as difference_from_average
from 
    productsales;

--15. Find Employees Who Have the Same Salary Rank
select *
from (
    select *, dense_rank() over (order by salary desc) as s_rnk
    from employees1
) e
where s_rnk in (
    select s_rnk
    from (
        select dense_rank() over (order by salary desc) as s_rnk
        from employees1
    ) t
    group by s_rnk
    having count(*) > 1
)
order by s_rnk, employeeid;

--16. Identify the Top 2 Highest Salaries in Each Department
With cte as
(Select *, Dense_Rank() over(Partition by Department order by Salary desc ) as HighestSalariesRank from Employees1) 
Select * from cte
where cte.HighestSalariesRank <= 2
Order by Department, Salary desc;

--17. Find the Lowest-Paid Employee in Each Department
With cte as
(Select *, Dense_Rank() over(Partition by Department order by Salary asc ) as SalaryRank from Employees1) 
Select * from cte
where cte.SalaryRank = 1
Order by Department, Salary asc;

--18. Calculate the Running Total of Salaries in Each Department
select 
    employeeid,
    name,
    department,
    salary,
    sum(salary) over (
        partition by department 
        order by salary 
        rows between unbounded preceding and current row
    ) as running_total_salary
from 
    employees1
order by 
    department, salary;

--19. Find the Total Salary of Each Department Without GROUP BY
Select Department, Sum(Salary) over(Partition by Department) as Total from Employees1;

--20. Calculate the Average Salary in Each Department Without GROUP BY
Select Department, Avg(Salary) over(Partition by Department) as AvgSalary from Employees1;

--21. Find the Difference Between an Employee’s Salary and Their Department’s Average
select 
    employeeid,
    name,
    department,
    salary,
    avg(salary) over (partition by department) as avg_department_salary,
    salary - avg(salary) over (partition by department) as salary_difference
from 
    employees1;

--22. Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)
select 
    employeeid,
    name,
    department,
    salary,
    avg(salary) over (
        order by employeeid
        rows between 1 preceding and 1 following
    ) as moving_avg_salary_3
from 
    employees1
order by 
    employeeid;

--23. Find the Sum of Salaries for the Last 3 Hired Employees
with ranked as (
    select *,
           row_number() over (order by hiredate desc) as rn
    from employees1
)
select sum(salary) as total_salary_last_3_hired
from ranked
where rn <= 3;













