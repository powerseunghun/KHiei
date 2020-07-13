GRANT CREATE VIEW TO EMPLOYEE;
GRANT CREATE SYNONYM TO EMPLOYEE;

SELECT *FROM EMPLOYEE.EMPLOYEE;
SELECT *FROM EMPLOYEE.DEPARTMENT;

CREATE PUBLIC SYNONYM DEPT FOR EMPLOYEE.DEPARTMENT;

DROP SYNONYM DEPT;

-- <����� ����>
-- : ������� ������ ��ȣ ����, ���� �ο�
-- ����Ŭ �����ͺ��̽��� ��ġ�ϸ� �⺻������ �����Ǵ� ����
-- 1. SYS
-- 2. SYSTEM
-- 3. SCOTT(������ ���ð���) : 11G���� ������ �����ؾ���
-- 4. HR (���ð���) : ó������ ����� �ְ�, 11G������ ����

-- ������ ���� �����ͺ��̽� ������
-- : ����ڰ� �����ͺ��̽� ��ü(���̺�, �� ��)�� ����
--   Ư�� ������ ���� �� �ְ� �ϴ� ������ ����
--   �ټ��� ����ڰ� �����ϴ� �����ͺ��̽� ������ ���� ���� ����
--   �����ͺ��̽��� �����ϴ� ����ڸ��� ���� �ٸ� ���Ѱ� ���� �ο���
-- ���� : ����ڰ� Ư�� ���̺� ������ �� �ֵ��� �ϰų�
--        �ش� ���̺� SQL(SELECT/INSERT/UPDATE/DELETE)����
--        ����� �� �ֵ��� ������ �δ� ��

-- �ý��۱��� : �����ͺ��̽� �����ڰ� ������ �ִ� ����
--             CREATE USER(����� ���� �����)
--             DROP USER(����� ���� ����)
--             DROP ANY TABLE (������ ���̺� ����)
--             QUERY REWRITE (�Լ� ��� �ε��� ���� ����) (�����)
--             BACKUP ANY TABLE (���̺� ���)

-- �ý��� �����ڰ� ����ڿ��� �ο��ϴ� ����
-- CREATE SESSION (�����ͺ��̽��� ����)
-- CREATE TABLE (���̺� ����)
-- CREATE VIEW (�� ����)
-- CREATE SEQUENCE (������ ����)
-- CREATE PROCEDURE (���ν��� ���� ����)

-- SAMPLE / SAMPLE ���� ����
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;

GRANT CREATE SESSION TO SAMPLE;

-- ���̺� ����� ����.. �׷��� ���� ���̺� ���� �ȵ�(���̺� �����̽� �Ҵ� �ȵ�)
GRANT CREATE TABLE TO SAMPLE;

-- ���̺� �����̽�(TABLE SPACE) : ���̺� �Ӹ� �ƴ϶�
-- : ���̺�, ��, �� �� �ۿ� �����ͺ��̽� ��ü���� ����Ǵ� ���̺���� ���
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;

-- WITH ADMIN OPTION
-- : ����ڿ��� �ý��� ������ �ο��� �� ���
--   ������ �ο����� ����ڴ� �ٸ� ����ڿ��� ������ ������ �� ����
GRANT CREATE SESSION TO SAMPLE
WITH ADMIN OPTION;

-- ��ü ���� : ���̺��̳� ��, ������, �Լ� �� �� ��ü����
--            DML(SELECT/INSERT/UPDATE/DELETE)�� �� �� �ִ� ������ �ο���
-- GRANT �������� [(�÷���)] | ALL
-- ON ��ü�� | ROLE �̸� | PUBLIC
-- TO ������̸�;

-- ���� ����        ���� ��ü
-- ALTER          TABLE, SEQUENCE
-- DELETE         TABLE, VIEW
-- EXECUTE        PROCEDURE
-- INDEX          TABLE
-- REFERENCES     TABLE
-- INSERT         TABLE, VIEW
-- SELECT         TABLE, VIEW, SEQUENCE
-- UPDATE         TABLE, VIEW

-- SAMPLE���� EMPLOYEE�� EMPLOYEE ���̺� ��ȸ ����
GRANT SELECT ON EMPLOYEE.EMPLOYEE TO SAMPLE;

-- WITH GRANT OPTION
-- : ����ڰ� �ش� ��ü�� ������ �� �ִ� ������ �ο������鼭
--   �� ������ �ٸ� ����ڿ��� �ٽ� �ο��� �� �ִ� ���� �ɼ�
GRANT SELECT ON EMPLOYEE.EMPLOYEE TO SAMPLE
WITH GRANT OPTION;

-- ���� öȸ
-- : REVOKE ��ɾ� ���
REVOKE SELECT ON EMPLOYEE.EMPLOYEE FROM SAMPLE;

-- <�����ͺ��̽� ROLE - ��������>
-- : ����ڸ��� ������ ������ �ο��ϴ� ���� ���ŷӱ� ������
--   �����ϰ� ������ �ο��� �� �ִ� ������� ROLE�� �����Ѵ�.

-- ��(ROLE)
-- : ����ڿ��� ���� �����ϰ� �ο��� �� �ֵ���
--   ���� ���� ������ ������� ��

-- ���� ����
-- 1. ������ ���ǵ� ��
-- : ����Ŭ ��ġ �� �ý��ۿ��� �⺻������ ������
-- CONNECT ROLE
-- �ý��� ���� 8������ ���� ����
-- CREATE SESSION, ALTER SESSION
-- CREATE TABLE, CREATE VIEW
-- CREATE SYNONYM, CREATE SEQUENCE
-- CREATE CLUSTER, CREATE DATABASE LINK

-- RESOURCE ROLE
-- : ����ڰ� ��ü�� ������ �� �ֵ��� �ϴ� ������ ���� ����
-- CREATE CLUSTER, CREATE PROCEDURE
-- CREATE SEQUENCE, CREATE TABLE,
-- CREATE TRIGGER

-- 9���� ���Ŀ��� CONNECT, RESOURCE�� ������ �����
-- CONNECT ROLE : CREATE SESSION 
-- RESOURCE : CREATE CLUSTER, CREATE PROCEDURE,
--            CREATE SEQUENCE, CREATE TABLE
--            CREATE TRIGGER, CREATE TYPE,
--            CREATE INDEXTYPE, CREATE OPERATOR

-- 2. ����ڰ� �����ϴ� ��
-- : CREATE ROLE ������� �� ����
--   �� ������ �ݵ�� DBA ������ �ִ� ����ڸ� �� �� ����
-- CREATE ROLE ���̸�;         -- 1. �ѻ���
-- GRANT �������� TO ���̸�;    -- 2. ������ �ѿ� ���� �߰�
-- GRANT ���̸� TO ������̸�;  -- 3. ����ڿ��� �� �ο�

-- �� ���ε��� �ϼ���
CREATE ROLE MYROLE;
GRANT CREATE SESSION, CREATE TABLE TO MYROLE;
GRANT MYROLE TO SAMPLE;

-- �� ���ε��� �ϼ���
-- ������ ������ ����� ����
-- �����ڰ��� : �����ͺ��̽��� ���� ������ ������ ����ϴ� ��������(Super User)�����̸�,
--             ������Ʈ(Object)�� ����, ����, ���� ���� �۾��� �����ϴ�.
--             �����ͺ��̽��� ���� ��� ���Ѱ� å���� ������ �����̴�.
-- ����ڰ��� : �����ͺ��̽��� ���Ͽ� ����(Query), ����, ���� �ۼ� ���� �۾��� �����ϴ� ����
--             �Ϲ� ������ ������ ���Ͽ� ������ �ʿ��� �ּ����� ������ ������ ����
--             ��Ģ���� �Ѵ�.
