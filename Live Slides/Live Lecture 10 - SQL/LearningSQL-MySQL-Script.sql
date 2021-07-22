 

    create table ACCOUNT (
        ACCOUNT_ID integer not null auto_increment,
        AVAIL_BALANCE float,
        CLOSE_DATE date,
        LAST_ACTIVITY_DATE date,
        OPEN_DATE date not null,
        PENDING_BALANCE float,
        STATUS varchar(10),
        CUST_ID integer,
        OPEN_BRANCH_ID integer not null,
        OPEN_EMP_ID integer not null,
        PRODUCT_CD varchar(10) not null,
        primary key (ACCOUNT_ID)
    );

    create table ACC_TRANSACTION (
        TXN_ID bigint not null auto_increment,
        AMOUNT float not null,
        FUNDS_AVAIL_DATE datetime not null,
        TXN_DATE datetime not null,
        TXN_TYPE_CD varchar(10),
        ACCOUNT_ID integer,
        EXECUTION_BRANCH_ID integer,
        TELLER_EMP_ID integer,
        primary key (TXN_ID)
    );

    create table BRANCH (
        BRANCH_ID integer not null auto_increment,
        ADDRESS varchar(30),
        CITY varchar(20),
        NAME varchar(20) not null,
        STATE varchar(10),
        ZIP_CODE varchar(12),
        primary key (BRANCH_ID)
    );

    create table BUSINESS (
        INCORP_DATE date,
        NAME varchar(255) not null,
        STATE_ID varchar(10) not null,
        CUST_ID integer not null,
        primary key (CUST_ID)
    );

    create table CUSTOMER (
        CUST_ID integer not null auto_increment,
        ADDRESS varchar(30),
        CITY varchar(20),
        CUST_TYPE_CD varchar(1) not null,
        FED_ID varchar(12) not null,
        POSTAL_CODE varchar(10),
        STATE varchar(20),
        primary key (CUST_ID)
    );

    create table DEPARTMENT (
        DEPT_ID integer not null auto_increment,
        NAME varchar(20) not null,
        primary key (DEPT_ID)
    );

    create table EMPLOYEE (
        EMP_ID integer not null auto_increment,
        END_DATE date,
        FIRST_NAME varchar(20) not null,
        LAST_NAME varchar(20) not null,
        START_DATE date not null,
        TITLE varchar(20),
        ASSIGNED_BRANCH_ID integer,
        DEPT_ID integer,
        SUPERIOR_EMP_ID integer,
        primary key (EMP_ID)
    );

    create table INDIVIDUAL (
        BIRTH_DATE date,
        FIRST_NAME varchar(30) not null,
        LAST_NAME varchar(30) not null,
        CUST_ID integer not null,
        primary key (CUST_ID)
    );

    create table OFFICER (
        OFFICER_ID integer not null auto_increment,
        END_DATE date,
        FIRST_NAME varchar(30) not null,
        LAST_NAME varchar(30) not null,
        START_DATE date not null,
        TITLE varchar(20),
        CUST_ID integer,
        primary key (OFFICER_ID)
    );

    create table PRODUCT (
        PRODUCT_CD varchar(10) not null,
        DATE_OFFERED date,
        DATE_RETIRED date,
        NAME varchar(50) not null,
        PRODUCT_TYPE_CD varchar(255),
        primary key (PRODUCT_CD)
    );

    create table PRODUCT_TYPE (
        PRODUCT_TYPE_CD varchar(255) not null,
        NAME varchar(50),
        primary key (PRODUCT_TYPE_CD)
    );

    alter table ACCOUNT 
        add constraint ACCOUNT_CUSTOMER_FK 
        foreign key (CUST_ID) 
        references CUSTOMER (CUST_ID);

    alter table ACCOUNT 
        add constraint ACCOUNT_BRANCH_FK 
        foreign key (OPEN_BRANCH_ID) 
        references BRANCH (BRANCH_ID);

    alter table ACCOUNT 
        add constraint ACCOUNT_EMPLOYEE_FK 
        foreign key (OPEN_EMP_ID) 
        references EMPLOYEE (EMP_ID);

    alter table ACCOUNT 
        add constraint ACCOUNT_PRODUCT_FK 
        foreign key (PRODUCT_CD) 
        references PRODUCT (PRODUCT_CD);

    alter table ACC_TRANSACTION 
        add constraint ACC_TRANSACTION_ACCOUNT_FK 
        foreign key (ACCOUNT_ID) 
        references ACCOUNT (ACCOUNT_ID);

    alter table ACC_TRANSACTION 
        add constraint ACC_TRANSACTION_BRANCH_FK 
        foreign key (EXECUTION_BRANCH_ID) 
        references BRANCH (BRANCH_ID);

    alter table ACC_TRANSACTION 
        add constraint ACC_TRANSACTION_EMPLOYEE_FK 
        foreign key (TELLER_EMP_ID) 
        references EMPLOYEE (EMP_ID);

    alter table BUSINESS 
        add constraint BUSINESS_EMPLOYEE_FK 
        foreign key (CUST_ID) 
        references CUSTOMER (CUST_ID);

    alter table EMPLOYEE 
        add constraint EMPLOYEE_BRANCH_FK 
        foreign key (ASSIGNED_BRANCH_ID) 
        references BRANCH (BRANCH_ID);

    alter table EMPLOYEE 
        add constraint EMPLOYEE_DEPARTMENT_FK 
        foreign key (DEPT_ID) 
        references DEPARTMENT (DEPT_ID);

    alter table EMPLOYEE 
        add constraint EMPLOYEE_EMPLOYEE_FK 
        foreign key (SUPERIOR_EMP_ID) 
        references EMPLOYEE (EMP_ID);

    alter table INDIVIDUAL 
        add constraint INDIVIDUAL_CUSTOMER_FK 
        foreign key (CUST_ID) 
        references CUSTOMER (CUST_ID);

    alter table OFFICER 
        add constraint OFFICER_CUSTOMER_FK 
        foreign key (CUST_ID) 
        references CUSTOMER (CUST_ID);

    alter table PRODUCT 
        add constraint PRODUCT_PRODUCT_TYPE_FK 
        foreign key (PRODUCT_TYPE_CD) 
        references PRODUCT_TYPE (PRODUCT_TYPE_CD);


 

-- begin data population


-- SET MODE -- 
-- http://stackoverflow.com/questions/11448068/mysql-error-code-1175-during-update-in-mysql-workbench
SET SQL_SAFE_UPDATES = 0;


-- department data  
insert into department (dept_id, name)
values (null, 'Operations');
insert into department (dept_id, name)
values (null, 'Loans');
insert into department (dept_id, name)
values (null, 'Administration');

insert into department (dept_id, name)
values (null, 'IT');

/* branch data */
insert into branch (branch_id, name, address, city, state, Zip_Code)
values (null, 'Headquarters', '3882 Main St.', 'Waltham', 'MA', '02451');
insert into branch (branch_id, name, address, city, state, Zip_Code)
values (null, 'Woburn Branch', '422 Maple St.', 'Woburn', 'MA', '01801');
insert into branch (branch_id, name, address, city, state, Zip_Code)
values (null, 'Quincy Branch', '125 Presidential Way', 'Quincy', 'MA', '02169');
insert into branch (branch_id, name, address, city, state, Zip_Code)
values (null, 'So. NH Branch', '378 Maynard Ln.', 'Salem', 'NH', '03079');

/* employee data */
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (null, 'Michael', 'Smith', '2001-06-22', 
  (select dept_id from department where name = 'Administration'), 
  'President', 
  (select branch_id from branch where name = 'Headquarters'));
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (null, 'Susan', 'Barker', '2002-09-12', 
  (select dept_id from department where name = 'Administration'), 
  'Vice President', 
  (select branch_id from branch where name = 'Headquarters'));
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (null, 'Robert', 'Tyler', '2000-02-09',
  (select dept_id from department where name = 'Administration'), 
  'Treasurer', 
  (select branch_id from branch where name = 'Headquarters'));
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (null, 'Susan', 'Hawthorne', '2002-04-24', 
  (select dept_id from department where name = 'Operations'), 
  'Operations Manager', 
  (select branch_id from branch where name = 'Headquarters'));
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (null, 'John', 'Gooding', '2003-11-14', 
  (select dept_id from department where name = 'Loans'), 
  'Loan Manager', 
  (select branch_id from branch where name = 'Headquarters'));
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (null, 'Helen', 'Fleming', '2004-03-17', 
  (select dept_id from department where name = 'Operations'), 
  'Head Teller', 
  (select branch_id from branch where name = 'Headquarters'));
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (null, 'Chris', 'Tucker', '2004-09-15', 
  (select dept_id from department where name = 'Operations'), 
  'Teller', 
  (select branch_id from branch where name = 'Headquarters'));
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (null, 'Sarah', 'Parker', '2002-12-02', 
  (select dept_id from department where name = 'Operations'), 
  'Teller', 
  (select branch_id from branch where name = 'Headquarters'));
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (null, 'Jane', 'Grossman', '2002-05-03', 
  (select dept_id from department where name = 'Operations'), 
  'Teller', 
  (select branch_id from branch where name = 'Headquarters'));
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (null, 'Paula', 'Roberts', '2002-07-27', 
  (select dept_id from department where name = 'Operations'), 
  'Head Teller', 
  (select branch_id from branch where name = 'Woburn Branch'));
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (null, 'Thomas', 'Ziegler', '2000-10-23', 
  (select dept_id from department where name = 'Operations'), 
  'Teller', 
  (select branch_id from branch where name = 'Woburn Branch'));
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (null, 'Samantha', 'Jameson', '2003-01-08', 
  (select dept_id from department where name = 'Operations'), 
  'Teller', 
  (select branch_id from branch where name = 'Woburn Branch'));
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (null, 'John', 'Blake', '2000-05-11', 
  (select dept_id from department where name = 'Operations'), 
  'Head Teller', 
  (select branch_id from branch where name = 'Quincy Branch'));
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (null, 'Cindy', 'Mason', '2002-08-09', 
  (select dept_id from department where name = 'Operations'), 
  'Teller', 
  (select branch_id from branch where name = 'Quincy Branch'));
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (null, 'Frank', 'Portman', '2003-04-01', 
  (select dept_id from department where name = 'Operations'), 
  'Teller', 
  (select branch_id from branch where name = 'Quincy Branch'));
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (null, 'Theresa', 'Markham', '2001-03-15', 
  (select dept_id from department where name = 'Operations'), 
  'Head Teller', 
  (select branch_id from branch where name = 'So. NH Branch'));
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (null, 'Beth', 'Fowler', '2002-06-29', 
  (select dept_id from department where name = 'Operations'), 
  'Teller', 
  (select branch_id from branch where name = 'So. NH Branch'));
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (null, 'Rick', 'Tulman', '2002-12-12', 
  (select dept_id from department where name = 'Operations'), 
  'Teller', 
  (select branch_id from branch where name = 'So. NH Branch'));

/* create data for self-referencing foreign key 'superior_emp_id' */
create temporary table emp_tmp as
select emp_id, First_Name, Last_Name from employee;



update employee set superior_emp_id =
 (select emp_id from emp_tmp where Last_Name = 'Smith' and First_Name = 'Michael')
where ((Last_Name = 'Barker' and First_Name = 'Susan')
  or (Last_Name = 'Tyler' and First_Name = 'Robert'));
update employee set superior_emp_id =
 (select emp_id from emp_tmp where Last_Name = 'Tyler' and First_Name = 'Robert')
where Last_Name = 'Hawthorne' and First_Name = 'Susan';
update employee set superior_emp_id =
 (select emp_id from emp_tmp where Last_Name = 'Hawthorne' and First_Name = 'Susan')
where ((Last_Name = 'Gooding' and First_Name = 'John')
  or (Last_Name = 'Fleming' and First_Name = 'Helen')
  or (Last_Name = 'Roberts' and First_Name = 'Paula') 
  or (Last_Name = 'Blake' and First_Name = 'John') 
  or (Last_Name = 'Markham' and First_Name = 'Theresa')); 
update employee set superior_emp_id =
 (select emp_id from emp_tmp where Last_Name = 'Fleming' and First_Name = 'Helen')
where ((Last_Name = 'Tucker' and First_Name = 'Chris') 
  or (Last_Name = 'Parker' and First_Name = 'Sarah') 
  or (Last_Name = 'Grossman' and First_Name = 'Jane'));  
update employee set superior_emp_id =
 (select emp_id from emp_tmp where Last_Name = 'Roberts' and First_Name = 'Paula')
where ((Last_Name = 'Ziegler' and First_Name = 'Thomas')  
  or (Last_Name = 'Jameson' and First_Name = 'Samantha'));   
update employee set superior_emp_id =
 (select emp_id from emp_tmp where Last_Name = 'Blake' and First_Name = 'John')
where ((Last_Name = 'Mason' and First_Name = 'Cindy')   
  or (Last_Name = 'Portman' and First_Name = 'Frank'));    
update employee set superior_emp_id =
 (select emp_id from emp_tmp where Last_Name = 'Markham' and First_Name = 'Theresa')
where ((Last_Name = 'Fowler' and First_Name = 'Beth')   
  or (Last_Name = 'Tulman' and First_Name = 'Rick'));    

drop table emp_tmp;

/* product type data */
insert into product_type (product_type_cd, name)
values ('ACCOUNT','Customer Accounts');
insert into product_type (product_type_cd, name)
values ('LOAN','Individual and Business Loans');
insert into product_type (product_type_cd, name)
values ('INSURANCE','Insurance Offerings');

/* product data */
insert into product (product_cd, name, product_type_cd, date_offered)
values ('CHK','checking account','ACCOUNT','2000-01-01');
insert into product (product_cd, name, product_type_cd, date_offered)
values ('SAV','savings account','ACCOUNT','2000-01-01');
insert into product (product_cd, name, product_type_cd, date_offered)
values ('MM','money market account','ACCOUNT','2000-01-01');
insert into product (product_cd, name, product_type_cd, date_offered)
values ('CD','certificate of deposit','ACCOUNT','2000-01-01');
insert into product (product_cd, name, product_type_cd, date_offered)
values ('MRT','home mortgage','LOAN','2000-01-01');
insert into product (product_cd, name, product_type_cd, date_offered)
values ('AUT','auto loan','LOAN','2000-01-01');
insert into product (product_cd, name, product_type_cd, date_offered)
values ('BUS','business line of credit','LOAN','2000-01-01');
insert into product (product_cd, name, product_type_cd, date_offered)
values ('SBL','small business loan','LOAN','2000-01-01');

/* residential customer data */
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (null, '111-11-1111', 'I', '47 Mockingbird Ln', 'Lynnfield', 'MA', '01940');
insert into individual (cust_id, First_Name, Last_Name, birth_date)
select cust_id, 'James', 'Hadley', '1972-04-22' from customer
where fed_id = '111-11-1111';
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (null, '222-22-2222', 'I', '372 Clearwater Blvd', 'Woburn', 'MA', '01801');
insert into individual (cust_id, First_Name, Last_Name, birth_date)
select cust_id, 'Susan', 'Tingley', '1968-08-15' from customer
where fed_id = '222-22-2222';
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (null, '333-33-3333', 'I', '18 Jessup Rd', 'Quincy', 'MA', '02169');
insert into individual (cust_id, First_Name, Last_Name, birth_date)
select cust_id, 'Frank', 'Tucker', '1958-02-06' from customer
where fed_id = '333-33-3333';
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (null, '444-44-4444', 'I', '12 Buchanan Ln', 'Waltham', 'MA', '02451');
insert into individual (cust_id, First_Name, Last_Name, birth_date)
select cust_id, 'John', 'Hayward', '1966-12-22' from customer
where fed_id = '444-44-4444';
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (null, '555-55-5555', 'I', '2341 Main St', 'Salem', 'NH', '03079');
insert into individual (cust_id, First_Name, Last_Name, birth_date)
select cust_id, 'Charles', 'Frasier', '1971-08-25' from customer
where fed_id = '555-55-5555';
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (null, '666-66-6666', 'I', '12 Blaylock Ln', 'Waltham', 'MA', '02451');
insert into individual (cust_id, First_Name, Last_Name, birth_date)
select cust_id, 'John', 'Spencer', '1962-09-14' from customer
where fed_id = '666-66-6666';
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (null, '777-77-7777', 'I', '29 Admiral Ln', 'Wilmington', 'MA', '01887');
insert into individual (cust_id, First_Name, Last_Name, birth_date)
select cust_id, 'Margaret', 'Young', '1947-03-19' from customer
where fed_id = '777-77-7777';
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (null, '888-88-8888', 'I', '472 Freedom Rd', 'Salem', 'NH', '03079');
insert into individual (cust_id, First_Name, Last_Name, birth_date)
select cust_id, 'Louis', 'Blake', '1977-07-01' from customer
where fed_id = '888-88-8888';
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (null, '999-99-9999', 'I', '29 Maple St', 'Newton', 'MA', '02458');
insert into individual (cust_id, First_Name, Last_Name, birth_date)
select cust_id, 'Richard', 'Farley', '1968-06-16' from customer
where fed_id = '999-99-9999';

/* corporate customer data */
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (null, '04-1111111', 'B', '7 Industrial Way', 'Salem', 'NH', '03079');
insert into business (cust_id, name, state_id, incorp_date)
select cust_id, 'Chilton Engineering', '12-345-678', '1995-05-01' from customer
where fed_id = '04-1111111';
insert into officer (officer_id, cust_id, First_Name, Last_Name,
  title, start_date)
select null, cust_id, 'John', 'Chilton', 'President', '1995-05-01'
from customer
where fed_id = '04-1111111';
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (null, '04-2222222', 'B', '287A Corporate Ave', 'Wilmington', 'MA', '01887');
insert into business (cust_id, name, state_id, incorp_date)
select cust_id, 'Northeast Cooling Inc.', '23-456-789', '2001-01-01' from customer
where fed_id = '04-2222222';
insert into officer (officer_id, cust_id, First_Name, Last_Name,
  title, start_date)
select null, cust_id, 'Paul', 'Hardy', 'President', '2001-01-01'
from customer
where fed_id = '04-2222222';
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (null, '04-3333333', 'B', '789 Main St', 'Salem', 'NH', '03079');
insert into business (cust_id, name, state_id, incorp_date)
select cust_id, 'Superior Auto Body', '34-567-890', '2002-06-30' from customer
where fed_id = '04-3333333';
insert into officer (officer_id, cust_id, First_Name, Last_Name,
  title, start_date)
select null, cust_id, 'Carl', 'Lutz', 'President', '2002-06-30'
from customer
where fed_id = '04-3333333';
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (null, '04-4444444', 'B', '4772 Presidential Way', 'Quincy', 'MA', '02169');
insert into business (cust_id, name, state_id, incorp_date)
select cust_id, 'AAA Insurance Inc.', '45-678-901', '1999-05-01' from customer
where fed_id = '04-4444444';
insert into officer (officer_id, cust_id, First_Name, Last_Name,
  title, start_date)
select null, cust_id, 'Stanley', 'Cheswick', 'President', '1999-05-01'
from customer
where fed_id = '04-4444444';

/* residential account data */
insert into account (account_id, product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Woburn' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2000-01-15' open_date, '2005-01-04' last_date,
    1057.75 avail, 1057.75 pend union all
  select 'SAV' prod_cd, '2000-01-15' open_date, '2004-12-19' last_date,
    500.00 avail, 500.00 pend union all
  select 'CD' prod_cd, '2004-06-30' open_date, '2004-06-30' last_date,
    3000.00 avail, 3000.00 pend) a
where c.fed_id = '111-11-1111';
insert into account (account_id, product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Woburn' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2001-03-12' open_date, '2004-12-27' last_date,
    2258.02 avail, 2258.02 pend union all
  select 'SAV' prod_cd, '2001-03-12' open_date, '2004-12-11' last_date,
    200.00 avail, 200.00 pend) a
where c.fed_id = '222-22-2222';
insert into account (account_id, product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Quincy' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2002-11-23' open_date, '2004-11-30' last_date,
    1057.75 avail, 1057.75 pend union all
  select 'MM' prod_cd, '2002-12-15' open_date, '2004-12-05' last_date,
    2212.50 avail, 2212.50 pend) a
where c.fed_id = '333-33-3333';
insert into account (account_id, product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Waltham' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2003-09-12' open_date, '2005-01-03' last_date,
    534.12 avail, 534.12 pend union all
  select 'SAV' prod_cd, '2000-01-15' open_date, '2004-10-24' last_date,
    767.77 avail, 767.77 pend union all
  select 'MM' prod_cd, '2004-09-30' open_date, '2004-11-11' last_date,
    5487.09 avail, 5487.09 pend) a
where c.fed_id = '444-44-4444';
insert into account (account_id, product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Salem' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2004-01-27' open_date, '2005-01-05' last_date,
    2237.97 avail, 2897.97 pend) a
where c.fed_id = '555-55-5555';
insert into account (account_id, product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Waltham' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2002-08-24' open_date, '2004-11-29' last_date,
    122.37 avail, 122.37 pend union all
  select 'CD' prod_cd, '2004-12-28' open_date, '2004-12-28' last_date,
    10000.00 avail, 10000.00 pend) a
where c.fed_id = '666-66-6666';
insert into account (account_id, product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Woburn' limit 1) e
  cross join
 (select 'CD' prod_cd, '2004-01-12' open_date, '2004-01-12' last_date,
    5000.00 avail, 5000.00 pend) a
where c.fed_id = '777-77-7777';
insert into account (account_id, product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Salem' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2001-05-23' open_date, '2005-01-03' last_date,
    3487.19 avail, 3487.19 pend union all
  select 'SAV' prod_cd, '2001-05-23' open_date, '2004-10-12' last_date,
    387.99 avail, 387.99 pend) a
where c.fed_id = '888-88-8888';
insert into account (account_id, product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Waltham' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2003-07-30' open_date, '2004-12-15' last_date,
    125.67 avail, 125.67 pend union all
  select 'MM' prod_cd, '2004-10-28' open_date, '2004-10-28' last_date,
    9345.55 avail, 9845.55 pend union all
  select 'CD' prod_cd, '2004-06-30' open_date, '2004-06-30' last_date,
    1500.00 avail, 1500.00 pend) a
where c.fed_id = '999-99-9999';

-- corporate account data  
insert into account (account_id, product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Salem' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2002-09-30' open_date, '2004-12-15' last_date,
    23575.12 avail, 23575.12 pend union all
  select 'BUS' prod_cd, '2002-10-01' open_date, '2004-08-28' last_date,
    0 avail, 0 pend) a
where c.fed_id = '04-1111111';
insert into account (account_id, product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Woburn' limit 1) e
  cross join
 (select 'BUS' prod_cd, '2004-03-22' open_date, '2004-11-14' last_date,
    9345.55 avail, 9345.55 pend) a
where c.fed_id = '04-2222222';
insert into account (account_id, product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Salem' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2003-07-30' open_date, '2004-12-15' last_date,
    38552.05 avail, 38552.05 pend) a
where c.fed_id = '04-3333333';
insert into account (account_id, product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Quincy' limit 1) e
  cross join
 (select 'SBL' prod_cd, '2004-02-22' open_date, '2004-12-17' last_date,
    50000.00 avail, 50000.00 pend) a
where c.fed_id = '04-4444444';

-- put $100 in all checking/savings accounts on date account opened  
insert into acc_transaction (txn_id, txn_date, account_id, txn_type_cd,
  amount, funds_avail_date)
select null, a.open_date, a.account_id, 'CDT', 100, a.open_date
from account a
where a.product_cd IN ('CHK','SAV','CD','MM');
 