-- DAY3 ��������
-- NULL ó�� �Լ�
-- NVL(�÷���, �÷����� NULL�� �� �ٲ� ��)

SELECT
       EMP_NAME
     , BONUS
     , NVL(BONUS, 0)
FROM EMPLOYEE;

-- NVLL2 (�÷���, �ٲܰ�1, �ٲܰ�2)
-- �ش� �÷��� ���� ������ �ٲܰ�1�� ����
-- �ش� �÷��� NULL �̸� �ٲܰ�2�� ����

-- ������������ ���ʽ�����Ʈ�� NULL�� ��� 0.5��
-- ���ʽ� ����Ʈ�� NULL�� �ƴ� ��� 0.7�� �����Ͽ� ��ȸ
SELECT
       EMP_NAME
     , BONUS
     , NVL2(BONUS, 0.7, 0.5)
FROM EMPLOYEE;

-- �����Լ�
-- ���� ���� ��쿡 ������ �� �ִ� ����� �����Ѵ�.
-- DECODE(���� | �÷���, ���ǰ�1, ���ð�1, ���ǰ�2, ���ð�2, ...)

SELECT
       EMP_ID
     , EMP_NAME
     , EMP_NO
     , DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��')
FROM EMPLOYEE;

-- ������ ���ڷ� ���ǰ� ���� ���ð��� �ۼ��ϸ�
-- �ƹ��͵� �ش礷���� ���� �� �������� �ۼ��� ���ð��� ������ �����Ѵ�. ��ġ ELSE

SELECT
       EMP_ID
     , EMP_NAME
     , EMP_NO
     , DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '��')
FROM EMPLOYEE;

-- ������ �޿��� �λ��ϰ��� �Ѵ�.
-- �����ڵ尡 J7�� ������ �޿��� 10%�� �λ��ϰ�
-- �����ڵ尡 J6�� ������ �޿��� 15%�� �λ��ϰ�
-- �����ڵ尡 J5�� ������ �޿��� 20%�� �λ��Ѵ�.
-- �� �� ������ ������ �޿��� 5%�� �λ��Ѵ�.
-- ���� ���̺��� ������, �����ڵ�, �޿�, �λ�޿�(�� ����)�� ��ȸ�ϼ���
SELECT
       EMP_NAME
     , JOB_CODE
     , SALARY
     , DECODE(JOB_CODE, 'J7', SALARY + SALARY * 0.1,
                        'J6', SALARY + SALARY * 0.15, 
                        'J5', SALARY + SALARY * 0.20, 
                              SALARY + SALARY * 0.05) �λ�޿�
FROM EMPLOYEE;

-- CASE
--   WHEN ���ǽ� THEN �����
--   WHEN ���ǽ� THEN �����
--   ELSE �����
-- END
SELECT
       EMP_NAME
     , JOB_CODE
     , SALARY
     , CASE
         WHEN JOB_CODE = 'J7' THEN SALARY * 1.1
         WHEN JOB_CODE = 'J6' THEN SALARY * 1.15
         WHEN JOB_CODE = 'J5' THEN SALARY * 1.2
         ELSE SALARY * 1.05
       END AS �λ�޿�
FROM EMPLOYEE;

-- ���, �����, �޿��� EMPLOYEE ���̺��� ��ȸ�ϰ�
-- �޿��� 500������ �ʰ��ϸ� '���'
-- �޿��� 300 ~ 500�����̸� '�߱�'
-- �� ���ϴ� '�ʱ�'���� ����ϰ� ��Ī�� '����'���� �Ѵ�.
select *from employee;
SELECT 
       EMP_ID
     , EMP_NAME
     , SALARY
     , CASE
         WHEN SALARY > 5000000 THEN '���'
         WHEN SALARY >= 3000000 THEN '�߱�'
         ELSE '�ʱ�'
       END AS ����
FROM EMPLOYEE;

-- GROUP�� ���� ���� ������ ����
-- HAVING�� �׷����� �Ǿ� �ִ� ���¿��� ������ �ɷ����� �����

-- ORDER BY �� : SELECT�� �÷��� ������ ������ �� �����
-- ORDER BY �÷��� | �÷���Ī |  �÷��������� [ASC] | DESC [NULLS FIRST | LAST]
-- ORDER BY �÷��� ���Ĺ��, �÷��� ���� ���, �÷��� ���� ���, ....
-- ù ��° �������� �ϴ� �÷��� ���� �����ϰ�
-- ���� �� �鿡 ���� �� ��° �������� �ϴ� �÷��� ���� �ٽ� ����
-- SELECT ������ �� �������� ��ġ
-- ���� ������ �� ������
/*
5 SELECT �÷��� AS ��Ī, ����, �Լ���
1 FROM �������̺��
2 WHERE �÷��� | �Լ��� �񱳿����� �񱳰�
3 GROUP BY �׷��� ���� �÷���
4 HAVING �׷��Լ��� �񱳿����� �񱳰�
6 ORDER BY �÷��� | ��Ī | �÷����� ���Ĺ�� [NULLS FIRST | LAST]
*/

-- GROUP BY�� ���� ��
-- COUNT(*) ���� 1��, DEPT_CODE�� ������ �̹Ƿ� ���� �߻�
SELECT
       COUNT(*) �����
     , DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- ���� DEPT_CODE �� �־��ָ� ���� �߻�
-- JOB_CODE���� GROUP�Լ��� �־��־����
SELECT 
       DEPT_CODE
     , JOB_CODE
     , SUM(SALARY)
     , COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1;

-- ���� ���̺��� �μ� �ڵ庰 �׷��� �����Ͽ�
-- �μ��ڵ�, �׷캰 �޿��� �հ�
SELECT
       DEPT_CODE
     , SUM(SALARY)
     , CEIL(AVG(SALARY))
     , COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1;

-- ���� ���̺��� ���� �ڵ�, ���ʽ��� �޴� ��� ���� ��ȸ�Ͽ�
-- �����ڵ� ������ �������� �����ϼ���
SELECT 
       JOB_CODE
     , COUNT(BONUS)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE ASC;

SELECT
       JOB_CODE
     , COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY JOB_CODE
ORDER BY JOB_CODE ASC;

-- ���� ���̺��� �ֹι�ȣ 8��° �ڸ��� ��ȸ�Ͽ�
-- 1�̸� ��, 2�̸� ���� ��� ��ȸ�ϰ�
-- ������ �޿� ���(����ó��), �޿� �հ�
-- �ο����� �������� ���� �ϼ���.
SELECT *FROM EMPLOYEE;
SELECT
      DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') ����
    , CEIL(AVG(SALARY)) �հ�
    , COUNT(*) �ο���
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��')
ORDER BY �ο��� DESC;

-- GROUP BY �� : ���� ������ ���� �� ��ϵ� �÷��� �ϳ��� �׷����� ����
-- GROUP BY �÷��� | �Լ���, ...
-- ���� ���� ���� ��� �ϳ��� �׷����� ������ ���� �ִ�.

-- HAVING �� : �׷��Լ��� ���ؿ� �׷쿡 ���� ������ ������ �� ���
-- HAVING �÷��� | �Լ��� �񱳿����� �񱳰�

-- WHERE �� ���� �Ÿ��� �׷�ȭ.
SELECT
       DEPT_CODE
     , FLOOR(AVG(SALARY)) ���
  FROM EMPLOYEE
 WHERE SALARY > 3000000
 GROUP BY DEPT_CODE
 ORDER BY 1;

-- HAVING �׷� �߿��� ���ǿ� �����ϴ� �׷츸
SELECT
       DEPT_CODE
     , FLOOR(AVG(SALARY)) ���
  FROM EMPLOYEE
 GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) > 3000000
 ORDER BY 1;
 
-- �μ��� �׷��� �޿� �հ� �� 9�鸸���� �ʰ��ϴ� �μ���
-- �μ��ڵ�, �޿� �հ� ��ȸ
SELECT 
       DEPT_CODE
     , SUM(SALARY) "�޿� �հ�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 9000000
ORDER BY 1;

-- �޿� �հ谡 ���� ���� �μ��� �μ��ڵ�� �޿� �հ踦 ���ϼ���
SELECT
       *
FROM
(SELECT
       DEPT_CODE
     , SUM(SALARY) �޿��հ�
FROM EMPLOYEE
GROUP BY DEPT_CODE) b
WHERE b.�޿��հ�=17700000;
--WHERE b.�޿��հ�=b.MAX(SUM(SALARY));

SELECT
       MAX(SUM(SALARY))
  FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT
       DEPT_CODE
     , SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY DEPT_CODE
 HAVING SUM(SALARY) = 17700000;

SELECT
       DEPT_CODE
     , SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT
                        MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE);

-- ���� 
-- �ڹ� ��ũ��02
-- ���� ���ϸ� : JAVA_WORKSHOP02_NAME.zip

-- �̷��� �ϳ� (���� ���� ������� zip ���ϸ� �̸� ������..�߿���)
-- ����Ŭ ��ũ�� SELECT - �Լ� 10 ~ 14��(15�� ���� �ȹ��)
-- ����Ŭ ��ũ�� SELECT - OPTION 1~5��

-- �̷��� �ϳ� (���� ���� ������� zip ���ϸ� �̸� ������..�߿���)
-- �Լ� �������� 1~7��(employee���� Ǯ �� ����)
-- ���� ���ϸ� : DAY3_HOMEWORK_NAME.zip
-- ������ �ΰ��� �ɰŶ� ����
