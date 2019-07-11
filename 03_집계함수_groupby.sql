/* **************************************************************************
����(Aggregation) �Լ��� GROUP BY, HAVING
************************************************************************** */

/* ************************************************************
�����Լ�, �׷��Լ�, ������ �Լ�
- �μ�(argument)�� �÷�.
  - sum(): ��ü�հ�
  - avg(): ���
  - min(): �ּҰ�
  - max(): �ִ밪
  - stddev(): ǥ������
  - variance(): �л�
  - count(): ����
        - �μ�: 
            - �÷���: null�� ������ ����
            -  *: �� ���(null�� ����)
- count(*) �� ������ ��� �����Լ����� null�� �����ϰ� �����Ѵ�. (avg, stddev, variance�� ����)
- ������/date: max(), min(), count()���� ��밡��.
************************************************************* */
--�޿�(salary)�� ���հ�, ���, �ּҰ�, �ִ밪, ǥ������, �л�, ���������� ��ȸ 
select  to_char(sum(salary), '$999,999') "���հ�",
        round(avg(salary), 1) "���",
        min(salary) "�ּҰ�", 
        max(salary) "�ִ밪",
        stddev(salary) "ǥ������",
        variance(salary) "�л�",
        count(salary) "����"
from emp;

-- ���� �ֱ� �Ի��ϰ� ���� ������ �Ի����� ��ȸ
select max(hire_date), min(hire_date) --���� < �̷�
from emp;

select max(emp_name), min(emp_name) --����<�빮��<�ҹ���<�ѱ�
from emp;
-- emp ���̺��� job ������ ���� ��ȸ
select count(job) from emp;

select count(distinct job)
from emp;

--TODO:  Ŀ�̼� ����(comm_pct)�� �ִ� ������ ���� ��ȸ
select count(comm_pct) from emp;

--TODO: Ŀ�̼� ����(comm_pct)�� ���� ������ ���� ��ȸ
select count(*) - count(comm_pct) 
from emp;

select count(nvl(comm_pct,1))
from emp
where comm_pct is null;

--TODO: ���� ū Ŀ�̼Ǻ���(comm_pct)�� �� ���� ���� Ŀ�̼Ǻ����� ��ȸ
select max(comm_pct), min(comm_pct)
from emp;

--TODO:  Ŀ�̼� ����(comm_pct)�� ����� ��ȸ. 
--�Ҽ��� ���� 2�ڸ����� ���
select round(avg(comm_pct), 2) "��� 1", --comm_pct�� �ִ� �������� ���.
       round(avg(nvl(comm_pct, 0)), 2) "��� 2" -- ��ü ������ ���
from emp;

--TODO: ���� �̸�(emp_name) �� ���������� �����Ҷ� ���� ���߿� ��ġ�� �̸��� ��ȸ.
select max(emp_name) from emp;

--TODO: �޿�(salary)���� �ְ� �޿��װ� ���� �޿����� ������ ���
select max(salary), min(salary), max(salary)-min(salary) 
from emp;


--TODO: ���� �� �̸�(emp_name)�� ����� ���� ��ȸ.
select max(length(emp_name)), min(length(emp_name)), sum(length(emp_name))
from emp;

--TODO: EMP ���̺��� ����(job) ������ � �ִ� ��ȸ. 
--���������� ����
select count(distinct job) from emp;

--TODO: EMP ���̺��� �μ�(dept_name)�� �������� �ִ��� ��ȸ. 
-- ���������� ����
select count(distinct nvl(dept_name, 0))from emp;

select distinct nvl(dept_name, 0) from emp;



select dept_name, sum(salary) 
from emp
group by dept_name;
/* **************
group by ��
- select�� where �� ������ ����Ѵ�.
- Ư�� �÷�(��)�� ������ ���� ������ �� ������ �����÷��� �����ϴ� ����.
- ����: group by �÷��� [, �÷���]
- �÷�: �з���(������, �����) - �μ��� �޿� ���, ���� �޿� �հ�
- select ������ group by ���� ������ �÷��鸸 �����Լ��� ���� �� �� �ִ�.
****************/

-- ����(job)�� �޿��� ���հ�, ���, �ּҰ�, �ִ밪, ǥ������, �л�, �������� ��ȸ
select  job, 
        sum(salary), 
        round(avg(salary), 2),
        min(salary),
        max(salary),
        round(stddev(salary), 2),
        round(variance(salary), 2),
        count(*)
from emp
group by job;

-- �Ի翬�� �� �������� �޿� ���.
select  to_char(hire_date, 'yyyy') "�Ի�⵵",
        avg(salary) "��ձ޿�"
from    emp
group by to_char(hire_date, 'yyyy')
order by 1;


-- �޿�(salary) ������ �������� ���. �޿� ������ 10000 �̸�,  10000�̻� �� ����.
select  case when salary>=10000 then '1���' 
             when salary < 10000 then '2���'
        end "���",
        count(*) "������"
from emp
group by case when salary>=10000 then '1���' 
             when salary < 10000 then '2���'
        end;



select  case when salary>=10000 then '1���' 
             when salary < 10000 then '2���'
        end "���"
from emp;        


select  dept_name, job, sum(salary)
from emp
--group by job, dept_name
group by dept_name, job
order by 1;

--TODO: �μ���(dept_name) �������� ��ȸ
select dept_name, count(*) "������"
from emp
group by dept_name
--order by 2;
order by "������";

--TODO: ������(job) �������� ��ȸ. �������� ���� �ͺ��� ����.
select  job, 
        count(*)
from emp 
group by job
order by 2 desc, 1 asc;

--TODO: �μ���(dept_name), ����(job)�� ������, �ְ�޿�(salary)�� ��ȸ. �μ��̸����� �������� ����.
select  dept_name, job,
        count(*) "������", 
        max(salary) "�ְ� �޿�"
from emp
group by dept_name, job
order by dept_name; --1


--TODO: EMP ���̺��� �Ի翬����(hire_date) �� �޿�(salary)�� �հ��� ��ȸ. 
--(�޿� �հ�� �ڸ������� , �� �����ÿ�. ex: 2,000,000)
select  to_char(hire_date, 'yyyy') "�Ի�⵵",
        to_char(sum(salary), 'fm999,999,999') "�ѱ޿�"
from emp
group by to_char(hire_date, 'yyyy');

--TODO: ����(job)�� �Ի�⵵(hire_date)�� ��� �޿�(salary)�� ��ȸ
select  job, 
        extract(year from hire_date) "�Ի�⵵",
        floor(avg(salary)) "��ձ޿�"
from    emp
group by job, extract(year from hire_date);

--TODO: �μ���(dept_name) ������ ��ȸ�ϴµ� �μ���(dept_name)�� null�� ���� �����ϰ� ��ȸ.
select   dept_name, 
         count(*) "������"
from emp
where dept_name is not null
group by dept_name
order by "������";

--TODO �޿� ������ �������� ���. �޿� ������ 5000 �̸�, 5000�̻� 10000 �̸�, 
--10000�̻� 20000�̸�, 20000�̻�. 

select  count(*), 
        case when salary < 5000 then '5000�̸�'
             when salary >= 5000 and salary < 10000 then '5000~10000'
             when salary between 10000 and 19999 then '10000~20000'
             else '20000�̻�'
        end "���"
from emp
group by case when salary < 5000 then '5000�̸�'
             when salary >= 5000 and salary < 10000 then '5000~10000'
             when salary between 10000 and 19999 then '10000~20000'
             else '20000�̻�'
        end
order by decode(���, '5000�̸�', 1, 
                      '5000~10000', 2,
                      '10000~20000', 3, 4);
                      
select * from emp where salary >12000;
/* **************************************************************
having ��
- ������������ �� ���� ����
- group by ���� order by ���� �´�.
- ����
    having ��������  --�����ڴ� where���� �����ڸ� ����Ѵ�. �ǿ����ڴ� �����Լ�(�� ���)
************************************************************** */
-- �������� 10 �̻��� �μ��� �μ���(dept_name)�� �������� ��ȸ
select  dept_name, count(*) "������"
from    emp
group by dept_name
having count(*) >= 10;
--having ������ >= 10;


--TODO: 15�� �̻��� �Ի��� �⵵�� (�� �ؿ�) �Ի��� �������� ��ȸ.
select  to_char(hire_date, 'yyyy') "�Ի�⵵",
        count(*) ������
from emp
group by to_char(hire_date, 'yyyy')
having count(*) >= 15;

--TODO: �� ����(job)�� ����ϴ� ������ ���� 10�� �̻��� ����(job)��� ��� �������� ��ȸ
select  job, count(*) ������
from emp
group by job
having count(*) >= 10;

--TODO: ��� �޿���(salary) $5000�̻��� �μ��� �̸�(dept_name)�� ��� �޿�(salary), 
--       �������� ��ȸ
select  dept_name, 
        ceil(avg(salary)) ��ձ޿�, 
        count(*) ������
from emp
group by dept_name
having avg(salary) >= 5000;


--TODO: ��ձ޿��� $5,000 �̻��̰� �ѱ޿��� $50,000 �̻��� 
--�μ��� �μ���(dept_name), ��ձ޿��� �ѱ޿��� ��ȸ
select  dept_name,
        ceil(avg(salary)) ��ձ޿�,
        sum(salary) �ѱ޿�
from emp
group by dept_name
having avg(salary) >= 5000  and  sum(salary)>=50000;

-- TODO ������ 2�� �̻��� �μ����� �̸��� �޿��� ǥ�������� ��ȸ
select  dept_name, 
        stddev(salary)--, count(*)
from emp
group by dept_name
having   count(*) > 2;



/* **************************************************************
group by �� Ȯ�� : rollup �� cube
- rollup(): group by�� Ȯ��
    - �߰�����, �����踦 group �� �κ����迡 �߰��ؼ� ������ �� �� ���.
    - ���� : group by (�÷��� [, �÷���])

- cube() : rollup �� Ȯ��
    - group by ���� �÷��� ��� ������ ��� ����.
    - �׷����� ���� �÷��� �ΰ� �̻��϶� ���. 

grouping(), grouping_id() �Լ�

- grouping()
    - group by���� rollup�̳� cube�� ���� �÷��� ����� ���� ������ 0, ����� ��������
            �ʾ����� 1�� ��ȯ�Ѵ�.
    - select ������ ���
    - ���� : grouping(group by���� ����� �÷���)
            
************************************************************** */
/*
group by rollup(job)
����: job��
     job�� �����ϰ� ����
     
group by rollup(dept_name, job)     
1. (dept_name,job)
2. (dept_name)
3. ()
*/

-- EMP ���̺��� ����(job)�� �޿�(salary)�� ��հ� ����� �Ѱ赵 ���̳������� ��ȸ.
select nvl(job, '�����'), ceil(avg(salary)) ��ձ޿�
from emp
group by rollup(job);

select dept_name,
       grouping_id(dept_name),
       decode(grouping_id(dept_name), 0, dept_name, '�����'),
       ceil(avg(salary)) ��ձ޿�
from emp
group by rollup(dept_name);



select job, ceil(avg(salary)) ��ձ޿�
from emp
group by cube(job);


-- EMP ���̺��� ����(JOB) �� �޿�(salary)�� ��հ� ����� �Ѱ赵 ���̳������� ��ȸ.
-- ���� �÷���  �Ұ質 �Ѱ��̸� '�����'��  �Ϲ� �����̸� ����(job)�� ���


-- EMP ���̺��� �μ�(dept_name), ����(job) �� salary�� �հ�� �������� �Ұ�� �Ѱ谡 �������� ��ȸ
select  --dept_name, 
        decode(grouping_id(dept_name), 0, dept_name, '������') dept_name,
        job,
        sum(salary) �ѱ޿�,
        count(*) ������
from emp
group by rollup(dept_name, job);


select  dept_name, 
        job,
        sum(salary) �ѱ޿�,
        count(*) ������
from emp
group by cube(dept_name, job);
--()
--(dept_name)
--(job)
--(dept_name, job)

--# �Ѱ�/�Ұ� ���� ��� :  �Ѱ�� '�Ѱ�', �߰������ '��' �� ���
--TODO: �μ���(dept_name) �� �ִ� salary�� �ּ� salary�� ��ȸ
select    decode(grouping_id(dept_name), 0, dept_name, '�Ѱ�') dept_name,
          min(salary), max(salary)
from emp
group by rollup(dept_name);


--TODO: ���_id(mgr_id) �� ������ ���� �Ѱ踦 ��ȸ�Ͻÿ�.
select decode(grouping_id(mgr_id), 1, '�Ѱ�', mgr_id) mgr_id,
       count(*) ������
from emp group by rollup(mgr_id);         

--TODO: �Ի翬��(hire_date�� year)�� �������� ���� ���� �հ� �׸��� �Ѱ谡 ���� ��µǵ��� ��ȸ.
select decode(grouping_id(to_char(hire_date, 'yyyy') ), 0, to_char(hire_date, 'yyyy'), '�Ѱ�') hire_date,
       count(*) ������, 
       sum(salary) �޿��հ�
from emp
group by rollup(to_char(hire_date, 'yyyy'));


--TODO: �μ���(dept_name), �Ի�⵵�� ��� �޿�(salary) ��ȸ. �μ��� ����� �����谡 ���� �������� ��ȸ

select  grouping_id(dept_name), 
        grouping_id(to_char(hire_date, 'yyyy')),
        grouping_id(dept_name, to_char(hire_date, 'yyyy')),
        round(avg(salary)) 
from    emp
group by rollup(dept_name, to_char(hire_date, 'yyyy'));




select  --decode(grouping_id(dept_name), 0, dept_name, '�Ѱ�') dept_name,
        --decode(grouping_id(to_char(hire_date, 'yyyy')), 0, to_char(hire_date, 'yyyy'), '�Ұ�') hire_date,
        decode(grouping_id(dept_name, to_char(hire_date, 'yyyy')), 
                                      0, dept_name||' - '||to_char(hire_date, 'yyyy'), 1,  
                                      '�Ұ�', 3, 
                                      '�Ѱ�') "�μ� �Ի�⵵",
        round(avg(salary), 2) ��ձ޿�
from emp
group by rollup(dept_name, to_char(hire_date, 'yyyy'));









