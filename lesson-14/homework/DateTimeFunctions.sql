---Lesson - 14
-- 1.Write a SQL query to split the Name column by a comma into two separate 
---columns: Name and Surname.(TestMultipleColumns)
Select left (Name, Charindex(',', Name)-1) as Name, right (Name, Len(Name) - Charindex(',', Name))as Surname 
from TestMultipleColumns;

--2. Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)
Select * from TestPercent
where Patindex('%[%]%', Strs) <> 0;

--3. In this puzzle you will have to split a string based on dot(.).(Splitter)
Select Replace(Vals, '.', '  ') from Splitter;

--4. Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)
Select Translate('1234ABC123456XYZ1234567890ADS', '0123456789', 'XXXXXXXXXX');

--5. Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)
Select * from testDots 
Where Len(Vals) - Len(Replace(Vals,'.', ''))> 2;

--6. Write a SQL query to count the spaces present in the string.(CountSpaces)
Select len(texts) - len(Replace(texts, ' ', '')) from CountSpaces;

--7. write a SQL query that finds out employees who earn more than their managers.(Employee)
Select 
e1.Name as EmployeeName, 
e1.Id as EmployeeId,
e1.Salary as EmployeeSalary,
e2.Name as ManagerName, 
e2.Id as ManagerId,
e2.Salary as ManagerSalary 
from Employee e1 
Join Employee e2 on e1.ManagerId=e2.Id
where e1.Salary > e2.Salary;

--8. Find the employees who have been with the company for more than 10 years, but less than 15 years. Display their Employee ID, First Name, Last Name, 
--Hire Date, and the Years of Service (calculated as the number of years between the current date and the hire date).(Employees)
Select EmployeeId, Name, HireDate, Datediff(Year,HireDate,Getdate()) as YearOfService
from Employees
Where Datediff(Year,HireDate,Getdate()) > 10 and Datediff(Year,HireDate,Getdate()) < 15;

-- Medium Tasks
--1. Write a SQL query to separate the integer values and the character values into two different columns.(rtcfvty34redt)
Select Replace(Translate('rtcfvty34redt', '0123456789', '          '),' ', '') as letters,
       Replace(Translate('rtcfvty34redt', 'abcdefghijklmnopqrstuvwxyz', '                          '), ' ', '') as digits;

--2. write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)
Select w2.Id, w2.RecordDate, w2.Temperature 
from Weather w1 
Join Weather w2 on Day(w2.RecordDate) - Day(w1.RecordDate) = 1
where w2.Temperature>w1.Temperature;
--3. Write an SQL query that reports the first login date for each player.(Activity)
Select player_id, min(event_date) as firstlogindate 
from Activity 
Group by player_id;
--4. Your task is to return the third item from that list.(fruits)
Select
 Substring
(fruit_list, charindex(',', fruit_list, charindex(',', fruit_list)+1)+1,
 charindex(',', fruit_list + ',' , charindex(',', fruit_list, charindex(',', fruit_list)+1)+1) 
- charindex(',', fruit_list, charindex(',', fruit_list)+1)-1) as thirditem from fruits
--5. Write a SQL query to create a table where each character from the string will be converted into a row.(sdgfhsdgfhs@121313131)
with numbers as (
  select top (len('sdgfhsdgfhs@121313131'))
    row_number() over (order by (select null)) as n
  from master.dbo.spt_values
)
select 
  substring('sdgfhsdgfhs@121313131', n, 1) as character
from 
  numbers;

--6. You are given two tables: p1 and p2. Join these tables on the id column. The catch is: when the value of p1.code is 0, 
-- replace it with the value of p2.code.(p1,p2)
Select p1.id, Replace(p1.code,0,p2.code) as code  from p1 Join p2 on p1.id=p2.id;

--7. Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:
--If the employee has worked for less than 1 year → 'New Hire'
--If the employee has worked for 1 to 5 years → 'Junior'
--If the employee has worked for 5 to 10 years → 'Mid-Level'
--If the employee has worked for 10 to 20 years → 'Senior'
--If the employee has worked for more than 20 years → 'Veteran'(Employees)
Select *, Case 
           when datediff(Year, HireDate, Getdate()) < 1 then 'New Hire'
		   when datediff(Year, HireDate, Getdate()) between 1 and 5 then 'Junior'
		   when datediff(Year, HireDate, Getdate())  between 6 and 10 then 'Mid-Level'
		   when datediff(Year, HireDate, Getdate())  between 11 and 20 then 'Senior'
		   else 'Veteran'
		end as EmpStatus 
from Employees;

--8. Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)
select 
  left(vals, patindex('%[^0-9]%', vals + 'x') - 1) as intvalues
from GetIntegers
where vals like '[0-9]%';

--Difficult Tasks
--1. In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)
  Select vals,
  -- swap first and second values
  substring(vals, charindex(',', vals) + 1, 
            charindex(',', vals + ',', charindex(',', vals) + 1) - charindex(',', vals) - 1
  ) 
  + ',' +
  left(vals, charindex(',', vals) - 1) 
  + 
  substring(vals, 
            charindex(',', vals + ',', charindex(',', vals) + 1), 
            len(vals)
  ) as swapped_vals
from MultipleVals;

--2. Write a SQL query that reports the device that is first logged in for each player.(Activity)
select 
  a.player_id,
  a.device_id,
  a.event_date as first_login
from Activity a
join (
  select player_id, min(event_date) as first_login
  from Activity
  group by player_id
) first_logins
  on a.player_id = first_logins.player_id
  and a.event_date = first_logins.first_login;

--3. You are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week. For each week, the total sales will be 
-- considered 100%, and the percentage sales for each day of the week should be calculated based on the area sales for that week.(WeekPercentagePuzzle)
with daily_sales as (
  select 
    area,
    financialweek,
    financialyear,
    dayname,
    dayofweek,
    sum(isnull(saleslocal, 0) + isnull(salesremote, 0)) as daily_total
  from 
    WeekPercentagePuzzle 
  group by 
    area, financialweek, financialyear, dayname, dayofweek
),
weekly_totals as (
  select 
    area,
    financialweek,
    financialyear,
    sum(isnull(saleslocal, 0) + isnull(salesremote, 0)) as weekly_total
  from 
    WeekPercentagePuzzle
  group by 
    area, financialweek, financialyear
)
select 
  d.area,
  d.financialweek,
  d.financialyear,
  d.dayname,
  d.dayofweek,
  d.daily_total,
  w.weekly_total,
  round((1.0 * d.daily_total / nullif(w.weekly_total, 0)) * 100, 2) as percentage_of_week
from 
  daily_sales d
join 
  weekly_totals w 
    on d.area = w.area 
    and d.financialweek = w.financialweek 
    and d.financialyear = w.financialyear
order by 
  d.area, d.financialweek, d.dayofweek;
