-- DAY 7 ��������

-- DML(Data Manipulation Language) : ������ ���� ���
-- INSERT, UPDATE, DELTEE, SELECT
-- C(CREATE) : INSERT
-- R(READ) : SELECT
-- U(UPDATE) : UPDATE
-- D(DELETE) : DELETE
-- ���̺� ���� �����ϰų�, �����ϰų�, �����ϰų�, ��ȸ�ϴ� ���
-- ���̺��� �������� ��ȭ�� ����

-- INSERT : ���ο� ���� �߰��ϴ� �����̴�.
--          ���̺��� �� ������ �����Ѵ�.

-- INSERT INTO ���̺�� (�÷���, �÷���, �÷���, ....)
-- VALUES (������, ������, ������, ....)

-- ���̺��� ��� �÷��� ���� ���� INSERT �ϴ� ���
-- ���̺�� �ڿ� �÷������ ������ �� �ִ�.
-- INSERT INTO ���̺��
-- VALUES (������, ������, ������, ...);

INSERT
  INTO EMPLOYEE.EMPLOYEE
(
  EMP_ID, EMP_NAME, EMP_NO
, EMAIL, PHONE, DEPT_CODE
, JOB_CODE, SAL_LEVEL, SALARY
, BONUS, MANAGER_ID, HIRE_DATE
, ENT_DATE, ENT_YN
)
VALUES
(
  900, '��ä��', '901123-1080503'
, 'jang_ch@kh.or.kr', '01055559512', 'D1'
, 'J7', 'S3', 4300000
, 0.2, '200', SYSDATE
, NULL, DEFAULT
);

COMMIT;

SELECT *FROM EMPLOYEE 
WHERE EMP_ID=900;

-- INSERT�ÿ� VALUES ��� ���������� �̿��� �� �ִ�.
CREATE TABLE EMP_01 (
  EMP_ID NUMBER, 
  EMP_NAME VARCHAR2(30),
  DEPT_TITLE VARCHAR2(30)
);

SELECT *FROM EMP_01;

INSERT INTO EMP_01(
  SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
);

-- INSERT ALL : INSERT �ÿ� ����ϴ� ���������� ���� ���
--              �� �� �̻��� ���̺� INSERT ALL�� �̿��Ͽ�
--              �� ���� �����͸� ������ �� �ִ�.
--              ��, �� ���������� �������� ���ƾ� �Ѵ�.
CREATE TABLE EMP_DEPT_D1
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
     FROM EMPLOYEE
    WHERE 1 = 0;
    
CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
     FROM EMPLOYEE
    WHERE 1 = 0;
    
SELECT *FROM EMP_DEPT_D1;
SELECT *FROM EMP_MANAGER;

-- EMP_DEPT_D1 ���̺� EMPLOYEE ���̺� �ִ� �μ��ڵ尡 D1�� ������ ��ȸ�Ͽ�
-- ���, �̸�, �ҼӺμ�, �Ի����� �����ϰ�,
-- EMP_MANAGER ���̺� EMPLOYEE ���̺� �ִ� �μ��ڵ尡 D1�� ������ ��ȸ�ؼ�
-- ���, �̸�, ������ ����� �����ϼ���.
INSERT INTO EMP_DEPT_d1 (
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
   WHERE DEPT_CODE = 'D1'
);

INSERT INTO EMP_MANAGER (
  SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
   WHERE DEPT_CODE = 'D1'
);

SELECT *FROM EMP_DEPT_D1;
SELECT *FROM EMP_MANAGER;

DELETE FROM EMP_DEPT_D1;
DELETE FROM EMP_MANAGER;

INSERT ALL
INTO EMP_DEPT_D1 VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D1';

-- EMPLOYEE ���̺��� �Ի����� �������� 2000�� 1�� 1�� ������ �Ի��� �����
-- ���, �̸�, �Ի���, �޿��� ��ȸ�Ͽ� EMP_OLD ���̺� �����ϰ�
-- �� ���Ŀ� �Ի��� ����� EMP_NEW ���̺� �����ϼ���
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
     FROM EMPLOYEE
    WHERE 1 = 0;

CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
     FROM EMPLOYEE
    WHERE 1 = 0;

SELECT *FROM EMPLOYEE WHERE HIRE_DATE > TO_DATE('2000/01/01', 'RRRR/MM/DD');

SELECT *FROM EMPLOYEE;
INSERT ALL
    WHEN HIRE_DATE < TO_DATE('2000/01/01', 'RRRR/MM/DD') THEN
        INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
    ELSE INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
--    WHEN HIRE_DATE <= '2000/01/01'
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
  FROM EMPLOYEE;
  
SELECT *FROM EMP_OLD;
SELECT *FROM EMP_NEW;

-- UPDATE : ���̺� ��ϵ� �÷��� ���� �����ϴ� �����̴�.
--          ���̺��� ��ü �� ������ ��ȭ�� ����.
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- UPDATE ���̺�� SET �÷��� = �ٲܰ�, �÷��� = �ٲܰ�, ...
-- [WHERE �÷��� �񱳿����� �񱳰�];
UPDATE /*ȫ�浿::com.kh.jdbc.model.dao.DAO.updateDepartment()*/
       DEPT_COPY
   SET DEPT_TITLE = '������ȹ��'
 WHERE DEPT_ID = 'D9';

-- UPDATE �ÿ��� ���������� �̿��� �� �ִ�.
-- UPDATE ���̺��
--    SET �÷��� = (��������)
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
     FROM EMPLOYEE;

SELECT *FROM EMP_SALARY
 WHERE EMP_NAME IN ('�����', '����');
 
-- ���� ����� ����� �η����ϴ� ���� �����
-- �޿��� ���ʽ����� ����� ����� �����ϰ� �������ֱ�� �ߴ�.
-- �̸� �ݿ��ϴ� UPDATE���� �ۼ��غ�����
UPDATE EMP_SALARY
  SET SALARY = (SELECT SALARY
                  FROM EMPLOYEE
                 WHERE EMP_NAME='�����'),
      BONUS = (SELECT BONUS
                 FROM EMPLOYEE
                WHERE EMP_NAME='�����')
 WHERE EMP_NAME = '����';
 
UPDATE EMP_SALARY
  SET (SALARY, BONUS) = (SELECT SALARY
                              , BONUS 
                           FROM EMPLOYEE 
                          WHERE EMP_NAME='�����')
 WHERE EMP_NAME = '����';

-- ���߿� ���������� �̿��� UPDATE ��
-- ���� ����� �޿� �λ� �ҽ��� �ҹ��� ���� �ٶ��� �λ� �ҽ��� ���ص���
-- �ٸ� �������� ��ü�� �ľ��� �����ߴ�.
-- ���ö, ������, ������, �ϵ��� ����� �޿��� ���ʽ���
-- ����� ����� �޿��� ���ʽ��� ���� �����ϴ� UPDATE ���� �ۼ��ϼ���
SELECT *FROM EMP_SALARY WHERE EMP_NAME IN('���ö', '������', '������', '�ϵ���', '�����');

UPDATE EMP_SALARY
  SET (SALARY, BONUS) = (SELECT SALARY
                              , BONUS 
                           FROM EMPLOYEE 
                          WHERE EMP_NAME='�����')
 WHERE EMP_NAME IN ('���ö', '������', '������', '�ϵ���', '�����');

-- ������ ���������� �̿��� UPDATE
-- EMP_SALARY ���̺��� �ƽþ� �ٹ������� �ٹ��ϴ� ������
-- ���ʽ��� 0.5�� �����Ͻÿ�

-- My SOURCE
UPDATE (SELECT *
          FROM EMP_SALARY ES
          JOIN DEPARTMENT D ON (ES.DEPT_CODE = D.DEPT_ID)
          JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)) TMP
   SET TMP.BONUS = 0.5
 WHERE TMP.LOCAL_NAME LIKE 'ASIA%';

-- instructor SOURCE
SELECT EMP_ID
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
  JOIN LOCATION L ON (LOCATION_ID = LOCAL_CODE)
 WHERE LOCAL_NAME LIKE 'ASIA%';

UPDATE EMP_SALARY
   SET BONUS = 0.5
 WHERE EMP_ID IN (SELECT EMP_ID
                    FROM EMPLOYEE E
                    JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
                    JOIN LOCATION L ON (LOCATION_ID = LOCAL_CODE)
                   WHERE LOCAL_NAME LIKE 'ASIA%');

-- UPDATE �� ������ ���� �ش� �÷��� ���� �������ǿ� ������� �ʾƾ� �Ѵ�.
UPDATE EMPLOYEE
   SET DEPT_CODE = '65'   -- FOREIGN KEY �������� �����
 WHERE DEPT_CODE = 'D6';
 
UPDATE EMPLOYEE
   SET EMP_NAME = NULL    -- NOT NULL �������� �����
 WHERE EMP_ID = 200;

UPDATE EMPLOYEE
   SET EMP_NO = '621235-1985634'  -- UNIQUE �������� �����
 WHERE EMP_ID = 201;


 