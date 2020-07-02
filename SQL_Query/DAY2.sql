-- DAY 2 ��������

-- �Լ� (FUNCTION): �÷� ���� �ϰϼ� ����� ����� ������
-- ������ (SINGLE ROW) : �÷��� ��ϵ� N���� ���� �о N���� ����� ����
-- �׷�(GROUP) �Լ� : �÷��� ��ϵ� N���� ���� �о �� ���� ����� ����

-- SELECT ���� ������ �Լ��� �׷� �Լ��� �԰� ������� ���Ѵ�.
-- : ��� ���� ������ �ٸ��� ����

-- �Լ��� ����� �� �ִ� ��ġ
-- : SELECT ��, WHERE ��, GROUP BY ��, HAVING ��, ORDER BY ��

-- �׷� �Լ� : SUM, AVG, MAX, MIN, COUNT
-- SUM(���� | ���ڰ� ��ϵ� �÷���) : �հ踦 ���Ͽ� ����
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- AVG(���ڰ� ��ϵ� �÷���) : ����� ���Ͽ� ����
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- MIN(�÷���) : �÷����� ���� ���� �� ����
-- ����ϴ� �ڷ����� ANY TIME��
SELECT MIN(EMAIL), MIN(HIRE_DATE), MIN(SALARY)
FROM EMPLOYEE;

-- MAX(�÷���) : �÷����� ���� ū �� ����
-- ����ϴ� �ڷ����� ANY TYPE��
SELECT MAX(EMAIL), MAX(HIRE_DATE), MAX(SALARY)
FROM EMPLOYEE;

-- COUNT(* | �÷���) : ���� ������ ��Ʒ��� ����
-- COUNT([DISTINCT] �÷���) : �ߺ��� ������ �� ���� ����
-- COUNT(�÷���) : NULL�� ������ ���� ���� ��ϵ� �� ���� ����
SELECT COUNT(*), COUNT(DEPT_CODE), COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

SELECT 
       AVG(BONUS)
     , AVG(DISTINCT BONUS)
     , AVG(NVL(BONUS, 0))
FROM EMPLOYEE;

-- ������ �Լ�
-- ���� ���� �Լ�
-- : LENGTH, LENGTHB, SUBSTR, UPPER, LOWER,, INSTR, ...
SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL;

-- INSTR('���ڿ�' | �÷���, '����', 'ã�� ��ġ�� ���۰�', [��])
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;  --  -1 ������ Ž�� (�ڿ��� ù ��°)
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '@', -1) ��ġ
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, �̸���, @���ĸ� ������ ���̵� ��ȸ
SELECT
       EMP_NAME
     , EMAIL
     , SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') -1)
FROM EMPLOYEE;

-- LPAD / RPAD : �־��� �÷� ���ڿ��� ������ ���ڿ��� ���ٿ� ���� N�� ���ڿ��� ��ȯ
SELECT LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT LPAD(EMAIL, 10)
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 10)
FROM EMPLOYEE;

-- LTRIM/RTRIM : �־��� �÷��̳� ���ڿ� ����/�����ʿ���
--               ������ ���� Ȥ�� ���ڿ��� ������ �������� ��ȯ�ϴ� �Լ�
SELECT LTRIM('   KH') FROM DUAL;
SELECT LTRIM('   KH', ' ') FROM DUAL;
SELECT LTRIM('000123456', '0') FROM DUAL;
SELECT LTRIM('123123KH', '123') FROM DUAL;
SELECT LTRIM('123123KH123', '123') FROM DUAL;  -- ������ �� ������ �ٷ� ��ȯ.
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;    -- �����ڴ� ���� ������� ������
SELECT LTRIM('5782KH', '0123456789') FROM DUAL;

SELECT RTRIM('KH   ') FROM DUAL;
SELECT RTRIM('KH   ', ' ') FROM DUAL;
SELECT RTRIM('123456000', '0') FROM DUAL;
SELECT RTRIM('KH123123', '123') FROM DUAL;
SELECT RTRIM('KHACABACC', 'ABC') FROM DUAL;
SELECT RTRIM('KH5782', '0123456789') FROM DUAL;

-- TRIM : �־��� �÷��̳� ���ڿ��� ��/�ڿ� ������ ���ڸ� ����
SELECT TRIM('   KH   ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM(LEADING 'Z' FROM 'ZZZ123456ZZZ') FROM DUAL;
SELECT TRIM(TRAILING 'Z' FROM 'ZZZ123456ZZZ') FROM DUAL;
SELECT TRIM(BOTH 'Z' FROM 'ZZZ123456ZZZ') FROM DUAL;

-- SUBSTR : �÷��̳� ���ڿ����� ������ ��ġ�κ��� 
--          ������ ������ ���ڿ��� �߶� �����ϴ� �Լ��̴�.
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;
SELECT SUBSTR('��� �� �� �Ӵ�', 2, 5) FROM DUAL;

-- EMPLOYEE ���̺��� ����̸�, �ֹι�ȣ �����ڸ�
SELECT *FROM EMPLOYEE;
SELECT INSTR(EMP_NO, '-') FROM EMPLOYEE;

SELECT 
       EMP_NAME
     , SUBSTR(EMP_NO ,INSTR(EMP_NO, '-') + 1, 1)
FROM EMPLOYEE;

-- LOWER / UPPER / INITCAP
-- : LOWER(���ڿ� | �÷�) : �ҹ��ڷ� �������ִ� �Լ�
SELECT LOWER('Welcome To My World') 
FROM DUAL;

-- : UPPER(���ڿ� | �÷�) : �빮�ڷ� �������ִ� �Լ�
SELECT UPPER('Welcome To My World') 
FROM DUAL;

-- : INITCAP(���ڿ� | �÷�) : �ձ��ڸ� �빮�ڷ� �������ִ� �Լ�
SELECT INITCAP('welcome to my world') 
FROM DUAL;

-- CONCAT : ���ڿ� Ȥ�� �÷� �� ���� �Է¹޾� �ϳ��� ��ģ �� ����
SELECT CONCAT('�����ٶ�', 'ABCD')
FROM DUAL;

SELECT ('�����ٶ�' || 'ABCD') 
FROM DUAL;

-- REPLACE : �÷� Ȥ�� ���ڿ��� �Է¹޾�
--           �����ϰ��� �ϴ� ���ڿ���
--           �����Ϸ��� �ϴ� ���ڿ��� �ٲ� �� ����
SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��')
FROM DUAL;

-- EMPLOYEE ���̺��� �������� �ֹι�ȣ�� ��ȸ�Ͽ� 
-- �����, ����, ����, ������ ���� �и��Ͽ� ��ȸ
-- �� �÷� ��Ī�� �����, ����, ����, ���Ϸ� �Ѵ�.
SELECT
       EMP_NAME �����
       , SUBSTR(EMP_NO, 1, 2) ����
       , SUBSTR(EMP_NO, 3, 2) ����
       , SUBSTR(EMP_NO, 5, 2) ����
FROM EMPLOYEE;

-- ���������� ��� �÷� ���� ��ȸ
SELECT *FROM EMPLOYEE;
SELECT *FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2;

-- ��¥ �����Ϳ����� SUBSTR�� ����� �� �ִ�.
-- �������� �Ի��Ͽ��� �Ի�⵵, �Ի��, �Ի糯¥�� �и� ��ȸ
SELECT
       HIRE_DATE
     , SUBSTR(HIRE_DATE, 1, 2) �Ի�⵵
     , SUBSTR(HIRE_DATE, 4, 2) �Ի��
     , SUBSTR(HIRE_DATE, 7, 2) �Ի糯¥
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, �ֹι�ȣ ��ȸ
-- ��, �ֹι�ȣ�� ������ϸ� ���̰� �ϰ� '-' �̤����� ���� '*'�� �ٲ㼭 ���
SELECT *FROM EMPLOYEE;
SELECT EMP_NAME, CONCAT(SUBSTR(EMP_NO, 1, 7), '*******') �ֹι�ȣ
FROM EMPLOYEE;

SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 7) || '*******' �ֹι�ȣ
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 7), 14, '*') �ֹι�ȣ
FROM EMPLOYEE;

-- ���� ó�� �Լ� : ABS, MOD, ROUND, FLOOR, TRUNC, CEIL
-- ABS(���� | ���ڷ� �� �÷���) : ���밪 ���ϴ� �Լ�
SELECT ABS(-10), ABS(10) FROM DUAL;

-- MOD(���� | ���ڷ� �� �÷���, ���� | ���ڷ� �� �÷���) 
-- : �� ���� ����� �������� ���ϴ� �Լ�
-- ó�� ���ڴ� ���������� ��, �� ��° ���ڴ� ���� ��
SELECT MOD(10, 5), MOD(10, 3) FROM DUAL;

-- ROUND(���� | ���ڷ� �� �÷���, [��ġ])
--: �ݿø��ؼ� �����ϴ� �Լ� .�� 0��° ��ġ
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.456, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 2) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;
SELECT ROUND(123.456, -1) FROM DUAL;

-- FLOOR(���� | ���ڷ� �� �÷���) : ����ó�� �ϴ� �Լ�
SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(123.678) FROM DUAL;

-- TRUNC(���� | ���ڷ� �� �÷���, [��ġ]) : ����ó��(����) �Լ�
SELECT TRUNC(123.678) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456, 2) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;

-- CEIL(���� | ���ڷ� �� �÷���) : �ø�ó�� �Լ�
SELECT CEIL(123.456) FROM DUAL;

SELECT
       ROUND(123.456)
     , FLOOR(123.456)
     , TRUNC(123.456)
     , CEIL(123.456)
FROM DUAL;

-- ��¥ ó�� �Լ� : SYSDATE, MONTHS_BETWEEN, AND_MONTHS, 
--                 NEXT_DAY, LAST_DAY, EXTRACT
-- SYSDATE : �ý��ۿ� ����Ǿ� �ִ� ��¥�� ��ȯ�ϴ� �Լ�
SELECT SYSDATE FROM DUAL;

-- MONTHS_BETWEEN(��¥, ��¥)
-- : �� ��¥�� ���� �� ���̸� ���ڷ� �����ϴ� �Լ�
SELECT EMP_NAME, HIRE_DATE, CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) -- �ٹ� ���� ��
FROM EMPLOYEE;

-- ADD_MONTHS(��¥, ����)
-- : ��¥�� ���ڸ�ŭ ���� ���� ���� ��¥�� ����
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- EMPLOYEE ���̺��� ����� �̸�, �Ի���, �Ի� �� 6������ �Ǵ� ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �ٹ������ 20�� �̻��� ���� ��ȸ
SELECT *
FROM EMPLOYEE 
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;

SELECT *
FROM EMPLOYEE 
WHERE ADD_MONTHS(HIRE_DATE, 240) <= SYSDATE;

-- NEXT_DAY(���س�¥, ����)
-- : ���� ��¥���� ���Ϸ��� ���Ͽ� ���� ����� ��¥ ����
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�ݿ���') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;

-- LAST_DAY(��¥) : �ش� ���� ������ ��¥�� ���Ͽ� ����
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

-- EMPLOYEE ���̺��� �����, �Ի���, �Ի��� ���� �ٹ��ϼ��� ��ȸ�ϼ���
SELECT EMP_NAME, HIRE_DATE,
       LAST_DAY(HIRE_DATE) - HIRE_DATE + 1
FROM EMPLOYEE;

-- EXTRACT : ��, ��, �� ������ �����Ͽ� �����ϴ� �Լ�
-- EXTRACT(YEAR FROM ��¥) : �⵵�� ����
-- EXTRACT(MONTH FROM ��¥) : ���� ����
-- EXTRACT(DAY FROM ��¥) : ��¥�� ����
SELECT
       EXTRACT(YEAR FROM SYSDATE) �⵵
     , EXTRACT(MONTH FROM SYSDATE) ��
     , EXTRACT(DAY FROM SYSDATE) ��¥
FROM DUAL;

-- EMPLOYEE ���̺��� ����̸�, �Ի��, �Ի��, �Ի��� ��ȸ
SELECT
       EMP_NAME ����̸�
     , EXTRACT(YEAR FROM HIRE_DATE) �Ի��
     , EXTRACT(MONTH FROM HIRE_DATE) �Ի��
     , EXTRACT(DAY FROM HIRE_DATE) �Ի���
FROM EMPLOYEE
--WHERE ����̸� = '���ؼ�'
-- ORDER BY EMP_NAME ASC;
-- ORDER BY EMP_NAME DESC;
-- ORDER BY ����̸�;
-- ORDER BY 1;
--ORDER BY �Ի�� ASC, ����̸� ASC;
ORDER BY �Ի�� ASC, ����̸� DESC;

-- EMPLOYEE ���̺��� �������� ������ �ٹ� ��� ��ȸ
-- ��, MONTHS_BETWEEN ���
SELECT *FROM EMPLOYEE;

SELECT 
       EMP_NAME
     , HIRE_DATE
     , CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) �ٹ����
FROM EMPLOYEE;

SELECT EMP_NAME, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) �ٹ����
FROM EMPLOYEE;

ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';

-- ����ȯ �Լ�
SELECT *
FROM EMPLOYEE
WHERE EMP_ID = 200;

-- ����ȯ �Լ�
-- TO_CHAR(��¥, [����]) : ��¥�� �����͸� ���ڿ��� ����
-- TO_CHAR(����, [����]) : ������ �����͸� ���ڿ��� ����
SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '99999') FROM DUAL; -- ���ڶ�� ���ڶ�� ��� ����
SELECT TO_CHAR(1234, '00000') FROM DUAL; -- ���ڶ�� ���ڶ�� ���� 0���� ä��
SELECT TO_CHAR(1234, '999') FROM DUAL; -- ������ �Ұ�(�ڸ��� �ȸ���)
SELECT TO_CHAR(1234, '000') FROM DUAL; -- ������ �Ұ�(�ڸ��� �ȸ���)
SELECT TO_CHAR(1234, 'L99999') FROM DUAL; -- ȭ���ȣ(��ȭ)
SELECT TO_CHAR(1234, '$99999') FROM DUAL; -- ȭ���ȣ(�޷�)
SELECT TO_CHAR(1234, 'L99,999') FROM DUAL; -- ȭ���ȣ(��ȭ) õ�� ���� �޸�
SELECT TO_CHAR(1234, '$99,999') FROM DUAL; -- ȭ���ȣ(�޷�) õ�� ���� �޸�

-- ���� ���̺��� �����, �޿� ��ȸ
-- �޿��� '\9,000,000' �������� ���
SELECT *FROM employee;
SELECT EMP_NAME, TO_CHAR(SALARY, 'L99,999,999') AS �޿�
FROM EMPLOYEE;

-- ��¥ �����Ϳ� ���� ����� TO_CHAR �Լ� ���
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-fmMM-DD DAY') FROM DUAL; -- fm�� 0����
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL; -- DAY�� DY�� Ǯ���� DAY : �����, DY : ��
SELECT TO_CHAR(SYSDATE, 'YEAR, Q') || '�б�' FROM DUAL; -- Q�� �б⸦ �ǹ� YEAR�� ����� TEWENTY TWENTY

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') �Ի���
FROM EMPLOYEE;

-- �ѱ� ���� �ȵ�(��, ��, ��)
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY�� MM�� DD��') �Ի���
FROM EMPLOYEE;
-- ����ǥ �߰��ؼ� �ؽ�Ʈ�� ó��
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"') �Ի���
FROM EMPLOYEE;

SELECT
       EMP_NAME
     , HIRE_DATE
     , TO_CHAR(HIRE_DATE, 'YYYY/MM/DD HH24:MI:SS') ���Ի���
FROM EMPLOYEE;

-- ���� ��¥�� ���� �⵵ 4�ڸ�, �⵵ 2�ڸ�, �⵵ �̸����� ���
SELECT
       TO_CHAR(SYSDATE, 'YYYY')
     , TO_CHAR(SYSDATE, 'YY')
     , TO_CHAR(SYSDATE, 'RRRR')
     , TO_CHAR(SYSDATE, 'RR')
     , TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- RR�� YY�� ����
-- �⵵ �ٲ� ��(TO_DATE ����) Y�� �����ϸ�
-- ���� ����(2000��) ����
-- R�� 50�� �̻��̸� ���� ����(1900��),
-- 50�� �̸��̸� ���� ����(2000��) ����
SELECT TO_CHAR(TO_DATE('980630', 'YYMMDD'), 'YYYY-MM-DD')
FROM DUAL;
SELECT TO_CHAR(TO_DATE('980630', 'RRMMDD'), 'YYYY-MM-DD')
FROM DUAL;

-- ���� ��¥���� ���� ���
SELECT
       TO_CHAR(SYSDATE, 'MM')
     , TO_CHAR(SYSDATE, 'MONTH')
     , TO_CHAR(SYSDATE, 'MON')
     , TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-- ���� ��¥���� �ϸ� ���(DDD/DD/D)
-- DDD : 1�� �߿� �� �� ° ����
-- DD : �� ���� �� �� ° ����
-- D : �� �ֿ��� �� �� °����
SELECT
       TO_CHAR(SYSDATE, '"1�� ���� " DDD "�� °"')
     , TO_CHAR(SYSDATE, '"�� ���� " DD "�� °"')
     , TO_CHAR(SYSDATE, '"�� ���� " D "�� °"')
FROM DUAL;

-- ���� ��¥���� �б�� ���� ��� ó��
SELECT
       TO_CHAR(SYSDATE, 'Q"�б�"')
     , TO_CHAR(SYSDATE, 'DAY')
     , TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

-- ���� ���̺��� �̸�, �Ի��� ��ȸ
-- �Ի��Ͽ� ���� ������
-- '2018�� 6�� 15�� (��)' �������� ��� ó�� �ϼ���
SELECT* FROM EMPLOYEE;
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'RRRR"��" fmMM"��" DD"��" ') || TO_CHAR(HIRE_DATE, '"("DY")"') �Ի���
FROM EMPLOYEE;

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'RRRR"��" fmMM"��" DD"��" (DY)') �Ի��� FROM EMPLOYEE;

-- TO_DATE : ������ ������ Ȥ�� ������ �����͸� ��¥�� ��ȯ�Ͽ� ����
SELECT TO_DATE('20100101', 'RRRRMMDD') FROM DUAL;
SELECT TO_CHAR(TO_DATE('20100101', 'RRRRDDMM'), 'RRRR, MON') FROM DUAL;

SELECT TO_DATE('041030 143000', 'RRMMDD HH24MISS') FROM DUAL;
SELECT TO_CHAR(TO_DATE('041030 143000', 'RRMMDD HH24MISS'), 'DD-MON-RR HH:MI:SS PM')
FROM DUAL;

-- ���� ���̺��� 2000�⵵ ���Ŀ� �Ի��� �����
-- ���, �̸�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE HIRE_DATE >= TO_DATE(20000101, 'RRRRMMDD')
--WHERE HIRE_DATE >= 20000101;
WHERE HIRE_DATE >= '20000101';

-- TO_NUMBER : ���� �����͸� ���ڷ� �ٲ� �� ���
SELECT TO_NUMBER('123456789') FROM DUAL;

-- �ڵ� ����ȯ
SELECT '123' + '456' FROM DUAL;
-- ���ڷ� �� ���ڿ��� �����ϴ�.
SELECT '123' + '456A' FROM DUAL;

-- EMPLOYEE ���̺��� ����� Ȧ���� ������ ������ ��ȸ
SELECT *
FROM EMPLOYEE
WHERE MOD(TO_NUMBER(EMP_ID), 2) = 1;
--WHERE MOD(EMP_ID, 2) = 1; 

SELECT '1,000,000' + '5000,000' FROM DUAL;

-- �޸� ������ָ� TO_NUMBER ����
SELECT 
       TO_NUMBER('1,000,000', '99,999,999')
     + TO_NUMBER('500,000', '999,999')
FROM DUAL;

-- ����
-- �ڹ� ��ũ�� 01
-- : ���� ���� �� : JAVA_WORKSHOP01_ȫ�浿.zip
-- ����Ŭ ��ũ��
-- : basic select ��ü
-- : select - �Լ� 1 ~ 9��
-- : ���� ���� �� : DAY2_HOMEWORK_HONGGILDONG.sql