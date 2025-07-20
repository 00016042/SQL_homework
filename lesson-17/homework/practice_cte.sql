Create database lessson17
go  
use lessson17

--1. You must provide a report of all distributors and their sales by region. If a distributor did not have any sales for a region, rovide a zero-dollar value
--for that day. Assume there is at least one sale for each region
Select r.Region,d.Distributor, IsNull(Sum(rs.Sales), 0) as Sales
from (Select distinct Region from #RegionSales) as r
Cross Join(Select distinct Distributor from #RegionSales) as d
Left Join #RegionSales rs on rs.Region = r.Region and rs.Distributor = d.Distributor
Group by r.region, d.Distributor
Order by case d.Distributor 
         when 'ACE' then 1
         when 'Direct Parts' then 2
		 when 'ACME' then 3
         else 4
		 end, 
         case r.Region
        when 'North' then 1
        when 'South' then 2
        when 'East' then 3
        when 'West' then 4
        else 5
    end;

--2. Find managers with at least five direct reports
Select e2.name, Count(e1.Id) DirectReports 
from employee e1
Join Employee e2 on e2.Id = e1.managerId
Group by e2.name 
Having Count(e1.Id) >= 5 

--3. Write a solution to get the names of products that have at least 100 units ordered 
-- in February 2020 and their amount. 
Select p.product_name, orders.totalUnit
from (Select product_id, Sum(unit) as TotalUnit from Orders where order_date >= '2020-02-01' and order_date < '2020-03-01'
Group by product_id) Orders
Join Products p on p.product_id = orders.product_id
where orders.totalunit >= 100;

--4.Write an SQL statement that returns the vendor from which each customer has placed 
--the most orders
with customer_vendor_totals as (
    select 
        customerid,
        vendor,
        sum(count) as total_count
    from orders
    group by customerid, vendor
),
ranked_vendors as (
    select 
        *,
        rank() over (partition by customerid order by total_count desc) as rnk
    from customer_vendor_totals
)
select 
    customerid,
    vendor,
    total_count
from ranked_vendors
where rnk = 1;

--5. You will be given a number as a variable called @Check_Prime check if this number 
--is prime then return 'This number is prime' else eturn 'This number is not prime'
declare @Check_prime int = 7
declare @starting int = 2
Declare @isprime varchar(50) = 'This is a prime number'

while @starting*@starting < @Check_prime + 1
begin
   if @Check_prime % @starting = 0
   begin
    set @isprime = 'This is not a prime number'
    break
   end
   else
   set @starting = @starting + 1 --assigning a value to variable
end;
Select
  case when @Check_prime <= 1 then 'This is not a prime number'
  when @Check_prime = 2 then 'This is a prime number'
  else @isprime
  end

--6. Write an SQL query to return the number of locations,in which location most signals 
-- sent, and total number of signal for each device from the given table.
-- 1. total number of distinct locations
select count(distinct locations) as total_locations from device;

-- 2. location with the most signals sent
with location_counts as (
    select locations, count(*) as total_signals
    from device
    group by locations
)
select locations, total_signals
from location_counts
where total_signals = (
    select max(total_signals) from location_counts
);

-- 3. total number of signals for each device
select device_id, count(*) as total_signals
from device
group by device_id;

--7. Write a SQL to find all Employees who earn more than the average salary in their
-- corresponding department. Return EmpID, EmpName,Salary in your output
Select e.EmpID, e.EmpName,e.Salary, AvgSal.AverageSalByDept
From (Select DeptID, Avg(Salary) as AverageSalByDept from employee group by DeptID) as AvgSal 
Join Employee e on e.DeptID = AvgSal.DeptID
where e.Salary > AvgSal.AverageSalByDept;

--8. you are part of an office lottery pool where you keep a table of the winning lottery 
-- numbers along with a table of each ticket’s chosen numbers. If a ticket has some but 
-- not all the winning numbers, you win $10. If a ticket has all the winning numbers,
-- you win $100. Calculate the total winnings for today’s drawing.
with cte as 
(Select case when Count(*) = 3 then 100 else 10 end as Prize 
from Tickets t Join Numbers n on t.number=n.number
group by TicketId)
 select Sum(Prize) from cte;

 --9. The Spending table keeps the logs of the spendings history of users that make 
 -- purchases from an online shopping website which has a desktop and a mobile devices.
 -- Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both mobile and desktop together for 
 -- each date.
with user_platforms as (
    select 
        spend_date,
        user_id,
        max(case when platform = 'mobile' then 1 else 0 end) as used_mobile,
        max(case when platform = 'desktop' then 1 else 0 end) as used_desktop,
        sum(amount) as total_spent
    from spending
    group by spend_date, user_id
),
categorized as (
    select 
        spend_date,
        case 
            when used_mobile = 1 and used_desktop = 0 then 'mobile_only'
            when used_mobile = 0 and used_desktop = 1 then 'desktop_only'
            when used_mobile = 1 and used_desktop = 1 then 'both'
        end as usage_type,
        total_spent
    from user_platforms
)
select 
    spend_date,
    sum(case when usage_type = 'mobile_only' then 1 else 0 end) as mobile_only_users,
    sum(case when usage_type = 'mobile_only' then total_spent else 0 end) as mobile_only_amount,
    
    sum(case when usage_type = 'desktop_only' then 1 else 0 end) as desktop_only_users,
    sum(case when usage_type = 'desktop_only' then total_spent else 0 end) as desktop_only_amount,
    
    sum(case when usage_type = 'both' then 1 else 0 end) as both_users,
    sum(case when usage_type = 'both' then total_spent else 0 end) as both_amount
from categorized
group by spend_date
order by spend_date;

--10. Write an SQL Statement to de-group the following data.
with numbers as (
    select 1 as n
    union all select 2
    union all select 3
    union all select 4
    union all select 5
    union all select 6
    union all select 7
    union all select 8
    union all select 9
    union all select 10
),
product_data as (
    select 'Pencil' as product, 3 as quantity, 1 as sort_order
    union all
    select 'Eraser', 4, 2
    union all
    select 'Notebook', 2, 3
)
select 
    p.product,
    1 as quantity
from product_data p
join numbers n
    on n.n <= p.quantity
order by p.sort_order, p.product;








