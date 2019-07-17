/* *****************************************
�� (View)
- �ϳ� �Ǵ� ���� ���̺�� ���� �������� �κ� ������ �������� ǥ���ϴ� ��.
- ���� �����͸� ������ �ִ� ���� �ƴ϶� �ش� �������� ��ȸ SELECT ������ ������ �ִ� ��.
- �並 �̿��� ��ȸ�Ӹ� �ƴ϶� ������ ����(insert/update/delete)�� �����ϴ�.

- ����
  - ������ select���� �����ϰ� ó�� ����
  - ������� ������ ������ ����  (�ϳ��� �����͸� ������ �������� ��ȸ ������ ���� �� �ִ�)

- ���� ����
  - �ܼ��� 
	- �ϳ��� ���̺��� �����͸� ��ȸ��
    - �Լ��� ������� �ʴ´�.  

  - ���պ�
	- ���� ���̺��� �����͸� ��ȸ�Ѵ�.
	- �Լ��� group by�� �̿��� ��ȸ�Ѵ�.
	
- �並 �̿��� DML(INSERT/DELETE/UPDATE) �۾��� �ȵǴ� ���
	- ���� �׸��� ���Ե� �ִ� ��� insert/delete/update �� �� ����.
		- �׷��Լ�
		- group by ��
		- distinct 
		- rownum 
		- SELECT ���� ǥ������ �ִ� ���
		- View�� ����� �࿡ NOT NULL ���� �ִ� ���
		

- ����
CREATE [OR REPLACE] VIEW ���̸�    --REPLACE�� �̹� ���� �̸��� ���� ���̺��� ������ REPLACE�� ���ֵ��� �Ѵ�. 
AS
SELECT ��
[WITH CHECK OPTION]                
[WITH READ ONLY]          


- OR REPLACE
	- ���� �̸��� �䰡 ���� ��� �����ϰ� ���� �����Ѵ�.
	
- WITH CHECK OPTION
	- View���� ��ȸ�� �� �ִ� ���� insert�Ǵ� update�� �� �ִ�.
    

- WITH READ ONLY
	- �б� ���� View�� ����. INSERT/DELETE/UPDATE�� �� �� ����.
	
View ����
DROP VIEW VIEW�̸�;	
**************************************** */
--����:
create view emp_view 
as
select * from emp where dept_id=60;

select * from emp_view;

select *
from (select * from emp where dept_id=60);     --inline view******** (�� ������ �ȿ����� ��밡��)

select e.emp_name,d .dept_name       --�� ���̺�� d ���̺��� ������ ��.
from emp_view e, dept d
where d.dept_id=d.dept_id;

update emp_view 
set comm_pct =0.5
where emp_id=104;
select * from emp_view;  --update �� ���� �� �� �ִ�.

select *
from emp
where emp_id=104;   --emp ���̺��� comm_pct���� �ٲ�� ���� �� �� �ִ�.
--������ �信�� ���� �������� �ʱ� ������, �����ϸ� --->���� ���̺��� ��(���� ������)�� �ٲ��***********

create or replace view emp_view            --�Ȱ��� �̸��� �䰡 ������ ���� ���� ���������� ���� ���� ������ ��ü.*****
as
select emp_id, emp_name, dept_id
from emp;

select *
from emp_view;
select emp_id, emp_name, salary     --������ ����. emp_view�� �ִ� �÷��鸸 ������ ��ȸ�� �� �ִ�.
from emp_view;

insert into emp_view
values (5000,'���̸�',60);   --emp�� insert�ǹǷ� hire_date�� NOT NULL �÷� ������ ����****************

--dept_view �� ���̺� ����.
create view dept_view
as
select * from dept where loc='New York';

select * from dept_view;
insert into  dept_view 
values (300,'���μ�','����');  --�� ���� ����.

select * from dept_view;     -- ���� ��ȸ�غ���.. ��ȸ�� �ȵȴ�.  WHY? ��� New YorK�ΰ͸� ��ȸ�ϹǷ�..

select * from dept;   --���Ե� ���� �� �� �ִ�.

create view dept_view2
as
select * from dept where loc='New York'
with check option;                       --with check option �߰�

insert into dept_view2
values (303,'����μ�','����');          --����! ---> '����'�� ���� New York ���ǰ� ���� �����Ƿ� �ƿ� insert ���� ����.
                                      --with check option: ���� ���� ���̺�� ��ȸ�� �� �ִ� ���� �ƴϸ� ����**************************

update dept_view2
set dept_name='aaa'
where dept_id=10;    --0���� ���� ������Ʈ�ȴ�. �信 ���� �������̱� �����̴�.!!!  (������ X, �׳� ��� X)

select * 
from dept
where dept_id=10;


create view dept_view3
as
select * from dept where loc='New York'
with read only;          --with read only: 

select * from dept_view3;
insert into dept_view3
values (500,'����','��');       --read only�̹Ƿ� insert ���Ѵٴ� ���� �޽����� ���. 
delete from dept_view3;--read only�̹Ƿ� insert ���Ѵٴ� ���� �޽����� ���. 

create view emp_name_view
as
select emp_name, length(emp_name)as ����        --length()�Լ��� ����Ͽ���. �Լ��� ���� ������ ����. ��Ī�� ��������Ѵ�. 
from emp;

select * 
from emp_name_view;

create view emp_view2
as
select dept_id, max(salary) �ִ�޿� , min(salary) �ּұ޿�
from emp
group by dept_id;    --dept_id �� group by �� �ؼ� �����Լ��� ���! (��Ī�� �Բ� ����ؾ���)

select * 
from emp_view2;

update emp
set salary=20000
where emp_id=108;    --emp ���̺� �ִ� ���� update �ϸ� �䵵 �Բ� ����!!!!!!!!!!

create view emp_dept_view
as
select e.emp_id, e.emp_name, e.salary, e.job_id, e.hire_date, 
        d.dept_id, d.dept_name, d.loc --*�� ����Ͽ� ���̺��� ��� �׸� ��ȸ����.
from emp e left join dept d on e.dept_id=d.dept_id; 

select * from emp_dept_view;        --�̸� ������ ���� �� ���̺�� �������Ҵ�!!!!!!!!!!!!!!!!!!!!!!!

select * from emp_dept_view
where loc='Seattle';

-----------------------------------------------------------------------------
--TODO: �޿�(salary)�� 10000 �̻��� �������� ��� �÷����� ��ȸ�ϴ� View ����
create or replace view ex01_view
as
select * from emp where salary>=10000
order by salary;

select * 
from ex01_view;

--TODO: �μ���ġ(dept.loc) �� 'Seattle'�� �μ��� ��� �÷����� ��ȸ�ϴ� View ����
create view ex02_view
as
select * from dept
where loc='Seattle';

select *
from dept_view4;

--TODO: JOB_ID�� 'FI_ACCOUNT', 'FI_MGR' �� �������� ����_ID(emp.emp_id), �����̸�(emp.emp_name), ����_ID(emp.job_id), 
-- ������(job.job_title), �����ִ�޿�(job.max_salary), �ּұ޿�(job.min_salary)�� ��ȸ�ϴ� View�� ����
create view ex03_view
as
select e.emp_id, e.emp_name, e.job_id, j.job_title, j.max_salary, j.min_salary
from emp e , job j 
where e.job_id=j.job_id(+)   --job �� not null�� �͵� �����Ƿ� (+)�߰�
and j.job_id in ('FI_ACCOUNT', 'FI_MGR');

select *
from ex03_view;


--CONFUSING*********
--TODO: �������� ������ ������ �޿� ���(salary_grade.grade)�� ��ȸ�ϴ� View�� ����
create view ex05_view
as
select e.*, sg.*
from emp e, salary_grade sg 
where e.salary between sg.low_sal and sg.high_sal;

select * from ex05_view;

--TODO: ������ id(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title), �޿�(emp.salary), �Ի���(emp.hire_date),
--   ����̸�(emp.emp_name), ������Ի���(emp.hire_date), �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ�ϴ� View�� ����
-- ��簡 ���� ������ ��� ����̸�, ������Ի����� null�� ���.
-- �μ��� ���� ������ ��� '�̹�ġ'�� ���
-- ������ ���� ������ ��� '��������' ���� ���
create or replace view ex06_view
as
select e.emp_id, e.emp_name, nvl(j.job_title,'��������')jobtitle, e.salary, e.hire_date, 
        m.emp_name as ����̸�, m.hire_date ����Ի���,  --�÷����� �Ȱ��� ���� alias ����Ѵ�*** (duplicat columns)
        nvl(d.dept_name,'�̹�ġ') dept_name,
        nvl(d.loc,'�̹�ġ')loc
from emp e left join emp m on e.mgr_id=m.emp_id
            left join dept d on e.dept_id=d.dept_id
            left join job j on e.job_id=j.job_id;

--TODO: ������ �޿��� ��谪�� ��ȸ�ϴ� View ����.
--��� �÷� ������, �޿��� �հ�, ���, �ִ�, �ּҰ��� ��ȸ�ϴ� View�� ���� 
create or replace view ex07_view
as
select j.job_title, sum(salary) �޿��հ�, avg(salary) �޿����, max(salary) �ִ�޿�, min(salary) �ּұ޿�
from emp e, job j
where e.job_id=j.job_id
group  by job_title;

select *
from ex07_view;

--TODO: ������, �μ�����, ������ ������  ��ȸ�ϴ� View�� ����
create view ex08_view
as
select '������' label, count(*) cnt from emp
union all
select '�μ���',count(*) from dept
union all
select '������',count(*) from job;

select *
from ex08_view;

/* **************************************************************************************************************
������ : SEQUENCE
- �ڵ������ϴ� ���ڸ� �����ϴ� ����Ŭ ��ü
- ���̺� �÷��� �ڵ������ϴ� ������ȣ�� ������ ����Ѵ�.
	- �ϳ��� �������� ���� ���̺��� �����ϸ� �߰��� �� ������ �� �� �ִ�.

���� ����
CREATE SEQUENCE sequence�̸�
	[INCREMENT BY n]	
	[START WITH n]                		  
	[MAXVALUE n | NOMAXVALUE]    
	[MINVALUE n | NOMINVALUE]	--default�� NOMINVALUE
	[CYCLE | NOCYCLE(�⺻)]		
	[CACHE n | NOCACHE]		  

- INCREMENT BY n: ����ġ ����. ������ 1

- START WITH n: ���� �� ����. ������ 0
	- ���۰� ������
	 - ����: MINVALUE ���� ũĿ�� ���� ���̾�� �Ѵ�.
	 - ����: MAXVALUE ���� �۰ų� ���� ���̾�� �Ѵ�.
     
- MAXVALUE n: �������� ������ �� �ִ� �ִ밪�� ����
- NOMAXVALUE : �������� ������ �� �ִ� �ִ밪�� ���������� ��� 10^27 �� ��. ���������� ��� -1�� �ڵ����� ����. 
- MINVALUE n :�ּ� ������ ���� ����
- NOMINVALUE :�������� �����ϴ� �ּҰ��� ���������� ��� 1, ���������� ��� -(10^26)���� ����

- CYCLE �Ǵ� NOCYCLE : �ִ�/�ּҰ����� ������ ��ȯ�� �� ����. NOCYCLE�� �⺻��(��ȯ�ݺ����� �ʴ´�.)

- CACHE|NOCACHE : ĳ�� ��뿩�� ����.
(����Ŭ ������ �������� ������ ���� �̸� ��ȸ�� �޸𸮿� ����) 
NOCACHE�� �⺻��(CACHE�� ������� �ʴ´�. )


������ �ڵ������� ��ȸ
 - sequence�̸�.nextval  : ���� ����ġ ��ȸ
 - sequence�̸�.currval  : ���� �������� ��ȸ


������ ����
ALTER SEQUENCE ������ �������̸�           --��� ���� �������� SEQUENE�� ���� ����.
	[INCREMENT BY n]	               		  
	[MAXVALUE n | NOMAXVALUE]   
	[MINVALUE n | NOMINVALUE]	
	[CYCLE | NOCYCLE(�⺻)]		
	[CACHE n | NOCACHE]	

������ �����Ǵ� ������ ������ �޴´�. (�׷��� start with ���� ��������� �ƴϴ�.)	  


������ ����
DROP SEQUENCE sequence�̸�
	
************************************************************************************************************** */

-- 1���� 1�� �ڵ������ϴ� ������
create sequence ex01_seq;

select *
from user_sequences; 

select ex01_seq.nextval
from dual;

-- 1���� 50���� 10�� �ڵ����� �ϴ� ������
drop sequence ex02_seq;
create sequence ex02_seq
    increment by 10
    maxvalue 50;

select ex02_seq.nextval
from dual;

alter sequence ex02_seq
    cycle
    nocache; 

-- 100 ���� 150���� 10�� �ڵ������ϴ� ������
create sequence ex03_seq
    increment by 10
    start with 100
    maxvalue  150;
    
select ex03_seq.currval
from dual;


-- 100 ���� 150���� 2�� �ڵ������ϵ� �ִ밪�� �ٴٸ��� ��ȯ�ϴ� ������
drop sequence ex04_seq;
create sequence ex04_seq
    increment by 2
    start with 100
    maxvalue  150
    cycle;       --cycle �� �������� �����ϴ� ������ ������ cache size���� Ŀ�� �Ѵ�. 
    --25���� ������ �ǵ� cache ����� 20�̹Ƿ� ���� ������ �ʿ�X.

select ex04_seq.nextval
from dual;

create sequence ex05_seq
    increment by 10
    start with 100
    maxvalue 150
    minvalue 100
    cycle
    cache 3;
    
select ex05_seq.nextval
from dual;
    
-- -1���� �ڵ� �����ϴ� ������
create sequence ex06_seq
    increment by -1;
    
select *
from user_sequences;

select ex06_seq.nextval
from dual;

-- -1���� -50���� -10�� �ڵ� �����ϴ� ������
create sequence ex07_seq
    increment by -10
    minvalue -50
    maxvalue -1;
    
select *
from user_sequences;

select ex07_seq.nextval
from dual;

-- 100 ���� -100���� -100�� �ڵ� �����ϴ� ������
drop sequence ex08_seq;   
create sequence ex08_seq   --�����ϴ� �������϶���... �������� ����� ���� ���� maxvalue���� Ŭ ���� X.
    increment by -100
    start with 100
    minvalue -100
    maxvalue 100;
    
select *
from user_sequences;

select ex08_seq.nextval
from dual;


-- 15���� -15���� 1�� �����ϴ� ������ �ۼ�
drop sequence ex09_seq;
create sequence ex09_seq
    increment by -1
    start with 15
    minvalue -15
    maxvalue 15;
    
select *
from user_sequences;

select ex09_seq.nextval
from dual;


-- -10 ���� 1�� �����ϴ� ������ �ۼ�
drop sequence ex10_seq;     --����: �������� �����ϴ� ���� minvalue���� �۾Ƽ��� �ȵȴ�. 
create sequence ex10_seq
    start with -10
    increment by 1
    minvalue -10;
    
select *
from user_sequences;

select ex10_seq.nextval
from dual;

-- Sequence�� �̿��� �� insert



-- TODO: �μ�ID(dept.dept_id)�� ���� �ڵ����� ��Ű�� sequence�� ����. 10 ���� 10�� �����ϴ� sequence
-- ������ ������ sequence�� ����ؼ�  dept_copy�� 5���� ���� insert.

create table items          --���̺� ����
(   
    no number primary key,
    name varchar2(100) not null
);
--1�� ������, 2��,,3��...�� 1�� �ڵ������ϴ� ������ no�� ó���ϰ� ����!!!!!!!!!!
insert into items
values (item_no_seq.nextval, 'item�̸�' || ex01_seq.nextval);

drop sequence item_no_seq;
create sequence item_no_seq     --item ���̺��� ���� ������.
    start with 10
    increment by 10
    minvalue 10;

select *
from items;

rollback;   --���ݱ��� ���� ������ ���.
--�ٽ� insert �ϸ�... �̹� ������ ��ŭ �̻����� �Էµȴ�. 
--�������� rollback����� �ƴϴ�**********************************************

create table dept_copy 
as
select * from dept where 1=0;   --Ʋ�� ������

select *
from dept_copy;

-- TODO: ����ID(emp.emp_id)�� ���� �ڵ����� ��Ű�� sequence�� ����. 
--10 ���� 1�� �����ϴ� sequence
-- ������ ������ sequence�� ����� emp_copy�� ���� 5�� insert
drop table emp_copy;
create table emp_copy
as
select emp_id, emp_name, salary from emp;

select *
from emp_copy;

insert into emp_copy
values (item_no_seq2.nextval, 'item�̸�');

drop sequence item_no_seq2;
create sequence item_no_seq2    --item ���̺��� ���� ������.
    start with 10
    increment by 1
    minvalue 10;

select *
from items;



