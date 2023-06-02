-- ##DAY ONE## --
-- selecting the schema to use
USE sql_mastery;

-- creating a table
CREATE TABLE Customer (
	CustomerID int PRIMARY KEY,
    CustomerName varchar(50),
    LastName varchar(50),
    Country varchar(50),
    Age int,
    Phone int
);


INSERT INTO customer VALUES
(1, 'Shubham', 'Thakur', 'India', '23', 0773125457),
(2, 'Aman', 'Chopra', 'Australia', 21, 0774123456),
(3, 'Naveen', 'Tulasi', 'Sri lanka', '24', 0772145897),
(4, 'Aditya', 'Arpran', 'Austria', 21, 0771568781),
(5, 'Nishant. Salichichas S.A', 'Jain', 'Spain', 22, 0784978320);

SELECT *
FROM customer;

-- creating a table using another table
CREATE TABLE subtable AS
	SELECT CustomerID, CustomerName
	FROM customer;
    
SELECT *
FROM subtable;

-- ### DAY TWO ##### ---

SELECT *
FROM customer;

SELECT CustomerName, LastName
FROM customer;

SELECT CustomerName
FROM customer
WHERE Age = 21;

SELECT COUNT(COuntry), LastName
FROM customer
GROUP BY CustomerID;

CREATE TABLE employee (
	EmployeeID int PRIMARY KEY,
    Name varchar(50),
    Gender varchar(50),
    Salary int,
    Department varchar(50),
    Experience varchar(50)
);

INSERT INTO employee VALUES
(1, 'Racht', 'M', 50000, 'Engineering', '6 year'),
(2, 'Shobit', 'M', 37000, 'HR', '3 year'),
(3, 'Isha', 'F', 56000, 'Sales', '7 year'),
(4, 'Devi', 'F', 43000, 'Management', '4 year'),
(5, 'Akhil', 'M', 90000, 'Engineering', '15 year');

SELECT *
FROM employee;

-- Showing the sum of salaries by department where salaries are greater than or equal to 50000 --
SELECT
	Department,
    SUM(Salary) Salary
FROM employee
GROUP BY Department
HAVING SUM(Salary) >= 50000;

SELECT *
FROM customer
ORDER BY Age DESC;

SELECT *
FROM customer
WHERE Age = 24;

SELECT *
FROM customer
WHERE AGE > 21;

SELECT *
FROM customer
WHERE Age BETWEEN 22 AND 24;

SELECT *
FROM customer
WHERE CustomerName LIKE 'S%';

SELECT *
FROM customer
WHERE CustomerName LIKE '%M%';

-- In works as a substitute for BETWEEN??? --
SELECT *
FROM customer
WHERE Age IN (21, 23);

CREATE TABLE GFG_employees (
	id int,
    name varchar (50),
    email varchar (50),
    department varchar (50)
);

INSERT INTO gfg_employees VALUES
(1, 'Jessie', 'jessie23@gmail.com', 'Development'),
(2, 'Praveen', 'praveen.dagger@yahoo.com', 'HR'),
(3, 'Bisa', 'dragonBall@gmail.com', 'Sales'),
(4, 'Rithvik', 'msvv@hotmail.com', 'IT'),
(5, 'Suraj', 'srjsunny@gmail.com', 'Qaulity Assurance'),
(6, 'Om', 'OmShukia@yahoo.com', 'IT'),
(7, 'Naruto', 'uzumaki@ykonoha.com', 'Development');


SELECT *
FROM gfg_employees;

-- Deleting rows with name = 'Rithvik'
DELETE FROM gfg_employees
WHERE name = 'Rithvik';

SELECT *
FROM gfg_employees;

DELETE FROM gfg_employees
WHERE department = 'Development';

-- Deleting all records
DELETE FROM gfg_employees;

DROP TABLE gfg_employees;

CREATE TABLE student (
	ROLL_NO int,
    NAME varchar (50),
    ADDRESS varchar (50),
    PHONE varchar,
    AGE int
);

INSERT INTO student VALUES
(1, 'Ram', 'Delhi', '123456', 18),
(2, 'RAMESH', 'GURGAON', '1548979', 18),
(3, 'SUJIT', 'ROHTAK', '9856245', 20),
(4, 'SURESH', 'ROHTAK', '0013299', 18),
(3, 'SUJIT', 'ROHTAK', '986320156', 20),
(2, 'RAMESH', 'GURGAON', '97956220', 18);

-- Inserting new data into the table --

INSERT INTO student VALUES
(5, 'HARSH', 'WEST BENGAL', 79600000, 19);

SELECT *
FROM student;

-- insert into specified columns

INSERT INTO student (ROLL_NO, NAME, AGE) VALUES
(5, 'PATRIK', 19);

CREATE TABLE lateral_student (
	ROLL_NO int,
    NAME varchar (50),
    ADDRESS varchar (50),
    PHONE int,
    AGE int
);

INSERT INTO lateral_student VALUES
(7, 'SOUVIK', 'HYDERABAD', 66321546, 18),
(8, 'NIRAJ', 'NOIDA', 8552255, 19),
(9, 'SOMESH', 'ROHTAK', 00002555, 20);

SELECT *
FROM lateral_student;

-- Inserting data from another table

INSERT INTO student
SELECT * 
FROM lateral_student;

SELECT *
FROM student;

-- inserting specific columns from another table

INSERT INTO student (ROLL_NO, NAME, AGE)
SELECT ROLL_NO, NAME, AGE 
FROM lateral_student;

-- ###DAY THREE #####  ----

SELECT *
FROM student
WHERE Age = 18 AND ADDRESS = 'Delhi';

SELECT *
FROM student
WHERE Age = 18 AND NAME = 'Ram';

SELECT *
FROM student
WHERE NAME = 'Ram' OR NAME = 'SUJIT';

SELECT *
FROM student
WHERE NAME = 'Ram' OR AGE = 20;

SELECT *
FROM student
WHERE AGE = 18 AND (NAME = 'Ram' OR NAME = 'RAMESH');


DROP TABLE lateral_student;

-- Drop is used to delete the whole table while truncate is used to delete data inside the table --

TRUNCATE TABLE student;

-- TRUNCATE deletes the data inside the table and leaves the columns ---


CREATE TABLE customers (
	CustomerID int,
    CustomerName varchar (50),
    City varchar (50),
    PostalCode varchar (50),
    Country varchar (50)
);

INSERT INTO customers VALUES
(1, 'John Wick', 'New York', '1248', 'USA'),
(2, 'Around the Horn', 'London', 'WA1 1DP', 'UK'),
(3, 'Rohan', 'New Dehli', '10084', 'India');

SELECT *
FROM customers
WHERE NOT Country = 'UK';

SELECT *
FROM customers
WHERE NOT Country='USA' AND NOT Country='UK';

-- altarnatively the NOT operator can be written like <>

SELECT *
FROM customers
WHERE Country <> 'USA';

-- WITH CLAUSE ---
DROP TABLE employee;

CREATE TABLE employee (
	EmployeeID int,
    Name varchar(50),
    Salary int
);

INSERT INTO employee VALUES
(100011, 'Smith', 50000),
(100022, 'Bill', 94000),
(100027, 'Sam', 70550),
(100845, 'Walden', 80000),
(115585, 'Erik', 60000),
(110070, 'Kate', 69000);

SELECT *
FROM employee;

-- finding the employee whose salary is more than the average salary of all employees
WITH tempTable (averageValue) AS
	(SELECT avg(Salary)
    FROM employee)
SELECT EmployeeID, Name, Salary
FROM employee, tempTable
WHERE employee.Salary > tempTable.averageValue;

CREATE TABLE pilot (
	EmployeeID int,
    Airline varchar(50),
    Name varchar(50),
    Salary int
);
INSERT INTO pilot VALUES
(70007, 'Airbus 380', 'Kim', 60000),
(70002, 'Boeing', 'Laura', 20000),
(10027, 'Airbus 380', 'Will', 80050),
(10778, 'Airbus 380', 'Warren', 80780),
(115585, 'Boeing', 'Smith', 25000),
(114070, 'Airbus 380', 'Katy', 78000);

SELECT *
FROM pilot;

-- find all airlines where the total salary of all pilots in the airline is more than
-- the average of total salary of all pilots in the database

WITH totalSalary (Airline, total) AS
	(SELECT Airline, SUM(Salary)
    FROM pilot
    GROUP BY Airline),
    Average(avgSalary) AS
    (SELECT AVG(Salary)
    FROM pilot)
SELECT Airline
FROM totalSalary, Average
WHERE totalSalary.total > Average.avgSalary;

-- OFFSET FUNCTION --
-- used to identify the starting point to return rows from a result set
-- It excludes the first set of records (first row)
-- can only be used with ORDER BY clause & value must be greater than or equal to zero
-- value cannot be negative

-- FETCH FUCNTION returns the specified number of rows from results set

-- ARITHMETIC FUNCTIONS

SELECT EmployeeID, Name, Salary, Salary+100 Increase
FROM employee;

SELECT EmployeeID, Name, Salary, Salary+EmployeeID AS SalaryEmp
FROM employee;

SELECT EmployeeID, Name, Salary, Salary-100 Decrease
FROM employee;

SELECT EmployeeID, Name, Salary, Salary * 100 AS Salaryx100
FROM employee;



---- ### DAY 4 ----------------

CREATE TABLE Client (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    LastName VARCHAR(50),
    Country VARCHAR(50),
    Age int(2),
  Phone int(10)
);
-- Insert some sample data into the Customers table
INSERT INTO Client VALUES
(1, 'Shubham', 'Thakur', 'India','23','00000000'),
(2, 'Aman ', 'Chopra', 'Australia','21','89532565'),
(3, 'Naveen', 'Tulasi', 'Sri lanka','24','1519616661'),
(4, 'Aditya', 'Arpan', 'Austria','21','7976656595'),
(5, 'Nishant. Salchichas S.A.', 'Jain', 'Spain','22','2656211122');

DROP TABLE client;
DROP TABLE customer;

CREATE TABLE customer (
	CustomerID int,
    CustomerName varchar(50),
    LastName varchar(50),
    Country varchar(50),
    Age int,
    Phone int
);
INSERT INTO customer VALUES
(1, 'Shubam', 'Thakur', 'India', 23, 012345678),
(2, 'Aman', 'Chopra', 'Australia', 21, 235647995),
(3, 'Naveen', 'Tulasi', 'Sri Lanka', 24, 00000000),
(4, 'Aditya', 'Arpan', 'Australia', 21, 999855555),
(5, 'Nishant. Salchichas S.A', 'Jain', 'Spain', 22, 546889565);

SELECT *
FROM customer;

SELECT *
FROM customer
WHERE CustomerName LIKE 'A%';

SELECT *
FROM customer
WHERE CustomerName LIKE '%A';

SELECT *
FROM customer
WHERE CustomerName LIKE '%A%';

-- to fetch records from table where LastName containing a, b, or c
-- use of REGEXP function
SELECT *
FROM customer
WHERE LastName REGEXP '[A-C]';

-- records of LastName not containing y or z
SELECT *
FROM customer
WHERE LastName NOT LIKE '%[y-z]%';

-- records where country containing a total of 7 characters
SELECT *
FROM customer
WHERE Country LIKE '_______';

-- UPDATE used ot update the data of an existing table in a database
-- UPDATE and DELETE used to change data that is alrady there

SELECT *
FROM customer;

UPDATE customer
SET CustomerName = 'Nitin' WHERE Age = 22;

UPDATE customer
SET CustomerName = 'Satyam' WHERE Country = 'India' AND CustomerID = 1;

ALTER TABLE customer ADD
(Planet varchar(50), Kupenga int(3));

SELECT *
FROM customer;

ALTER TABLE customer
MODIFY Planet varchar (20);

ALTER TABLE customer
DROP COLUMN Kupenga;

SELECT CustomerName, Age,
CASE
	WHEN Age> 22 THEN 'The Age is greater than 20'
    WHEN Age= 21 THEN 'The Age is 21'
    ELSE 'The Age is over 30'
END AS AgeText
FROM customer;

-- UNION clause used to combine two select statements

DROP TABLE student;

CREATE TABLE students (
  roll_no INT,
  address VARCHAR(255),
  name VARCHAR(255),
  phone VARCHAR(20),
  age INT
);
INSERT INTO students (roll_no, address, name, phone, age)
VALUES
  (1, '123 Main St, Anytown USA', 'John Doe', '555-1234', 20),
  (2, '456 Oak St, Anytown USA', 'Jane Smith', '555-5678', 22),
  (3, '789 Maple St, Anytown USA', 'Bob Johnson', '555-9012', 19),
  (4, '234 Elm St, Anytown USA', 'Sarah Lee', '555-3456', 21),
  (5, '567 Pine St, Anytown USA', 'David Kim', '555-7890', 18);
  
SELECT *
FROM students;

CREATE TABLE student_details (
  roll_no INT,
  branch VARCHAR(50),
  grade VARCHAR(2)
);
INSERT INTO student_details (roll_no, branch, grade)
VALUES 
  (1, 'Computer Science', 'A'),
  (2, 'Electrical Engineering', 'B'),
  (3, 'Mechanical Engineering', 'C');
  
SELECT *
FROM student_details;

-- TO fetch DISTINCT ROLL_NO from STudent_details table
SELECT roll_no
FROM students
UNION
SELECT roll_no
FROM student_details;

-- to fetch the ROLL_NO from student WHERE ROLL_NO is greater than 3
-- and ROLL_NO from student_details WHERE ROLL_NO is less than 3

SELECT roll_no, name
FROM students
WHERE roll_no > 3
UNION ALL
Select roll_no, branch
FROM student_details 
WHERE roll_no < 3
ORDER BY 1
