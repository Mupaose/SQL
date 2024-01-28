use bank;

select * from account;
select * from branch;
select * from card;
select * from customer;
select * from customer_branch;
select * from loan;
select * from loan_type;
select * from transaction;


-- Identifying the customers by their branch
select c.id, c.first_name, c.last_name, b.name
from customer c
join branch b
	on b.id = c.id;

-- identify the customers by their branch, card and account numbers
select c.id, c.first_name, c.last_name, b.name branch_name, ca.number card_number
from customer c
join branch b 
	on b.id = c.id
join card ca
	on ca.id = c.id
order by c.id;

-- how much loans customer have grouped from highest to lowest
select c.first_name, c.last_name, lt.type, lt.base_amount, l.start_date, l.due_date
from customer c
join branch b
	on b.id = c.id
join loan l
	on l.id = c.id
join loan_type lt
	on lt.id = l.id
order by lt.base_amount DESC;

-- calculate the accumlative interest and remaining balances on customer loan accounts
-- interest calculated by multiplying the principal amount by the interest rate and the period

select c.id, c.first_name, c.last_name, lt.type, lt.base_amount, l.amount_paid, (lt.base_amount - l.amount_paid) as balance, lt.base_interest_rate, cast(base_amount * (base_interest_rate/100) as decimal(6,2)) as interest
from customer c
join branch b
    on b.id = c.id
join loan l
	on l.id = c.id
join loan_type lt
	on lt.id = l.id
order by interest DESC;

-- subquery nested inside where
select c.first_name, c.last_name 
from customer c
where c.id IN ( select b.id from branch b);

# Create a procedure that asks you to insert an customer id to obtain an output containing the same number, 
-- as well as the name, branch and location of the last branch the customer used.
# Finally, call the procedure for customer 4.

delimiter $$
create procedure last_branch (in c_id integer)
begin
select c.id, c.first_name, c.last_name, b.name, b.address
from customer c
join branch b
	on b.id = c.id
where c.id = c_id;

end$$
delimiter ;

call last_branch(4);

-- obtain a table containing the following fields for a clients:
-- 1. customer information
-- 2. loan information
-- 3. branch information
-- 4. the branch with the smallest loan by customer
-- 5. assign "Kodling Bank' aas the main local loan processing branch for all loan amounts less than or equal to 5000 and the rest being processed at the head office

-- use of CTEs and CASE Statements and nested subqueires

WITH 
customer_info as (
select id, first_name, last_name, gender
from customer),

loan_info as (
select id, type, base_amount, description
from loan_type
order by base_amount desc),

branch_info as (
select id, name, address
from branch)

select c.first_name, c.last_name, b.name, b.address, l.type, l.base_amount,
case when l.base_amount <= 5000 then 'Kolding Bank'
else 'Head Office' end as loans
from customer_info c
join branch_info b
	on b.id = c.id
join loan_info l
	on b.id = l.id;
    













