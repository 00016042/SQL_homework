S---Lesson - 13
---Easy Tasks
--1.You need to write a query that outputs "100-Steven King", meaning 
--emp_id + first_name + last_name in that format using employees table.
Select concat(EMPLOYEE_ID,'-',FIRST_NAME,' ',LAST_NAME)as emp_id_and_name
from Employees;

--2. Update the portion of the phone_number in the employees table, 
--within the phone number the substring '124' will be replaced by '999'
Select Replace(PHONE_NUMBER, '124', '999') as PhoneNumber
from Employees;

--3. That displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. Give each column an 
--appropriate label. Sort the results by the employees' first names.(Employees)
Select FIRST_NAME as FirstName, Len(FIRST_NAME) as LengthOfName
from Employees
Where Left(FIRST_NAME,1) IN ('A', 'J','M')
Order by FIRST_NAME;

--4. Write an SQL query to find the total salary for each manager ID.(Employees table)
Select Manager_ID, Sum(Salary) as TotalSalary
from Employees
Group by Manager_ID;

--5. Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table
Select Year1, Case when max1>max2 and max1>max3 then max1
                   when max2>max1 and max2>max3 then max2
				   else max3
				   end as HighestValue
From TestMax;

--6. Find me odd numbered movies and description is not boring.(cinema)
Select id, description 
from cinema 
where id%2 = 1 and description != 'boring';

--7. You have to sort data based on the Id but Id with 0 should always be the last row. Now the question is can you do that with a single order by column.
-- (SingleOrder)
Select * 
from SingleOrder
Order by 
case when id = 0 then 1 else 0 end,
id;
--8. Write an SQL query to select the first non-null value from a set of columns. If the first column is null, move to the next, and so on. If all columns are
--null, return null.(person)
Select Coalesce(ssn,passportid,itin) as FirstNonNullValue
from Person;



--Medium task
--1. Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)
Select * from students 
select 
  fullname,
  left(fullname, charindex(' ', fullname) - 1) as firstname,

  substring(
    fullname,
    charindex(' ', fullname) + 1,
    charindex(' ', fullname, charindex(' ', fullname) + 1) - charindex(' ', fullname) - 1
  ) as middlename,

  right(
    fullname,
    len(fullname) - charindex(' ', fullname, charindex(' ', fullname) + 1)
  ) as lastname

from students;

--2. For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas. (Orders Table)
 Select *
 from Orders 
 where DeliveryState = 'TX' and CustomerId in  
 (select CustomerID from Orders where DeliveryState='CA');

--3. Write an SQL query to find the total salary for each manager ID.(Employees table)
Select ManagerID, Sum(Salary) TotalSalary
from Employees 
Group by ManagerID;

--4. Find all employees whose names (concatenated first and last) contain the letter "a" at least 3 times.
select *
from employees
where len(lower(name)) - len(replace(lower(name), 'a', '')) >= 3;

--5. The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years(Employees)
Select * from Employees 
Select DepartmentID, Count(EmployeeID) as TotalEmployees,
Sum(case when datediff(Year,HireDate, Getdate())>3 then 1 else 0 end) as employee_over_3_years,
round(100.0 * sum(case when datediff(year, hiredate, getdate()) > 3 then 1 else 0 end) / count(*), 2) as percentage_over_3_years
from Employees 
 Group by DepartmentID;

--6. Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)
Select * from Personal 

select jobdescription, spacemanid, missioncount, 'most experienced' as experience_level
from personal p1
where missioncount = (
    select max(missioncount)
    from personal p2
    where p1.jobdescription = p2.jobdescription
)
union
select jobdescription, spacemanid, missioncount, 'least experienced' as experience_level
from personal p1
where missioncount = (
    select min(missioncount)
    from personal p2
    where p1.jobdescription = p2.jobdescription
);

--7. Difficult Tasks
--1. Write an SQL query that separates the uppercase letters, lowercase letters, numbers, and other characters from the given string 'tf56sd#%OqH' into 
--separate columns.
-- declare and assign the input string
declare @text varchar(100);
set @text = 'tf56sd#%OqH';

-- recursive CTE to split each character
with chars as (
    select 1 as pos, substring(@text, 1, 1) as ch
    union all
    select pos + 1, substring(@text, pos + 1, 1)
    from chars
    where pos + 1 <= len(@text)
)
select
    string_agg(case when ch collate latin1_general_cs_as like '[A-Z]' then ch end, '') as uppercase_letters,
    string_agg(case when ch collate latin1_general_cs_as like '[a-z]' then ch end, '') as lowercase_letters,
    string_agg(case when ch collate latin1_general_cs_as like '[0-9]' then ch end, '') as numbers,
    string_agg(case when ch collate latin1_general_cs_as not like '[a-zA-Z0-9]' then ch end, '') as other_characters
from chars
option (maxrecursion 100);

--2. Write an SQL query that replaces each row with the sum of its value and the previous rows' value. (Students table)
Select * from Students
select 
    studentid,
    name,
    sum(age) over (order by studentid) as age
from students;

--3. You are given the following table, which contains a VARCHAR column that contains mathematical equations. Sum the equations and provide the answers in the output.(Equations)
-- Declare variables
declare @eq varchar(200), @sql nvarchar(300), @res int;

-- Cursor to loop through each row
declare eq_cursor cursor for 
    select Equation from Equations;

open eq_cursor;
fetch next from eq_cursor into @eq;

while @@fetch_status = 0
begin
    -- Build and execute the dynamic SQL to evaluate the expression
    set @sql = 'select @r_out = ' + @eq;
    exec sp_executesql @sql, N'@r_out int output', @r_out = @res output;

    -- Update the TotalSum for this row
    update Equations
    set TotalSum = @res
    where Equation = @eq;

    fetch next from eq_cursor into @eq;
end

close eq_cursor;
deallocate eq_cursor;

-- Final result
select * from Equations;

--4. Given the following dataset, find the students that share the same birthday.(Student Table)
Select * from Student
select studentname, birthday
from student
where birthday in (
    select birthday
    from student
    group by birthday
    having count(*) > 1
);

--5. You have a table with two players (Player A and Player B) and their scores. If a pair of players have multiple entries, aggregate their scores into a 
-- single row for each unique pair of players. Write an SQL query to calculate the total score for each unique player pair(PlayerScores)
select
    case when PlayerA < PlayerB then PlayerA else PlayerB end as Player1,
    case when PlayerA < PlayerB then PlayerB else PlayerA end as Player2,
    sum(Score) as TotalScore
from PlayerScores
group by
    case when PlayerA < PlayerB then PlayerA else PlayerB end,
    case when PlayerA < PlayerB then PlayerB else PlayerA end;


