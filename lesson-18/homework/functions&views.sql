--lesson - 18 
--1.Create a temporary table named MonthlySales to store the total quantity sold and 
-- total revenue for each product in the current month.
With MonthlySales as
(Select s.ProductID,
 Sum(s.Quantity) as TotalQuantity,
 Sum(s.Quantity * p.price) as TotalRevenue 
 from Sales s
 Join Products p on s.ProductID = p.ProductID
 where datediff(Month, s.SaleDate, GetDate()) = 0
 Group by s.ProductID)
 Select * from MonthlySales;

 --2. Create a view named vw_ProductSalesSummary that returns product info along with total sales quantity across all time.
 create view vw_productSalesSummary as
select 
    p.productid,
    p.productname,
	p.Category,
    sum(s.quantity) as TotalQuantitySold
from sales s
join products p on s.productid = p.productid
group by p.productid, p.productname, p.Category;

select * from vw_ProductSalesSummary;

--3. Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)
--  Return: total revenue for the given product ID
Create Function fn_GetTotalRevenueForProduct(@productId int)
Returns decimal(18,2)
As
Begin
    Declare @totalRevenue decimal(18,2);

    Select @totalRevenue = Sum(s.quantity * p.price)
    From sales s
    Join products p on s.productId = p.productId
    Where s.productId = @productId;

    Return @totalRevenue;
End;

Select dbo.fn_GetTotalRevenueForProduct(1) as totalRevenue;

--4. Create an function fn_GetSalesByCategory(@Category VARCHAR(50))
--   Return: ProductName, TotalQuantity, TotalRevenue for all products in that category.
Create Function fn_GetSalesByCategory (@Category varchar(50))
Returns table
As
Return
(
    Select 
        p.ProductName,
        Sum(s.Quantity) as TotalQuantity,
        Sum(s.Quantity * p.Price) as TotalRevenue
    From Products p
    Join Sales s on p.ProductID = s.ProductID
    Where p.Category = @Category
    Group by p.ProductName
);

Select * from fn_GetSalesByCategory('Toys');


--Create function fn_GetSalesByCategory(@Category VARCHAR(50))
--Returns @result table (
--       ProductName varchar(100), 
--       TotalQuantity int,
--	   TotalRevenue decimal(18,2))
--as 
--Begin 
--      insert into @result 
--	  Select p.ProductName, 
--       Sum(s.Quantity) as TotalQuantity,
--	   Sum(s.Quantity * p.Price) as TotalRevenue
--	From products p 
--	Join Sales s on p.ProductID = s.ProductID
--	where p.Category = @Category
--	Group by p.ProductName;

--	Return
--end;

--5. You have to create a function that get one argument as input from user and the function 
-- should return 'Yes' if the input number is a prime number and 'No' otherwise. You can start it 
-- like this:
Create Function fn_IsPrime (@Number int)
Returns varchar(3)
As
Begin
    Declare @i int = 2
    Declare @IsPrime bit = 1
    Declare @Result varchar(3)

    If @Number < 2
    Begin
        Set @Result = 'No'
        Return @Result
    End

    While @i <= Sqrt(@Number)
    Begin
        If @Number % @i = 0
        Begin
            Set @IsPrime = 0
            Break
        End
        Set @i = @i + 1
    End

    If @IsPrime = 1
        Set @Result = 'Yes'
    Else
        Set @Result = 'No'

    Return @Result
End;

Select dbo.fn_IsPrime(7) as IsPrime   -- Returns 'Yes'
Select dbo.fn_IsPrime(10) as IsPrime  -- Returns 'No'

--6. Create a table-valued function named fn_GetNumbersBetween that accepts two integers as input:
-- The function should return a table with a single column:
--@Start INT
--@End INT
--It should include all integer values from @Start to @End, inclusive.
Create Function fn_GetNumbersBetween (@Start int, @End int)
Returns @Result table (
    Number int
)
As
Begin
    Declare @i int

    If @Start <= @End
    Begin
        Set @i = @Start
        While @i <= @End
        Begin
            Insert into @Result (Number)
            Values (@i)
            Set @i = @i + 1
        End
    End
    Else
    Begin
        Set @i = @Start
        While @i >= @End
        Begin
            Insert into @Result (Number)
            Values (@i)
            Set @i = @i - 1
        End
    End

    Return
End;

-- Code for check:
-- Case 1: Normal order
Select * from fn_GetNumbersBetween(3, 7);
-- Output: 3, 4, 5, 6, 7

-- Case 2: Reverse order
Select * from fn_GetNumbersBetween(7, 3);
-- Output: 7, 6, 5, 4, 3

-- Case 3: Same number
Select * from fn_GetNumbersBetween(5, 5);
-- Output: 5

--7. Write a SQL query to return the Nth highest distinct salary from the Employee table. If there
-- are fewer than N distinct salaries, return NULL.
Create Function getNthHighestSalary (@N int)
Returns table
As
Return
(
    Select 
        Max(Salary) as HighestNSalary
    From
    (
        Select Distinct Salary
        From Employee
        Order by Salary desc
        Offset (@N - 1) rows
        Fetch next 1 row only
    ) as T
);

-- code for check 
Select * from getNthHighestSalary(2);

--8. Write a SQL query to find the person who has the most friends.
Select top 1
    user_id,
    Count(*) as total_friends
From
(
    Select requester_id as user_id
    From RequestAccepted
    Union all
    Select accepter_id as user_id
    From RequestAccepted
) as AllFriends
Group by user_id
Order by total_friends desc;

--9. Create a View for Customer Order Summary.
Create view vw_CustomerOrderSummary 
as 
Select c.customer_id, c.name, Sum(o.order_id) as total_orders, sum(o.amount) as TotalAmounmt, 
Max(o.order_date) as last_order_date
from customers c Join orders o on o.Customer_id = c.customer_id
Group by c.customer_id, c.name

--code to check the view:
Select * from vw_CustomerOrderSummary 

--10. Write an SQL statement to fill in the missing gaps. You have to write only select statement, 
-- no need to modify the table.
Select 
    RowNumber,
    Max(TestCase) Over (
        Order By RowNumber
        Rows Between Unbounded Preceding And Current Row
    ) As Workflow
From Gaps
Order By RowNumber;






