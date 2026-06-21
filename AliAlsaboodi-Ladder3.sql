-- Joins
-- 
-- 62) Which employee made which sale? Join the `employees` table onto the `transactions` table by `employee_id`. You only need to include the employee's first/last name from `employees`.
select firstname, lastname, order_id from employees join transactions on transactions.employee_id = employees.ID group by order_id

-- 63) What is the name of the employee who made the most in sales? Find this answer by doing a join as in the previous problem. Your resulting query will be difficult for someone else to read.
select  firstname, lastname, sum(unit_price*quantity) as totalsales from employees join transactions on transactions.employee_id = employees.ID group by employee_id order by totalsales desc limit 1

-- 64) Solve the previous problem by joining `employees` onto the `trans_by_employee` view.
select  firstname, lastname, total_cost as totalsales from employees join trans_by_employee on trans_by_employee.employee_id = employees.ID group by employee_id order by totalsales desc limit 1

-- 65) Next, the company will try to give bonuses based on performance. Show all employees who've made more in sales than 1.5 times their salary.
select firstname, lastname, salary, total_cost as totalsales from employees join trans_by_employee on trans_by_employee.employee_id = employees.ID where totalsales > salary*1.5

-- 66) Do we have potentially erroneous rows? Find all transactions which occurred _before_ the employee was even hired! (Make sure each transaction only occupies one row).
select DISTINCT order_id,firstname, lastname, startdate, orderdate from employees join transactions on transactions.employee_id = employees.ID where orderdate < startdate

-- 67) Among all transactions that occurred from 2015 to 2019, create a table that is the monthly revenue of our company versus the total trading volume of Yum! in that month. Format the columns nicely. (Hint: look at the views) That is, a sample row of your result might look like this:
-- 
-- ```
-- | year | month | company_revenue | yum_trade_volume |
-- |------|-------|-----------------|------------------|
-- | 2017 |    03 |        $100,000 |      125,000,000 |
-- ```
-- 
-- * _Hint:_ You don't need any `WHERE` statements here. You can get the right answer simply by changing what kind of join you do!
select trans_by_month.year, trans_by_month.month, printf('$%,0.f',trans_by_month.total_cost) as company_revenue, printf('$%,0.f',yum_by_month.tot_volume) as yum_trade_volume from trans_by_month join yum_by_month on trans_by_month.year = yum_by_month.year and trans_by_month.month = yum_by_month.month