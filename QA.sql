use bank_loandb;
select *from finance_1;
select *from finance_2;

---------------------------------------------------------# KPI
select count(distinct id) as total_no_of_loan_application, sum(loan_amnt) as Total_loan_amnt, sum(funded_amnt) as Total_loan_amnt, 
avg(int_rate) as Avg_int_rate, avg(annual_inc) as Avg_annual_income, Avg(dti) as Avg_DTI 
from finance_1;

---------------------------------------------------------# loan application analysis 

# Year-Wise Loan application
select year(issue_d) ,count(distinct id)
from finance_1
group by year(issue_d);

# emp_len_year-Wise Loan application 
select emp_len_year, count(distinct id)
from finance_1
group by emp_len_year;

# Purpose-Wise Loan application 
select purpose, count(distinct id)
from finance_1
group by purpose;

# subgrade-Wise Loan application
select sub_grade, count(distinct id)
from finance_1
group by sub_grade;

# State-Wise loan application 
select addr_state, count(distinct id)
from finance_1
group by addr_state;

# loan status-Wise loan application 
select loan_status, count(distinct id)
from finance_1
group by loan_status;

---------------------------------------------------------# loan Amount analysis 

# Year-Wise Loan application
select year(issue_d) ,sum(loan_amnt)
from finance_1
group by year(issue_d);

# emp_len_year-Wise Loan application 
select emp_len_year, sum(loan_amnt)
from finance_1
group by emp_len_year;

# Purpose-Wise Loan application 
select purpose, sum(loan_amnt)
from finance_1
group by purpose;

# subgrade-Wise Loan application
select sub_grade, sum(loan_amnt)
from finance_1
group by sub_grade;

# State-Wise loan application 
select addr_state, sum(loan_amnt)
from finance_1
group by addr_state;

# loan status-Wise loan application 
select loan_status, sum(loan_amnt)
from finance_1
group by loan_status;

---------------------------------------------------------# Funded Amount analysis 

# Year-Wise Loan application
select year(issue_d) ,sum(funded_amnt)
from finance_1
group by year(issue_d);

# emp_len_year-Wise Loan application 
select emp_len_year, sum(funded_amnt)
from finance_1
group by emp_len_year;

# Purpose-Wise Loan application 
select purpose, sum(funded_amnt)
from finance_1
group by purpose;

# subgrade-Wise Loan application
select sub_grade, sum(funded_amnt)
from finance_1
group by sub_grade;

# State-Wise loan application 
select addr_state, sum(funded_amnt)
from finance_1
group by addr_state;

# loan status-Wise loan application 
select loan_status, sum(funded_amnt)
from finance_1
group by loan_status;
