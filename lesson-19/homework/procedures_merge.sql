--Lessson - 19 
--1. Task 1:
Create procedure TotalEmployeeBonus
@EmployeeID int
As 
Begin
CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(100),
        Department NVARCHAR(50),
        Salary DECIMAL(10,2),
        BonusAmount DECIMAL(10,2)
    );
INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
Select 
EmployeeID, FirstName+ ' ' +LastName as FullName, e.Department, Salary, e.Salary * db.BonusPercentage / 100 as BonusAmount
from DepartmentBonus db 
Join Employees e on db.Department = e.Department
where e.EmployeeID = @EmployeeID

SELECT * FROM #EmployeeBonus;
End;

EXEC TotalEmployeeBonus @EmployeeID = 1;

--2. 
create procedure updatedepartmentsalary
    @deptname nvarchar(50),
    @increasepercent decimal(5,2)
as
begin
    set nocount on;

    -- step 1: update salaries
    update employees
    set salary = salary + (salary * @increasepercent / 100)
    where department = @deptname;

    -- step 2: return updated employees
    select 
        employeeid,
        firstname,
        lastname,
        department,
        salary
    from employees
    where department = @deptname;
end;

exec updatedepartmentsalary @deptname = 'sales', @increasepercent = 10;

--3. 
merge into products_current as target
using products_new as source
on target.productid = source.productid

when matched then
    update set 
        target.productname = source.productname,
        target.price = source.price

when not matched by target then
    insert (productid, productname, price)
    values (source.productid, source.productname, source.price)

when not matched by source then
    delete;

select * from products_current;

--4. 
select 
    t1.id,
    case 
        when t1.p_id is null then 'Root'
        when t1.id not in (select distinct p_id from tree where p_id is not null) then 'Leaf'
        else 'Inner'
    end as type
from tree t1
order by t1.id;

--5. 
select 
    s.user_id,
    cast(
        count(case when c.action = 'confirmed' then 1 end) * 1.0 
        / nullif(count(c.action), 0)
        as decimal(5,2)
    ) as confirmation_rate
from signups s
left join confirmations c 
    on s.user_id = c.user_id
group by s.user_id
order by s.user_id;

--6.  
Select e.id, e.name, e.Salary
from Employees e
where e.Salary = (Select min(Salary) from employees)

--7. 
create procedure GetProductSalesSummary
@ProductID int
as
begin
    select 
        p.ProductName, 
        coalesce(sum(s.Quantity), 0) as TotalQuantitySold, 
        coalesce(sum(s.Quantity * p.Price), 0) as TotalSalesAmount,
        min(s.SaleDate) as FirstSaleDate, 
        max(s.SaleDate) as LastSaleDate
    from Products p
    left join Sales s on p.ProductID = s.ProductID
    where p.ProductID = @ProductID
    group by p.ProductName
end;

exec GetProductSalesSummary @Productid = 18;
exec GetProductSalesSummary @Productid = 4;




