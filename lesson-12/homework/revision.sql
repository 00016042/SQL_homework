--lesson 12
--1.
Select p.lastName, p.firstName, a.city, a.state
from Person p 
Left Join Address a on p.personId=a.personId;

--2.
Select e1.name as Employee from Employee e1 Join Employee e2 on e1.managerId=e2.id
Where e1.salary>e2.salary;

--3. 
Select email as Email 
From Person  
Group by email 
having Count(email) > 1;

--4.
select * from Person
Delete from person where id not in (Select Min(id) From person Group by email);

--5.
Select ParentName from Girls
except
Select ParentName from Boys;
 
--6. 
SELECT custid, SUM(unitprice*qty*(1-discount)), MIN(weight) FROM [TSQL2012].[Sales].[Orders] o
join [TSQL2012].[Sales].[OrderDetails] od
on o.orderid = od.orderid
where weight > 50
group by custid;

--7.
Select Isnull(c1.Item,''), Isnull(c2.Item,'')
from Cart1 c1
Full join Cart2 c2 on c1.item=c2.item
Order by c1.item desc;

--8.
Select c.Name
from Customers c
Left Join Orders o on c.id=o.customerId 
where o.id is null;

--9.
Select s.student_id, s.student_name, sb.subject_name, count(e.student_id) attended_exams from Students s cross join Subjects sb left join Examinations e on s.student_id = e.student_id and sb.subject_name = e.subject_name
group by s.student_id, s.student_name, sb.subject_name
order by s.student_id, student_name;
