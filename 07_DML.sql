/* *********************************************************************
INSERT �� - �� �߰�
����
 - �����߰� :
   - INSERT INTO ���̺�� (�÷� [, �÷�]) VALUES (�� [, ��[])
   - ��� �÷��� ���� ���� ��� �÷� ���������� ���� �� �� �ִ�.

 - ��ȸ����� INSERT �ϱ� (subquery �̿�)
   - INSERT INTO ���̺�� (�÷� [, �÷�])  SELECT ����
	- INSERT�� �÷��� ��ȸ��(subquery) �÷��� ������ Ÿ���� �¾ƾ� �Ѵ�.
	- ��� �÷��� �� ���� ��� �÷� ������ ������ �� �ִ�. -->��, ���� ������ ���̺� ���� �� ������ �÷���**
    
    -NULL: null��
    -DATE: '��/��/��' �̿��� ������ to_date()��ȯ , sysdate (��������� �Ͻø� ǥ������)
    
************************************************************************ */
insert into emp (emp_id, emp_name,job_id, mgr_id, hire_date, salary, comm_pct, dept_id)
values (1100,'��ö��', NULL,120,to_date('2013/03','yyyy/mm'),5000,0.1,NULL);    --���� ���� ���� ���̸� NULL�� �����Ѵ�****��

insert into emp (emp_id, emp_name,job_id, mgr_id, hire_date, salary, comm_pct, dept_id)
values (1200,'��ö��', NULL,120,sysdate,5000,0.1,NULL);    --���� ���� ���� ���̸� NULL�� �����Ѵ�****��

select *
from emp
order by emp_id desc;

--**************************************���� ���� �͵�**********************************
insert into emp (emp_id, emp_name, hire_date)  --salary: NOT NULL ���� ����--> �ݵ�� ���� ���� �Ѵ�. 
values (1300,'yoojin','2019/10/30');

--salary�� ������: 5�ڸ�. --->7�ڸ� (������ ũ�Ⱑ �÷��� ũ�⺸�� ũ�� ��������!!!!)
insert into emp (emp_id, emp_name, hire_date, salary)   
values (1400,'�̼���','2019/11/30',1000000);  --salary�� �����δ� 5�ڸ������� ����! (���� ����) 

--��������: primary key (�⺻Ű) �÷��� ���� ���� insert ����. 
insert into emp (emp_id, emp_name, hire_date, salary)   
values (1400,'�̼����̼���','2019/11/30',10000);  

--�ܷ�Ű �÷����� �ݵ�� �θ����̺��� primary key �÷��� �ִ� ���鸸 ���� �� �ִ�.**

--table emp2 ����
create table emp2(
emp_id number(6),
emp_name varchar2(20),
salary number(7,2)
);

--emp���� ��ȸ�� ���� emp2�� insert
insert into emp2 (emp_id, emp_name, salary)
select emp_id, emp_name, salary from emp
where dept_id=10;

select *
from emp2;


--***************************************************************************************************
--TODO: �μ��� ������ �޿��� ���� ��� ���̺� ����. 
--      ��ȸ����� insert. ����: �հ�, ���, �ִ�, �ּ�, �л�, ǥ������
drop table salary_stat;
create table salary_stat(
dept_id number(6),
salary_sum number(15,2),
salary_avg number(10,2), --�Ǽ����� ���� �� �ֱ� ����
salary_max number(7,2),
salary_min number(7,2),
salary_var number(20,2),
salary_stddev number(7,2)
);

insert into salary_stat
select 
    sum(salary),
    round(avg(salary),2),
    max(salary),
    min(salary),
    round(variance(salary),2),
    round(stddev(salary),2)
from emp
group by dept_id
order by 1;

/* *********************************************************************
UPDATE : ���̺��� �÷��� ���� ����
UPDATE ���̺��
SET    ������ �÷� = ������ ��  [, ������ �÷� = ������ ��]
[WHERE ��������]


--**********UPDATE �� ���̺� �ϳ����� ����. 

 - UPDATE: ������ ���̺� ����
 - SET: ������ �÷��� ���� ����
 - WHERE: ������ ���� ����. 
************************************************************************ */

-- ���� ID�� 200�� ������ �޿��� 5000���� ����
select *
from emp
where emp_id=200;

update emp 
set salary=5000;   -- 5000���� �� �����Ͽ���.  (�࿡ ���� ������ �����Ƿ� ��ü������ �ٲ�)

commit;        --select�� �����͸� �ٲ��� ������, update, insert �� �����͸� �ٲٴ� ��! 
               --�� �������� �߻��ϴ� �Ǽ��� rollback ����ϰ�, commit�� ����ϸ� ���̻� rollback�� �ȵǵ���!!!
rollback;   -- UNDO

update emp 
set salary=5000
where emp_id=200;  --���������� �����ν� ���ϴ� �ุ ��������. 

-- ���� ID�� 200�� ������ �޿��� 10% �λ��� ������ ����.

select *
from emp
where emp_id=200;

update emp
set salary=salary*1.1
where emp_id=200;

-- �μ� ID�� 100�� ������ Ŀ�̼� ������ 0.2�� salary�� 3000�� ���� ������ ����.
select *
from emp
where dept_id=100;

update emp
set comm_pct=0.2, salary=salary+300   --��ǥ�� ����Ͽ� �� ���̻��� ������ �� �� �ִ�****
where dept_it=100;

rollback;
-- TODO: �μ� ID�� 100�� �������� �޿��� 100% �λ�
select *
from emp
where dept_id=100;

update emp
set salary=salary*2
where dept_id=100;

rollback;

-- TODO: IT �μ��� �������� �޿��� 3�� �λ�
select *
from emp e join dept d on e.dept_id=d.dept_id
where dept_name='IT';

update emp
set salary=salary*3
where dept_name='IT';

rollback;

-- TODO: EMP2 ���̺��� ��� �����͸� MGR_ID�� NULL�� HIRE_DATE �� �����Ͻ÷� COMM_PCT�� 0.5�� ����.
select *
from emp;

update emp
set mgr_id=null, hire_date=sysdate, comm_pct=0.5;
rollback;
/* *********************************************************************
DELETE : ���̺��� ���� ����
���� 
 - DELETE FROM ���̺�� [WHERE ��������]
   - WHERE: ������ ���� ����
   
   --�ڽ� ���̺��� �����ϰ� �ִ� ���̺��� ������ �ȵȴ�.
   --->�����ϰ� �ִ� ������ �� NULL�� �ٲٰų� ������ �� ����.   x  ccxccvx
   ---->�ڵ����� ������ �� �ֵ��� �ϴ� Ű���� -->cascade, 
************************************************************************ */

delete from emp 
where dept_id=100;
rollback;
-- TODO: �μ� ID�� ���� �������� ����
delete 
from emp
where dept_id is null;

-- TODO: ��� ����(emp.job_id)�� 'SA_MAN'�̰� �޿�(emp.salary) �� 12000 �̸��� �������� ����.
delete
from emp
where job_id='SA_MAN' and salary<12000;    --������ �ǰ� �ִ� �ڽ� ���̺��� �����ϹǷ�..�Ժη� ����X -->������ null�� �ٲ��ִ��� �ؾ���.


-- TODO: comm_pct �� null�̰� job_id �� IT_PROG�� �������� ����
delete 
from emp
where comm_pct is null and job_id='IT_PROG';

