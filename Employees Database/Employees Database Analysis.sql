# Analysis of the employees Database

-- QN: Find the average salary of the male and female employees in each department

USE employees;

SELECT 
    AVG(salary), e.gender, de.dept_name
FROM
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no
        JOIN
    dept_emp d ON d.emp_no = e.emp_no
        JOIN
    departments de ON de.dept_no = d.dept_no
GROUP BY e.gender , de.dept_name
ORDER BY de.dept_no;


-- QN Find the lowest department number encountered in the 'dept_emp' table. The find the highest department number

-- select * from dept_emp;

SELECT 
    MIN(dept_no)
FROM
    dept_emp;

SELECT 
    MAX(dept_no)
FROM
    dept_emp;


-- QN: Obtain a table containing the following three fields for all individuals whose employee number is not greater than 10040:
#  employee number
# the lowest department number among the departents where the employee has worked in (hint: use the subquery to retriev the value from the 'dept_emp' table)
# assign '110022' as 'manager' to all individuals whose employee number is lower than or equel to 10020 and '110039' to those whose number is between 10021 and 10040 inclusive
# USE CASE statement to create the third field

# if you have worked correctly, you should obtain an output containing 40 rows.


SELECT 
    emp_no,
    (SELECT 
            MIN(dept_no)
        FROM
            dept_emp de
        WHERE
            e.emp_no = de.emp_no) dept_no,
    CASE
        WHEN emp_no <= 10020 THEN '110022'
        ELSE '110039'
    END AS manager
FROM
    employees e
WHERE
    emp_no <= 10040;


-- QN Retriev a list of all employees that have been hired in 2000

select * 
from employees 
where year(hire_date) = 2000;


select * 
from employees 
where hire_date = 2000;

use employees;

-- QN Retrieve a list of all employees from the ‘titles’ table who are engineers.
-- Repeat the exercise, this time retrieving a list of all employees from the ‘titles’ table who are senior engineers.
-- After LIKE, you could indicate what you are looking for with or without using parentheses. Both options are correct and will deliver the same output.
-- We think using parentheses is better for legibility and that’s why it is the first option we’ve suggested.

SELECT 
    *
FROM
    titles
WHERE
    title LIKE '%engineer%';

SELECT 
    *
FROM
    titles
WHERE
    title = ('%Senior Engineer%');

SELECT 
    *
FROM
    titles
WHERE
    title LIKE '%Senior Engineer%'

# use of like considered better for legibility but  both answers correct


-- QN Create a procedure that asks you to insert an employee number and that will obtain an output containing the same number, as well as the number and name of the last department the employee has worked in.
-- Finally, call the procedure for employee number 10010.
-- If you've worked correctly, you should see that employee number 10010 has worked for department number 6 - "Quality Management".


# so this is requirement for stored procedure with an input parameter


delimiter $$
use employees $$
create procedure emp_dept(in p_emp_no Integer)
begin
	select e.emp_no, de.dept_no, de.dept_name
    from employees e
    join dept_emp d on d.emp_no = e.emp_no
    join departments de on de.dept_no = d.dept_no
    where e.emp_no = p_emp_no;
end $$

delimiter ;

-- required/given solution
DROP procedure IF EXISTS last_dept;

DELIMITER $$
CREATE PROCEDURE last_dept (in p_emp_no integer)
BEGIN
SELECT
    e.emp_no, d.dept_no, d.dept_name
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
        JOIN
    departments d ON de.dept_no = d.dept_no
WHERE
    e.emp_no = p_emp_no
        AND de.from_date = (SELECT
            MAX(from_date)
        FROM
            dept_emp
        WHERE
            emp_no = p_emp_no);
END$$
DELIMITER ;


-- How many contracts have been registered in the ‘salaries’ table with duration of more than one year and of value higher than or equal to $100,000?
-- Hint: You may wish to compare the difference between the start and end date of the salaries contracts

SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    salary >= 100000
        AND DATEDIFF(to_date, from_date) > 365;
        
# to note, the 'how many' indictaes count..




























