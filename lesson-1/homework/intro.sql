--Lesson 1 - introduction to SQL.

--1. Define the following terms: data, database, relational database, and table.
/*  Data is a collection of information that can be in two type those are structured 
and unstructured data. Structured data is the one that can be stored in collumns and rows.
Database is the place where data is stored in it.
Relational database is a special database. In relational database all tables will be relational 
to one another and it will be a connection with the tables inside a database with one another.
Table is a form where structured data is stored and  the data inside a table is stored inside 
row and columns.*/

--2. List five key features of SQL Server.
/* Five key features of SQL Server include high-performance and scalability,
robust transactional support, comprehensive data security, intelligent query processing,
and a wide range of management tools.*/

--3. What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
/*There are two possible modes: Windows Authentication mode and mixed mode. 
Windows Authentication mode enables Windows Authentication and disables SQL Server Authentication. 
Mixed mode enables both Windows Authentication and SQL Server Authentication.*/

--4. Create a new database in SSMS named SchoolDB.
Create database SchoolDB

/*5. Write and execute a query to create a table called Students with columns: 
StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT). */

use SchoolDB 
go
Create table Students (StudentId int Primary Key, Name varchar(50), Age int)

--code for cheking the new created Students table and its inputs
Select * from Students

--6. Describe the differences between SQL Server, SSMS, and SQL.
/*SQL Server is the software that handles the database and the tables. 
SQL Server Management Studio is the interface between the user and the database. 
Instead of SSMS it can be used SQL interfaces like Paycharm, visual studio code and so on.
While SQL is a query language, which is used to write commands to access or manipulate data. */

--7. Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples. 
/* DQL stands for Data Query Language and select is an example of it.
   DML is Data Manipulation Language. It is used for the data inside a table. DML includes insert,delete and update commands.
   DDL - Data Definition Language is used for SQL objects as database and tables. 
   It includes create, alter and drop commands.
   DCL - Data Control Language is used to give access to the users or 
   restrict the users from access. Grant and revoke are the commands of DCL.
   TCL - Transaction Control Language commands are used to manage transactions in a database to ensure data integrity.
   Begin transaction should be written before any code that is going to be executed and 
   if the user want to return the changings back, rolback transaction should be executed. 
   However if the user sure that he/she did the right changings then commit changings command should be executed.
   Note that if commit changings comand executed the rollback transaction command doesn't work. */

--8. Write a query to insert three records into the Students table.
Insert into Students (StudentId , Name , Age) values 
(1, 'Axror', 10)
,(2,'Oqila', 10)
,(3, 'Salohiddin', 10);

--code for cheking the new created Students table and its inputs
Select * from Students

--9. Restore AdventureWorksDW2022.bak file to your server. (write its steps to submit)
/* Firstly I have downloaded the AdventureWorksDW2022.bak file via the provided link to my divice. Then from the object explorer on the SSMS double click on Databases, choose Restore Database option,
then tick on device option and click on the three dots on the right side, press add button and choose the file that needs to be restored from its location. After those steps press ok on all views on the screen 
and if database succesfully restored it will be shown confirmation message on the screen. */
