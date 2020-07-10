-- DAY 6 ��������

-- DDL(DATA DEFINITION LANGUAGE) : ������ ���� ���
-- ��ü(OBJECT)�� �����(CREATE), ����(ALTER)�ϰ�, ����(DROP) �ϴ� ����

-- ����Ŭ ��ü
-- : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE),
--   �ε���(INDEX), ��Ű��(PACKAGE), Ʈ����(TRIGGER),
--   ���Ǿ�(SYNONYM), ���ν���(PROCEDURE), �Լ�(FUNCTION), �����(USER)

-- ���̺� �����
-- [ǥ����] :
-- CREATE TABLE ���̺��(�÷��� �ڷ���(ũ��), �÷��� �ڷ���(ũ��), ...);

CREATE TABLE MEMBER(
  MEMBER_ID VARCHAR2(20),
  MEMBER_PWD VARCHAR2(20),
  MEMBER_NAME VARCHAR2(20)
);

-- �÷��� �ּ� �ޱ�
-- [ǥ����]
-- COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '��й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME Is 'ȸ���̸�';

SELECT *FROM MEMBER;
INSERT INTO MEMBER VALUES('seunghun457', '1234', '�Ŀ�����');
DELETE FROM MEMBER WHERE MEMBER_ID='seunghun457';
COMMIT;

SELECT *FROM TAB;

-- ������ ��ųʸ� ��

-- ������ ������ �ִ� ���̺�
SELECT *FROM USER_TABLES;

-- ������ ������ �ִ� ���̺� �÷����� ������
-- WHERE ������ �����ؼ� ���ϴ� ���̺� �� �� ����.
SELECT *FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'MEMBER';

-- ��������
-- ���̺� �ۼ� �� �� �÷��� ���� �� ��Ͽ� ���� ���������� ������ �� �ִ�.
-- ������ ���Ἲ ������ �������� �Ѵ�.
-- �Է�/�����ϴ� �����Ϳ� ������ ������ �ڵ����� �˻��ϴ� ����
-- PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY

SELECT * FROM USER_CONSTRAINTS;

SELECT *FROM USER_CONS_COLUMNS;

-- NOT NULL : �ش� �÷��� �ݵ�� ���� ��ϵǾ�� �ϴ� ��� ���
--            ����/���� �� NULL ���� ������� �ʵ��� �÷��������� ����
CREATE TABLE USER_NOCONS (
  USER_NO NUMBER,
  USER_ID VARCHAR2(20),
  USER_PWD VARCHAR2(30),
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);

INSERT INTO USER_NOCONS 
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_NOCONS
VALUES(2, NULL, NULL, NULL, NULL, '010-1234-5678', 'hong123@kh.or.kr');

SELECT *FROM USER_NOCONS;

CREATE TABLE USER_NOTNULL (
  USER_NO NUMBER NOT NULL,      -- �÷� ���� �������� ����
  USER_ID VARCHAR2(20) NOT NULL,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30) NOT NULL,
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);

INSERT INTO USER_NOTNULL
VALUES(1, 'user01', 'pass01', NULL, NULL, '010-1234-5678', 'hong123@kh.or.kr');

-- �������� Ȯ��
-- sqldeveloper������ ���̺� ���� Ŭ�� ��, �������� �ǿ��� Ȯ�ΰ���
-- NOT NULL�� ���� ���̺��� CONSTRAINT_TYPE (C = CHECK) (NOT NULL�� ������ CHECK ����)
-- �� SEARCH_CONDITION�� NOT NULL ���� Ȯ���ؾ���.
SELECT *
FROM USER_CONSTRAINTS C1
JOIN USER_CONS_COLUMNS C2 USING(CONSTRAINT_NAME)
WHERE C1.TABLE_NAME = 'USER_NOTNULL';

-- UNIQUE �������� : �÷��� �Է°��� ���� �ߺ��� �����ϴ� ��������
--                  �÷� �������� ���� ����, ���̺� �������� ���� ����
SELECT *FROM USER_NOCONS;
INSERT INTo USER_NOCONS
VALUES (1, 'user01', 'pass01', 'ȫ�浿' , '��', '010-1234-5678', 'hong123@kh.or.kr');

CREATE TABLE USER_UNIQUE (
  USER_NO NUMBER,
  USER_ID VARCHAR2(20) UNIQUE NOT NULL,   -- �÷� �������� �������� ����
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR(50)
);

INSERT INTO USER_UNIQUE
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_UNIQUE
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

-- SYS_C007051
SELECT *
FROM USER_CONSTRAINTS
JOIN USER_CONS_COLUMNS USING(CONSTRAINT_NAME)
WHERE CONSTRAINT_NAME = 'SYS_C007051';

SELECT
       UCC.TABLE_NAME
     , UCC.COLUMN_NAME
     , UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC
     , USER_CONS_COLUMNS UCC
 WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
   AND UCC.CONSTRAINT_NAME = 'SYS_C007051';

CREATE TABLE USER_UNIQUE2(
  USER_NO NUMBER,
  USER_ID VARCHAR2(20),
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  UNIQUE(USER_ID)        -- ���̺� �������� �������� ����, ��� ������ ��ġ ����
);

INSERT INTO USER_UNIQUE2
VALUES (1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_UNIQUE2
VALUES (1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

SELECT *FROm USER_UNIQUE2;

SELECT *
  FROM USER_CONSTRAINTS
  JOIN USER_CONS_COLUMNS USING(CONSTRAINT_NAME)
where USER_CONSTRAINTS.TABLE_NAME = 'USER_UNIQUE2';

-- �� �� �÷��� ��� �ϳ��� UNIQUE �������� ���� (���̺� ���������� ����)
CREATE TABLE USER_UNIQUE3(
  USER_NO NUMBER,
  USER_ID VARCHAR2(20),
  USER_PWD VARCHAR2(30),
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  UNIQUE(USER_NO, USER_ID)
);

INSERT INTO USER_UNIQUE3
VALUES (1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_UNIQUE3
VALUES (2, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_UNIQUE3
VALUES (1, 'user02', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_UNIQUE3
VALUES (1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

SELECT 
       UC.TABLE_NAME
     , UCC.COLUMN_NAME
     , UCC.CONSTRAINT_NAME
     , UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC
  JOIN USER_CONS_COLUMNS UCC ON(UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
 WHERE UCC.CONSTRAINT_NAME = 'SYS_C007054';

-- �������� �̸� ����
CREATE TABLE CONS_NAME(
  TEST_DATA1 VARCHAR2(20) CONSTRAINT NN_TEST_DATA1 NOT NULL,
  TEST_DATA2 VARCHAR2(20) CONSTRAINT UK_TEST_DATA2 UNIQUE,
  TEST_DATA3 VARCHAR2(30),
  CONSTRAINT UK_TEST_DATA3 UNIQUE(TEST_DATA3)
);

SELECT *FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CONS_NAME';

-- CHECK �������� : �÷��� ��ϵǴ� ���� ������ ������ �� ����
-- CHECK (�÷��� �񱳿����� �񱳰�)
-- ���� : �񱳰��� ���ͷ��� ����� �� �ְ�, ���ϴ� ���̳� �Լ� ������� ���� ����ȯ�� ����(TO_DATE ��)
-- �÷� ������ ���̺� �������� �� �� ���� ������
CREATE TABLE USER_CHECK(
  USER_NO NUMBER,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10) CHECK (GENDER IN ('��', '��')),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);

INSERT INTO USER_CHECK
VALUES (1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_CHECK
VALUES (1, 'user02', 'pass02', 'ȫ�浿', '����', '010-1234-5678', 'hong123@kh.or.kr');

SELECT 
       *
  FROM USER_CONSTRAINTS UC
  JOIN USER_CONS_COLUMNS UCC ON(UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
 WHERE UC.CONSTRAINT_NAME = 'SYS_C007059';
 
CREATE TABLE TEST_CHECK(
  TEST_NUMBER NUMBER,
  CONSTRAINT CK_TEST_NUMBER CHECK (TEST_NUMBER > 0)
);

INSERT INTO TEST_CHECK 
VALUES(-5);
INSERT INTO TEST_CHECK 
VALUES(-10);

CREATE TABLE TBL_CHECK (
  C_NAME VARCHAR2(10),
  C_PRICE NUMBER,
  C_LEVEL CHAR(1),
  C_DATE DATE,
  CONSTRAINT CK_C_PRICE CHECK(C_PRICE >= 1 AND C_PRICE <= 99999),
  CONSTRAINT CK_C_LEVEL CHECK(C_LEVEL = 'A' OR C_LEVEL = 'B' OR C_LEVEL = 'C'),
  CONSTRAINT CK_C_DATE CHECK(C_DATE >= TO_DATE('2016/01/01', 'YYYY/MM/DD'))
);

-- ȸ�����Կ� ���̺� ����(USER_TEST)
-- �÷��� : USER_NO(ȸ����ȣ)
--         USER_ID(ȸ�����̵�)     �ߺ� ����, NULL�� ��� ����
--         USER_PWD(ȸ����й�ȣ)   NULL�� ��� ����
--         PNO(�ֹε�Ϲ�ȣ)       �ߺ� ����, NULL�� ��� ����
--         GENDER(����)           '��' Ȥ�� '��'�� �Է�
--         PHONE(����ó)
--         ADDRESS(�ּ�)
--         STATUS(Ż�𿩺�)        NULL�� ��� ����, 'Y' Ȥ�� 'N'���� �Է�
-- �� �÷��� �������� �ο��� �� �������� �̸� �ο��� ��
-- ���̺� ���� �� 5�� �̻��� ȸ�� ���� INSERT
-- �� �÷����� ��ȣ�ȿ� �ִ� �������� �ڸ�Ʈ ����

CREATE TABLE USER_TEST(
  USER_NO NUMBER,
  USER_ID VARCHAR2(10) CONSTRAINT NN_USER_ID NOT NULL 
                       CONSTRAINT UN_USER_ID UNIQUE,
  USER_PWD VARCHAR2(20) CONSTRAINT NN_USER_PWD NOT NULL,
  PNO VARCHAR2(20) CONSTRAINT NN_PNO NOT NULL 
                   CONSTRAINT UN_PNO UNIQUE,
  GENDER VARCHAR2(5) CONSTRAINT CK_GENDER CHECK(GENDER IN ('��', '��')),
  PHONE VARCHAR2(20),
  ADDRESS VARCHAR2(50),
  STATUS VARCHAR2(5) CONSTRAINT NN_STATUS NOT NULL 
                     CONSTRAINT CK_STATUS CHECK (STATUS IN ('Y', 'N'))
);
SELECT
       *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'USER_TEST';

SELECT
       *
  FROM USER_CONSTRAINTS
 WHERE TABLE_NAME = 'USER_TEST';

COMMENT ON COLUMN USER_TEST.USER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN USER_TEST.USER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN USER_TEST.USER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN USER_TEST.PNO IS '�ֹε�Ϲ�ȣ';
COMMENT ON COLUMN USER_TEST.GENDER IS '����';
COMMENT ON COLUMN USER_TEST.PHONE IS '����ó';
COMMENT ON COLUMN USER_TEST.ADDRESS IS '�ּ�';
COMMENT ON COLUMN USER_TEST.STATUS IS 'Ż�𿩺�';

INSERT INTO USER_TEST 
VALUES(1, 'user01', 'pass01', '000000-1111111', '��', '010-1234-5678'
        , '��⵵ ����� ���ߵ�', 'N');
        
INSERT INTO USER_TEST 
VALUES(2, 'user02', 'pass02', '000000-1111112', '��', '010-1456-5678'
        , '��⵵ ����� ��ߵ�', 'N');

INSERT INTO USER_TEST 
VALUES(3, 'user03', 'pass03', '000000-1111113', '��', '010-1885-5678'
        , '��⵵ ����� ��ȭ��', 'N');

INSERT INTO USER_TEST 
VALUES(4, 'user04', 'pass04', '000000-1111114', '��', '010-5959-5678'
        , '��⵵ ����� �̻굿', 'N');

INSERT INTO USER_TEST 
VALUES(5, 'user05', 'pass05', '000000-1111115', '��', '010-7456-5678'
        , '��⵵ ����� ���ൿ', 'Y');
        
SELECT *FROM USER_TEST;

-- PRIMARY KEY(�⺻Ű) ��������
-- : ���̺��� �� ���� ������ ã�� ���� ����� �÷��� �ǹ��Ѵ�.
--   ���̺� ���� �ĺ��� ������ �Ѵ�.
--   NOT NULL + UNIQUE ��������
--   �� ���̺� �� �� ���� ������ �� ����
--   �÷� ����, ���̺� ���� �� �� ���� ����
--   �� �� �÷��� ������ �� �� �ְ�, ���� �� �÷��� ��� ������ �� ����

CREATE TABLE USER_PRIMARYKEY (
  USER_NO NUMBER CONSTRAINT PK_USER_NO PRIMARY KEY,   -- �÷� ����
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);

INSERT INTO USER_PRIMARYKEY
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

-- PRIMARY �������������� UNIQUE �������� ����
INSERT INTO USER_PRIMARYKEY
VALUES(1, 'user02', 'pass02', '�̼���', '��', '010-5678-9012', 'lee123@kh.or.kr');

-- Cannot insert NULL into (OWNER.TABLE.COLUMN)
INSERT INTO USER_PRIMARYKEY
VALUES(NULL, 'user03', 'pass03', '������', '��', '010-9999-3131', 'yoo123@kh.or.kr');

SELECT
       UC.TABLE_NAME
     , UCC.COLUMN_NAME
     , UC.CONSTRAINT_NAME
     , UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC
  JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
 WHERE UC.CONSTRAINT_NAMe = 'PK_USER_NO';
 
CREATE TABLE USER_PRIMARYKEY2(
  USER_NO NUMBER,
  USER_ID VARCHAR2(20),
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  CONSTRAINT PK_USER_NO2 PRIMARY KEY(USER_NO, USER_ID)
);

INSERT INTO USER_PRIMARYKEY2
VALUES (1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY2
VALUES (1, 'user02', 'pass02', '�̼���', '��', '010-5678-9012', 'lee123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY2
VALUES (2, 'user01', 'pass01', '������', '��', '010-9999-3131', 'yoo123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY2
VALUES (1, 'user01', 'pass01', '�Ż��Ӵ�', '��', '010-9999-9999', 'shin123@kh.or.kr');
SELECT
      UC.TABLE_NAME
    , UCC.COLUMN_NAME
    , UC.CONSTRAINT_NAME
    , UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC
  JOIN USER_CONS_COLUMNS UCC ON(UC.CONSTRAINT_NAME=UCC.CONSTRAINT_NAME)
 WHERE UC.CONSTRAINT_NAME = 'PK_USER_NO2';

SELECT
       UC.TABLE_NAME
     , UCC.COLUMN_NAME
     , UC.CONSTRAINT_NAME
     , UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC
  JOIN USER_CONS_COLUMNS UCC ON(UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
 WHERE UC.TABLE_NAME = 'USER_PRIMARYKEY2';
 
-- FOREIGN KEY (�ܺ�Ű/�ܷ�Ű) ��������
-- : ����(REFERRENCES)�� �ٸ� ���̺��� �����ϴ� ���� ����� �� ����
--   ���� ���Ἲ�� �������� �ʰ� �ϱ� ���� ���
--   FOREIGEN KEY �������ǿ� ���ؼ�
--   ���̺��� ����(RELATIONSHIP)�� ������
--   �����Ǵ� �� �ܿ��� NULL�� ����� �� ����

-- �÷� ������ ���
-- �÷��� �ڷ���(ũ��) [CONSTRATINTS �̸�] REFERRENCES ���������̺�� [(�������÷�)] [������]

-- ������ ���̺��� ������ �÷����� �����Ǹ�
-- PRIMARY KEY�� ������ �÷��� �ڵ� ������ �÷�

-- ������ �� �ִ� �÷��� PRIMARY KEY �÷���, UNIQUE ������ �÷��� �ܷ�Ű�� ����� �� ����

-- �߰�������, �� �÷��� �� �� �̻��� ���̺��� ������ �� ����

-- USER_GRADE�� �θ� ���̺�(���� �����ϰ� �ִ� ���̺��� �θ�)
CREATE TABLE USER_GRADE(
  GRADE_CODE NUMBER PRIMARY KEY,
  GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE
VALUES (10, '�Ϲ�ȸ��');

INSERT INTO USER_GRADE
VALUES (20, '���ȸ��');

INSERT INTO USER_GRADE
VALUES (30, 'Ư��ȸ��');

COMMIT;

SELECT *FROM USER_GRADE;

CREATE TABLE USER_FOREIGNKEY(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER,
  CONSTRAINT FK_GRADE_CODE FOREIGN KEY (GRADE_CODE) REFERENCES USER_GRADE (GRADE_CODE)
);

INSERT INTO USER_FOREIGNKEY
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��',
       '010-1234-5678', 'hong123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY
VALUES(2, 'user02', 'pass02', '�̼���', '��',
       '010-5678-9012', 'lee123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY
VALUES(3, 'user03', 'pass03', '������', '��',
       '010-9999-3131', 'yoo123@kh.or.kr', 30);
       
INSERT INTO USER_FOREIGNKEY
VALUES(4, 'user04', 'pass04', '���߱�', '��',
       '010-2222-0000', 'ahn123@kh.or.kr', null);

-- �����Ϸ��� ���� �����Ƿ� error       
INSERT INTO USER_FOREIGNKEY
VALUES(5, 'user05', 'pass05', '������', '��',
       '010-6666-1234', 'yoon123@kh.or.kr', 50);
       
SELECT
       UC.TABLE_NAME
     , UCC.COLUMN_NAME
     , UC.CONSTRAINT_NAME
     , UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC
  JOIN USER_CONS_COLUMNS UCC ON(UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
 WHERE UC.CONSTRAINT_NAME = 'FK_GRADE_CODE';

-- USER_FOREIGNKEY ���̺���
-- ȸ�����̵�, �̸�, ����, ����ó, ȸ����޸� ��ȸ
SELECT
       USER_ID
     , USER_NAME
     , GENDER
     , PHONE
     , GRADE_NAME
 FROM USER_FOREIGNKEY
-- LEFT JOIN USER_GRADE USING(GRADE_CODE);
NATURAL LEFT JOIN USER_GRADE;

-- �����ɼ�
-- : �θ� ���̺��� ������ ���� �� �ڽ� ���̺��� �����͸� � ������ ó���� ���� ����
--   ������ ������ �� �ִ�.

-- child record found
DELETE FROM USER_GRADE
WHERE GRADE_CODE = 10;

DELETE FROM USER_GRADE
WHERE GRADE_CODE = 20;

SELECT *FROM USER_GRADE;

ROLLBACK;

-- FOREIGN KEY�� ������ �÷����� ���ǰ� �ִ� ���� ���
-- �����ϴ� �÷��� ���� �������� ���Ѵ�.
-- ON DELETE RESTRICTED (�⺻��)

-- ON DELETE SET NULL : �θ�Ű�� ������ �� �ڽ� Ű�� NULL�� �ٲپ� �ش�.
CREATE TABLE USER_GRADE2(
  GRADE_CODE NUMBER PRIMARY KEY,
  GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE2
VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE2
VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE2
VALUES(30, 'Ư��ȸ��');

SELECT *FROM USER_GRADE2;

CREATE TABLE USER_FOREIGNKEY2(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER,
  CONSTRAINT FK_GRADE_CODE2 FOREIGN KEY (GRADE_CODE)
  REFERENCES USER_GRADE2 (GRADE_CODE) ON DELETE SET NULL
);

INSERT INTO USER_FOREIGNKEY2
VALUES (1, 'user01', 'pass01', 'ȫ�浿', '��', 
        '010-1234-5678', 'hong123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY2
VALUES (2, 'user02', 'pass02', '�̼���', '��', 
        '010-5678-9012', 'lee123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY2
VALUES (3, 'user03', 'pass03', '������', '��', 
        '010-9999-3131', 'yoo123@kh.or.kr', 30);
        
INSERT INTO USER_FOREIGNKEY2
VALUES (4, 'user04', 'pass04', '���߱�', '��',
        '010-2222-1111', 'ahn123@kh.or.kr', null);

DELETE FROM USER_GRADE2
WHERE GRADE_CODE = 10;
        
SELECT *FROM USER_GRADE2;
SELECT *FROM USER_FOREIGNKEY2;

-- ON DELETE CASCADE : �θ� Ű ���� �� �ڽ� Ű�� ���� �൵ �Բ� ����
CREATE TABLE USER_GRADE3(
  GRADE_CODE NUMBER PRIMARY KEY,
  GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE3
VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE3
VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE3
VALUES(30, 'Ư��ȸ��');

SELECT *FROM USER_GRADE3;

CREATE TABLE USER_FOREIGNKEY3(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER,
  CONSTRAINT FK_GRADE_CODE3 FOREIGN KEY (GRADE_CODE)
  REFERENCES USER_GRADE3 (GRADE_CODE) ON DELETE CASCADE
);

INSERT INTO USER_FOREIGNKEY3
VALUES (1, 'user01', 'pass01', 'ȫ�浿', '��', 
        '010-1234-5678', 'hong123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY3
VALUES (2, 'user02', 'pass02', '�̼���', '��', 
        '010-5678-9012', 'lee123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY3
VALUES (3, 'user03', 'pass03', '������', '��', 
        '010-9999-3131', 'yoo123@kh.or.kr', 30);
        
INSERT INTO USER_FOREIGNKEY3
VALUES (4, 'user04', 'pass04', '���߱�', '��',
        '010-2222-1111', 'ahn123@kh.or.kr', null);
        
SELECT *FROM USER_FOREIGNKEY3;
COMMIT;

DELETE FROM USER_GRADE3
WHERE GRADE_CODE = 10;

SELECT *FROM USER_GRADE3;
SELECT *FROM USER_FOREIGNKEY3;

-- ���������� �̿��� ���̺� ����
CREATE TABLE EMPLOYEE_COPY
AS SELECT *FROM EMPLOYEE
-- ���̺��� ������ ������ �� ��� (1 = 0�� ������ FALSE)
WHERE 1 = 0;

SELECT *FROM EMPLOYEE_COPY;

DROP TABLE EMPLOYEE_COPY;

-- �÷���, ������ Ÿ��, ���� ����ǰ�, ���������� NOT NULL�� �����
CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_TITLE, JOB_NAME
     FROM EMPLOYEE E
     LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE=D.DEPT_ID)
     LEFT JOIN JOb J ON(E.JOB_CODE = J.JOB_CODE);

SELECT *FROM EMPLOYEE_COPY2;

-- �������� �߰�
-- ALTER TABLE ���̺�� ADD PRIMARY KEY (�÷���);
-- ALTER TABLE ���̺�� ADD FOREIGN KEY (�÷���)
--                         REFERENCES ���̺�� (�÷���);
-- ALTER TABLE ���̺�� ADD UNIQUE (�÷���)
-- ALTER TABLE ���̺�� ADD CHECK(�÷��� �񱳿����� �񱳰�)
-- ALTER TABLE ���̺�� MODIFY �÷��� NOT NULL;    NULL ����� NOT NULL��
-- ALTER TABLE ���̺�� MODIFY �÷��� NULL;        NOT NULL�� NULL ������� ����ġ ������ MODIFY

ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY (EMP_ID);
ALTER TABLE EMPLOYEE_COPY MODIFY EMP_NO NOT NULL;

-- �ǽ�
-- EMPLOYEE ���̺��� DEPT_CODE�� �ܷ�Ű �������� �߰�
-- ���� ���̺��� DEPARTMENT, ���� �÷��� DEPARTMENT�� �⺻Ű
ALTER TABLE EMPLOYEE ADD FOREIGN KEY (DEPT_CODE)
                         REFERENCES DEPARTMENT(DEPT_ID);
-- DEPARTMENT ���̺��� LOCATION_ID�� �ܷ�Ű �������� �߰�
-- ���� ���̺��� LOCATION, ���� �÷��� LOCATION�� �⺻Ű
ALTER TABLE DEPARTMENT ADD FOREIGN KEY (LOCATION_ID)
                           REFERENCES LOCATION (LOCAL_CODE);
-- EMPLOYEE ���̺��� JOB_CODE�� �ܷ�Ű �������� �߰�
-- ���� ���̺��� JOB, ���� �÷��� JOB�� �⺻Ű
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE)
                         REFERENCES JOB(JOB_CODE);
-- EMPLOYEE ���̺��� SAL_LEVEL�� �ܷ�Ű �������� �߰�
-- ���� ���̺��� SAL_GRADE, ���� �÷��� SAL_GRADE ���̺��� �⺻Ű
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(SAL_LEVEL)
                         REFERENCES SAL_GRADE(SAL_LEVEL);
-- EMPLOYEE ���̺��� EMT_YN �÷��� CHECK �������� �߰� ('Y', 'N')
-- ��, �� �ҹ��ڸ� �����ϱ� ������ �빮�ڷθ� ������ ��
ALTER TABLE EMPLOYEE ADD CHECK(ENT_YN IN ('Y', 'N'));
-- EMPLOYEE ���̺��� SALARY �÷��� CHECK �������� �߰�(���)
ALTER TABLE EMPLOYEE ADD CHECK(SALARY > 0);
-- EMPLOYEE ���̺��� EMP_NO �÷��� UNIQUE �������� �߰�
ALTER TABLE EMPLOYEE ADD UNIQUE(EMP_NO);

-- ALTER TABLE EMPLOYEE DROP CONSTRAINT SYS_C007156;

SELECT
       UC.TABLE_NAME
     , UCC.COLUMN_NAME
     , UC.CONSTRAINT_NAME
     , UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC
  JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
 WHERE UC.TABLE_NAME = 'EMPLOYEE';
