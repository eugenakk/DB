/*
1. ��ǰ ���̺��� ��ǰ_ID �÷��� _Primary Key �÷����� �� ���� �ٸ� ��� �ĺ��� �� ���ȴ�.

2. ��ǰ ���̺��� ������ �÷��� Not Null(NN) �� ������ ���� _null_ �� ������ ���� ����.

3. �� ���̺��� �ٸ���� �ĺ��� �� ����ϴ� �÷��� _cust_id__ �̴�. 
asd
4. �� ���̺��� ��ȭ��ȣ �÷��� ������ Ÿ���� _varchar2_ ���� _���ڿ�_������ �� _15_����Ʈ ������ �� ������
   NULL ���� _���� �� �ִ�_.asd
   
5. �� ���̺��� ������ �÷��� ���� 4�� ó�� ������ ���ÿ�.
  �� ���̺��� ������ �÷��� ������ Ÿ���� _date_ ���� _��¥_������ �� _x_����Ʈ ������ �� ������
   NULL ���� _���� �� ����__.
   
6. �ֹ� ���̺��� �� 5�� �÷��� �ִ�. ���� Ÿ���� _3_���̰� ���ڿ� Ÿ���� _2_�� �̰� ��¥ Ÿ���� _1_���̴�.

7. �� ���̺�� �ֹ����̺��� ���� ���谡 �ִ� ���̺��Դϴ�.
    �θ����̺��� _��_���̺�_ �̰� �ڽ� ���̺��� __�ֹ� ���̺�_�̴�.
    �θ����̺��� _PRIMARY KEY (��_id)_�÷��� �ڽ����̺��� _FOREIGN KEY(��_id)_�÷��� �����ϰ� �ִ�.
    �����̺��� ������ �����ʹ� �ֹ����̺��� _n����_ ��� ���谡 ���� �� �ִ�.
    �ֹ����̺��� ������ �����̺��� _1����_��� ���谡 ���� �� �ִ�.
    
8. �ֹ� ���̺�� �ֹ�_��ǰ ���̺��� ���� ���谡 �ִ� ���̺��Դϴ�.
    �θ� ���̺��� __�ֹ� ���̺� _ �̰� �ڽ� ���̺��� __�ֹ�_��ǰ ���̺�_____�̴�.
    �θ� ���̺��� __�ֹ�_ids___�÷��� �ڽ� ���̺��� _�ֹ�_id(FOREIGN KEY)_�÷��� �����ϰ� �ִ�.
    �ֹ� ���̺��� ������ �����ʹ� �ֹ�_��ǰ ���̺��� _0~n����_ ��� ���谡 ���� �� �ִ�.
    �ֹ�_��ǰ ���̺��� ������ �ֹ� ���̺��� _1����_��� ���谡 ���� �� �ִ�.
    
9. ��ǰ�� �ֹ�_��ǰ�� ���� ���谡 �ִ� ���̺��Դϴ�. 
    �θ� ���̺��� _��ǰ_ �̰� �ڽ� ���̺��� _�ֹ�_��ǰ_�̴�.
    �θ� ���̺��� _��ǰ_id(PRIMARY KEY)__�÷��� �ڽ� ���̺��� _��ǰ_id(FOREIGN KEY)_�÷��� �����ϰ� �ִ�.
    ��ǰ ���̺��� ������ �����ʹ� �ֹ�_��ǰ ���̺��� _0~n��_ ��� ���谡 ���� �� �ִ�.
    �ֹ�_��ǰ ���̺��� ������ ��ǰ ���̺��� _1����_��� ���谡 ���� �� �ִ�.
*/

-- TODO: 4���� ���̺� � ������ �ִ��� Ȯ��.
desc products;
desc customers;
desc order_items;
desc orders;

-- TODO: �ֹ� ��ȣ�� 1�� �ֹ��� �ֹ��� �̸�, �ּ�, �����ȣ, 
--��ȭ��ȣ ��ȸ
select c.cust_name, c.address, c.postal_code, c.phone_number
from customers c join orders o on c.cust_id=o.cust_id
where o.order_id=1;

--����Ŭ ��������
select c.cust_name, c.address, c.postal_code, c.phone_number
from customers c, orders o
where c.cust_id=o.cust_id 
and o.order_id=1;

-- TODO : �ֹ� ��ȣ�� 2�� �ֹ��� �ֹ���, �ֹ�����, �ѱݾ�, 
--�ֹ��� �̸�, �ֹ��� �̸��� �ּ� ��ȸ
select o.order_date, o.order_status, o.order_total, c.cust_name, c.cust_email
from orders o join customers c on c.cust_id=o.cust_id
where o.order_id=2;

--����Ŭ ��������
select o.order_date, o.order_status, o.order_total, c.cust_name, c.cust_email
from customers c, orders o
where o.cust_id=c.cust_id   --where���� ���� ������ ��� X
and o.order_id=2;

-- TODO : �� ID�� 120�� ���� �̸�, ����, �����ϰ� 
--���ݱ��� �ֹ��� �ֹ������� �ֹ�_ID, �ֹ���, �ѱݾ��� ��ȸ
select c.cust_name, c.gender, c.join_date, o.order_id, o.order_date,o.order_total
from customers c join orders o on  c.cust_id=o.cust_id
where c.cust_id=120; 

--����Ŭ �������� ����...
select c.cust_name, c.gender, c.join_date, o.order_id, o.order_date,o.order_total
from customers c, orders o
where c.cust_id=o.cust_id
and c.cust_id=120;

-- TODO : �� ID�� 110�� ���� �̸�, �ּ�, ��ȭ��ȣ, �װ� ���ݱ���
--�ֹ��� �ֹ������� �ֹ�_ID, �ֹ���, �ֹ����� ��ȸ
 select c.cust_name, c.address, c.phone_number, o.order_id, o.order_date, o.order_status
from customers c join orders o on  c.cust_id=o.cust_id
where c.cust_id=110;

--����Ŭ ����
select c.cust_name, c.address, c.phone_number, o.order_id, o.order_date, o.order_status
from customers c, orders o
where c.cust_id=o.cust_id
and c.cust_id=110;

-- TODO : �� ID�� 120�� ���� ������ ���ݱ��� �ֹ��� �ֹ������� ��� ��ȸ.
select *
from customers c join orders o on  c.cust_id=o.cust_id
where c.cust_id=120;

--����Ŭ ����
select *
from customers c , orders o 
where c.cust_id=o.cust_id
and c.cust_id=120;

-- TODO : '2017/11/13'(�ֹ���¥) �� �ֹ��� �ֹ��� �ֹ����� ��_ID, �̸�, �ֹ�����, �ѱݾ��� ��ȸ
 select c.cust_id, c.cust_name, o.order_status, o.order_total
from customers c join orders o on  c.cust_id=o.cust_id
where to_char(o.order_date,'yyyy/mm/dd')='2017/11/13';

-- TODO : �ֹ��� ID�� 1�� �ֹ���ǰ�� ��ǰ�̸�, �ǸŰ���, ��ǰ������ ��ȸ.
select p.product_name, oi.sell_price, p.price
from products p join order_items oi on p.product_id=oi.product_id
where oi.ordere_item_id=1;

--����Ŭ ����
select p.product_name, oi.sell_price, p.price
from products p, order_items oi
where p.product_id=oi.product_id
and oi.ordere_item_id=1;

-- TODO : �ֹ� ID�� 4�� �ֹ��� �ֹ� ���� �̸�, �ּ�, �����ȣ, �ֹ���, �ֹ�����, �ѱݾ�, 
--�ֹ� ��ǰ�̸�, ������, ��ǰ����, �ǸŰ���, ��ǰ������ ��ȸ.
--************************CONFUSING**************************
select c.cust_name, c.address, c.postal_code,
o.order_date, o.order_status, o.order_total,
p.product_name, p.maker, p.price, oi.sell_price, oi.quantity
from orders o join order_items oi on o.order_id=oi.order_id
                join customers c on c.cust_id=o.cust_id
                join products p on oi.product_id=p.product_id
where o.order_id=4;

--����Ŭ ���� 
select c.cust_name, c.address, c.postal_code,
o.order_date, o.order_status, o.order_total,
p.product_name, p.maker, p.price, oi.sell_price, oi.quantity
from customers c, orders o, order_items oi, products p
where c.cust_id=o.cust_id
and o.order_id=oi.order_id
and p.product_id=oi.product_id
and o.order_id=4;

-- TODO : ��ǰ ID�� 200�� ��ǰ�� 2017�⿡ � �ֹ��Ǿ����� ��ȸ.
select count(*)
from products p join order_items oi on p.product_id=oi.product_id
                join orders o on oi.order_id=o.order_id
where p.product_id=200
and to_char(o.order_date,'yyyy')='2017';

--����Ŭ ����
select count(*)
from products p, order_items oi, orders o
where p.product_id=oi.product_id
and oi.order_id=o.order_id 
and p.product_id=200
and to_char(o.order_date,'yyyy')='2017';

-- TODO : ��ǰ�з��� �� �ֹ����� ��ȸ
select category, count(*)
from products p join order_items oi on p.product_id=oi.product_id
group by p.category;


