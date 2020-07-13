-- DAY 8 ��������

-- TCL(Transaction Control Language)
-- : Ʈ������ ���� ���
-- COMMIT�� ROLLBACK�� �ִ�.

-- Ʈ������
-- �Ѳ����� ����Ǿ�� �� �ּ��� �۾� ������ ���Ѵ�.
-- ���� �۾� ����(Logical Unit of Work : LUW)

-- ���ڼ�
-- �ϳ��� Ʈ���������� �̷���� �۾��� �ݵ�� �Ѳ����� �Ϸ�(COMMIT)
-- �Ǿ�� �ϸ�, �׷��� ������ �Ѳ����� ��� (ROLLBACK) �Ǿ�� �Ѵ�.

-- COMMIT : Ʈ�������۾��� ���� �Ϸ�Ǹ� ���� ������ ������ ����
-- ROLLBACK : Ʈ������ �۾��� ����ϰ� �ֱ� COMMIT �� �������� �̵�
-- SAVEPOINT ���̺� ����Ʈ�� : ���� Ʈ������ �۾� ������ �̸��� ������
--                           �ϳ��� Ʈ������ �ȿ� ������ ����
-- ROLLBACK TO ���̺�����Ʈ�� : Ʈ������ �۾��� ����ϰ�
--                            SAVEPOINT �������� �̵�

CREATE TABLE USER_TBL (
  USERNO NUMBER UNIQUE,
  ID VARCHAR2(20) PRIMARY KEY,
  PASSWORD CHAR(20) NOT NULL
);

INSERT INTO USER_TBL VALUES(1, 'test1', 'pass01');
INSERT INTO USER_TBL VALUES(2, 'test2', 'pass02');
INSERT INTO USER_TBL VALUES(3, 'test3', 'pass03');
COMMIT;

SELECT *FROM USER_TBL;

INSERT INTO USER_TBL VALUES(4, 'test4', 'pass04');

SELECT *FROM USER_TBL;

ROLLBACK;

SELECT *FROM USER_TBL;

INSERT INTO USER_TBL VALUES (4, 'test4', 'pass04');
SAVEPOINT SP1;

INSERT INTO USER_TBL VALUES (5, 'test5', 'pass05');

SELECT *FROM USER_TBL;

-- SAVE POINT�� ���� (4�� ���� ����) ���� ROLLBACK�� �Ѵٸ� (3�� ���� ��������)
-- ���� ROLLBACK �ϰ�, ROLLBACK TO SP1 �ϰ� �Ǹ� ���� (���� ����)
-- ��� ROLLBACK TO SP1 �ϰ� ROLLBACK�� ����.
ROLLBACK TO SP1;

SELECT *FROM USER_TBL;

ROLLBACK;

SELECT *FROM USER_TBL;

-- ���� ������ ���� �Ƚ��ѵ� �� ��� �ȴ� / �ȵȴ� ������
-- DDL
-- ALTER : ��ü�� �����ϴ� ����
-- ���̺�ü ���� : ALTER TABLE ���̺�� ������ ����
-- �÷� �߰�/����/����, �������� �߰�/����/����
-- ���̺�� ����, �������� �̸� ����

-- �÷� �߰�
SELECT *FROM DEPT_COPY;

-- NULL ������ ä����
ALTER TABLE DEPT_COPY 
ADD (LNAME VARCHAR2(20));

-- �÷� ����
ALTER TABLE DEPT_COPY
DROP COLUMN LNAME;

SELECT *FROM DEPT_COPY;

-- �÷� ���� �� DEFAULT�� ����
ALTER TABLE DEPT_COPY
ADD (CNAME VARCHAR2(20) DEFAULT '�ѱ�');

SELECT *FROM DEPT_COPY;

-- �÷��� �������� �߰�
CREATE TABLE DEPT_COPY2
AS SELECT *FROM DEPARTMENT;

-- NOT NULL �������Ǹ� ����Ǿ���..
SELECT *FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2
ADD CONSTRAINT PK_DEPT_ID2 PRIMARY KEY(DEPT_ID);
ALTER TABLE DEPT_COPY2
ADD CONSTRAINT UN_DEPT_TITLE2 UNIQUE (DEPT_TITLE);
-- NOT NULL / NULL�� MODIFY & ���� ���� ���� �̸� ���̷��� 
-- CONSTRAINT�� �ڿ� �ٿ������
ALTER TABLE DEPT_COPY2
MODIFY LOCATION_ID CONSTRAINT NN_LID NOT NULL;

-- �÷��� �ڷ��� ����

-- ���� ��
---------------------------------
-- DEPT_ID CHAR(2 BYTE)
-- DEPT_TITLE VARCHAR2(35 BYTE)
-- LOCATION_ID CHAR(2 BYTE)
---------------------------------
ALTER TABLE DEPT_COPY2
MODIFY DEPT_ID CHAR(3)
MODIFY DEPT_TITLE VARCHAR2(30)
MODIFY LOCATION_ID VARCHAR2(2);

-- ������
---------------------------------
-- DEPT_ID CHAR(3 BYTE)
-- DEPT_TITLE VARCHAR2(30 BYTE)
-- LOCATION_ID VARCHAR(2 BYTE)
---------------------------------

-- �÷��� ũ�⸦ ���̴� ��쿡��
-- �����Ϸ��� ũ�⸦ �ʰ��ϴ� ���� ���� ���� ������ �� �ִ�.
ALTER TABLE DEPT_COPY2
MODIFY DEPT_TITLE VARCHAR2(10);

-- DEFAULT �� ����
SELECT *FROM DEPT_COPY;

ALTER TABLE DEPT_COPY
MODIFY CNAME DEFAULT '�̱�';

-- ���� DEFAULT ���� �ٲ����� ���� '�ѱ�' -> '�̱�' (X)
SELECT *FROM DEPT_COPY;

INSERT INTO DEPT_COPY
VALUES ('D0', '�����', 'L2', DEFAULT);

-- ���Ӱ� �ԷµǴ� ���� '�̱�' DEFAULT ������.
SELECT *FROM DEPT_COPY;

-- �÷� ����
ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_TITLE;

SELECT *FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2
DROP COLUMN LOCATION_ID;

SELECT *FROM DEPT_COPY2;

-- �̰Ŵ� ����� �� �ʿ䰡 �־��.
-- ��� �÷��� ���� �Ұ� (�ּ� 1�� �̻��� �÷��� �����־�� ��)
-- ���̺��� 1�� �̻� �־�� ���̺�μ��� ��ġ�� �ִ�.
ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_ID;

-- �� �ڽ� ���̺��� ����. (��ȯ����) EMPLOYEE ���̺��� EMPLOYEE_ID �� MANAGER_ID
-- ���� EMPLOYEE ���̺� 200�� ����� �ԷµǾ��ٰ� ����(ù��° ������)
-- MANAGER_ID�� NULL�� �Ǿ�� �ϰ� 
-- 2��° ���ͼ��� MANAGER_ID�� 200 �ۼ� ����
-- �׷��Ƿ� MANAGER_ID�� NOT NULL ���������� ���Ǹ� �ȵ�.

-- NULL ��������, �ʼ� ����, ���� ���� (EMP/DEPT) / (EMP/HOBBY)
-- FK�� NULL���� ������� �ʴ´ٸ�
-- ù��° ���� ���� �� �� ����..
-- ���� ������ ������ �����������
CREATE TABLE TB1 (
  PK NUMBER PRIMARY KEY,
  FK NUMBER REFERENCES TB1,
  COL1 NUMBER,
  CHECK (PK > 0 AND COL1 > 0)
);

-- �÷� ���� �� �����ϰ� �ִ� �÷��� �ִٸ� �������� ���Ѵ�.
ALTER TABLE TB1
DROP COLUMN PK;

-- �������ǵ� �Բ� ����
ALTER TABLE TB1
DROP COLUMN PK CASCADE CONSTRAINTS;

SELECT *FROM TB1;

-- �÷� ���� : DROP COLUMN ������ �÷��� �Ǵ� DROP (������ �÷���)
-- �����Ͱ� ��ϵǾ� �־ ������
-- ������ �÷��� ROLLBACK���� ������ �Ұ��� (DDL ������ AUTO COMMIT)
-- ���̺��� �ּ� �� ���� �÷��� �����ؾ� ��.
SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY
DROP (CNAME);

SELECT * FROM DEPT_COPY;

-- ������ �÷� ����
ALTER TABLE DEPT_COPY
DROP (DEPT_TITLE, LOCATION_ID);

SELECT * FROM DEPT_COPY;

-- ROLLBACK �Ұ�
ROLLBACK;

-- �������� ����
CREATE TABLE CONST_EMP (
  ENAME VARCHAR2(20) NOT NULL,
  ENO VARCHAR2(15) NOT NULL,
  MARRIAGE CHAR(1) DEFAULT 'N',
  EID CHAR(3),
  EMAIL VARCHAR2(30),
  JID CHAR(2),
  MID CHAR(3),
  DID CHAR(2),
  -- ���̺� ������ �������� ����
  CONSTRAINT CK_MARRIAGE CHECK (MARRIAGE IN ('Y', 'N')),
  CONSTRAINT PK_EID PRIMARY KEY(EID),
  CONSTRAINT UN_ENO UNIQUE(ENO),
  CONSTRAINT UN_EMAIL UNIQUE(EMAIL),
  CONSTRAINT FK_JID FOREIGN KEY(JID)
  REFERENCES JOB(JOB_CODE) ON DELETE SET NULL,
  CONSTRAINT FK_MID FOREIGN KEY(MID)
  REFERENCES CONST_EMP ON DELETE SET NULL,
  CONSTRAINT FK_DID FOREIGN KEY(DID)
  REFERENCES DEPARTMENT ON DELETE CASCADE
);

-- �������� 1�� ���� ��
ALTER TABLE CONST_EMP
DROP CONSTRAINT CK_MARRIAGE;

-- �������� ���� �� ���� ��
ALTER TABLE CONST_EMP
DROP CONSTRAINT FK_DID
DROP CONSTRAINT FK_JID
DROP CONSTRAINT FK_MID;

-- NOT NULL �������� ���� �� MODIFY ���
ALTER TABLE CONST_EMP
-- MODIFY (ENAME NULL, ENO NULL)
MODIFY ENAME NULL
MODIFY ENO NULL;

-- �÷��� �̸� ����
CREATE TABLE DEPT_COPY3
AS SELECT *FROM DEPARTMENT;

SELECT *FROM DEPT_COPY3;

-- RENAME COLUMN A TO B ���
ALTER TABLE DEPT_COPY3
RENAME COLUMN DEPT_ID TO DEPT_CODE;

SELECT *FROM DEPT_COPY3;

-- �������� �̸� ����
ALTER TABLE DEPT_COPY3
ADD CONSTRAINT PK_DEPT_CODE3 PRIMARY KEY(DEPT_CODE);

-- RENAME CONSTRAINT A TO B
ALTER TABLE DEPT_COPY3
RENAME CONSTRAINT PK_DEPT_CODE3 TO PK_DCODE;

-- ���̺� �̸� ����
ALTER TABLE DEPT_COPY3
RENAME TO DEPT_TEST;

SELECT *FROM DEPT_COPY3;
SELECT *FROM DEPT_TEST;

-- ���̺� ����
DROP TABLE DEPT_TEST; --CASCADE CONSTRAINT �������ǵ� �Բ� ����;

-- ����� ���� ���� (����) - ����� ���� ������ System ����
DROP USER jinho;

SELECT
       UC.TABLE_NAME
     , UCC.COLUMN_NAME
     , UC.CONSTRAINT_NAME
     , UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC
  JOIN USER_CONS_COLUMNS UCC ON(UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
 WHERE UC.TABLE_NAME = 'DEPT_COPY2';

-- ������ ��ųʸ�(DATA DICTIONARY)
-- �ڿ��� ȿ�������� �����ϱ� ���� �پ��� ������ �����ϴ� �ý��� ���̺�
-- ����ڰ� ���̺��� �����ϰų�, ����ڸ� �����ϴ� ���� �۾��� �� ��
-- �����ͺ��̽� ������ ���� �ڵ����� ���ŵǴ� ���̺�
-- ����ڴ� ������ ��ųʸ� ������ ���� �����ϰų� ������ �� ����

-- ���� ���̺��� Ŀ���͸���¡�ؼ� �����ִ� ���� ���̺��� ���� ���̺� ��ü(VIEW)

-- 3���� ��ųʸ� ��� ����
-- 1. DBA_XXX : �����ͺ��̽� �����ڸ� ���� ������ ��ü ���� ���� ��ȸ
-- 2. ALL_XXX : �ڽ��� ���� + ������ �ο����� ��ü�� ���� ��ȸ
-- 3. USER_XXX : �ڽ��� ������ ������ ��ü� ���� ���� ��ȸ

SELECT * FROM DBA_USERS;

-- OR REPLACE�� ������ �����Ѵٸ� ��ü�ض�.
CREATE OR REPLACE VIEW V_EMP(���, �̸�, �μ�)
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE
     FROM EMPLOYEE;
    
-- �ý��� �������� GRANT CREATE VIEW TO EMPLOYEE;
 
-- ��
SELECT * FROM V_EMP;

-- �ζ��� ��
SELECT *FROM (SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_CODE �μ� FROM EMPLOYEE);

-- �� ��ü ����
DROP VIEW V_EMP;

-- VIEW(��)
-- SELECT �������� ������ ��ü�̴�.
-- �������� �����͸� �����ϰ� ���� ����
-- ���̺��� ����ϴ� �Ͱ� �����ϰ� ����� �� �ִ�.
-- CREATE [OR REPLACE] VIEW ���̸� AS ��������

-- ���, �̸�, ���޸�, �μ���, �ٹ������� ��ȸ�ϰ�
-- �� ����� V_RESULT_EMP��� �並 �����ؼ� �����ϼ���
CREATE OR REPLACE VIEW V_RESULT_EMP AS
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE, L.LOCAL_NAME
  FROM EMPLOYEE E -- ���̽����̺�
  LEFT JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
  LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);
     
SELECT *FROM V_RESULT_EMP
WHERE EMP_ID = 205;

-- �信 ���� ������ Ȯ���ϴ� ������ ��ųʸ�
SELECT *FROM USER_VIEWS;

-- ���̽� ���̺��� ������ ����Ǹ� VIEW�� ���� ����ȴ�.
COMMIT;

SELECT *FROM EMPLOYEE WHERE EMP_ID = 205;

-- DML ��ɾ�� ������ �Ұ����� ���
-- 1. �� ���ǿ� ���Ե��� ���� �÷��� �����ϴ� ���
-- 2. �信 ���Ե��� ���� �÷��߿�,
--    ���̽��� �Ǵ� ���̺� �÷��� NOT NULL ���������� ������ ���
-- 3. ���ǥ�������� ���ǵ� ���
-- 4. JOIN�� �̿��� ���� ���̺��� ������ ���
-- 5. DISTINCT�� ������ ���
-- 6. �׷��Լ��� GROUP BY ���� ������ ���

-- ������(SEQUENCE)
-- �ڵ� ��ȣ �߻��� ������ �ϴ� ��ü
-- ���������� ���� ���� �ڵ����� ��������
/*
  CREATE SEQUENCE ������ �̸�
  [INCREMENT BY ����] -- ���� ���� ���� ����ġ, �����ϸ� �ڵ� 1 �⺻
  [START WITH ����] -- ó�� �߻���ų �� ����, �����ϸ� �ڵ� 1 �⺻
  [MAXVALUE ���� | NOMAXVALUE] -- �߻���ų �ִ밪 ���� (10�� 27�±���)
  [MINVALUE ���� | NOMINVALUE] -- �߻���ų �ּڰ� ���� (-10�� 26�±���)
  [CYCLE | NOCYCLE] -- �� ��ȯ,
  CYCLE : 0 ~ 10 -> 10 ������ 0
  NOCYCLE : 10 �������� ���� �߻�
  [CACHE ����Ʈũ�� | NOCACHE] -- ĳ�� ��� ����, �⺻���� 20����Ʈ, �ּҴ� 2����Ʈ
  CACHE -> �������� �߰��� ����� ���� �̾
  NOCACHE -> ĳ�� ��� ���� ����
*/

CREATE SEQUENCE SEQ_EMPID
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

-- ���� �� ���� �� �߻����� �ʾƼ�
SELECT SEQ_EMPID.CURRVAL FROM DUAL;

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;

-- ������ ���� 
-- START WITH �� ALTER�� ���� �Ұ� (DROP �� �ٽ� �����ؾ���)
-- ���� �� ���浵 DROP�� �ٽ� �����ؾ���
-- ������ INCREMENT �� ���� �� �ٽ� ������ ���� �� ����

-- ���� �������� 222�̰� 100���� �ٲ�� �Ѵٸ�
-- ALTER SEQUENCE [SEQUENCE_NAME] INCREMENT BY -122;
-- SELECT [SEQUENCE_NAME].CURRVAL FROM DUAL  Ȯ���ϰ�
-- ALTER SEQUENCE [SEQUENCE_NAME] INCREMENT BY 1;
ALTER SEQUENCE SEQ_EMPID
INCREMENT BY 10
MAXVALUE 400
NOCYCLE
NOCACHE;

-- SELECT ������ ��� ����
-- INSERT ������ SELECT �������� ��� ����
-- INSERT ������ VALUES������ ��� ���� (���������� �̰�)
-- UPDATE ������ SET������ ��� ����

-- ��, ���������� SELECT ������ ��� �Ұ�
-- VIEW�� SELECT ������ ��� �Ұ�
-- DISTINCT Ű���尡 �ִ� SELECT ������ ��� �Ұ�
-- GROUP BY, HAVING ���� �ִ� SELECT������ ��� �Ұ�
-- ORDER BY ������ ��� �Ұ�
-- CREATE TABLE, ALTER TABLE�� DEFAULT������ ��� �Ұ�

CREATE SEQUENCE SEQ_EID
START WITH 300
INCREMENT BY 1
MAXVALUE 10000
NOCYCLE
NOCACHE;

INSERT INTO EMPLOYEE
VALUES (SEQ_EID.NEXTVAL, 'ȫ�浿', '666666-6666666',
        'hong_gd@kh.or.kr', '01012344444', 'D2', 'J7', 'S1',
        5000000, 0.1, 200, SYSDATE, NULL, DEFAULT);

SELECT *FROM EMPLOYEE;

ROLLBACK;

DROP SEQUENCE SEQ_EID;

CREATE SEQUENCE SEQ_EID2;

-- �ε��� (INDEX)
-- : SQL ��ɹ��� ó�� �ӵ��� ����Ű�� ���ؼ�
-- �÷��� ���� �����ϴ� ����Ŭ ��ü�̴�.
-- �ε��� ���� ������ ���� Ʈ�� �������� �����Ǿ� �ִ�.
-- �ε����� �����ϴ� ���� ó�� �ӵ��� ����Ű�� ������ ������ ������,
-- �ݵ�� �ε����� ����ϴ� ���� ���� ���� �ƴϴ�.

-- ����
-- �˻� �ӵ��� ������

-- ����
-- �ε����� ���� �߰� ���� ������ �ʿ���
-- �ε����� �����ϴµ� �ð��� �ɸ�
-- �������� ���� �۾�(INSERT/UPDATE/DELETE)�� ���� �Ͼ�� ��� ������ ������ ���ϵ�

-- �ε����� �����ϴ� ������ ��ųʸ�
SELECT *FROM USER_IND_COLUMNS;

-- ���� ���� �� F10 -> OPTIMIZER
-- HINT �ּ��� �̿��� OPTIMIZER���� ��ĵ ��� �˸�
-- F10 �̿��� Ȯ�� �� ���� FULL SCAN -> INDEX ROWID�� �ٲ�
SELECT /*+ INDEX_DESC(EMPLOYEE ����Ƽ1_PK) */ EMP_NAME
FROM EMPLOYEE;

SELECT *
FROM EMPLOYEE
WHERE EMP_ID > '0';

-- �ε����� ����
-- 1. ���� �ε��� (UNIQUE INDEX)
-- 2. ����� �ε��� (NON UNIQUE INDEX)
-- 3. ���� �ε��� (SINGLE INDEX)
-- 4. ���� �ε��� (COMPOSITE INDEX)
-- 5. �Լ� ��� �ε��� (FUNCTION BASED INDEX)

-- ���Ǿ�(SYNONYM)
-- �ٸ� �����ͺ��̽� ���� ��ü�� ���� ���� Ȥ�� ���Ӹ�
-- ���� ����ڰ� ���̺��� �����ϴ� ���
-- �ٸ� ����ڰ� ���̺� ������ �� '����ڸ�.���̺��'���� ǥ����
-- ���Ǿ ����ϸ� �����ϰ� ����� �� �ִ�.
-- EMPLOYEE.EMPLOYEE -> EMP�� ��ȸ

-- �������
-- CREATE SYNONYM ���Ӹ� FOR ����ڸ�.��ü��;

CREATE SYNONYM EMP FOR EMPLOYEE;

SELECT *FROM EMP;
SELECT *FROM EMPLOYEE;