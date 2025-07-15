--Lesson-15.
--1. Find Employees with Minimum Salary
Select Id, Name, Salary from employees
where Salary = (Select min(Salary) from employees);

--2. Find Products Above Average Price
Select id, product_name, price  
from products
where price > (Select avg(price) from Products);

--3. Find Employees in Sales Department
--Select e.id, e.name, e.department_id, d.id, d.department_name
--from employees e Join departments d on e.department_id = d.id
--where d.department_name = 'HR';
Select id, name, department_id 
from employees
where department_id in(Select id from departments where department_name = 'Sales');

--4. Find Customers with No Orders
Select * from Customers 
where customer_id not in (Select customer_id from orders);

--5. Find Products with Max Price in Each Category
Select * from Products 
where price = (Select max(price) from products);

--6. Find Employees in Department with Highest Average Salary
Select * from employees e
Where  e.department_id = (
Select top 1 department_id
from employees
group by department_id
order by Avg(Salary)desc
);

--7. Find Employees Earning Above Department Average
--Task: Retrieve employees earning more than the average salary in their department. Tables: employees (columns: id, name, salary, department_id) 
Select *
from employees e1
where e1.salary > (select avg(e2.salary) from employees e2  where e1.department_id=e2.department_id group by e2.department_id);

--8. Find Students with Highest Grade per Course
-- Task: Retrieve students who received the highest grade in each course. Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)
Select s.student_id, s.name, g.course_id, g.grade
from students s
Join grades g on s.student_id=g.student_id
Join (Select course_id, Max(grade) as maxgrade from grades group by course_id)mg on mg.course_id=g.course_id and mg.maxgrade=g.grade; 

-- Level 5: Subqueries with Ranking and Complex Conditions
-- 9. Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. 
-- Tables: products (columns: id, product_name, price, category_id)
with cte as (Select *, dense_rank() over (partition by category_id order by price desc) as hp from Products) 
Select id, product_name, category_id, price ThirdHighSalary from cte where hp = 3;

--10. Find Employees whose Salary Between Company Average and Department Max Salary
--Task: Retrieve employees with salaries above the company average but below the maximum in their department. Tables: employees (columns: id, name, salary, department_id
Select e.*
from employees e 
Join(Select  department_id, 
     max(salary) as maxsalary, 
	 avg(salary) as avgsalary 
  from employees 
  group by department_id
)dp_status 
on dp_status.department_id = e.department_id
where dp_status.maxsalary > e.salary and dp_status.avgsalary < e.salary;

