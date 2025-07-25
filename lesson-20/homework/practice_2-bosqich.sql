--Lesson 20
--1.  
Select s1.SaleId, Count(s1.Quantity) as PurchasedItem from #Sales s1
where Exists (Select s2.SaleID from #Sales s2
where  s2.SaleID = s1.SaleID
and Year(s2.SaleDate) = 2024 and Month(s2.SaleDate) = 3) 
Group by s1.SaleId
Having Count(Quantity) >= 1;

--2. Find the product with the highest total sales revenue using a subquery.
with product_totals as (
    select product, sum(quantity * price) as total
    from #sales
    group by product
)
select product, total
from product_totals
where total = (select max(total) from product_totals);


--3. Find the second highest sale amount using a subquery
select total, saleid
from (
    select saleid,
           quantity * price as total,
           dense_rank() over (order by quantity * price desc) as rnk
    from #sales
) as ranked_sales
where rnk = 2;

--4. Find the total quantity of products sold per month using a subquery
select year, month, total_quantity
from (
    select 
        year(saledate) as year,
        month(saledate) as month,
        sum(quantity) as total_quantity
    from #sales
    group by year(saledate), month(saledate)
) as monthly_sales;

--5. Find customers who bought same products as another customer using EXISTS
select distinct s1.customername
from #sales s1
where exists (
    select 1
    from #sales s2
    where s1.product = s2.product
      and s1.customername <> s2.customername
);

--6. 
select *
from (
    select 
        name,
        sum(case when fruit = 'Apple' then 1 else 0 end) as apple,
        sum(case when fruit = 'Orange' then 1 else 0 end) as orange,
        sum(case when fruit = 'Banana' then 1 else 0 end) as banana
    from fruits
    group by name
) as pivot_result;

--7. Return older people in the family with younger ones
with ancestry as (
    -- base case: direct parent-child pairs
    select parentid as pid, childid as chid
    from family

    union all

    -- recursive case: extend the chain
    select a.pid, f.childid
    from ancestry a
    join family f
        on a.chid = f.parentid
)
select *
from ancestry
order by pid, chid;

--8. Write an SQL statement given the following requirements. For every customer that had a delivery
-- to California, provide a result set of the customer orders that were delivered to Texas
select *
from #orders o
where o.deliverystate = 'TX'
  and exists (
      select 1
      from #orders o2
      where o2.customerid = o.customerid
        and o2.deliverystate = 'CA'
  );

--9. Insert the names of residents if they are missing
update #residents
set address = concat(address, ' name=', fullname)
where address not like '%name=%';

--10. Write a query to return the route to reach from Tashkent to Khorezm. The result should 
-- include the cheapest and the most expensive routes
with route_cte as (
    -- Base case: Routes that start from Tashkent
    select 
        cast(routeid as varchar(max)) as route_ids,
        departurecity,
        arrivalcity,
        cast(cost as money) as total_cost,
        cast(departurecity + ' -> ' + arrivalcity as varchar(max)) as full_path
    from #routes
    where departurecity = 'Tashkent'

    union all

    -- Recursive case: extend the path
    select 
        r.route_ids + ',' + cast(n.routeid as varchar),
        r.departurecity,
        n.arrivalcity,
        r.total_cost + n.cost,
        r.full_path + ' -> ' + n.arrivalcity
    from route_cte r
    join #routes n on r.arrivalcity = n.departurecity
    where n.arrivalcity != r.departurecity  -- prevent looping
)

select *
from (
    select *,
        rank() over (order by total_cost asc) as min_rank,
        rank() over (order by total_cost desc) as max_rank
    from route_cte
    where arrivalcity = 'Khorezm'
) ranked
where min_rank = 1 or max_rank = 1;

-- 11. Rank products based on their order of insertion
with productranks as (
    select *,
        sum(case when vals = 'Product' then 1 else 0 end) 
        over (order by id rows unbounded preceding) as productrank
    from #rankingpuzzle
)
select id, vals, productrank
from productranks
order by id;

-- 12. Find employees whose sales were higher than the average sales in their department
with deptavg as (
    select 
        department,
        avg(salesamount) as avgdeptsales
    from #employeesales
    group by department
)
select 
    e.employeeid,
    e.employeename,
    e.department,
    e.salesamount,
    e.salesmonth,
    e.salesyear
from #employeesales e
join deptavg d on e.department = d.department
where e.salesamount > d.avgdeptsales
order by e.department, e.salesamount desc;

--13. Find employees who had the highest sales in any given month using EXISTS
select e1.employeeid,
       e1.employeename,
       e1.department,
       e1.salesamount,
       e1.salesmonth,
       e1.salesyear
from #employeesales e1
where not exists (
    select 1
    from #employeesales e2
    where e2.salesmonth = e1.salesmonth
      and e2.salesyear = e1.salesyear
      and e2.salesamount > e1.salesamount
)
order by e1.salesyear, e1.salesmonth, e1.department;

--14. Find employees who made sales in every month using NOT EXISTS
select distinct e.employeeid, e.employeename
from #employeesales e
where not exists (
    select 1
    from (select distinct salesmonth from #employeesales) m
    where not exists (
        select 1
        from #employeesales es
        where es.employeeid = e.employeeid 
          and es.salesmonth = m.salesmonth
    )
);

--15. Retrieve the names of products that are more expensive than the average price of all products.
select name, price
from products
where price > (
    select avg(price)
    from products
);

--16. Find the products that have a stock count lower than the highest stock count.
select name, stock
from products
where stock < (
    select max(stock)
    from products
);

--17. Get the names of products that belong to the same category as 'Laptop'.
select name
from products
where category = (
    select category
    from products
    where name = 'Laptop'
);

--18. Retrieve products whose price is greater than the lowest price in the Electronics category.
select *
from products
where price > (
    select min(price)
    from products
    where category = 'Electronics'
);

--19. Find the products that have a higher price than the average price of their respective category.
select p.*
from products p
join (
    select category, avg(price) as avg_price
    from products
    group by category
) cat_avg
on p.category = cat_avg.category
where p.price > cat_avg.avg_price;

--20. Find the products that have been ordered at least once.
select distinct p.*
from products p
join orders o on p.productid = o.productid;

--21. Retrieve the names of products that have been ordered more than the average quantity ordered.
select p.name
from products p
join orders o on p.productid = o.productid
group by p.name
having sum(o.quantity) > (
    select avg(quantity) from orders
);

--22. Find the products that have never been ordered.
select name
from products
where productid not in (
    select distinct productid from orders
);

--23. Retrieve the product with the highest total quantity ordered.
select top 1 p.name, sum(o.quantity) as total_quantity
from orders o
join products p on o.productid = p.productid
group by p.name
order by total_quantity desc;















