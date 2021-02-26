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

-- RESTORING THE DATA. 
select * from customer --Datasets 
select * from product --Datasets
select * from sales --Datasets

-- IN COMMAND - 
 -- 'in' command is used with 'where' to help to reduce the need to use multiple OR Conditions in a SELECT, INSERT, UPDATE, DELETE statement
select * from customer where city in ('Philadelphia', 'Seattle')

-- BETWEEN COMMAND - 
 -- 'between' command is used with 'where' to retrive values within the range in a SELECT, INSERT, UPDATE, DELETE statement
select * from customer where age between 20 and 30 -- 20 and 30 are included 
 -- 'not' and 'between' can be combined
select * from customer where age not between 20 and 30 -- 20 and 30 are excluded
 -- To select from the date range
select * from sales where ship_date between '2015-04-01' and '2016-04-01'

-- LIKE COMMAND - 
 -- 'like' condition is used to perform pattern matching using wild cards - wildcards are the special symbol 
	-- '%' wildcard is used to match any string of any length
	-- '_' wildcard allows to use match on single character
 -- 'space' is considered as the character and no_value is also considered as the character
	-- A% means start with A like ABCDE
	-- %A means anything that ends with A
	-- A%B means start with A but ends with B
	-- AB_C means string starts with AB, then there is a single character, then there is C
select * from customer where customer_name like 'J%'
select * from customer where customer_name like '%Nelson%' --customer name where 'nelson' is occuring
select * from customer where customer_name like '____ %' --To select the customer name in which there is first name who consist of 4 char and after that there can be any number of char. For 4 char we will use 4 underscores - '____ '
select distinct city from customer where city not like 'S%' --The word does not start with letter 's'
 -- To find the '%' symbol in the table, we need to use the '\' i.e escape character. Eg: like 'G\%' - This is o/p the string starting with 'G%' 

-- ORDER BY COMMAND - The orderBy clause is used to sort the result data
select * from customer where state = 'California' order by customer_name --This is arrange them in ascending order
select * from customer where state = 'California' order by customer_name asc --This is arrange them in ascending order
select * from customer where state = 'California' order by customer_name desc --This is arrange them in descending order
select * from customer where state = 'California' order by city asc, customer_name desc --This is city arranged in asc order and customer_name arrange them in descending order
select * from customer where state = 'California' order by 2 desc --This is arrange the 2nd col in descending order i.e customer_name 
select * from customer order by age --Order entire age column

-- LIMIT - 'limit' statement is used to limit the number of records returned based on limit value
select * from customer where age > 25 order by age desc limit 10

-- AS STATEMENT - Wanted to change the name of the column using 'as'
select customer_id as "Serial number", customer_name as name, age as "customer age" from customer --As we are using space in b/w serial number, therefore we used the double quotes

-- AGGREGATE FUNCTIONS -  
 --1) count function - It will count the non-null values after applying the condition 
select count (*) from sales --Count total number of rows 
select count(order_line) as "Numebr of products ordered", count (distinct order_id) as "Number of orders" from sales where customer_id = 'CG-12520' -- To combine and count for this customer id
 --2) Sum function - 
select sum(profit) as "Total Profit" from sales
select sum(profit) as "Total Profit" from sales where product_id = 'FUR-BO-10001798'
 --3) Avg function-
select avg(age) as "avg age" from customer
select avg(sales * 0.10) as "avg commission" from sales --if 10% is the commission value. 
 --4) Min and max-
select min(sales) as "Min sales value June 15" from sales where order_date between '2015-06-01' and '2015-06-30'
select max(sales) as "Max sales value June 15" from sales where order_date between '2015-06-01' and '2015-06-30'

-- GROUPBY COMMAND - 'groupby' clause is used in a SELECT statement to group the results by one or more columns
select region, count(customer_id) as customer_count from customer group by region --To get the count of the customer_id from a particular region i.e count from south, east, west and so on, so will groupby the region 
select product_id, sum(quantity) as quantity_sold from sales group by product_id order by quantity_sold desc -- To use the sum aggregate 
select customer_id, min(sales) as min_sales, max(sales) as max_sales, avg(sales) as average_sales, sum(sales) as total_sales from sales group by customer_id order by total_sales desc limit 10
 -- When we are selecting the column in the grouby, it should be unique with select 'column' i.e for eg : we can not select the region along with the age, beacuse there can be many age for the particular region so age should be used as an aggregate, we can select the 'state' along with the 'region'
select region,state, avg(age) as avg_age, count(customer_id) as customer_count from customer group by region, state

-- HAVING COMMAND - 'having' clause is used in combination with the group by clause to restict the group of returned rows to only those whos condition is satisfied
select region, count(customer_id) as customer_count from customer group by region having count(customer_id) > 200

-- CONDITIONAL STATEMENT - CASE - 
 -- 'case' expression is a conditional expression, similar to if/else statement
select *, case
	when age < 30 then 'young'
	when age > 60 then 'senior citizen'
	else 'middle_aged'
	end as Age_category from customer --if 'as Age_category' not written then it will give name as 'case'

-- JOINS - IMP - 
 -- 'joins' are used to retrive data from multiple table. It is performed when 2 or more tables are joined in SQL statement. 
 -- will create 2 table
create table sales_2015 as select * from sales where ship_date between '2015-01-01' and '2015-12-31';
select count(*) from sales_2015; 
select count (distinct customer_id) from sales_2015;

create table customer_20_60 as select * from customer where age between 20 and 60;
select count(*) from customer_20_60; 

 -- Inner join - It finds the intersection between the 2 tables. when satisfied, column values of each matched pairs of rows of table A and B are combined into results
 -- there are 2 tables = 'table a' and 'table b'
select customer_id from sales_2015 order by customer_id
select customer_id from customer_20_60 order by customer_id

select a.order_line, a.product_id, a.customer_id, a.sales, b.customer_name, b.age
from sales_2015 as a
inner join customer_20_60 as b
on a.customer_id = b.customer_id order by customer_id

 -- Left join - It returns all row from the left table and intersection from left and right table, even if there is no match from the right table 
select a.order_line, a.product_id, a.customer_id, a.sales, b.customer_name, b.age
from sales_2015 as a
left join customer_20_60 as b
on a.customer_id = b.customer_id order by customer_id

 -- Right join -  It returns all row from the right table and intersection from left and right table, even if there is no match from the left table 
select a.order_line, a.product_id, b.customer_id, a.sales, b.customer_name, b.age
from sales_2015 as a
right join customer_20_60 as b
on a.customer_id = b.customer_id order by customer_id

 -- full join -  It returns all row from both of the table 
select a.order_line, a.product_id, a.customer_id, a.sales, b.customer_name, b.age, b.customer_id
from sales_2015 as a
full join customer_20_60 as b
on a.customer_id = b.customer_id order by a.customer_id, b.customer_id

 -- cross join - It creates the cartisian product between 2 sets of data i.e to get the repeative data easily 
 -- If we didnt used the cross join and if we wanted the each year to map with 12 months, then we need to write 12x9 rows = 108 rows 
create table month_values(MM integer);
create table year_values(YY integer);

insert into month_values values (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12);
insert into year_values values (2011), (2012), (2013), (2014), (2015), (2016), (2017), (2018), (2019);

select * from month_values;
select * from year_values;
select a.YY, b.MM from year_values as a, month_values as b order by a.YY, b.MM

 -- except operator - it is used to return all rows in first select statement and removes the all rows present in second select statement
 -- i.e it joins both of the table and remove the intersection part from the first table and display the first table
select customer_id from sales_2015 order by customer_id;
select customer_id from customer_20_60 order by customer_id;
select customer_id from sales_2015 except select customer_id from customer_20_60 order by customer_id;

-- Union operator - It is used to combine the result set of 2 or more select statement. It removes the duplicate rows between the various select statement
-- The particular expression in both/multiple of the select statement should have same datatype and also the number of expression in multiple select statement should be same
select customer_id from sales_2015 union
select customer_id from customer_20_60 order by customer_id

-- SUBQUERIES - IMP - 
 -- subquery is query within the query. Subquery is used to reduce the efforts, also to make query more readable 
 -- subquery can reside within the 'where','select','from' clause. syntax is : 
/* SELECT "column_name1" FROM "table_name1"
WHERE "column_name2" [Comparison Operator]
(SELECT "column_name3" 
FROM "table_name2"
WHERE "condition"); */
 -- In bracket () denonted above it is the subquery. The output of this subquery will be used as the values in the comparision operator where column_name2 will be compared

 --1) subquery written in the 'where' part
select * from sales where customer_id in (select customer_id from customer where age > 60) -- Here the subquery must have one col to be comapred with the where claue column
 --2) subquery written in the 'from' part - suppose to find out how much of each product has been sold from 2 tables
select a.product_id, a.product_name, a.category, b.quantity from product as a 
left join (select product_id, sum(quantity) as quantity from sales group by product_id) as b
on a.product_id = b.product_id order by quantity desc -- null is considered as the topmost for the desc order, for asc null is considered as the bottommost
 --3) subquery written in the 'select' part
select customer_id, order_line, (select customer_name from customer where customer.customer_id = sales.customer_id)
from sales order by customer_id
 -- The between operator cannot be used with a subquery, however the between operator can be used within the subquery 

-- VIEW - view is the query. It is not the physical table, but a virtual table created by query join by one or more tables. 
 -- virtual table is used beacuse it gives ease of use, data security and space saving (As it is not the actual table). Output is saved as the view
create or replace view logistics as select a.order_line, a.order_id, b.customer_name, b.city, b.state, b.country
from sales as a left join customer as b
on a.customer_id = b.customer_id order by order_line
select * from logistics
 -- To aviod the error of running the create view again(error is 'relation "logistics" already exists'), we can write 'create or replace view' instead of 'create view'
drop view logistics --To delete the view
 -- Updating the table will update the original table and this is NOT advisible to do it. 

-- INDEX - An index is a performance-tuning method of allowing faster retrival of records. In database will first find out the index, after the index will find out the relevant position of the record and then will search in the table
 -- disadvantage of applying index is that - If we apply update method, then with index it is slower to use.
 -- A simple index is the index for which we want to retrive the data from the single column and for retriving the data from the multiple column, we use the composite index
create index mon_idx on month_values(MM)
 -- To drop the index, If 'if exist' is not written then if the query is not there then it will give the error. 'if exist' is used also when dropping out the table also
 -- There is optional keyword in drop, i.e cascade - If the database object is dependent on index and if deleting this index, if we write cascade then that dependent object would also be deleted
 -- and if we write 'restict' then it will give the error that there is the dependent object and hence the index cannot be deleted. 
drop index if exists mon_idx 
 -- If want to rename the index then will use the alter index 

-- STRING FUNCTIONS - 
 --1) length function - It returns the length of the specified string, expressed as number of characters 
select customer_name, length(customer_name) as char_num from customer where length(customer_name) > 15
 --2) upper and lower case - 
select upper('start-tech Academy')
select lower('START-TECH ACADEMY')
 --3) replce - It will replace the all set of characters to other set of characters - IT IS CASE SENSITIVE
select customer_name, country, replace(country, 'United States', 'US') as country_new from customer
 --4) TRIM function, RTRIM function, LTRIM function - To clean the data
 --TRIM function removes all specified characters either from the beginning or the end of a string - syntax - 'trim([ leading | trailing | both ] [ trim_character ] from string )'
	-- By default it will trim from both side, if we mention leading then it will trim from the left side, and if mentioned the trailing then from right side
	-- Then to mention the 'trim_character', if we do not mention it then it will remove the spaces only. 
 --RTRIM function removes all specified characters from the right-hand side of a string - syntax - rtrim( string, trim_character )
 --LTRIM function removes all specified characters from the left-hand side of a string - syntax - ltrim( string, trim_character )
 -- This all functions are not working here for trimming the left part of the string, dont know why..but concept is correct
select trim(leading ' ' from '	Start,Tech Academy ') --After leading, trailing, both there is the space here - ' ', but we can mention special char also like ','
select trim(trailing ' ' from '	Start-Tech Academy ')
select trim(both ' ' from '	Start-Tech Academy ')
select trim('	Start-Tech Academy ')
select rtrim('	Start-Tech Academy     ')
select ltrim('		Start-Tech Academy     ')

 --5) concat - concat(||) allows to concat 2 or more strings
select customer_name, city || ' , ' || state || ' , ' || country as adress from customer
 --6) substring - allows to extract a substring from a string - syntax - 'substring( string [from start_position] [for length] )'	
	-- As customer_id has first 2 char as the alphabets and last 5 numbers as the unique numbers, so we use 2 select statement to form 2 substring
SELECT Customer_id, Customer_name, SUBSTRING (Customer_id FOR 2) AS cust_group -- For 2 means for first 2 position, we are not mentioning the from statement as in below select statement because we are starting from the first position
FROM customer WHERE SUBSTRING(Customer_id FOR 2) = 'AB' 
SELECT Customer_id, Customer_name, SUBSTRING (Customer_id FROM 4 FOR 5) AS cust_number -- From 4 for 5 is mentioned beacuse we are starting from the 4th position (As 3rd position is '-') and for 5 positions
FROM customer WHERE SUBSTRING(Customer_id FOR 2) = 'AB'
 --7) STRING_AGG - It concatenates input values into a string, separated by delimiter - syntax - string_agg (expression, delimiter). 
	-- It will use to concatenate all the values in the particular column which is different from concat function 
select order_id , string_agg(product_id, ' , ') FROM sales GROUP BY order_id -- For particular order_id there would be different product_id, so we are aggregating different product id (rows).

-- MATHEMATICAL FUNCTIONS -
 -- 1) ceil and floor number - 
select order_line, sales, ceil(sales), floor(sales) from sales
 -- 2) random - return a random number from 0 to 1. 0 will be included or 1 will be excluded 
	-- Random decimal between a range (a included and b excluded) - SELECT RANDOM()*(b-a)+a, suppose a = 10 and b = 20 and we want the decimal random number from 10 to 20. 
	-- Random Integer between a range (both boundaries included) - SELECT FLOOR(RANDOM()*(b-a+1))+a, will use the floor function for integer value
	 -- (b-a+1)* random() will make sure that (b-a+1)* random() is > 1 and adding +a will make it > a and hence both boundaries are included. 
select random()*(50-10)+10 --decimal
select floor(random()*(50-10))+10 --integer
 --3) setseed - If we set the seed by calling the setseed function, then the random function will return a repeatable sequence of random numbers that is derived from the seed.
	-- seed value can be inbetween -1 and 1 and both can be inclusive. Eg : when we set the seed to 0.5 then when first time when we run the random number it will give same random number
	-- everytime when we run it and when second time run the random number then it will give the same random number in all PCs, but it would be different from first random number and so on 
select setseed(0.5)
select random() -- value - 0.2499104186659835
select random() -- value - 0.520017612227381
 --4) ROUND function returns a number rounded to a certain number of decimal places
select order_line, sales, round(sales) from sales
 --5) POWER function returns m raised to the nth power - Eg : square of all ages in the customer table
select age, power(age,2) from customer 

-- CURRENT DATE AND TIME - 
 --1) current date - The CURRENT_DATE function will return the current date as a 'YYYY-MM-DD' format.
 --2) current time - CURRENT_TIME function will return the current time of day as a 'HH:MM:SS.GMT+TZ' format.
 --3) current timestamp - The CURRENT_TIMESTAMP function will return the current date as a 'YYYYMM-DD HH:MM:SS.GMT+TZ' format.
select current_date, current_time, current_time(1), current_time(3), current_timestamp -- for () we are mentioning the precision value, for random with precision 
 -- we can see that for millisecond - any number without precision is generated, for current_time(1), there is precised value upto one decimal place is generated, 
 -- and for current_time(3) there is precised value upto three decimal place is generated. 

 --4) age function - AGE function returns the number of years, months, and days between two dates - syntax - age( [date1,] date2 ). If date1 is NOT provided, current date will be used
select age ('2021-02-24','2000-06-14')
SELECT order_line, order_date, ship_date, age(ship_date, order_date) as time_taken FROM sales ORDER BY time_taken DESC -- string type of output

 --5) Extract - It extracts the parts from the date. Need to use the 'from' keyword in extract function - syntax - EXTRACT ( ‘unit’ from ‘date’ )
	--It helps to manipulate the output. 
select order_date,ship_date, extract(epoch from(ship_date - order_date)) from sales -- 'epoch from(ship_date - order_date)' will give the number of seconds b/w (ship_date - order_date).
	-- (ship_date - order_date) was giving difference b/w this 2 dates. wheneve we have seconds we can convert this seconds to minutes (by /60), then hours (by /60) then days (by /24), so thats why extract keyword is used
	-- The above statement gives the error because when we subtracted ship_date - order_date, it gave the output of integer and doing epoch of this is giving error i.e it is not converting date integer to seconds
select order_date,ship_date, (extract(epoch from ship_date ) - extract(epoch from order_date)) as sec_taken from sales

select extract(day from current_date)	
select current_timestamp, extract(hour from current_timestamp)

-- PATTERN MATCHING - 
 -- ~(regular expression) - It provides powerful and flexible tool to perform matching. One thing to note is that wildcards of 'regular expression' and wildcards of 'like' statement is different. 
  --Another major difference between like and regular expression statement is that - like statement perform pattern matching on the whole string, but regular expression perform pattern matching on the part of the string. 
  -- Eg : suppose we want to find in table where first name starts with A,B,C,D,E and last name with F,G then we need to write 5x2 like statement, and hence for complex situation we use the reg-ex statement

 -- reg-ex expression symbol - FOR THE THEROY TABLE AND EXPRESSION EXPLANATION (ADVANCE PATTERN MATCHING) REFER 76th VIDEO OF SQL FOR DATA ANALYTICS
select * from customer where customer_name ~* '^a+[a-z\s]+$'
select * from customer where customer_name ~* '^(a|b|c|d)+[a-z\s]+$'
select * from customer where customer_name ~* '^(a|b|c|d)[a-z]{3}\s[a-z]{4}$'
select * from customer where customer_name ~* '^(a|b|c|d)+[a-z]{3}\s[a-z]{4}$'

create table users(id serial primary key, name character varying);
insert into users (name) VALUES ('Alex'), ('Jon Snow'), ('Christopher'), ('Arya'),('Sandip Debnath'), ('Lakshmi'),('alex@gmail.com'),('@sandip5004'), ('lakshmi@gmail.com');
select * from users
select * from users where name ~* '[a-z0-9\.\-\_]+@[a-z0-9\-]+\.[a-z]{2,5}';
 
-- DATATYPE CONVERSION - To change the datatype in the column
 --1)TO_CHAR function converts a number or date to a string - syntax - TO_CHAR ( value, format_mask ) , here the format mask has different value for number and different for dates
	--number to string - 
SELECT sales, TO_CHAR(sales, '9999.99') FROM sales; --To write the sales in the to_char format with double precision (2 digits after decimal). '9999' is writen because before decimal there are max 4 digits in the table. 
SELECT sales, TO_CHAR(sales, '$9,999.99') FROM sales; -- To put the '$' sign we use '$9,999.99', rest of the syntax meaning is same as above
select sales, 'Total sales value for this order is' || TO_CHAR(sales, ' $9999.99') as message FROM sales --same as above statement. 
	--date to a string -> Date format - (YYYY-MM-DD) -- this is the default format, we can change to other format as shown below.
SELECT order_date, TO_CHAR(order_date, 'MM-DD-YY') FROM sales;
SELECT order_date, TO_CHAR(order_date, 'Month DD-YY') FROM sales;
SELECT order_date, TO_CHAR(order_date, 'DD Month YY') FROM sales;
SELECT order_date, TO_CHAR(order_date, 'DD Day Month YY') FROM sales;

 --2) TO_DATE function converts a string to a date - syntax - TO_DATE( string1, format_mask ) - Earlier the format mask was used to save the string in that particular format
  -- and now this format mask is just defining the format of date in this string. 
select to_date('2021/02/24','YYYY/MM/DD')
select to_date('24/02/2021','DD/MM/YYYY')

 --3) TO_NUMBER function converts a string to a number - TO_NUMBER( string1, format_mask ) - TO_NUMBER work same 'number to string' syntax parameters
select to_number('2045.876','9999.999')
select to_number('2,045.876','L9,999.999')

-- USER CONTROL ACCESS FUNCTIONS - Controlling the acess of the database 
 -- create user - CREATE USER statement creates a database account that allows you to log into the database - syntax - CREATE USER user_name [WITH PASSWORD 'password_value’ | VALID UNTIL 'expiration' ];
  -- In this we can create the password and can also set the condition for the valid_until which will allow that user to acess the database only till that date
create user starttech with password 'Academy'
create user starttec with password 'Academy' valid until 'Feb 25 2021'
create user startte with password 'Academy' valid until 'infinity'
 -- Suppose we want the user to read the data, but not to write the data, Also suppose we want the user to update but not delete the data. So this is done using the 
 -- 'GRANT & REVOKE'. These permissions can be any combination of SELECT, INSERT, UPDATE, DELETE, INDEX, CREATE, ALTER, DROP, GRANT OPTION or ALL.
 -- For giving the acess we will use the 'Grant' command and for removing the acess, we will use the 'revoke' command. 
 -- syntax for 'grant' - GRANT privileges ON object TO user; syntax for revoke - REVOKE privileges ON object FROM user;
grant select, update, insert, delete on product to starttech 
revoke delete on product from starttech -- User cannot delete from product database. 
GRANT ALL ON product TO starttech; -- User have all permission 
revoke ALL ON product from starttech; -- User has been revoked from all permission 

 -- Drop USER statement is used to remove a user from the database - syntax - DROP USER user_name
drop user starttech
 -- Alter USER statement is used to rename a user in the database - syntax - ALTER USER user_name RENAME TO new_name;
alter user startte rename to ste
 -- When we create the user, all the user are stored in the table named 'pg_user' - Run a query against pg_user table to retrieve information about Users
select usename from pg_user
select * from pg_user -- To get all the information of the user. 
 -- To find the user which are logged in - Run a query against pg_stat_activity table to retrieve information about Logged-in Users - syntax - SELECT DISTINCT usename FROM pg_stat_activity;
select distinct usename from pg_stat_activity 
select distinct * from pg_stat_activity -- to see all the activites

-- TABLESPACE - Tablespaces allow database administrators to define locations in the file system where the files representing database objects can be stored. 
 -- If we want the table to go to different location then to create the different tablespace. Creation of the tablespace can only be done by database superuser(main user)
 -- however once the table space is created then new user has privalge to create the table on that database using 'create privalge'
 -- Couldnt create the database. 
create tablespace NewSpace location 'C:\Program Files\PostgreSQL\13\data\store'
CREATE TABLE PG_13_202007201 (test_column int) TABLESPACE newspace; -- Giving error -- followed according to the course. 

-- TRUNCATE - The TRUNCATE TABLE statement is used to remove all records from a table or set of tables in PostgreSQL. It performs the same function as a DELETE statement without a WHERE clause.
 -- syntax - TRUNCATE [ONLY] table_name [ CASCADE | RESTRICT] ; - When to use this 'only' keyword, when we have some tables which have inherited data from this table which is going to be deleted,
  --so if we dont use 'only' then dependent table will also be deleted, but if we use only then the mentioned table will only be deleted. 
  -- 'cascade and restrict ' is used beacuse if there is any table which has foriegn key reference with this table, so if we write cascade then all such table will also be deleted, and if we write restrict then this table will also be not deleted. 
  -- Truncate is similar to delete i.e it will delete the all rows of the table and not the table. For deleting the table column, need to drop command. 
truncate table customer_20_60 

-- PERFORMANCE TUNING TIPS  - 
 -- 1) Explain query - explain helps us to enable the performace of the query without running actual query. Displays the execution plan for a query statement without running the query.
explain select * from customer -- in this the cost is divided into 2 parts - 0.00 is the total execution cost of my query before the output. The another cost i.e
 -- 19.93 is the total cost of execution along with display of the data. This will help to compare the query effieciency with other query. The another thing is the 
 -- row value and width value which is total width of the resultant table. 
explain select distinct * from customer - --The distinct keyword is grouping the data for all of the keywords and then we are aggregating the table. 
 -- If we write verbose like this 'EXPLAIN [ VERBOSE ] query;' then it will display the full query plan instead of just a summary. 
--explain verbose distinct * from customer -- Not working 

 -- 2) softdelete - Soft deletion means you don’t actually delete the record instead you are marking the record as deleted, but in actual it remains in the database, but it consumes space
   -- Harddelete - Hard deletion means data is physically deleted from the database table.
   -- Eg: When we update the table, it softdelete the previous records and then it update the table. Eg for harddelete is truncating the table. 
 -- 3) Case Statement - While the update statement is increasing the space in the table, we will use the case statement.  
 -- 4) Truncate vs delete - The TRUNCATE statement is typically far more efficient than using the DELETE statement with no WHERE clause to empty the table. TRUNCATE requires fewer resources and less logging overhead
  -- Instead of creating and dropping the entire table each time, try to use truncate as it will keep the table structure and properties intact. One disadvantage is that Truncate frees up space and impossible to rollback as truncate is doing the harddelete on data. 
 -- 5) String functions - Patten Operations : Whenever possible use LIKE statements in place of REGEX expressions. Do not use ‘Similar To’ statements, instead use Like and Regex
  -- Avoid unnecessary string operations such as replace, upper, lower etc. 
  -- String Operations - Use trim instead of replace whenever possible. Avoid unnecessary String columns. For eg. Use date formats instead of string for dates
 -- 6) Joins - The incorrect joins statement can increase the data size by 10 to 100 times. Best pratices - Use subqueries to select only the required fields from the tables, 
  -- Avoid one to many joins by mentioning Group by clause on the matching fields
 -- 7) Schema - A schema is a collection of database objects associated with one particular database. You may have one or multiple schemas in a database.
  -- Suppose their are different teams in the company and wanted to use the same database, then suppose if one team wanted to chaneg the data, but it should not affect the original database, so in this case they will form the schema and do it. 
  -- To organize database objects into logical groups to make them more manageable. Also suppose with the help of schemas we can have same name for 2 tables in the same database. 
  -- To acess the table / object from particular schema - syntax - schema_name.table_name. Syntax of creating schema - CREATE SCHEMA schema_name. 
  -- To create new table in the schema - create schema_name.table 
create schema test 
create table test.customer as select * from customer -- To create the object in the test schema. We are using subquery to extract all data from original customer table. 
select * from test.customer -- To acess the table/object from test schema. 

-- For Primary key, foriegn key (lec - 82) and acid compilance (lect - 83), refer the video and PPT as it contains the theory only. 
