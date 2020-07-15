-- DAY 9 ��������

-- PL/SQL (PROCEDURE LANGUAGE EXTENSION TO SQL)
-- ����Ŭ ��ü�� ����� ������ ���
-- SQL�� ������ �����Ͽ� SQL���� ������
-- ���� ����, ���� ó��, �ݺ� ó��, ����ó�� ���� �����Ѵ�.

-- PL/SQL ����
-- �����, �����, ����ó���η� �����Ǿ� ����
-- ����� : DECLARE�� ����, ������ ����� �����ϴ� �κ�
-- ����� : BEGIN���� ����, ���, �ݺ���, �Լ��� ���� �� ���� �ۼ�
-- ����ó���� : EXCEPTION���� ����, ����ó�� ���� �ۼ�

-- DBMS_OUTPUT ��Ű���� PUT_LINE ����
BEGIN
  DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END;
/

-- default : �ܼ� ��� ������� �������� ����
SET SERVEROUTPUT ON;

-- ������ ����� �ʱ�ȭ, ������ ���
DECLARE
  EMP_ID NUMBER;
  EMP_NAME VARCHAR2(30);
BEGIN
  EMP_ID := 888;
  EMP_NAME := '����ȣ';
  
  DBMS_OUTPUT.PUT_LINE('EMP_ID : '  || EMP_ID);
END;
/

-- �ٸ� ���̺��� �÷����� �����ؼ� �����..���۷��� ����
-- ���۷��� ������ ����� �ʱ�ȭ, ������ ���

-- WHERE���� AMPERSAND�ǹ� -> ��ȭ���ڰ� ����
DECLARE
  EMP_ID EMPLOYEE.EMP_ID%TYPE;
  EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
  SELECT EMP_ID, EMP_NAME
  INTO EMP_ID, EMP_NAME
  FROM EMPLOYEE
  WHERE EMP_ID = '&EMP_ID';
  
  DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
  DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
END;
/

-- ���۷��� ������ EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY�� �����ϰ�
-- EMPLOYEE ���̺��� ���, �̸�, �����ڵ�, �μ��ڵ�, �޿��� ��ȸ�Ͽ�
-- ������ ���۷��� ������ ��� ����ϼ���
-- ��, �Է¹��� �̸��� ��ġ�ϴ� ������ ������ ��ȸ�ϼ���.

DECLARE
  EMP_ID EMPLOYEE.EMP_ID%TYPE;
  EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
  DEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
  JOB_CODE EMPLOYEE.JOB_CODE%TYPE;
  SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    INTO EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    FROM EMPLOYEE
   WHERE EMP_NAME = '&EMP_NAME';
   
  DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
  DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
  DBMS_OUTPUT.PUT_LINE('DEPT_CODE : ' || DEPT_CODE);
  DBMS_OUTPUT.PUT_LINE('JOB_CODE : ' || JOB_CODE);
  DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
  
END;
/
-- %ROWTYPE
-- : ���̺��� �� ���� ��� �÷��� �ڷ����� �����ϴ� ��� ���
DECLARE
  E EMPLOYEE%ROWTYPE;
BEGIN
  SELECT * INTO E
  FROM EMPLOYEE
  WHERE EMP_ID = '&EMP_ID';
  
  DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || E.EMP_ID);
  DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || E.EMP_NAME);
  DBMS_OUTPUT.PUT_LINE('EMP_NO : ' || E.EMP_NO);
  DBMS_OUTPUT.PUT_LINE('SALARY : ' || E.SALARY);
  
END;
/

-- ������ ���ϴ� PL/SQL �� �ۼ�
DECLARE
  VEMP EMPLOYEE%ROWTYPE;
  YSALARY NUMBER;
BEGIN
  SELECT * INTO VEMP
  FROM EMPLOYEE
  WHERE EMP_NAME = '&�����';
  
  IF (VEMP.BONUS IS NULL) THEN YSALARY := VEMP.SALARY * 12;
  ELSIF (VEMP.BONUS IS NOT NULL) THEN YSALARY := (VEMP.SALARY + (VEMP.SALARY * VEMP.BONUS));
  END IF;
  
  DBMS_OUTPUT.PUT_LINE(VEMP.EMP_ID || '    ' || VEMP.EMP_NAME || '    '
                       || TO_CHAR(YSALARY, 'L999,999,999'));
END;
/

-- ������ �Է¹޾� SCORE ������ �����ϰ�
-- 90�� �̻��� 'A', 80�� �̻��� 'B', 70�� �̻��� 'C', 60�� �̻��� 'D', 60�� �̸��� 'F'�� ���� ó���Ͽ�
-- GRADE ������ �����Ͽ�
-- '����� ������ 90�� �̰�, ������ A���� �Դϴ�.' ���·� ����ϼ���.

DECLARE
  SCORE NUMBER;
  GRADE CHAR(3);
BEGIN
  SCORE := &SCORE;
  IF (SCORE >=90 ) THEN GRADE := 'A';
  ELSIF (SCORE >= 80) THEN GRADE := 'B';
  ELSIF (SCORE >= 70) THEN GRADE := 'C';
  ELSIF (SCORE >= 60) THEN GRADE := 'D';
  ELSE GRADE := 'F';
  END IF;
  
  DBMS_OUTPUT.PUT_LINE('����� ������ ' || SCORE || '�� �̰�, ������ ' || GRADE || '���� �Դϴ�.');
END;
/

DECLARE
  VEMPNO EMPLOYEE.EMP_ID%TYPE;
  VENAME EMPLOYEE.EMP_NAME%TYPE;
  VDEPTNO EMPLOYEE.DEPT_CODE%TYPE;
  VDNAME VARCHAR2(20) := NULL;
BEGIN
  SELECT EMP_ID, EMP_NAME, DEPT_CODE
  INTO VEMPNO, VENAME, VDEPTNO
  FROM EMPLOYEE
  WHERE EMP_ID = '&���';
  
  VDNAME := CASE VDEPTNO
              WHEN 'D1' THEN '�λ������'
              WHEN 'D2' THEN 'ȸ�������'
              WHEN 'D3' THEN '�����ú�'
              WHEN 'D4' THEN '����������'
              WHEN 'D5' THEN '�ؿܿ���1��'
              WHEN 'D6' THEN '�ؿܿ���2��'
              WHEN 'D7' THEN '�ؿܿ���3��'
              WHEN 'D8' THEN '���������'
              WHEN 'D9' THEN '�ѹ���'
            END;
  DBMS_OUTPUT.PUT_LINE('���        �̸�       akao  �μ���');
  DBMS_OUTPUT.PUT_LINE('-----------------------------');
  DBMS_OUTPUT.PUT_LINE(VEMPNO || '        ' || VENAME || '       ' || VDNAME);
END;
/

DECLARE
  N NUMBER := 1;
BEGIN
  LOOP
    DBMS_OUTPUT.PUT_LINE(N);
    N := N + 1;
    IF N > 5 THEN EXIT;
    END IF;
  END LOOP;
END;
/

CREATE TABLE TEST1 (
  BUNHO NUMBER(3),
  NALJJA DATE
);

BEGIN
  FOR I IN 1..10 LOOP
    INSERT INTO TEST1 VALUES(I, SYSDATE);
  END LOOP;
END;
/
SELECT * FROM TEST1;

-- ������ ¦���� ����ϱ�
DECLARE
  RESULT NUMBER;
BEGIN
  FOR DAN IN 2..9 LOOP
    IF MOD(DAN, 2) = 0
      THEN
      FOR SU IN 1..9 LOOP
        RESULT := DAN * SU;
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || SU || ' = ' || RESULT);
      END LOOP;
    END IF;
    DBMS_OUTPUT.PUT_LINE(' ');
  END LOOP;
END;
/
-- LOOP VER.
DECLARE
  I NUMBER := 2;
  J NUMBER := 1;
BEGIN
  LOOP
    J := 1;
    LOOP
      DBMS_OUTPUT.PUT_LINE(I || ' * ' || J || ' = ' || I * J);
      J := J + 1;
      IF J > 9 THEN EXIT;
      END IF;
    END LOOP;
    I := I + 2;
    
    IF I > 9 THEN EXIT;
    END IF;
  END LOOP;
END;
/

-- WHILE LOOP
DECLARE
  I NUMBER := 1;
BEGIN
  WHILE I <= 10 LOOP
    DBMS_OUTPUT.PUT_LINE(I);
    I := I + 1;
  END LOOP;
END;
/

-- WHILE LOOP�� �̿��� ������ ¦���� ���
DECLARE
  DAN NUMBER := 1;
  SU NUMBER := 1;
BEGIN
  WHILE DAN < 10 LOOP
    IF MOD(DAN, 2) = 0 THEN
      SU := 1;
      WHILE SU < 10 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || SU || ' = ' || (DAN * SU));
        SU := SU + 1;
      END LOOP;
      DBMS_OUTPUT.PUT_LINE('');
    END IF;
    DAN := DAN + 1;
  END LOOP;
END;
/

-- ���̺� Ÿ���� ���� ���� �� �� ���� ���
-- BINARY_INTEGER�θ� INDEX ��� ����

-- TYPE�� ����..

-- I�� 1�� ������ ���̺� �ε����� 1���� ����
DECLARE
  TYPE EMP_ID_TABLE_TYPE IS TABLE OF EMPLOYEE.EMP_ID%TYPE INDEX BY BINARY_INTEGER;
  TYPE EMP_NAME_TABLE_TYPE IS TABLE OF EMPLOYEE.EMP_NAME%TYPE INDEX BY BINARY_INTEGER;
  
  EMP_ID_TABLE EMP_ID_TABLE_TYPE;
  EMP_NAME_TABLE EMP_NAME_TABLE_TYPE;
  
  I BINARY_INTEGER := 0;
BEGIN
  I := 1;
  
  FOR K IN (SELECT EMP_ID, EMP_NAME FROM EMPLOYEE) LOOP
    EMP_ID_TABLE(I) := K.EMP_ID;
    EMP_NAME_TABLE(I) := K.EMP_NAME;
    
    I := I + 1;
  END LOOP;
  
  FOR J IN 1..I-1 LOOP
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID_TABLE(J) || ', EMP_NAME : ' || EMP_NAME_TABLE(J));
  END LOOP;

END;
/

-- ���ڵ� Ÿ���� ���� ���� �� �� ���� ��� look like ����ü
DECLARE
  TYPE EMP_RECORD_TYPE IS RECORD(
    EMP_ID EMPLOYEE.EMP_ID%TYPE,
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE,
    DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE,
    JOB_NAME JOB.JOB_NAME%TYPE
  );
  
  EMP_RECORD EMP_RECORD_TYPE;
  
BEGIN

  SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
  INTO EMP_RECORD
  FROM EMPLOYEE
  LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  LEFT JOIN JOB USING(JOB_CODE)
  WHERE EMP_NAME = '&EMP_NAME';
  
  DBMS_OUTPUT.PUT_LINE('��� : ' || EMP_RECORD.EMP_ID);
  DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP_RECORD.EMP_NAME);
  DBMS_OUTPUT.PUT_LINE('�μ� : ' || EMP_RECORD.DEPT_TITLE);
  DBMS_OUTPUT.PUT_LINE('���� : ' || EMP_RECORD.JOB_NAME);
END;
/

-- ����ó��
BEGIN
  UPDATE EMPLOYEE
  SET EMP_ID = '&���'
  WHERE EMP_ID = 200;
EXCEPTION
  WHEN DUP_VAL_ON_INDEX
  THEN DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�.');
END;
/

-- ���� ���� ���� ���� ó��
DECLARE
  DUP_EMPNO EXCEPTION;
  PRAGMA EXCEPTION_INIT(DUP_EMPNO, -00001);
BEGIN
  UPDATE EMPLOYEE
  SET EMP_ID = '&���'
  WHERE EMP_ID = 200;

EXCEPTION
  WHEN DUP_EMPNO 
  THEN DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����̶�ϱ�');
END;
/

-- ���ν���(PROCEDURE)
-- : ������ SQL�� + PL/SQL���� �����ϴ� ��ü�̴�.
--   �ʿ��� �� ���� ������ ������ �ٽ� �Է��� �ʿ� ����
--   �����ص� ��ü�� ȣ���� �ؼ� ������ �����Ű�� ���� �������� ���ȴ�.

CREATE TABLE EMP_DUP
AS SELECT *FROM EMPLOYEE;
SELECT *FROM EMP_DUP;

CREATE OR REPLACE PROCEDURE DEL_ALL_EMP
IS 
BEGIN
  DELETE FROM EMP_DUP;
  COMMIT;
END;
/

EXECUTE DEL_ALL_EMP;
EXEC DEL_ALL_EMP;

SELECT *FROM EMP_DUP;
ROLLBACK;

-- �Ű����� �ִ� ���ν���
CREATE OR REPLACE PROCEDURE DEL_EMP_ID(V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
IS
BEGIN
  DELETE FROM EMPLOYEE
  WHERE EMP_ID = V_EMP_ID;
END;
/

EXEC DEL_EMP_ID('&EMP_ID');

ROLLBACK;
SELECT *FROM EMPLOYEE;

-- IN/OUT �Ű����� �ִ� ���ν���
CREATE OR REPLACE PROCEDURE SELECT_EMP_ID (
  V_EMP_ID IN EMPLOYEE.EMP_ID%TYPE,
  V_EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
  V_EMP_SALARY OUT EMPLOYEE.SALARY%TYPE,
  V_EMP_BONUS OUT EMPLOYEE.BONUS%TYPE
)
IS
BEGIN
  SELECT EMP_NAME, SALARY, NVL(BONUS, 0) 
  INTO V_EMP_NAME, V_EMP_SALARY, V_EMP_BONUS
  FROM EMPLOYEE
  WHERE EMP_ID = V_EMP_ID;
END;
/

VARIABLE VAR_EMP_NAME VARCHAR2(30);
VARIABLE VAR_SALARY NUMBER;
VARIABLE VAR_BONUS NUMBER;

-- : <-- ���ε� ���� ǥ��(OUT)
EXEC SELECT_EMP_ID(205, :VAR_EMP_NAME, :VAR_SALARY, :VAR_BONUS);

PRINT VAR_EMP_NAME;
PRINT VAR_SALARY;
PRINT VAR_BONUS;

-- PRINT �������� �ʰ� ���ν��� ����ø��� �ڵ����� ���
SET AUTOPRINT ON;

-- FUNCTION
-- : ���ν����� ��� �뵵�� ���� ����ϴ�.
--   �������� �ǵ��� ���� �� �ִ�. (OUT �Ű������� �ƴ϶� RETURN)
CREATE OR REPLACE FUNCTION BONUS_CALC(V_EMP EMPLOYEE.EMP_ID%TYPE) RETURN NUMBER
IS
  V_SAL EMPLOYEE.SALARY%TYPE;
  V_BONUS EMPLOYEE.BONUS%TYPE;
  CALC_SAL NUMBER;
BEGIN
  SELECT SALARY, NVL(BONUS, 0)
  INTO V_SAL, V_BONUS
  FROM EMPLOYEE
  WHERE EMP_ID = V_EMP;
  
  CALC_SAL := (V_SAL + (V_SAL * V_BONUS)) * 12;

  RETURN CALC_SAL;
END;
/

VARIABLE VAR_CALC NUMBER;

-- �Լ� ����
EXEC :VAR_CALC := BONUS_CALC('&EMP_ID');


-- �Լ��� ��� ����
SELECT EMP_ID, EMP_NAME, BONUS_CALC(EMP_ID)
FROM EMPLOYEE
WHERE BONUS_CALC(EMP_ID) > 30000000;

-- CURSOR
-- : ó�� ����� ���� ���� ������ �������� SELECT ���� ó���ϱ� ����
--   SELECT ����� ������ ���� ��ü�̴�.
--  CURSOR~ OPEN~ FETCH~ CLOSE �ܰ�� ����ȴ�.

-- CURSOR�� ����
-- %NOTFOUND : Ŀ�� ������ �ڷᰡ ��� ����(FETCH)�Ǿ� ���� ������ �������� ������ TRUE
-- %FOUND : Ŀ�� ������ �ڷᰡ ���� ���������� TRUE
-- %ISOPEN : Ŀ���� OPEN�� �����̸� TRUE

CREATE OR REPLACE PROCEDURE CURSOR_DEPT
IS
  V_DEPT DEPARTMENT%ROWTYPE;
  CURSOR C1
  IS
  SELECT * FROM DEPARTMENT;
BEGIN
  OPEN C1;
  
  LOOP
    FETCH C1 INTO V_DEPT.DEPT_ID, V_DEPT.DEPT_TITLE, V_DEPT.LOCATION_ID;
    --IF C1%NOTFOUND = TRUE THEN EXIT;
    --END IF;
    EXIT WHEN C1%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ� : ' || V_DEPT.DEPT_ID 
                         || ', �μ��� : ' || V_DEPT.DEPT_TITLE
                         || ', ���� : ' || V_DEPT.LOCATION_ID);
  END LOOP;
  CLOSE C1;
END;
/
EXEC CURSOR_DEPT;

-- FOR IN LOOP�� �̿��ϸ�
-- �ݺ��ÿ� �ڵ����� CURSOR OPEN�ϰ�,
-- ����(FETCH)�� �ڵ����� �Ѵ�.
-- LOOP ������ �� �ڵ����� CLOSE �Ѵ�.

CREATE OR REPLACE PROCEDURE CURSOR_DEPT2
IS
  V_DEPT DEPARTMENT%ROWTYPE;
  CURSOR C1
  IS
  SELECT * FROM DEPARTMENT;
BEGIN
  FOR V_DEPT IN C1 LOOP
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ� : ' || V_DEPT.DEPT_ID
                         || ', �μ��� : ' || V_DEPT.DEPT_TITLE
                         || ', ���� : ' || V_DEPT.LOCATION_ID);
  END LOOP;
END;
/
EXEC CURSOR_DEPT2;

-- I�� 1�� ������ ���̺� �ε����� 1���� ���� <-- �� �ּ��� ����..?
-- IN �κ��� ���������� CURSOR ��ü
CREATE OR REPLACE PROCEDURE CURSOR_DEPT3
IS
  V_DEPT DEPARTMENT%ROWTYPE;
BEGIN
  FOR V_DEPT IN (SELECT * FROM DEPARTMENT) LOOP
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ� : ' || V_DEPT.DEPT_ID
                         || ', �μ��� : ' || V_DEPT.DEPT_TITLE
                         || ', ���� : ' || V_DEPT.LOCATION_ID);
  END LOOP;
END;
/
EXECUTE CURSOR_DEPT3;

-- PACKAGE
-- : ���ν����� �Լ��� ȿ�������� �����ϱ� ���� ���� ����
--   ��Ű����.�Լ���() <- �̷� ���·� ȣ����
--   EX) DBMS_OUTPUT.PUT_LINE();

CREATE OR REPLACE PACKAGE KH_PACK
IS
  PROCEDURE CURSOR_DEPT3;
  FUNCTION BONUS_CALC(V_EMPID EMPLOYEE.EMP_ID%TYPE) RETURN NUMBER;
END;
/

-- ���� �� �� ��Ű�� �ٵ� ��������
-- �׷��� �̹� �����Ǿ� �ִ� �Լ��δ� �� ��
EXEC KH_PACK.CURSOR_DEPT3;

DROP PACKAGE KH_PACK;

CREATE OR REPLACE PACKAGE KH_PACK
IS
  PROCEDURE SHOW_EMP;
END;
/
CREATE OR REPLACE PACKAGE BODY KH_PACK
IS
  PROCEDURE SHOW_EMP
  IS
    V_EMP EMPLOYEE%ROWTYPE;
    CURSOR C1
    IS
    SELECT EMP_ID, EMP_NAME, EMP_NO FROM EMPLOYEE;
  BEGIN
    FOR V_EMP IN C1 LOOP
      DBMS_OUTPUT.PUT_LINE('��� : ' || V_EMP.EMP_ID || ', �̸� : ' || V_EMP.EMP_NAME 
                           || ', �ֹε�Ϲ�ȣ : ' || V_EMP.EMP_NO);
    END LOOP;
  END;
END;
/
EXEC KH_PACK.SHOW_EMP;

-- Ʈ����(TRIGGER)
-- : ���̺� INSERT, UPDATE, DELETE �� DML�� ����
--   ����� �� �ڵ����� ������ ������ �����Ͽ� ������ ��ü�̴�.
--   Ʈ���Ű� �߻��ϴ� ������ DML ����, ���ķ� ������ �� �ִ�.
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT
ON EMPLOYEE
BEGIN
  DBMS_OUTPUT.PUT_LINE('���Ի���� �Ի��߽��ϴ�.');
END;
/

INSERT INTO EMPLOYEE
VALUES (300, '�漺��', '650512-1151241', 'gil_sc@kh.or.kr', 
        '01012343578', 'D5', 'J3', 'S5', 3000000, 0.1, 200,
        SYSDATE, NULL, DEFAULT);

CREATE TABLE PRODUCT(
  PCODE NUMBER PRIMARY KEY,
  PNAME VARCHAr2(30),
  BRAND VARCHAR2(30),
  PRICE NUMBER,
  STOCK NUMBER DEFAULT 0
);

CREATE TABLE PRO_DETAIL (
  DCODE NUMBER PRIMARY KEY,
  PCODE NUMBER,
  PDATE DATE,
  AMOUNT NUMBER,
  STATUS VARCHAR2(10) CHECK (STATUS IN ('�԰�' , '���')),
  FOREIGN KEY(PCODE) REFERENCES PRODUCT(PCODE)
);

CREATE SEQUENCE SEQ_PCODE;
CREATE SEQUENCE SEQ_DCODE;

INSERT INTO PRODUCT
VALUES (SEQ_PCODE.NEXTVAL, '�����ó�Ʈ8', '���', 900000, DEFAULT);

INSERT INTO PRODUCT
VALUES (SEQ_PCode.NEXTVAL, '������8', '����', 900000, DEFAULT);

INSERT INTO PRODUCT
VALUES (SEQ_PCode.NEXTVAL, '�����', '�����', 300000, DEFAULT);

COMMIT;

SELECT *FROM PRODUCT;

SELECT *FROM PRO_DETAIL;

-- �� Ʈ���� : �÷��� ������ �࿡ �����Ϳ� �� ��ȭ�� ���� ������ ����Ǹ�,
--            �� ������ ���� ���� ���� ������ �� �ִ�.
-- ���� Ʈ���� : Ʈ���� ��ǿ� ���ؼ� �� �ѹ��� ����Ǹ�, 
--              �÷��� �� ������ ���� ������ �� ����.

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT
ON PRO_DETAIL
FOR EACH ROW
BEGIN
  IF :NEW.STATUS = '�԰�'
    THEN 
      UPDATE PRODUCT
      SET STOCK = STOCK + :NEW.AMOUNT
      WHERE PCODE = :NEW.PCODE;
  END IF;
  IF :NEW.STATUS = '���'
    THEN
      UPDATE PRODUCT
      SET STOCK = STOCK - :NEW.AMOUNT
      WHERE PCODE = NEW.PCODE;
  END IF;
END;
/



