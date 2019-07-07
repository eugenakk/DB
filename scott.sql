/*
���̺�:customer
�÷�: id: varchar2(10)
    name: nvarchar2(10)
    age: number(3)
    gender: char(1)  ����: F, ����: M
    join_date: Date
*/
create table customer(
    id varchar2(10),
    name nvarchar2(10),
    age number(3),
    gender char(1),
    join_date date
);
--���̺� �� ���� ������ �߰�
/*
    insert into ���̺��̸� (�÷���, �÷���,...) values (��,��,....)
*/
insert into customer (id,name,age,gender,join_date)
    values ('my-id','ȫ�浿',20,'M','2000-10-05');

insert into customer
    values ('id-10','ȫ�浿',20,'M','2000-10-05');

insert into customer (id,name,age)
    values ('my-id2','������',20);

--��ȸ
select *
from customer;

--���̺��� ����.(�����ͱ��� �� ���󰣴�)
drop table customer;

--���̺��� ���������� ���ؼ� �ٽ� ����!
create table customer(
    id varchar2(10) PRIMARY KEY,  --primary key �÷� (not null�̸鼭 �������� ���� �Ӽ�)
    name nvarchar2(10) not null,   --null�� ���� �� ���� �÷�
    age number(3) not null,   
    gender char(1),
    join_date date
);
--��������: ���� ���鿡 ���� ������ �� �� ����.
--�ʼ����� �Ӽ� ����/ �⺻Ű ����/ 

insert into customer 
    values ('my-id10','������',24,'M','2018-10-05');
    
 insert into customer (id)
    values ('my-id3');
    

insert into customer (id,name,age)
    values ('my-id11','�ڿ���',22);
    

    
    