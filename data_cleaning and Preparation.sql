use bank_loandb;

select *from finance_1;
describe finance_1;
set SQL_safe_updates = 0;

select distinct id from finance_1;
alter table finance_1 
modify column id varchar(7) primary key;

select distinct member_id from finance_1;
alter table finance_1 
modify column member_id char(7) unique not null;

select *from finance_1
where loan_amnt =' ' or loan_amnt is null;
alter table finance_1 
modify column loan_amnt int not null;

select *from finance_1
where funded_amnt =' ' or funded_amnt is null;
alter table finance_1 
modify column funded_amnt int not null;

select *from finance_1
where funded_amnt_inv is null;
alter table finance_1 
modify column funded_amnt_inv int not null;

select distinct substring_index(term,' ',1) as int_rate1 from finance_1;
update finance_1
set term = substring_index(term,' ',1);
alter table finance_1 
rename column term to term_months;
alter table finance_1
modify column term_months int not null;

select *from finance_1
where int_rate = ' ' or int_rate is null;
select substring_index(int_rate,'%',1) as int_rate1 from finance_1;

update finance_1 
set int_rate = substring_index(int_rate,'%',1);

select *from finance_1 where int_rate is null;
alter table finance_1 
modify column int_rate float not null;


select *from finance_1 where installment is null;
alter table finance_1 
modify column installment float not null;

select *from finance_1
where grade is null or sub_grade is null or grade = ' ' or sub_grade = ' ';
select distinct grade from finance_1;
alter table finance_1 
modify column grade enum('A','D','B','C','F','G','E'),
modify column sub_grade char(2) not null;

select distinct emp_title from finance_1;
select *from finance_1 where emp_title = '' or emp_title is null;
update finance_1 
set emp_title = null 
where emp_title = '';
select *from finance_1;

select column_name, data_type, character_maximum_length
from information_schema.columns 
where table_name = 'finance_1'
and column_name = 'emp_title';

select distinct emp_length from finance_1;
update finance_1 
set emp_length = '0 years' 
where emp_length = '< 1 year';
update finance_1 
set emp_length = '11 years' 
where emp_length = '10+ years';
update finance_1 
set emp_length = null 
where emp_length = 'n/a';
---# here 0 means less than 1 year and 11 means more than 10 years 

select distinct substring_index(emp_length,' ',1) as emp from finance_1 order by emp;
update finance_1
set emp_length = substring_index(emp_length,' ',1);

alter table finance_1 
rename column emp_length to emp_len_year;
alter table finance_1 
modify column emp_len_year enum('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11');


select distinct home_ownership from finance_1;
alter table finance_1 
modify column home_ownership enum('RENT','MORTGAGE','OWN','NONE','OTHER') not null;

select distinct verification_status from finance_1;
alter table finance_1 
modify column verification_status enum('Source Verified','Verified','Not Verified') not null;


select distinct issue_d from finance_1;

select distinct substring_index(issue_d,'/',1) as months from finance_1;
select distinct substring_index(substring_index(issue_d,'/',-2),'/',1) as years from finance_1;

alter table finance_1
add column dates text after issue_d;

update finance_1 
set dates = concat('20',substring_index(substring_index(issue_d,'/',-2),'/',1), '-', substring_index(issue_d,'/',1), '-', '01');

alter table finance_1 
drop column issue_d;
alter table finance_1 
rename column dates to issue_d;
alter table finance_1 
modify column issue_d date not null;


select distinct loan_status from finance_1;
alter table finance_1 
modify column loan_status enum('Current','Fully Paid','Charged Off') not null;


select distinct pymnt_plan from finance_1;
alter table finance_1 
drop column pymnt_plan;


alter table finance_1
rename column `desc` to desc_;
select *from finance_1 where desc_ is null or desc_ = '';
update finance_1 
set desc_ = null 
where desc_ = '';


select distinct purpose from finance_1;
alter table finance_1 
modify column purpose varchar(25) not null;

select distinct title from finance_1;
alter table finance_1 
modify column title varchar(100) not null;


alter table finance_1
modify column zip_code char(5) not null; 

alter table finance_1 
modify column addr_state char(2) not null; 

alter table finance_1 
modify column dti float not null;


select distinct id from finance_2;
alter table finance_2 
modify column id varchar(7) primary key;

select distinct delinq_2yrs from finance_2;
alter table finance_2 
modify column delinq_2yrs tinyint not null;

select str_to_date(earliest_cr_line, '%m/%d/%Y') as new_date from finance_2;
update finance_2 
set earliest_cr_line = str_to_date(earliest_cr_line,'%m/%d/%Y');

select distinct inq_last_6mths from finance_2;
alter table finance_2
modify column inq_last_6mths tinyint not null;


select distinct mths_since_last_delinq from finance_2;
update finance_2 
set mths_since_last_delinq = null 
where mths_since_last_delinq = 'NA';
alter table finance_2 
modify column mths_since_last_delinq tinyint unsigned ;
select *from finance_2 where mths_since_last_delinq is null;

select distinct mths_since_last_record from finance_2;
update finance_2 
set mths_since_last_record = null 
where mths_since_last_record = 'NA';
alter table finance_2 
modify column mths_since_last_record tinyint unsigned ;
select *from finance_2 where mths_since_last_record is null;


select distinct open_acc from finance_2;
alter table finance_2 
modify column open_acc tinyint unsigned not null;

select distinct pub_rec from finance_2;
alter table finance_2
modify column pub_rec enum('1','2','3','4','0') not null;


select *from finance_2 where revol_bal = '';
select distinct substring_index(revol_util,'%',1) from finance_2;
update finance_2
set revol_util = substring_index(revol_util,'%',1);
update finance_2 
set revol_util = round(revol_util,2);
alter table finance_2 
modify column revol_util float not null;


select distinct total_acc from finance_2;
alter table finance_2
modify column total_acc tinyint not null;

select distinct initial_list_status from finance_2;
alter table finance_2 
drop column initial_list_status;


alter table finance_2 
modify column total_pymnt double not null,
modify column total_pymnt_inv double not null,
modify column total_rec_prncp double not null,
modify column total_rec_int double not null;

select distinct  total_rec_late_fee from finance_2;
select *  from finance_2 where total_rec_late_fee = 0;

select distinct  recoveries from finance_2;
select *  from finance_2 where recoveries = 0;

select distinct  collection_recovery_fee from finance_2;
select *  from finance_2 where collection_recovery_fee = 0;

alter table finance_2 
modify column total_rec_late_fee tinyint unsigned not null,
modify column collection_recovery_fee int not null,
modify column recoveries int not null;


update finance_2
set last_pymnt_d =  case 
	when last_pymnt_d != '' then str_to_date(last_pymnt_d,'%m/%d/%Y')
	else null
end;

update finance_2 
set next_pymnt_d = case 
	when next_pymnt_d != '' then str_to_date(next_pymnt_d,'%m/%d/%Y')
    else null
end;

update finance_2
set last_credit_pull_d = case 
	when last_credit_pull_d != '' then str_to_date(last_credit_pull_d,'%m/%d/%Y')
    else null
end;

select *from finance_2;
describe finance_2;

alter table finance_2
modify column earliest_cr_line  date;
alter table finance_2
modify column last_pymnt_d date,
modify column next_pymnt_d date,
modify column last_credit_pull_d date;

select *from finance_2 where last_pymnt_amnt is null;
alter table finance_2
modify column last_pymnt_amnt double not null;