
/* ***********************************************************************************
���̺� ����
- ����
create table ���̺� �̸�(
  �÷� ����
  -�÷��� ������Ÿ�� [default ��] [��������] ,....
  -������ Ÿ��
        -���ڿ�: char/nchar (��������), varchar2/nvarchar2/clob (��������)
        -����: number , number(��ü�ڸ���, �ҽ����ڸ���)
        -��¥: date, timestamp (milli�ʱ��� ��Ÿ�� �� �ִ�)
        
  -default: �⺻��, ���� �Է����� ���� �� �־��� �⺻��.
)


�������� ���� -------------------------------------------------------------------------------
    -Primary key (PK): ��ĺ� �÷�. NOT NULL, ���� ��(UNIQUE), 
    -Unique key (UK): ���ϰ��� ������ �÷�.(PK���� ���̴� NULL�� ���� �� �ִٴ� ��!
    -not null (nn): ���� ����� �ȵǴ� �÷�.
    -check key (ck): �÷��� �� �� �ִ� ���� ������ ���� ����. *******
    -foreign key (fk): �ٸ� ���̺��� primary key �÷��� ���� ���� �� �ִ� �÷�.
                      �ٸ� ���̺��� ������ �� ����ϴ� �÷�
    

- �÷� ���� ����
    - �÷� ������ ���� ����
- ���̺� ���� ����
    - �÷� �����ڿ� ���� ����

- �⺻ ���� : constraint ���������̸� ��������Ÿ��
- ���̺� ���� ���� ��ȸ
    - USER_CONSTRAINTS ��ųʸ� �信�� ��ȸ
    
���̺� ����
- ����
DROP TABLE ���̺��̸� [CASCADE CONSTRAINTS]


*********************************************************************************** */
--�÷����� �������� ����
drop table parent_tb 
cascade constraints;      --�����Ǵ� ���̺��� �ֱ� ������..������ �ٷ� ���� X.

select *
from user_constraints 
where table_name='CHILD_TB';

create table parent_tb(
    no number constraint parent_tb_pk primary key,   --pk�տ� �̸��� �������ָ� ���߿� ���ϴ�. 
    name nvarchar2(50) not null, --not null�� �÷� ������ ����. 
    birthday date default sysdate, --insert �Ǵ� ������ ��¥�� ����Ʈ�� �����Ѵ�. 
    email varchar2(100) constraint parent_email_uk unique,
    gender char(1) not null constraint parent_gender_ck check(gender in ('M','F'))
);


insert into parent_tb (no, name, email, gender)
values (100,'�̸�1','a@a.com','M');

insert into parent_tb (no, name,birthday, email, gender)
values (101,'�̸�2',null,'b@b.com','F');

insert into parent_tb (no, name,birthday, email, gender)
values (101,'�̸�2',null,'b@b.com','F');          --email�� uk�̱� ������ ������ ���� �� �ִ´�. 

insert into parent_tb (no, name,birthday, email, gender)
values (101,'�̸�2',null,'b@b.com','f');       --check (gender in ('M','F')) �� ��������, �빮�ڸ� ...



select *
from parent_tb;

select to_char(birthday,'hh24:mi:ss') 
from parent_tb;

--���̺� ������  �������� ����
drop table child_tb;
create table child_tb(
    no number,
    jumin_num char(14),
    age number not null,
    parent_no number,
    constraint child_pk primary key(no),
    constraint child_jumin_uk unique(jumin_num),         --null�� �׷��� ���԰���. null���� ���� ���� �����Ͱ� ���͵� unique �ش�)
    --null�� ����̳� ���� �� ����.
    constraint child_age_ck check (age between 10 and 90),
    constraint child_parent_fk foreign key(parent_no) references parent_tb on delete cascade
    --constraint child_parent_fk foreign key(parent_no) references parent_tb on delete set null
    --on delete set null: �θ� ���̺��� ���� ���� �����Ǹ� null���� ����
    --on delete cascade: �θ� ���̺��� ���� ���� ���� �Ǹ� �ڽ��� �൵ ���� ����****** 
    
);

insert into child_tb 
values (100,'951102-1010101',30,101);

insert into child_tb 
values (101,null,30,101); 

insert into child_tb 
values (102,null,30,101); --null���� ���� �־ unique key �ش���.

insert into child_tb 
values (103,null,5,101);  --age: 1-~90���� ���� �־�� ��.

insert into child_tb 
values (104,null,5,200); --parent key�� 100,101 �ۿ� ���µ� 200���� �־����Ƿ�... parent_tb�� ���� ��. 

select *
from parent_tb;

select *
from child_tb;

delete from parent_tb 
where no=101;              --child_tb���� �����ϰ� �����Ƿ� delete�� �� ����...

-------------------------------------------------------------------------------
--���̺� ���� ������ �� ���´�. 
select *
from user_tables;    

 --table�� �÷� ������ �� �� �ִ�.
desc parent_tb; 

--���� ���ǵ��� �� �� �ִ�. 
select *                  
from user_constraints
where table_name='PARENT_TB';        --�빮�ڷ� ��ȸ�ؾ��Ѵ�. 




-------------------------------------------------------
--PUBLISHER �� BOOK ���̺� ����--------------------------

--	å�� ���ݰ� ���������� ����� ������.
--	å�� �������� �⺻������ INSERT�� ���� �Ͻø� �����Ѵ�.
drop table publisher;
create table publisher(
    publisher_no number not null,   --pk�տ� �̸��� �������ָ� ���߿� ���ϴ�. 
    publisher_name varchar2(50) not null, --not null�� �÷� ������ ����. 
    publisher_address varchar2(100) , 
   publisher_tel varchar2(20) not null,
   constraint publisher_pk primary key(publisher_no)
);

drop table book;
create table book(
    ISBN varchar2(13) not null,   --pk�տ� �̸��� �������ָ� ���߿� ���ϴ�. 
    title varchar2(50) not null, --not null�� �÷� ������ ����. 
    author varchar2(50) not null, --insert �Ǵ� ������ ��¥�� ����Ʈ�� �����Ѵ�. 
    page number(4) not null,
    price number(8) not null,
    publish_date date default sysdate not null, ---	å�� �������� �⺻������ INSERT�� ���� �Ͻø� �����Ѵ�.
    publisher_no number not null, 
    constraint book_pk primary key(ISBN),
    constraint book_price_ck check(price>=0),         ---	å�� ���ݰ� ���������� ����� ������.
    constraint book_page_ck check (page>=0) ,         ---	å�� ���ݰ� ���������� ����� ������.
    constraint book_publisher_fk foreign key(publisher_no) references publisher
    
);



/* ************************************************************************************
ALTER : ���̺� ����

�÷� ���� ����

- �÷� �߰�
  ALTER TABLE ���̺��̸� ADD (�߰��� �÷����� [, �߰��� �÷�����])
  - �ϳ��� �÷��� �߰��� ��� ( ) �� ��������

- �÷� ����
  ALTER TABLE ���̺��̸� MODIFY (�������÷���  ���漳�� [, �������÷���  ���漳��])
	- �ϳ��� �÷��� ������ ��� ( )�� ���� ����
	- ����/���ڿ� �÷��� ũ�⸦ �ø� �� �ִ�.
		- ũ�⸦ ���� �� �ִ� ��� : ���� ���� ���ų� ��� ���� ���̷��� ũ�⺸�� ���� ���
	- �����Ͱ� ��� NULL�̸� ������Ÿ���� ������ �� �ִ�. (�� CHAR<->VARCHAR2 �� ����.)

- �÷� ����	
  ALTER TABLE ���̺��̸� DROP COLUMN �÷��̸� [CASCADE CONSTRAINTS]
    - CASCADE CONSTRAINTS : �����ϴ� �÷��� Primary Key�� ��� �� �÷��� �����ϴ� �ٸ� ���̺��� Foreign key ������ ��� �����Ѵ�.
	- �ѹ��� �ϳ��� �÷��� ���� ����.
	
  ALTER TABLE ���̺��̸� SET UNUSED (�÷��� [, ..])
  ALTER TABLE ���̺��̸� DROP UNUSED COLUMNS
	- SET UNUSED ������ �÷��� �ٷ� �������� �ʰ� ���� ǥ�ø� �Ѵ�. ***  (select �ص� ��ȸ�� �ȵȴ�)
	- ������ �÷��� ����� �� ������ ���� ��ũ���� ����� �ִ�. �׷��� �ӵ��� ������.
	- DROP UNUSED COLUMNS �� SET UNUSED�� �÷��� ��ũ���� �����Ѵ�. 

- �÷� �̸� �ٲٱ�
  ALTER TABLE ���̺��̸� RENAME COLUMN �����̸� TO �ٲ��̸�;

**************************************************************************************  
���� ���� ���� ����
-�������� �߰�
  ALTER TABLE ���̺�� ADD CONSTRAINT �������� ����

- �������� ����
  ALTER TABLE ���̺�� DROP CONSTRAINT ���������̸�
  PRIMARY KEY ����: ALTER TABLE ���̺�� DROP PRIMARY KEY [CASCADE]
	- CASECADE : �����ϴ� Primary Key�� Foreign key ���� �ٸ� ���̺��� Foreign key ������ ��� �����Ѵ�.

- NOT NULL <-> NULL ��ȯ�� �÷� ������ ���� �Ѵ�.
   - ALTER TABLE ���̺�� MODIFY (�÷��� NOT NULL),    null�� �ָ� not null�� �� �ٲٴ� ��Ȳ�� ���� �� �ִ�. 
   - ALTER TABLE ���̺�� MODIFY (�÷��� NULL)  
************************************************************************************ */
--customers copy�ؼ� cost ��� ���̺� �����.
--not null�� ������ ���� ������ copy�� �ȵ�.
drop table cust;
create table cust
as
select * from customers
where 1=0;              -- �� �κ��� �߰��ϸ� �����͸� copy���� �ʰ� Ʋ��!!!!!

desc cust;
select *
from user_constraints
where table_name='COST';

--���� ���� �߰�.
--COST:pk
alter table cust add constraint cust_pk primary key(cust_id);
alter table ord add constraint ord_cust_pk foreign key(cust_id) references cust;

--�÷� �߰�/����
alter table  cust add (age number not null);
desc cust;

alter table cust modify(cust_name not null, address null,postal_code null);

alter table cust modify (cust_name varchar2(100));

--�÷� �̸� ����
alter table cust rename column age to cust_age;

--�÷� ����
alter table cust 
drop column cust_age;  --�ѹ��� �� �÷����� ���� ����.

--���� ���� ����
alter table cust
drop primary key cascade;   --constraint �� ���� ���� �̸��� ���� ��!

--orders -->ord
drop table ord;
create table ord
as
select * from orders
where 1=0;                  --���̺� Ʋ�� �����´�.

select * 
from ord;


--TODO: emp ���̺��� ī���ؼ� emp2�� ����
drop table emp2;
create table emp2 
as
select * from emp where 1 = 0;


--TODO: gender �÷��� �߰�: type char(1)
alter table emp2 add (gender char(1));


--TODO: email �÷� �߰�. type: varchar2(100),  not null  �÷�
alter table emp2 add (email varchar2(100) not null);


--TODO: jumin_num(�ֹι�ȣ) �÷��� �߰�. type: char(14), null ���. ������ ���� ������ �÷�.
alter table emp2 add (jumin_num char(14) constraint emp2_jumin_num_uk unique);


--TODO: emp_id �� primary key �� ����
alter table emp2 add primary key(emp_id);

  
--TODO: gender �÷��� M, F �����ϵ���  �������� �߰�
alter table emp2 add constraint emp2_gender_ck check(gender in ('M', 'F'));

 
--TODO: salary �÷��� 0�̻��� ���鸸 ������ �������� �߰�
alter table emp2 add constraint emp2_salary_ck check(salary >= 0);

--TODO: email �÷��� null�� ���� �� �ֵ� �ٸ� ��� ���� ���� ������ ���ϵ��� ���� ���� ����
alter table emp2 add constraint emp2_email_uk unique(email);


--TODO: emp_name �� ������ Ÿ���� varchar2(100) ���� ��ȯ
alter table emp2 modify (emp_name varchar2(100));


-- TODO: job_id�� not null �÷����� ����
alter table emp2 modify (job_id not null);


--TODO: dept_id�� not null �÷����� ����
alter table emp2 modify (dept_id not null);


--TODO: job_id  �� null ��� �÷����� ����
alter table emp2 modify (job_id null);


--TODO: dept_id  �� null ��� �÷����� ����
alter table emp2 modify (dept_id null);


--TODO: ������ ������ emp_email_uk ���� ������ ����
alter table emp2 drop constraint emp2_email_uk;


--TODO: ������ ������ emp_salary_ck ���� ������ ����
alter table emp2 drop constraint emp2_salary_ck;


--TODO: primary key �������� ����
alter table emp2 drop primary key;


--TODO: gender �÷�����
alter table emp2 drop column gender;


--TODO: email �÷� ����
alter table emp2 drop column email;