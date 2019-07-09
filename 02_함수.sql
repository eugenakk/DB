/* *************************************
�Լ� - ���ڿ����� �Լ�
 UPPER()/ LOWER() : �빮��/�ҹ��� �� ��ȯ
 INITCAP(): �ܾ� ù���ڸ� �빮�� ������ �ҹ��ڷ� ��ȯ
 LENGTH() : ���ڼ� ��ȸ
 LPAD(��, ũ��, ä�ﰪ) : "��"�� ������ "ũ��"�� �������� ���ڿ��� ����� ���ڶ�� ���� ���ʺ��� "ä�ﰪ"���� ä���.
 RPAD(��, ũ��, ä�ﰪ) : "��"�� ������ "ũ��"�� �������� ���ڿ��� ����� ���ڶ�� ���� �����ʺ��� "ä�ﰪ"���� ä���.
 SUBSTR(��, ����index, ���ڼ�) - "��"���� "����index"��° ���ں��� ������ "���ڼ�" ��ŭ�� ���ڿ��� ����. ���ڼ� ������ ������. 
 REPLACE(��, ã�����ڿ�, �����ҹ��ڿ�) - "��"���� "ã�����ڿ�"�� "�����ҹ��ڿ�"�� �ٲ۴�.
 LTRIM(��): �ް��� ����
 RTRIM(��): �������� ����
 TRIM(��): ���� ���� ����
 ************************************* */
 
select 'abc', upper('abc'), lower('ABC'), initcap('abc def_ghi')
from dual;

select length('alala')
from dual;

select * 
from emp
where length(emp_name) >=7;

select lpad('test',10,'-')
from dual;

select replace('A--B--C','-','#')
from dual;


--EMP ���̺��� ������ �̸�(emp_name)�� ��� �빮��, �ҹ���, ù���� �빮��, �̸� ���ڼ��� ��ȸ



-- TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary), �μ�(dept_name)�� ��ȸ. 
--�� �����̸�(emp_name)�� ��� �빮��, �μ�(dept_name)�� ��� �ҹ��ڷ� ���.
-- UPPER/LOWER
select emp_id, upper(emp_name), salary, lower(dept_name)
from emp;


--(�Ʒ� 2���� �񱳰��� ��ҹ��ڸ� Ȯ���� �𸣴� ����)
--TODO: EMP ���̺��� ������ �̸�(emp_name)�� PETER�� ������ ��� ������ ��ȸ�Ͻÿ�.
select emp_name
from emp
where upper(emp_name)='PETER';


--TODO: EMP ���̺��� ����(job)�� 'Sh_Clerk' �� ��������  
--ID(emp_id), �̸�(emp_name), ����(job), �޿�(salary)�� ��ȸ
select emp_id, emp_name, job, salary
from emp
where initcap(job)='Sh_Clerk';


--TODO: ���� �̸�(emp_name) �� �ڸ����� 15�ڸ��� ���߰� ���ڼ��� ���ڶ� ��� ������ �տ� �ٿ� ��ȸ. ���� �µ��� ��ȸ
select lpad(emp_name,15,' ')
from emp;
    
--TODO: EMP ���̺��� ��� ������ �̸�(emp_name)�� �޿�(salary)�� ��ȸ.
--(��, "�޿�(salary)" ���� ���̰� 7�� ���ڿ��� �����, ���̰� 7�� �ȵ� ��� ���ʺ��� �� ĭ�� '_'�� ä��ÿ�. EX) ______5000) -LPAD() �̿�
select emp_name,
    lpad(salary,7,'_')salary
    from emp;


-- TODO: EMP ���̺��� �̸�(emp_name)�� 10���� �̻��� �������� �̸�(emp_name)�� �̸��� ���ڼ� ��ȸ
select emp_name, length(emp_name)
from emp
where length(emp_name)>=10;



/* *************************************
�Լ� - ���ڰ��� �Լ�
 round(��, �ڸ���) : �ڸ������� �ݿø� (��� - �Ǽ���, ���� - ������)
 trunc(��, �ڸ���) : �ڸ������� ����(��� - �Ǽ���, ���� - ������)
 ceil(��) : �ø�
 floor(��) : ����
 mod(�����¼�, �����¼�) : �������� ������ ����

************************************* */
select ceil(50.123) --������ �ø�.
from dual;

--ceil�� flooor�� ����� ����.

select round(50.123),
        round(50.79),
        round(50.1234,2)   --�Ҽ��� 2�ڸ� ���� �ݿø�.
        from dual;
        
select round(12345, -1),  --10���� ���Ͽ��� �ݿø�
        round(12378,-2)   --100���� ���Ͽ��� �ݿø�
    from dual;
    
--�ڸ���: 0 (�ܴ���), ����-->�Ǽ���, ���-->������

select trunc(1234.56,-2), -- -2�� 2 ���Ͽ��� �߶�����ϱ� 1200
trunc(1234.56,-1), --1230
trunc(1234.56,0), --1234
trunc(1234.56,1),  --1234.5
trunc(1234.56,2)    --1234.56
from dual;

select mod(10,3)   --10������ 3�� ������.
from dual;

--TODO: EMP ���̺��� �� ������ ���� ����ID(emp_id), �̸�(emp_name), �޿�(salary) 
--�׸��� 15% �λ�� �޿�(salary)�� ��ȸ�ϴ� ���Ǹ� �ۼ��Ͻÿ�.
--(��, 15% �λ�� �޿��� �ø��ؼ� ������ ǥ���ϰ�, ��Ī�� "SAL_RAISE"�� ����.)
select emp_id,emp_name,salary, ceil(salary*1.15) as SAL_RAISE
from emp;


--TODO: ���� SQL������ �λ� �޿�(sal_raise)�� �޿�(salary) 
--���� ������ �߰��� ��ȸ (����ID(emp_id), �̸�(emp_name), 15% �λ�޿�, �λ�� �޿��� ���� �޿�(salary)�� ����)
select emp_id,emp_name,salary, ceil(salary*1.15) as SAL_RAISE, 
ceil(salary*1.15)-salary 
from emp;


-- TODO: EMP ���̺��� Ŀ�̼��� �ִ� �������� ����_ID(emp_id), �̸�(emp_name), 
--Ŀ�̼Ǻ���(comm_pct), Ŀ�̼Ǻ���(comm_pct)�� 8% �λ��� ����� ��ȸ.
--(�� Ŀ�̼��� 8% �λ��� ����� �Ҽ��� ���� 2�ڸ����� �ݿø��ϰ� ��Ī�� comm_raise�� ����)

select emp_id,emp_name,comm_pct,
round(comm_pct*1.08,2) comm_raise
from emp
where comm_pct is not null;


/* *************************************
�Լ� - ��¥���� ��� �� �Լ�
Date +- ���� : ��¥ ���.
sysdate --�������ڰ� �����ϱ� ()�� ���� �ʴ´�. (��������� �Ͻ�)
systimestamp: ��������� �Ͻ�. timestamp.
months_between(d1, d2) -����� ������(d1�� �ֱ�, d2�� ����)
add_months(d1, ����) - �������� ���� ��¥. ������ ��¥�� 1���� �Ĵ� ���� ������ ���� �ȴ�. 
next_day(d1, '����') - d1���� ù��° ������ ������ ��¥. ������ �ѱ�(locale)�� �����Ѵ�.
last_day(d) - d ���� ��������.
extract(year|month|day from date) - date���� year/month/day�� ����
************************************* */

select sysdate
from dual;

select systimestamp
from dual;

select to_char(sysdate,'yyyy/mm/dd hh24:mi:ss')  --hh24�� 24�ð����� �����޶�� ��.
from dual;

select sysdate-10
from dual;

select add_months(sysdate,10),
        add_months(sysdate,12*3)  --3�� ��.
from dual;

select months_between (sysdate,'2015-07-05')
from dual;

select months_between (sysdate,'2015-07-01')
from dual;

select next_day(sysdate,'�Ͽ���')
from dual;

select last_day(sysdate)
from dual;

select hire_date, last_day(hire_date)
from emp;

select extract(year from hire_date),
extract(month from hire_date),
extract(day from hire_date)
from emp;


select * 
from emp
where extract (year from hire_date)=2004;

--TODO: EMP ���̺��� �μ��̸�(dept_name)�� 'IT'�� �������� '�Ի���(hire_date)�� ���� 10����',
--�Ի��ϰ� '�Ի��Ϸ� ���� 10����',  �� ��¥�� ��ȸ. 
select hire_date-10, hire_date, hire_date+10
from emp;

--TODO: �μ��� 'Purchasing' �� ������ �̸�(emp_name), �Ի� 6�������� �Ի���(hire_date), 6������ ��¥�� ��ȸ.
select add_months(hire_date,-6), hire_date, add_months(hire_date,+6)
from emp
where dept_name='Purchasing';

--TODO: EMP ���̺��� �Ի��ϰ� �Ի��� 2�� ��, �Ի��� 2�� �� ��¥�� ��ȸ.
select add_months(hire_date,-2), hire_date, add_months(hire_date,+2)
from emp;

-- TODO: �� ������ �̸�(emp_name), �ٹ� ������ (�Ի��Ͽ��� ��������� �� ��)�� ����Ͽ� ��ȸ.
--(�� �ٹ� �������� �Ǽ� �� ��� ������ �ݿø�. �ٹ������� ������������ ����.)
select emp_name,
    round(months_between(sysdate,hire_date))
from emp
order by 2 desc;


--TODO: ���� ID(emp_id)�� 100 �� ������ �Ի��� ���� ù��° �ݿ����� ��¥�� ���Ͻÿ�.
select hire_date,next_day(hire_date,'�ݿ���')
from emp
where emp_id=100;
/* *************************************
�Լ� - ��ȯ �Լ�

to_char() : ������, ��¥���� ���������� ��ȯ
to_char(���, ����� ����) : � ���·� �ٲٰ� ������ �˷�����Ѵ�. 
to_number() : �������� ���������� ��ȯ 
to_number('2,000','0,000') --->� ������ �������� �˷������
to_date() : �������� ��¥������ ��ȯ
to_date('10','yy')   -- ������� ���� �˷���.
���Ĺ��� 

***format ����***
���� 
0, 9: ������ �ڸ��� ���� (9:���� �ڸ��� �������� ä���, 0�� 0���� ä���.)
                      (fm���� �����ϸ� 9�� ��� ������ ����)
. : ����/�Ǽ��� ������
',': ������ ����������. 
'L','$':��ȭǥ��. L:���� ��ȭ��ȣ. (�츮�� ��ȭ)

�Ͻ� 
yyyy :���� 4�ڸ�. yy: ���� 2�ڸ� -->��� ������ 2000���.
      rr: ���� 2�ڸ��ε�, 50�̻��� 90���, 50�̸��� 2000���.
mm: �� 2�ڸ� 
dd: �� 2�ڸ�
hh24: 24�ð��� �û�. 00��~23�ñ��� ǥ��.
hh: 1~12�ñ���.
mi:�� 2�ڸ�
ss;: �� 2�ڸ�
day(����)
am �Ǵ� pm : �� �߿� �ƹ��ų� �ᵵ ��. �������� ���� ���� ǥ��. am,pm�ᵵ ����� �Ȱ��� ����.

************************************* */
select '10'    --10�� ���⼭ ���ڰ� �ƴ϶� ���ڴ�. ���� 10�� ��� �Ұ�.
from dual;

--�� �Ʒ� ���� ����� �ȴ�. ����Ŭ�� �ڵ������� '10'�� �˾Ƽ� ���ڷ� �ٲ��ش�. 
select '10'+10    
from dual;

--����Ŭ�� �ڵ������� ����ȯ ���ش�. ('2010'�� �ǵ��ߴ� -->'10'�� )
select '10'-10
from dual;

--����� ��ȯ
select to_date('10','yy')-10
from dual;

select to_char(1234567,'9,999,999')
from dual;

select to_char(12345,'9,999,999')a,
to_char(12345,'fm9,999,999')a1,
to_char(12345,'0,000,000')a2,
to_char(1234567,'9,999')a3,

--�Ҽ��� ���� ���ڸ������� �ĸ�
to_char(12345.6789, '99999.99')  ,
to_char(5000,'$9,999'),
to_char(5000,'L9,999'),
to_char(5000,'9,999')|| '��'
from dual;

select to_number('4,000','0,000') +10,
to_number('$5,000','$9,999')+50
from dual;

select sysdate,
    to_char(sysdate,'yyyy-mm-dd'),
    to_char(sysdate,'yyyy-mm-dd hh24:mi')
from dual;

select to_char(sysdate, 'hh24'),
to_char(sysdate, 'hh24am mi')||'��'
from dual;

--��/��/�� 
select to_char(sysdate, 'yyyy"��" mm"��" dd"��"' )
from dual;

--�� ��° ��***
select to_char(sysdate, 'w')
from dual;

--1�� �߿� �� ��° ������ �˷��ش�. 
select to_char(sysdate, 'ww')
from dual;

--4�б� �߿� �� ��° �б� ���� �˷��ش�. 
select to_char(sysdate, 'q')
from dual;

--������ ���ڷ� ǥ�� (�Ͽ����� 1, ������� 7)
select to_char(sysdate, 'd')
from dual;

select to_date('20191010','yyyymmdd')-10,
        to_date('201005','yyyymm')
        -- ���� ������ �ȵǾ� ������ ��� ���� ����Ʈ�� 00 ���� . 
from dual; 

-- EMP ���̺��� ����(job)�� "CLERK"�� ���� �������� ID(emp_id), �̸�(name), ����(job), �޿�(salary)�� ��ȸ
--(�޿��� ���� ������ , �� ����ϰ� �տ� $�� �ٿ��� ���.)
select emp_id, emp_name, job, salary,
        to_char(salary,'fm$99,999.99') sal
from emp
where job like '%CLERK%';
desc emp;

-- ���ڿ� '20030503' �� 2003�� 05�� 03�� �� ���.
--********�̰��� char-->char�� �ٲ���� �ϴ� ��*************
--format�� �ٲ�����Ѵ�.  �׷��� ���ؼ���..
--char �� date���� �ٲ� �� �ٽ� char�� �ٲ�����Ѵ�.
select to_char(to_date('20030503','yyyymmdd'),'yyyy"��" mm"��" dd"��"' )as today
from dual;

-- TODO: �μ���(dept_name)�� 'Finance'�� �������� ID(emp_id), �̸�(emp_name)�� �Ի�⵵(hire_date) 
--4�ڸ��� ����Ͻÿ�. (ex: 2004);
--to_char()
select emp_id, emp_name, to_char(hire_date,'yyyy"��"') �Ի�⵵
from emp
where dept_name='Finance'
order by 3;

--TODO: �������� 11���� �Ի��� �������� ����ID(emp_id), �̸�(emp_name), �Ի���(hire_date)�� ��ȸ
--to_char()
select emp_id, emp_name, hire_date
from emp
where to_char(hire_date,'mm')=11;
--where extract (month from hire_date)='11';

--TODO: 2006�⿡ �Ի��� ��� ������ �̸�(emp_name)�� �Ի���(yyyy-mm-dd ����)�� �Ի���(hire_date)�� ������������ ��ȸ
--to_char()
select emp_name, to_char(hire_date,'yyyy-mm-dd')
from emp
where to_char(hire_date,'yyyy')=2006
--where extract (year from hire_date)=2006;
order by 2;

--TODO: 2004�� 01�� ���� �Ի��� ���� ��ȸ�� �̸�(emp_name)�� �Ի���(hire_date) ��ȸ
select emp_name, hire_date
from emp
where to_char(hire_date,'yyyy')>=2004 and to_char(hire_date,'mm')>=1;
--where to_char(hire_date,'yyyymm')>='200401';

-- ���ڿ� '20100107232215' �� 2010�� 01�� 07�� 23�� 22�� 15�� �� ���. (dual ���Ժ� ���)
select to_char(to_date('20100107232215','yyyymmddhh24miss'),'yyyy"��" mm"��" dd"��" hh24"��" mi"��"ss"��"')
from dual;

/* *************************************
�Լ� - null ���� �Լ� 
NVL(expr1,expr2) : expr1�� not null�̸� expr1 ��ȯ, null�̸� expr2 ��ȯ.
NVL2(expr, nn, null) - expr�� null�� �ƴϸ� nn, ���̸� ����°
nullif(ex1, ex2) ���� ������ null, �ٸ��� ex1.
 coalesce (ex1,ex2,ex3,.....) ex=exn �� null�� �ƴ� ù��° ���� ��ȯ!
************************************* */

select nvl(null,0) 
from dual;

select nullif(10,10), nullif(10,20) 
from dual;

select emp_id, comm_pct, mgr_id, dept_name,
    coalesce(comm_pct, mgr_id)
from emp
where emp_id in (150,100,101);

-- EMP ���̺��� ���� ID(emp_id), �̸�(emp_name), �޿�(salary),
--Ŀ�̼Ǻ���(comm_pct)�� ��ȸ. �� Ŀ�̼Ǻ����� NULL�� ������ 0�� ��µǵ��� �Ѵ�..
select emp_id, emp_name,salary, nvl(comm_pct,0)
from emp;

--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), ����(job), �μ�(dept_name)�� ��ȸ. 
--�μ��� ���� ��� '�μ��̹�ġ'�� ���.
select emp_id, emp_name, job, nvl(dept_name,'�μ��̹�ġ')
from emp
where dept_name is null;

--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary), Ŀ�̼� (salary * comm_pct)�� ��ȸ. 
--Ŀ�̼��� ���� ������ 0�� ��ȸ�Ƿ� �Ѵ�.
select emp_id, salary, 
    to_char(nvl(salary*comm_pct,0),'$9999')
from emp;

/* *************************************
DECODE�Լ��� CASE ��
decode(�÷�, [�񱳰�, ��°�, ...] , else���) 

case�� �����
case �÷� when �񱳰� then ��°�
              [when �񱳰� then ��°�]
              [else ��°�]
              end 
              
case�� ���ǹ�
case when ���� then ��°�
       [when ���� then ��°�]
       [else ��°�]
       end

************************************* */
select decode(dept_name,null,'�μ�����')
from emp
where dept_name is null;

select 
--case dept_name when null then '�μ�����' end
    case when dept_name is null then '�μ�����' end
from emp
where dept_name is null;

--EMP���̺��� �޿��� �޿��� ����� ��ȸ�ϴµ� �޿� ����� 10000�̻��̸� '1���', 
--10000�̸��̸� '2���' ���� �������� ��ȸ
-- ********������ decode�� case �÷� when ���� ǥ�� X
select salary, case when salary>=10000 then '1���'
               else '2���'
                end as ���
from emp;

--TODO: EMP ���̺��� ����(job)�� 'AD_PRES'�ų� 'FI_ACCOUNT'�ų� 'PU_CLERK'�� �������� ID(emp_id),
--�̸�(emp_name), ����(job)�� ��ȸ. 
-- ����(job)�� 'AD_PRES'�� '��ǥ', 'FI_ACCOUNT'�� 'ȸ��', 'PU_CLERK'�� ��� '����'�� ��µǵ��� ��ȸ
select emp_id, emp_name, decode(job, 'AD_PRES','��ǥ',
                                        'FI_ACCOUNT','ȸ��',
                                        'PU_CLERK','����','��Ÿ')
from emp
where job in ('AD_PRES','FI_ACCOUNT','PU_CLERK');

---------------------------------------------------------------------------
select emp_id, emp_name, case job when 'AD_PRES' then'��ǥ'
                                    when 'FI_ACCOUNT' then 'ȸ��'
                                    when 'PU_CLERK' then '����'
                                    else '��Ÿ'
                                    end as job2
from emp
where job in ('AD_PRES','FI_ACCOUNT','PU_CLERK');


--TODO: EMP ���̺��� �μ��̸�(dept_name)�� �޿� �λ���� ��ȸ. �޿� �λ���� �μ��̸��� 'IT' �̸�
--�޿�(salary)�� 10%�� 'Shipping' �̸� �޿�(salary)�� 20%�� 'Finance'�̸� 30%�� �������� 0�� ���
-- decode �� case���� �̿��� ��ȸ
select dept_name,case dept_name when 'IT' then salary*1.1
                                when 'Shipping' then salary*1.2
                                when 'Finance' then salary*1.3
                                else '0'
                                end
from emp;

--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary), �λ�� �޿��� ��ȸ�Ѵ�. 
--�� �޿� �λ����� �޿��� 5000 �̸��� 30%, 5000�̻� 10000 �̸��� 20% 10000 �̻��� 10% �� �Ѵ�.
select emp_id, emp_name, salary, 
    case when salary<5000 then salary*1.3
            when salary between 5000 and 10000 then salary*1.2
            else
            salary*1.1
            end as "�λ�� �޿�"
from emp;

--decode()/case �� �̿��� ����
-- �������� ��� ������ ��ȸ�Ѵ�. �� ������ ����(job)�� 'ST_CLERK', 'IT_PROG',S
--'PU_CLERK', 'SA_MAN' ������� ������������ �Ѵ�. (������ JOB�� �������)
select*
from emp
order by decode (job, 'ST_CLERK',1,
                    'IT_PROG',2,
                    'PU_CLERK',3,
                    'SA_MAN',4);

