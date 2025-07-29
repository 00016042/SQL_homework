Create database Lesson22
Use lesson22
--Lesson-22
--1. Compute Running Total Sales per Customer
Select *, Count(Sale_id) Over(Partition by customer_id) as TotalSales from Sales_data;
--2. Count the Number of Orders per Product Category
Select *, 
         Count(Sale_ID) over (Partition by Product_Category) as ProductNumber 
from Sales_Data;

--3. Find the Maximum Total Amount per Product Category
Select *, max(total_amount) over(Partition by Product_Category) as TotalSalesAmount from Sales_Data;

--4. Find the Minimum Price of Products per Product Category
Select *, Min(unit_price) over(Partition by product_category) as MinPriceOfEachCategory from Sales_data; 

--5. Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)
 Select *,
          Avg(Total_Amount) over(order by order_date Rows Between 1 Preceding and 1 following) as threedayMovingAvg 
 from Sales_data;

 --6. Find the Total Sales per Region
 Select *, Count(sale_id) over(partition by region) as TotalSalesPerRegion from Sales_data;

 --7. Compute the Rank of Customers Based on Their Total Purchase Amount
 Select customer_id, customer_name, 
                                   Sum(Total_amount) as TotalPurchase, 
								   Rank() over( order by Sum(Total_amount) desc) as TotalPurchaseRank
 from Sales_Data
 Group by customer_id, customer_name
 Order by TotalPurchaseRank; 

 --8. Calculate the Difference Between Current and Previous Sale Amount per Customer
 Select *, Lag(Total_Amount) over(Partition by Customer_id order by order_date) as PreviousSaleAmount, 
 Total_Amount - Lag(Total_Amount)  over(Partition by Customer_id order by order_date) as SaleAmountDifference 
 from Sales_data;

 --9. Find the Top 3 Most Expensive Products in Each Category
 With RankedProducts as
 (Select Product_name, Product_Category,  
 Max(Unit_Price) as MaxPrice, Dense_Rank() over(Partition by Product_Category order by Max(Unit_Price) desc ) as MostExpensiveProducts 
 from Sales_Data 
 Group by Product_name, Product_Category)
 Select * from RankedProducts
 where MostExpensiveProducts <= 3;

 --10. Compute the Cumulative Sum of Sales Per Region by Order Date
 Select region,
    order_date,
    total_amount, 
	Sum(Total_Amount) over(Partition by Region order by order_date) as CumulativeSumOfSales 
from Sales_Data
order by region, order_date;

--11. Compute Cumulative Revenue per Product Category
Select *, Sum(total_amount) over(Partition by product_category) as EachCategoryRevenue 
from Sales_data;

--12. Here you need to find out the sum of previous values. Please go through the sample input and expected output.
select 
  *, 
  sum(total_amount) over (
    partition by product_category 
    order by order_date 
    rows between unbounded preceding and current row
  ) as cumulative_revenue
from Sales_data;

--13. Sum of Previous Values to Current Value
Select value, Sum(Value) over(Order by value) as sum_of_previous from OneColumn;

--14. Find customers who have purchased items from more than one product_category
select 
  customer_id,
  customer_name,
  count(distinct product_category) as category_count
from sales_data
group by customer_id, customer_name
having count(distinct product_category) > 1;

--15. Find Customers with Above-Average Spending in Their Region
with regional_avg as (
  select 
    customer_id,
    customer_name,
    region,
    total_amount,
    avg(total_amount) over (partition by region) as regional_avg
  from sales_data
)
select 
  customer_id, 
  customer_name
from regional_avg
where total_amount > regional_avg;

--16. Rank customers based on their total spending (total_amount) within each region. If multiple customers have the same
-- spending, they should receive the same rank.
Select Customer_id,
Customer_name,
total_amount,
region, 
sum(total_amount) as total_amount,
Dense_Rank() over(Partition by region order by total_amount desc)   
as RankOfTotalSales from Sales_data
Group by Customer_id,Customer_name,total_amount,region;

--17.Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date.
select 
  customer_id, 
  customer_name, 
  order_date,
  total_amount,
  sum(total_amount) over (
    partition by customer_id 
    order by order_date
    rows between unbounded preceding and current row
  ) as cumulative_sales
from sales_data;

--18. Calculate the sales growth rate (growth_rate) for each month compared to the previous month.
with monthly_sales as (
  select 
    format(order_date, 'yyyy-MM') as sale_month,
    sum(total_amount) as monthly_total
  from sales_data
  group by format(order_date, 'yyyy-MM')
),
growth_calc as (
  select 
    sale_month,
    monthly_total,
    lag(monthly_total) over (order by sale_month) as previous_month_total
  from monthly_sales
)
select 
  sale_month,
  monthly_total,
  previous_month_total,
  round(
    case 
      when previous_month_total = 0 or previous_month_total is null then null
      else ((monthly_total - previous_month_total) / previous_month_total) * 100
    end, 2
  ) as growth_rate_percent
from growth_calc;

--19. Identify customers whose total_amount is higher than their last order''s total_amount.(Table sales_data)
with previous_vs_current as (
  select 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    lag(total_amount) over (
      partition by customer_id 
      order by order_date
    ) as previous_total_amount
  from sales_data
)
select *
from previous_vs_current
where total_amount > previous_total_amount;

--20. Identify Products that prices are above the average product price
Select Product_name, unit_price from Sales_data 
where unit_price > (Select avg(unit_price) from Sales_data);

--21. In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the 
-- group in the new column. The challenge here is to do this in a single select. For more details please see the sample 
-- input and expected output.
select 
  id,
  grp,
  val1,
  val2,
  case 
    when row_number() over (partition by grp order by id) = 1
    then sum(val1 + val2) over (partition by grp)
    else null
  end as tot
from mydata;

--22. 
select 
  id,
  sum(cost) as cost,
  sum(distinct quantity) as quantity
from thesumpuzzle
group by id;

--23. From following set of integers, write an SQL statement to determine the expected outputs
-- create a numbers table from 1 to 100 (you can increase if needed)
with numbers as (
    select 1 as num
    union all
    select num + 1 from numbers where num < 54
),
missing as (
    select num
    from numbers
    where num not in (select seatnumber from seats)
),
grouped as (
    select 
        num,
        num - row_number() over (order by num) as grp
    from missing
)
select 
    min(num) as gap_start,
    max(num) as gap_end
from grouped
group by grp
order by gap_start
option (maxrecursion 0);
