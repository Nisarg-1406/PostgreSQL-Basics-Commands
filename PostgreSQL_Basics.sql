-- SQL is the computer language which is used for storing, manipulating and retriving the data. SQL stand for structured query language. 
-- SQL works in the relational databases. Relational databses are the collection of the table and this tables are related in some ways. 
 -- The record in the table is the row of the data and attribute is the column in the table. 
-- SQL queries classification - 
 --1) Data Definition Language - Define the structure of the data. We can CREATE, ALTER, DROP
 --2) Data Manipulation Language - Manipulate the data contians within the objects. We can INSERT, UPDATE, DELETE
 --3) Data Query Language - To retrive the data from table. Done by using , few eg : SELECT, ORDER BY, GROUP BY statement. 
 --4) Data Control Language - Access control to users. To do use : GRANT, REVOKE
 --5) Transactional Control Commands - To manage various transaction over the database. Eg: COMMIT, ROLLBACK
 
-- PostgreSQL - PostgreSQL is an advanced object-relational database management system that supports an extended subset of the SQL standard, including transactions, foreign keys, subqueries, triggers, user-defined types and functions. 

-- We have created the database named ABC. 

-- CREATE TABLE - 
-- Syntax - 
'''
CREATE TABLE "table_name"(
	"column 1" "data type for column 1" [column 1 constraint(s)],
	"column 2" "data type for column 2" [column 2 constraint(s)],
	...
	"column n "
[table constraint(s)] );
'''
create table Customer_table (
	Cust_id int,
	First_name varchar,
	Last_name varchar,
	age int,
	email_id varchar);
	
create table science_class (
	enrollement_no int,
	Name varchar,
	science_marks int);	
	
-- INSERT 
 -- Not specifying the column name 
insert into customer_table values
(1,'bee','cee',32,'bc@xyz.com'); 

 -- Specifying the column name  
insert into customer_table (cust_id, first_name, age, email_id) values
(1,'bee',32,'bc@xyz.com'); 

 -- Specifying multiple rows. 
insert into customer_table values 
(1,'bee','eee',32,'be@xyz.com'), 
(2,'cee','fee',22,'cf@xyz.com'), 
(3,'dee','gee',12,'dg@xyz.com');

-- IMPORT FILE INTO THE DATA - 
copy customer_table from 'C:\Program Files\PostgreSQL\Data\copy.csv' delimiter ',' csv header;
copy customer_table from 'C:\Program Files\PostgreSQL\Data\copytext.txt' delimiter ','; 

-- SELECT - The SELECT statement is used to fetch the data from a database table which returns this data in the form of a result table. These result tables are called result-sets.
 -- syntax - SELECT "column_name1", "column_name2", "column_name3" FROM "table_name";
select first_name from customer_table
select first_name,last_name,age from customer_table
select * from customer_table

-- SELECT DISTINCT - To eleminate the duplicate records 
select distinct first_name from customer_table -- It is case sensitive. Capital and small letters are treated differently. 
select distinct first_name,age from customer_table 
select distinct * from customer_table --As costumer id of Gee at 5th and 7th row is different, hence first_name is appearing as 'Gee'

copy customer_table from 'C:\Program Files\PostgreSQL\Data\copy.csv' delimiter ',' csv header;
select * from customer_table 
select distinct * from customer_table -- It will remove the exactly same row. 

-- WHERE CLAUSE - 
--The Sql WHERE clause is used to specify the condition while fecthing out the data from the single table or joining with multiple table
-- If the condition is satisfied, then only it returns a specific value from the table
--Syntax - Select col1 col2 from table where condtion
select distinct first_name from customer_table where age = 25
select distinct first_name from customer_table where age > 25
select * from customer_table where first_name = 'Gee'

-- LOGICAL OPERATORS - 
--Multiple conditions can be applied using 'and','or' operator. They are used to narrow out the data in SQL statement. 
select first_name, last_name, age from customer_table where age > 20 and age < 30
select first_name, last_name, age from customer_table where age < 20 or age >= 30

--Not condition is used to negate the condition in a SELECT, INSERT, UPDATE, DELETE
select * from customer_table where not age = 35
select * from customer_table where not age = 25 and not first_name='Jay'

-- UPDATE - 
-- We use the WHERE condition to update the some of the records, but for updating the entire table we will not use the 'WHERE' condition
--For updating the entire table, we use the 'update'
select * from customer_table where cust_id = 2 --To update the last_name which was null and age 
update customer_table set last_name = 'pe', age = 17 where cust_id = 2
select * from customer_table where cust_id = 2

update customer_table set email_id = 'gee@xyz.com' where first_name = 'Gee' or first_name = 'gee'
select * from customer_table

-- DELETE - 
--To delete the existing records i.e rows from the table, we will use the DELETE Query. 
delete from customer_table where cust_id = 1
delete from customer_table where age > 30
delete from customer_table --delete entire table
select * from customer_table

-- ALTER - 
-- to change the structure of the table, will use the alter table command, syntax - alter table 'table name' [specify actions] ==>
-- specify actions means - 1) columns - Add, delete, modify or rename. 2) constraints - Add, drop. 3) index - Add, drop 
alter table customer_table add test varchar(255) --To add the column of variable char datatype of having 255 as the maximum limit
alter table customer_table drop that --To delete the column, can also write it as 'alter table customer_table drop column that'

--To change the datatype of the particular column 
alter table customer_table alter column age type varchar(255)
select * from customer_table

--To rename the column name 
alter table customer_table rename column email_id to customer_email

--To add or drop the constraints 
-- 1) To set the column such that no value in the column is null
alter table customer_table alter column cust_id set not null
insert into customer_table(first_name, last_name, age, customer_email) values ('aa','bb',25,'ab@xyz.com') -- With this we get the error - ERROR:  null value in column "cust_id" of relation "customer_table" violates not-null constraint
--2) To drop the null constraints i.e it is ok to have the null in the column 
alter table customer_table alter column cust_id drop not null
insert into customer_table(first_name, last_name, age, customer_email) values ('aa','bb',25,'ab@xyz.com')
--3) To add the constraint that cust_id > 0 
alter table customer_table add constraint cust_id check (cust_id > 0)
insert into customer_table(cust_id, first_name, last_name, age, customer_email) values (-1,'aa','bb',25,'ab@xyz.com') -- Error- new row for relation "customer_table" violates check constraint "cust_id"
--4) To make the column as the primary key - Primary key cannot have the null values 
alter table customer_table add primary key (first_name)
