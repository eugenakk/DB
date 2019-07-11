
create user scott_join identified by  tiger;
grant all privileges to scott_join;

/* ****************************************
����(JOIN) �̶�
- 2�� �̻��� ���̺� �ִ� �÷����� ���ļ� ������ ���̺��� ����� ��ȸ�ϴ� ����� ���Ѵ�.
 	- �ҽ����̺� : ���� ���� �о�� �Ѵٰ� �����ϴ� ���̺�
	- Ÿ�����̺� : �ҽ��� ���� �� �ҽ��� ������ ����� �Ǵ� ���̺�
 
- �� ���̺��� ��� ��ĥ���� ǥ���ϴ� ���� ���� �����̶�� �Ѵ�.
-foreign key�� primary key�� ���� �͵��� �����ض�--->equi join.
    - ���� ���꿡 ���� ��������
        - Equi join , non-equi join
        
- ������ ����
    - Inner Join 
        - ���� ���̺��� ���� ������ �����ϴ� ��鸸 ��ģ��. 
        -������ ������Ű�� ������ ���� �߰��� �ȵȴ�.
        -������ ��ġ�ϴ� �͸� �߰��Ѵ�. 
        
    - Outer Join
        - ���� ���̺��� ����� ��� ����ϰ� �ٸ� �� ���̺��� ���� ������ �����ϴ� �ุ ��ģ��. 
        ���������� �����ϴ� ���� ���� ��� NULL�� ��ģ��.
        -���� ����� ������ �׳� ����д�. (�׷��� ��ģ��)
        
        -�ҽ� ���̺��� ��ġ�� ���� ������ ������. right, left?
        - ���� : Left Outer Join,  Right Outer Join, Full Outer Join
        
    - Cross Join
        - �� ���̺��� �������� ��ȯ�Ѵ�. 
        -��� ��ĥ �� ������ �˷����� �ʰ� �׳� �������ϴ� ��.
        -m�� * n�� ��ŭ�� ���� ����. cartesian  product.
        (�ϳ��� ���� ���� ��� ����)
        
        
- ���� ����
    - ANSI ���� ����
        - ǥ�� SQL ����
        - ����Ŭ�� 9i ���� ����.
    - ����Ŭ ���� ����
        - ����Ŭ ���� �����̸� �ٸ� DBMS�� �������� �ʴ´�.
**************************************** */        
/* ****************************************
-- inner join : ANSI ���� ����
FROM  ���̺�a INNER JOIN ���̺�b ON �������� 

- inner�� ���� �� �� �ִ�.
**************************************** */
-- ������ ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
select emp_id, emp_name, hire_date, dept_name
from emp inner join dept on emp.dept_id=dept.dept_id;  --������ ������ source�̹Ƿ� �տ��ٰ�.

select e.emp_id, e.emp_name, e.hire_date, d.dept_name
from emp e inner join dept d on e.dept_id=d.dept_id;  -- e,d�� ���̺� ��Ī.

-- ������ ID(emp.emp_id)�� 100�� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date),
--�ҼӺμ��̸�(dept.dept_name)�� ��ȸ.
select emp_id, emp_name, hire_date, dept_name
from emp e join dept d on e.dept_id=d.dept_id
where e.emp_id=100;

-- ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), ��������(job.job_title),
--�ҼӺμ��̸�(dept.dept_name)�� ��ȸ
select emp_id, emp_name, salary, job_title, dept_name  
from emp e inner join job j on e.job_id=j.job_id --3���� ���̺� ���� �ؾ���.
            inner join dept d on e.dept_id=d.dept_id;

-- �μ�_ID(dept.dept_id)�� 30�� �μ��� �̸�(dept.dept_name), ��ġ(dept.loc), 
--�� �μ��� �Ҽӵ� ������ �̸�(emp.emp_name)�� ��ȸ.
select d.dept_name, d.loc, e.emp_name
from emp e join dept d on e.dept_id=d.dept_id
where d.dept_id=30;


--******************CONFUSING**************
--NON EQUI JOIN 
-- ������ ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), �޿����(salary_grade.grade) �� ��ȸ. 
--�޿� ��� ������������ ����
select emp_id, emp_name, salary, grade ||'grade'
from emp e join salary_grade s on e.salary between s.low_sal and s.high_sal   --���̿� �ִٴ� ���� ������
order by grade asc;                       -- between �� ��� ������ non-equi join �̴�.

--TODO: 200����(200 ~ 299) ���� ID(emp.emp_id)�� ���� �������� ����_ID(emp.emp_id), �̸�(emp.emp_name), 
--�޿�(emp.salary), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.
select emp_id, emp_name, e.salary, dept_name, loc
from emp e join dept d on e.dept_id=d.dept_id
where e.emp_id between 200 and 300
order by emp_id;

--TODO ����(emp.job_id)�� 'FI_ACCOUNT'�� ������ ID(emp.emp_id), �̸�(emp.emp_name), ����(emp.job_id), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ.  ����_ID�� ������������ ����.
select emp_id,emp_name,job_id,dept_name, loc
from emp e inner join dept d on e.dept_id=d.dept_id
where e.job_id='FI_ACCOUNT'
order by emp_id asc;


--TODO: Ŀ�̼Ǻ���(emp.comm_pct)�� �ִ� �������� ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), 
--Ŀ�̼Ǻ���(emp.comm_pct), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.
select emp_id, emp_name, salary, comm_pct, dept_name, loc
from emp e inner join dept d on e.dept_id=d.dept_id
where e.comm_pct is not null
order by emp_id asc;

--TODO 'New York'�� ��ġ��(dept.loc) �μ��� �μ�_ID(dept.dept_id), �μ��̸�(dept.dept_name), ��ġ(dept.loc), 
--     �� �μ��� �Ҽӵ� ����_ID(emp.emp_id), ���� �̸�(emp.emp_name), ����(emp.job_id)�� ��ȸ. 
--�μ�_ID �� ������������ ����.
select d.dept_id, d.dept_name, d.loc, e.emp_id, e.emp_name, e.job_id
from dept d join emp e on d.dept_id=e.dept_id --dept�� �ҽ� ���̺��̴ϱ� ���� ����. ������ �مU ����� SAME.
where d.loc='New York'
order by dept_id asc;

--TODO ����_ID(emp.emp_id), �̸�(emp.emp_name), ����_ID(emp.job_id), ������(job.job_title) �� ��ȸ.
select e.emp_id, e.emp_name, e.job_id, j.job_title
from emp e inner join job j on e.job_id=j.job_id;

-- TODO: ���� ID �� 200 �� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), 
--       ��������(job.job_title), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ              
select e.emp_id, e.emp_name, e.salary, j.job_title,d.dept_name
from emp e join dept d on e.dept_id=d.dept_id
            join job j on e.job_id=j.job_id
where e.emp_id=200;

-- TODO: 'Shipping' �μ��� �μ���(dept.dept_name), ��ġ(dept.loc), �Ҽ� ������ �̸�(emp.emp_name),
--������(job.job_title)�� ��ȸ. 
--       �����̸� ������������ ����
select d.dept_name, d.loc, e.emp_name, j.job_title
from emp e join dept d on e.dept_id=d.dept_id
            join job j on e.job_id=j.job_id
where d.dept_name='Shipping'
order by e.emp_name asc;


-- TODO:  'San Francisco' �� �ٹ�(dept.loc)�ϴ� ������ id(emp.emp_id), �̸�(emp.emp_name), 
--�Ի���(emp.hire_date)�� ��ȸ
--         �Ի����� 'yyyy-mm-dd' �������� ���
select e.emp_id, e.emp_name, to_char(e.hire_date,'yyyy-mm-dd')
from emp e join dept d on e.dept_id=d.dept_id
where d.loc='San Francisco'; 

--******************CONFUSING**************
-- TODO: �μ��� �޿�(salary)�� ����� ��ȸ. 
--�μ��̸�(dept.dept_name)�� �޿������ ���. �޿� ����� ���� ������ ����.
-- �޿��� , ���������ڿ� $ �� �ٿ� ���.
select to_char(round(avg(e.salary),2),'fm$999,999')��ձ޿�, d.dept_name 
from  emp e join dept d on e.dept_id=d.dept_id
            join salary_grade s on e.salary between s.low_sal and s.high_sal
group by d.dept_name
order by avg(e.salary) desc;  --��Ī�� �ƴ� ���ڷ� �����ؾ� ��Ȯ. ��Ī�� ���ڿ��� ���ϹǷ� ��Ȯ���� X

--TODO ������ ID(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title), �޿�(emp.salary), 
--     �޿����(salary_grade.grade), �ҼӺμ���(dept.dept_name)�� ��ȸ. ��� ������������ ����
select e.emp_id, e.emp_name, j.job_title, e.salary, s.grade, d.dept_name
from emp e join job j on e.job_id=j.job_id
            join dept d on e.dept_id=d.dept_id
            join salary_grade s on e.salary between s.low_sal and s.high_sal
order by s.grade desc;


--******************CONFUSING**************
--TODO: �޿������(salary_grade.grade) 1�� ������ �Ҽӵ� �μ���(dept.dept_name)�� ��� 1�� ������ ���� ��ȸ. 
--�������� ���� �μ� ������� ����.f
select distinct d.dept_name , count(*)
from emp e join dept d on e.dept_id=d.dept_id
            join salary_grade s on e.salary between s.low_sal and s.high_sal
where s.grade=1
group by d.dept_name
order by 2 asc;

/* ###################################################################################### 
����Ŭ ���� 
- Join�� ���̺���� from���� �����Ѵ�.
- Join ������ where���� ����Ѵ�. 
**���� �ٸ� ���� from ������ �ְ� where������ �ִ´ٴ� ��.

###################################################################################### */
-- ������ ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
-- �Ի�⵵�� �⵵�� ���
select e.emp_id, e.emp_name, to_char(e.hire_date,'yyyy'), d.dept_name
from emp e, dept d    --from ������ ���̺��� ������ �Ѵ�.
where e.dept_id=d.dept_id;

-- ������ ID(emp.emp_id)�� 100�� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date), 
--�ҼӺμ��̸�(dept.dept_name)�� ��ȸ
-- �Ի�⵵�� �⵵�� ���
select e.emp_id, e.emp_name, to_char(e.hire_date,'yyyy'), d.dept_name
from emp e, dept d    --from ������ ���̺��� ������ �Ѵ�.
where e.dept_id = d.dept_id 
and e.emp_id=100;

-- ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), ��������(job.job_title), 
--�ҼӺμ��̸�(dept.dept_name)�� ��ȸ
select e.emp_id, e.emp_name, e.salary, j.job_title
from emp e, dept d, job j    --������ ���̺��� 3���̹Ƿ� �ּ��� 2���� ���ο����� �ʿ��ϴٰ� �� �� �ִ�***************
where e.dept_id=d.dept_id and e.job_id=j.job_id;


--TODO 200����(200 ~ 299) ���� ID(emp.emp_id)�� ���� �������� ����_ID(emp.emp_id), �̸�(emp.emp_name), 
--�޿�(emp.salary), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.
select e.emp_id, e.emp_name, e.salary, d.dept_name, d.loc
from emp e, dept d
where e.dept_id=d.dept_id
and e.emp_id between 200 and 299
order by 1 asc;  

--TODO ����(emp.job_id)�� 'FI_ACCOUNT'�� ������ ID(emp.emp_id), �̸�(emp.emp_name), ����(emp.job_id), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ.  ����_ID�� ������������ ����.
select e.emp_id, e.emp_name, e.job_id, d.dept_name, d.loc
from emp e, dept d
where e.dept_id=d.dept_id 
and e.job_id='FI_ACCOUNT'
order by 1 asc;


--TODO Ŀ�̼Ǻ���(emp.comm_pct)�� �ִ� �������� ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary),
--Ŀ�̼Ǻ���(emp.comm_pct), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.
select e.emp_id, e.emp_name, e.salary, e.comm_pct, d.dept_name,d.loc
from emp e, dept d
where e.dept_id=d.dept_id 
and e.comm_pct is not null
order by 1 asc;

--TODO 'New York'�� ��ġ��(dept.loc) �μ��� �μ�_ID(dept.dept_id), �μ��̸�(dept.dept_name), ��ġ(dept.loc), 
--     �� �μ��� �Ҽӵ� ����_ID(emp.emp_id), ���� �̸�(emp.emp_name), ����(emp.job_id)�� ��ȸ. 
--�μ�_ID �� -������������ ����.
select d.dept_id, d.dept_name, d.loc, e.emp_id, e.emp_name, e.job_id
from emp e, dept d
where e.dept_id=d.dept_id 
and d.loc='New York'
order by 1 asc; 


--TODO ����_ID(emp.emp_id), �̸�(emp.emp_name), ����_ID(emp.job_id), ������(job.job_title) �� ��ȸ.
select e.emp_id, e.emp_name, e.job_id, j.job_title
from emp e, dept d, job j
where e.dept_id=d.dept_id 
and e.job_id=j.job_id;

             
-- TODO: ���� ID �� 200 �� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), 
--       ��������(job.job_title), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ              
select e.emp_id, e.emp_name, e.salary, j.job_title, d.dept_name
from emp e, dept d, job j     --���̺� 3���� �����ϴ� ��.
where e.dept_id=d.dept_id     --�׷��� �ּ� 2���� ���ο����� �����Ѵ�. 
and e.job_id=j.job_id
and e.emp_id=200;


-- TODO: 'Shipping' �μ��� �μ���(dept.dept_name), ��ġ(dept.loc), �Ҽ� ������ �̸�(emp.emp_name), 
--������(job.job_title)�� ��ȸ. 
--       �����̸� ������������ ����
select d.dept_name, d.loc, e.emp_name, j.job_title
from emp e, dept d, job j
where e.dept_id=d.dept_id 
and e.job_id= j.job_id
and d.dept_name='Shipping'
order by 3 desc;

-- TODO:  'San Francisco' �� �ٹ�(dept.loc)�ϴ� ������ id(emp.emp_id), �̸�(emp.emp_name),
--�Ի���(emp.hire_date)�� ��ȸ
--         �Ի����� 'yyyy-mm-dd' �������� ���
select e.emp_id, e.emp_name, to_char(e.hire_date,'yyyy-mm-dd')
from emp e, dept d
where e.dept_id=d.dept_id 
and d.loc='San Francisco';  --��ģ ���̺��� ������ �� �߰��Ѵ�. 

--TODO �μ��� �޿�(salary)�� ����� ��ȸ. �μ��̸�(dept.dept_name)�� �޿������ ���. �޿� ����� ���� ������ ����.
-- �޿��� , ���������ڿ� $ �� �ٿ� ���.
select  d.dept_name, to_char(ceil(avg(e.salary)),'$999,999')
from emp e, dept d
where e.dept_id=d.dept_id
group by d.dept_name
order by 1;

--TODO ������ ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), �޿����(salary_grade.grade) �� ��ȸ. 
--���� id ������������ ����
select e.emp_id, e.emp_name, e.salary, s.grade
from emp e, salary_grade s
where e.salary between s.low_sal and s.high_sal     --non equi join***********
order by 1 asc;

--TODO ������ ID(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title), �޿�(emp.salary), 
--     �޿����(salary_grade.grade), �ҼӺμ���(dept.dept_name)�� ��ȸ. ��� ������������ ����
select e.emp_id, e.emp_name, j.job_title, e.salary, s.grade, d.dept_name
from emp e, job j, dept d, salary_grade s   --4���� ���̺��� ����**
where e.dept_id=d.dept_id 
and e.salary between s.low_sal and s.high_sal
and e.job_id=j.job_id                      --4���� ���̺��̹Ƿ� �ּ� 3���� ���ο���
order by s.grade desc;

--TODO �޿������(salary_grade.grade) 1�� ������ �Ҽӵ� �μ���(dept.dept_name)�� ���1�� ������ ���� ��ȸ.
--�������� ���� �μ� ������� ����.
select d.dept_name, count(*)
from emp e, dept d, salary_grade s
where e.dept_id=d.dept_id
and  e.salary between s.low_sal and s.high_sal
and s.grade=1
group by rollup(d.dept_name)   --**********rollup���� ������... ��ü�� ���� ������~ �׷��� �Ѱ��� 45�� ����!!!
order by 2 asc;

/* ****************************************************
Self ����
- ���������� �ϳ��� ���̺��� �ΰ��� ���̺�ó�� �����ϴ� ��.
-��ȸ�� ����� ���� ���̺� �ִ�.  -->�������� 2���� ���� ������ ��Ų��*** (�ϳ��� ���̺��� 2����!!!)
**************************************************** */
--������ ID(emp.emp_id), �̸�(emp.emp_name), ����̸�(emp.emp_name)�� ��ȸ
select e.emp_id, e.emp_name, m.emp_name    
from emp e join emp m on e.mgr_id=m.emp_id;  --employee �� manager ���̺��� 2�� ����!!!! (�������� �ٸ� ���̺�� �����)

--*************************CONFUSING********************************
-- TODO : EMP ���̺��� ���� ID(emp.emp_id)�� 110�� ������ �޿�(salary)���� ���� �޴� �������� id(emp.emp_id),
--�̸�(emp.emp_name), �޿�(emp.salary)�� ���� ID(emp.emp_id) ������������ ��ȸ.
select e1.emp_id, e1.emp_name, e1.salary 
from emp e1 join emp e2 on e2.emp_id=110
and e2.salary <e1.salary
order by 1 asc;

/* ****************************************************
�ƿ��� ���� (Outer Join)
-inner join �� ������ �����ϴ� �ೢ�� ��ġ�� ��.
-outer join�� ����� ��ȸ��� �Ѵ�.
-���� ������ �ҽ� ���̺��� ���� �� join �ϰ� Ÿ�� ���̺��� ���� ���� ������ �����ϸ� ���̰�, 
--������ null ó��. *****

-ANSI ����
from ���̺�a [LEFT | RIGHT | FULL] OUTER JOIN ���̺�b ON ��������
- OUTER�� ���� ����.
- emp, dept ���̺��� ������ null�� �� ���� ���� ���ؾ���. �װͿ� ���� left, right, full outer join �������ش�. 
(�ҽ� ���̺��� ����ִ��Ŀ� ���� �ٸ�)

left outer join: ���� �� �ҽ� ���̺��� ����
right outer join: ���� �� �ҽ� ���̺��� ������
full outer join: 

-����Ŭ JOIN ����
- FROM ���� ������ ���̺��� ����
- WHERE ���� ���� ������ �ۼ�
    - Ÿ�� ���̺� (+) �� ���δ�.
    - FULL OUTER JOIN�� �������� �ʴ´�.************

**************************************************** */

-- ������ id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), �μ���(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. 
-- �μ��� ���� ������ ������ �������� ��ȸ. (�μ������� null). dept_name�� ������������ �����Ѵ�.
select e.emp_id, e.emp_name, e.salary, d.dept_name, d.loc 
from emp e left outer join dept d on e.dept_id=d.dept_id   --*****8 left outer join�� ���� ���̺��� �� �������� ����.
order by dept_name;

--������ ���̺��� dept�� ��� ������ ���� �ͱ� ������ right outer join�� ����Ѵ�.
select d.dept_id, d.dept_name, d.loc, e.emp_name, e.hire_date
from emp e right outer join dept d on e.dept_id=d.dept_id;

--*******************CONFUSING***********************
-- ��� ������ id(emp.emp_id), �̸�(emp.emp_name), �μ�_id(emp.dept_id)�� ��ȸ�ϴµ�
-- �μ�_id�� 80 �� �������� �μ���(dept.dept_name)�� �μ���ġ(dept.loc) �� ���� ����Ѵ�. (�μ� ID�� 80�� �ƴϸ� null�� ��������)
select e.emp_id, e.emp_name, e.dept_id,d.dept_name, d.loc
from emp e left outer join dept d on e.dept_id=d.dept_id   
and d.dept_id=80;                              --******************* 

--����Ŭ ��������!!!!!
select e.emp_id, e.emp_name, e.dept_id,d.dept_name, d.loc
from emp e, dept d
where e.dept_id=d.dept_id(+)   --���ο���. Ÿ�� ���̺��� dept
and d.dept_id(+)=8;   --�߰������� (+)�� �ٿ���� ���ο����� ��

--full outer join�� �μ��� �������� �ʾƵ� ������ ������ ������, �μ��� ���������� ������ �������� �ʴ�
--��쵵 �� �����ش�. 
select d.dept_id, d.loc,e.emp_id, e.emp_name, e.salary
from dept d full outer join emp e on d.dept_id=e.dept_id
where e.emp_id in (100,175,178)   --right�� emp�� ��� ���� �߰��ǹǷ�.. 175 178�� ����.
or d.dept_id in (260,270,10,60);


--TODO: ����_id(emp.emp_id)�� 100, 110, 120, 130, 140�� ������ ID(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title) �� ��ȸ. 
--      �������� ���� ��� '�̹���' ���� ��ȸ
select e.emp_id, e.emp_name, j.job_title
from emp e left outer join job j on e.job_id=j.job_id
where e.emp_id in (100,110,120,130,140) ;


--����Ŭ ����
select e.emp_id, e.emp_name,e.salary,d.dept_name,d.loc
from emp e,dept d
where e.dept_id=d.dept_id (+)  --*************target ���̺��ٰ� (+) ǥ�ø� �Ѵ�.**************
--�׷��Ƿ� left outer join �̶� �� �� �ִ�.
and e.emp_id in (100,175,178);

--TODO: �μ��� ID(dept.dept_id), �μ��̸�(dept.dept_name)�� �� �μ��� ���� �������� ���� ��ȸ. 
--      ������ ���� �μ��� 0�� �������� ��ȸ�ϰ� �������� ���� �μ� ������ ��ȸ.
select d.dept_id, d.dept_name, count(e.emp_id) ������  --count(*)���� �ϰ� �Ǹ� �� �μ��� ���� ��� 1�� ���´�.
from dept d left join emp e on d.dept_id=e.dept_id --dept�� �ҽ� ���̺�. ������ 0���� ���;��ϴϱ�!!!!!!
group by d.dept_id, dept_name   -- 2���� �� ������Ѵ�. 
order by 3 desc;

-- TODO: EMP ���̺��� �μ�_ID(emp.dept_id)�� 90 �� �������� id(emp.emp_id), �̸�(emp.emp_name), ����̸�(emp.emp_name), 
--�Ի���(emp.hire_date)�� ��ȸ. 
-- �Ի����� yyyy-mm-dd �������� ���
-- ��簡�� ���� ������ '��� ����' ���
select e.emp_id, e.emp_name ����, nvl(m.emp_name, '������') �Ŵ���, to_char(e.hire_date,'yyyy-mm-dd') �Ի���
from emp e, emp m
where e.mgr_id=m.emp_id(+)   --���ο���. 
and e.dept_id(+)=90;   --�߰������� (+)�� �ٿ���� ���ο����� ��

select e.emp_id, e.emp_name, nvl(m.emp_name, '������') ����̸�, e.hire_date
from emp e left join emp m on e.mgr_id=m.emp_id;

--TODO 2003��~2005�� ���̿� �Ի��� ������ id(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title), �޿�(emp.salary), 
--�Ի���(emp.hire_date),
--    ����̸�(emp.emp_name), ������Ի���(emp.hire_date), �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ.
-- �� ��簡 ���� ������ ��� ����̸�, ������Ի����� null�� ���.
-- �μ��� ���� ������ ��� null�� ��ȸ

select e.emp_id, e.emp_name ����, j.job_title, e.salary, e.hire_date,
        m.emp_name �Ŵ���, m.hire_date "����� �Ի���",d.dept_name, d.loc
from emp e left join job j on e.job_id=j.job_id
        left join emp m on e.mgr_id=m.emp_id
        left join dept d on e.dept_id=d.dept_id
where to_char(e.hire_date,'yyyy') between 2003 and 2005;




