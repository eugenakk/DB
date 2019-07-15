/* **************************************************************************
��������(Sub Query) 
- �����ȿ��� select ������ ����ϴ� ��.
- ���� ���� - ��������

���������� ���Ǵ� ��
 - select��, from��, where��, having�� 
 
***���������� ����***
- ��� ������ ���Ǿ������� ���� ����  (select��, from��, where��, having�� �� ����)
    - ��Į�� �������� - select ���� ���. �ݵ�� �������� ����� 1�� 1��(�� �ϳ�-��Į��) 0���� ��ȸ�Ǹ� null�� ��ȯ
    - �ζ��� �� - from ���� ���Ǿ� ���̺��� ������ �Ѵ�.
    
�������� ��ȸ��� ����� ���� ����
    - ������ �������� - ���������� ��ȸ��� ���� �� ���� ��.
    - ������ �������� - ���������� ��ȸ��� ���� ���� ���� ��.
    
���� ��Ŀ� ���� ����
    - ����(�񿬰�) ��������
        - ���������� ���������� �÷��� ������ �ʴ´�. 
        -���������� ����� ���� ���������� �����ϴ� ������ �Ѵ�.
            (���� ������ ���� �� ��---> ���� ������ �����ش�)  
            
    - ���(����) �������� - ������������ ���������� �÷��� ����Ѵ�. 
                            ���������� ���� ����Ǿ� ������ �����͸� ������������ ������ �´��� Ȯ���ϰ��� �Ҷ� �ַ� ����Ѵ�. 
                            
************************************************************************** */
-- ����_ID(emp.emp_id)�� 120���� ������ ���� ����(emp.job_id)���� 
-- ������ id(emp_id),�̸�(emp.emp_name), ����(emp.job_id), �޿�(emp.salary) ��ȸ
select job_id
from emp
where emp_id=120;    --���⼭ ���� ������� ST_MAN

select *
from emp 
where job_id='ST_MAN';   --������ ���� ������� ����Ͽ� ��ȸ�Ѵ�. 

select *
from emp 
where job_id= (select job_id        --������ 2���� ������ �ʿ���� �ѹ���!
from emp                            --������������ �����Ѵ�. (�ݵ�� ��ȣ�� ������� �Ѵ�)
where emp_id=120);                  --�ٱ��ʰ� ���������� ����ȴ�. 

-- ����_id(emp.emp_id)�� 115���� ������ ���� ����(emp.job_id)�� �ϰ� ���� �μ�(emp.dept_id)�� ���� �������� ��ȸ�Ͻÿ�.
select job_id, dept_id
from emp
where emp_id=115;            --���� �� ����� ���´�. 

select *
from emp
where job_id='PU_MAN'
and dept_id=30;  --�̰��� ���������� �ۼ��ϸ�..


select *
from emp
where (job_id, dept_id) = (select job_id, dept_id   --�������̹Ƿ�... �̷��� �ۼ��Ѵ�.. 
from emp
where emp_id=115);

-- ������ �� �޿�(emp.salary)�� ��ü ������ ��� �޿����� ���� 
-- �������� id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary)�� ��ȸ. �޿�(emp.salary) �������� ����.
select emp_id, emp_name, salary
from emp
where salary<(
select avg(salary) 
from emp)
order by emp.salary asc;

-- ��ü ������ ��� �޿�(emp.salary) �̻��� �޴� �μ���  �̸�(dept.dept_name), �Ҽ��������� ��� �޿�(emp.salary) ���. 
-- ��ձ޿��� �Ҽ��� 2�ڸ����� ������ ��ȭǥ��($)�� ���� ������ ���
select d.dept_name, to_char(avg(salary),'$999,999.99')
from emp e, dept d 
where e.dept_id=d.dept_id(+)  --null�� �������� outer join (+) �߰��Ѵ�. 
group by d.dept_name 
having avg(salary) >(select avg(salary) from emp);


-- TODO: ������ ID(emp.emp_id)�� 145�� �������� ���� ������ �޴� �������� 
--�̸�(emp.emp_name)�� �޿�(emp.salary) ��ȸ.
-- �޿��� ū ������� ��ȸ
select e.emp_name, e.salary
from emp e
where e.salary> (select salary
from emp
where emp_id=145)
order by 2 desc;


-- TODO: ������ ID(emp.emp_id)�� 150�� ������ ���� ����(emp.job_id)�� �ϰ� ���� 
--���(emp.mgr_id)�� ���� �������� 
-- id(emp.emp_id), �̸�(emp.emp_name), ����(emp.job_id), ���(emp.mgr_id) �� ��ȸ
select e.emp_id, e.emp_name, e.job_id, e.mgr_id
from emp e
where (job_id, mgr_id)= (select emp.job_id, emp.mgr_id    --pair������� !!!!!!!
from emp 
where emp.emp_id=150);

-- TODO : EMP ���̺��� ���� �̸���(emp.emp_name)��  'John'�� ������ �߿��� 
--�޿�(emp.salary)�� ���� ���� ������ salary(emp.salary)���� ���� �޴� 
-- �������� id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary)�� ���� ID(emp.emp_id) ������������ ��ȸ.
select e.emp_id, e.emp_name, e.salary, e.emp_id
from emp e
where e.salary > (select max(e.salary)
from emp e
where e.emp_name='John')
order by 1 asc;


-- TODO: �޿�(emp.salary)�� ���� ���� ������ ���� 
--�μ��� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ.
select d.dept_name, d.loc
from emp e join dept d on e.dept_id=d.dept_id
where e.salary=(select max(e.salary)
from emp e);

--���� ��������...
select *
from dept d, emp e
where e.dept_id=d.dept_id
and e.salary = (select max(salary) from emp);

-- TODO: 30�� �μ�(emp.dept_id) �� ��� �޿�(emp.salary)���� �޿��� ���� �������� ��� ������ ��ȸ.
select *
from emp e
where e.salary > (select avg(e.salary)
from emp e
where e.dept_id=30);

-- TODO: ��� ����ID(emp.job_id) �� 'ST_CLERK'�� �������� ��� �޿����� ���� �޿��� ������ �޴� �������� ��� ������ ��ȸ. 
--�� ���� ID�� 'ST_CLERK'�� �ƴ� �����鸸 ��ȸ. 
select *
from emp e 
where e.salary < (select avg(e.salary)
from emp e
where e.job_id!='ST_CLERK');   -- != �� ����Ѵ�.


-- TODO: �޿�(emp.salary)�� ���� ���� �޴� �������� �̸�(emp.emp_name), �μ���(dept.dept_name), �޿�(emp.salary) ��ȸ. 
--       �޿��� �տ� $�� ���̰� ���������� , �� ���
select e.emp_name, d.dept_name, to_char(e.salary,'$999,999')
from emp e join dept d on e.dept_id=d.dept_id
where e.salary = (select max(e.salary)
from emp e);


-- TODO: EMP ���̺��� ����(emp.job_id)�� 'IT_PROG' �� �������� ��� �޿� �̻��� �޴� 
-- �������� id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary)�� �޿� ������������ ��ȸ.
select e.emp_id, e.emp_name, e.salary
from emp e
where e.salary> (select avg(e.salary)
from emp e
where e.job_id='IT_PROG')
order by 3 desc;

-- TODO: 'IT' �μ�(dept.dept_name)�� �ִ� �޿����� ���� �޴� ������ ID(emp.emp_id), �̸�(emp.emp_name), 
--�Ի���(emp.hire_date), �μ� ID(emp.dept_id), �޿�(emp.salary) ��ȸ
-- �Ի����� "yyyy�� mm�� dd��" �������� ���
-- �޿��� �տ� $�� ���̰� ���������� , �� ���
select to_char(e.hire_date,'yyyy"��" mm"��" dd"��"'), e.dept_id, to_char(e.salary,'$999,999')
from emp e join dept d on e.dept_id=d.dept_id
where e.salary> (
select max(e.salary)
from emp e join dept d on e.dept_id=d.dept_id
where d.dept_name='IT');

/* ----------------------------------------------
 ������ ��������
 - ���������� ��ȸ ����� �������� ���
 - where�� ������ ������
	- in
	- �񱳿����� any : ��ȸ�� ���� �� �ϳ��� ���̸� �� (where �÷� > any(��������) )
	- �񱳿����� all : ��ȸ�� ���� ��ο� ���̸� �� (where �÷� > all(��������) )
------------------------------------------------*/

--'Alexander' �� �̸�(emp.emp_name)�� ���� ������(emp.mgr_id)�� 
-- ���� �������� ID(emp_id), �̸�(emp_name), ����(job_id), �Ի�⵵(hire_date-�⵵�����), �޿�(salary)�� ��ȸ

select emp_id, emp_name, job_id, to_char(hire_date,'yyyy'), salary
from emp e
where e.mgr_id in (select emp_id     -- ��ȸ ����� �������� �����Ƿ�.. ������ ����******
from emp                           --�̷� ������ ������ �����ڸ� ���.*** (in)
where emp_name='Alexander');

-- ���� ID(emp.emp_id)�� 101, 102, 103 �� ������ ���� �޿�(emp.salary)�� ���� �޴� ������ ��� ������ ��ȸ.
select * 
from emp e
where e.salary >all (select salary      -- >all �� ����ؼ� ��� ���� ���̾�� ��ȸ�ǵ��� �Ѵ�. 
                    from emp
                    where emp_id in (101,102,103));

-- ���� ID(emp.emp_id)�� 101, 102, 103 �� ������ �� �޿��� ���� ���� �������� �޿��� ���� �޴� ������ ��� ������ ��ȸ.
select * 
from emp e
where e.salary >any (select salary   -- >all �� ����ؼ� ��� ���� ���̾�� ��ȸ�ǵ��� �Ѵ�. 
                    from emp
                    where emp_id in (101,102,103));

-- TODO : �μ� ��ġ(dept.loc) �� 'New York'�� �μ��� �Ҽӵ� ������ 
--ID(emp.emp_id), �̸�(emp.emp_name), �μ�_id(emp.dept_id) �� sub query�� �̿��� ��ȸ.
select e.emp_id, e.emp_name, e.dept_id
from emp e 
where dept_id in (select dept_id
                    from dept
                    where loc='New York');

-- ****���� ����� ���͵� �������� ��� OR JOIN ���!!! (2���� ����� �ִ�)


-- TODO : �ִ� �޿�(job.max_salary)�� 6000������ ������ ����ϴ� 
--����(emp)�� ��� ������ sub query�� �̿��� ��ȸ.
select *
from emp e 
where job_id in (select job_id 
                    from job
                    where max_salary<=6000);

-- TODO: �μ�_ID(emp.dept_id)�� 20�� �μ��� ������ ���� �޿�(emp.salary)�� ���� �޴� �������� ������ sub query�� �̿��� ��ȸ.
select *
from emp e
where e.salary >all (select salary
from emp
where dept_id=20);


-- TODO: �μ��� �޿��� ����� 
--���� ���� �μ��� ��� �޿����� ���� ���� �޴� ������� �̸�, �޿�, ������ ���������� �̿��� ��ȸ
select *
from emp
where salary >any (select avg(salary)
                    from emp
                    group by dept_id);
                    
                    
-- TODO: ���� id(job_id)�� 'SA_REP' �� �������� ���� ���� �޿��� �޴� �������� ���� �޿��� �޴� 
--�������� �̸�(emp_name), �޿�(salary), ����(job_id) �� subquery�� �̿��� ��ȸ.
select emp_name, salary, job_id
from emp
where salary>all (select salary         --max������ ū ���̴ϱ�..  >all�� ����ؾ��Ѵ�. 
                    from emp
                    where job_id='SA_REP');

/* ****************************************************************
���(����) ����
-������������ ��ȸ���� ���������� ���ǿ��� ����ϴ� ����.
-���������� �����ϰ� �� ����� �������� ���������� �������� ���Ѵ�.
* ****************************************************************/
-- �μ���(DEPT) �޿�(emp.salary)�� ���� ���� �޴� 
--�������� id(emp.emp_id), �̸�(emp.emp_name), ����(emp.salary), �ҼӺμ�ID(dept.dept_id) ��ȸ
select * 
from emp e
where salary= (select max(salary) from emp where dept_id=e.dept_id); --�ٱ��� ������ �ִ� ���� id�� �����ͼ� ���������� Ư���÷��� ���Ѵ�. 

/* ******************************************************************************************************************
EXISTS, NOT EXISTS ������ (���(����)������ ���� ���ȴ�)-->��ǥ�� ������**

-- ���������� ����� �����ϴ� ���� �����ϴ��� ���θ� Ȯ���ϴ� ����. 
������ �����ϴ� ���� �������� ���ุ ������ ���̻� �˻����� �ʴ´�.

-Transaction ���̺�: ���, ������ �����Ѵ�. *********
ex) �ֹ� ���̺�(�ֹ� ���� (�� ����, ..��)) 
-->� ���� ���̺� �ִ��� ������ Ȯ���ϱ� ���� ��.

**********************************************************************************************************************/
-- ������ �Ѹ��̻� �ִ� �μ��� �μ�ID(dept.dept_id)�� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ
select dept_id, dept_name, loc
from dept d 
where exists (select emp_id from emp where dept_id=d.dept_id); --���� ��µǴ� ���� �����ϴ� ��

-- ������ �Ѹ� ���� �μ��� 
--�μ�ID(dept.dept_id)�� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ
select dept_id, dept_name, loc
from dept d 
where not exists (select emp_id from emp where dept_id=d.dept_id) --���� ��µǴ� ���� �����ϴ� ��!
order by 1;

-- �μ�(dept)���� ����(emp.salary)�� 13000�̻��� �Ѹ��̶� �ִ� �μ��� 
--�μ�ID(dept.dept_id)�� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ
select dept_id, dept_name, loc
from dept d 
where exists (select emp_id from emp where dept_id=d.dept_id
                                        and emp.salary>=13000) --���� ��µǴ� ���� �����ϴ� ��!
order by 1;

/* ******************************
�ֹ� ���� ���̺�� �̿�.
******************************* */
--TODO: ��(customers) �� �ֹ�(orders)�� �ѹ� �̻� �� ������ ��ȸ.
select *
from customers c
where exists (select order_id from orders where cust_id= c.cust_id);

--TODO: ��(customers) �� �ֹ�(orders)�� �ѹ��� ���� ���� ������ ��ȸ.
select *
from customers c
where not exists (select order_id from orders where cust_id= c.cust_id);

--TODO: ��ǰ(products) �� �ѹ��̻� �ֹ��� ��ǰ ���� ��ȸ
select *
from products p
where exists (select order_id from order_items where product_id= p.product_id);

--TODO: ��ǰ(products)�� �ֹ��� �ѹ��� �ȵ� ��ǰ ���� ��ȸ
select *
from products p
where not exists (select order_id from order_items where product_id= p.product_id);


/***
inline-view : sub-query�� from ������ ���.

view: ���̺��� ������� ����Ŭ���� ���� ���� ���� �� �ִ�.
--->����ڰ� ������ ���� �����͸� �����̺�� ������ش�. (���� ���� �����͸� ����)

--subquery�� ��ȸ����� ���̺�� �ؼ� main ������ ����ȴ�. 
*/

--emp ���̺��� ��ü ���̺��� ��ȸ ������� �ϴ� ���� �ƴ϶�, ���� ������ ������ ������� �� �ٽ� select�� �� �ֵ��� �Ѵ�. 

--inline view�� ������������ �÷� ��Ī (alisa)�� �����ϸ� main ���������� ��Ī�� ����ؾ� �Ѵ�.
select *         ---���⼭ ��ȸ�� �� �ִ� ����� �� ���̺��� ������ �÷��� ���̴�. 
from (select emp_id e_id, emp_name e_name, job_id , dept_id 
from emp where dept_id=60) e,
dept d  --����, ���̺��� �����ϰ� �ʹٸ� ���� �̸��� ����������Ѵ�. 
where e.dept_id=d.dept_id;


--rownum �÷�: ��ȸ ��� ���ȣ�� ��ȯ
select rownum , emp_id, emp_name
from emp
where rownum<=5;   --rownum 5���� ��ȸ .

select rownum , emp_id, emp_name, salary
from emp
where rownum<=5
order by salary desc;

--from������ ó��,
--2��°��where
--select
--order by ������ ....ó��

--**** select������ rownum�� �پ��� ������, ������ ������ ��Ȯ���� X�������� �߻�.
--�׷���...������ �� �� rownum�� ����Ѵ�. ---->inline view�� ����ؾ��Ѵ�. 
--(������������ ������ ���� �ϰ� �Ѵ�)

select rownum, emp_id, emp_name, salary
from(
select *    --������ ����� from�����ٰ� �ִ´� !!!!!!!!!!!!!
from emp
order by salary desc)
where rownum<=5;

--salary�� ���� ���� (5~10�� �������� ��ȸ)

select rownum ����, emp_id, emp_name, salary, d.dept_id, d.dept_name
    from(
            select rownum rank, emp_id, emp_name, salary,dept_id
                from(
                        select *    --������ ����� from�����ٰ� �ִ´� !!!!!!!!
                        from emp
                        order by salary desc 
                    ) 
--where rownum>5; -- �߰��� ���� ���� ����� �ȳ��´�****
--where rownum between 5 and 10;    -- ����� �ȳ���.
--where rownum>=1;      --�̰��� �����ϴ�. 
            )  e, dept d
            where e.dept_id = d.dept_id   --���ο���
            and rank between 5 and 10;


select rownum ����, emp_id, emp_name, salary, dept_id
from (
    select rownum rank, emp_id, emp_name, salary, dept_id
            from
            (
            select e.emp_id, e.emp_name, e.salary, d.dept_id
            from emp e left join dept d on e.dept_id=d.dept_id
            order by e.salary desc
            )
)
where rank between 5 and 10;


--�Ի����� ���� ���� 10��
select *
from (select * 
from emp
order by hire_date asc)
where rownum<=10;


--�Ի����� ���� ���� 10��
select *
from (select * 
from emp
order by hire_date desc)
where rownum<=10;



















