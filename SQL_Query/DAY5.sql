-- DAY 5 ��������
-- SUBQUERY(��������)
-- �������� : ������ �ȿ��� ���� ������

-- ������� ���ö�� ����� �μ� ��ȸ
SELECT
       DEPT_CODE
  FROM EMPLOYEE
 WHERE EMP_NAME='���ö';

-- �μ��ڵ尡 D9�� ���� ��ȸ
SELECT
       EMP_NAME
  FROM EMPLOYEE
 WHERE DEPT_CODE='D9';
 
-- �μ��ڵ尡 ���ö ����� ���� �Ҽ��� ���� ��� ��ȸ
SELECT
       EMP_NAME
  FROM EMPLOYEE
 WHERE DEPT_CODE = (
                    SELECT DEPT_CODE
                      FROM EMPLOYEE
                     WHERE EMP_NAME='���ö'
                   )
   AND EMP_NAME <> '���ö';
   
-- �� ������ ��� �޿����� ���� �޿��� �ް� �ִ� ������
-- ���, �̸�, �����ڵ�, �޿��� ��ȸ�ϼ���
SELECT
       EMP_ID
     , EMP_NAME
     , JOB_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY > (
                 SELECT AVG(SALARY)
                   FROM EMPLOYEE
                );

-- ���������� ����
-- ������ �������� : ���������� ��ȸ ������� 1���� ���� ��
--                  �����ڷ� ��밡��
-- ������ �������� : ���������� ��ȸ ������� ���� ���� ���� ��
--                  ���� �μ��ڵ� D9, D7�̸� IN (��������)
-- ���߿� �������� : ���������� ��ȸ ������� ���� �÷��� ��
-- ������ ���߿� �������� : ���������� ��ȸ ��� �� ���� �� ���� ���� ���� ��

-- �������� ������ ���� �������� �տ� �ٴ� �����ڰ� �ٸ�
-- ������ �������� �տ��� �Ϲ� �񱳿����� ���
-- >, <, >=, <=, =, !=/^=/<>

-- ���ö ����� �޿����� ���� �޴� ������
-- ���, �̸�, �μ�, ����, �޿��� ��ȸ�ϼ���
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , JOB_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY > (
                 SELECT SALARY
                   FROM EMPLOYEE
                  WHERE EMP_NAME='���ö'
                );

-- JOIN .VER
SELECT
       E.EMP_ID
     , E.EMP_NAME
     , D.DEPT_TITLE
     , J.JOB_NAME
     , E.SALARY
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
 WHERE SALARY > (
                 SELECT SALARY
                   FROM EMPLOYEE
                  WHERE EMP_NAME = '���ö'
                );
 
-- ���� ���� �޿��� �޴� ������
-- ���, �̸�, ����, �μ�, �޿�, �Ի��� ��ȸ
SELECT
       EMP_ID
     , EMP_NAME
     , JOB_CODE
     , DEPT_CODE
     , SALARY
     , HIRE_DATE
  FROM EMPLOYEE
 WHERE SALARY = (
                 SELECT MIN(SALARY)
                   FROM EMPLOYEE
                );

-- ���������� SELECT, FROM, WHERE, HAVING, ORDER BY�������� ����� �����ϴ�. (GROUP BY�� ����)
-- �μ��� �޿��� �հ� �� ���� ū �μ��� �μ���, �޿� �հ踦 ���ϼ���
SELECT
       MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT 
       DEPT_CODE
     , SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (
                      SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                       GROUP BY DEPT_CODE
                     );
SELECT 
       D.DEPT_TITLE
     , SUM(SALARY)
 FROM EMPLOYEE E
 LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) = (
                      SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                       GROUP BY DEPT_CODE
                     );

-- ������ ��������
-- ������ �������� �տ��� �Ϲ� �񱳿����� ��� ����
-- IN / NOT IN : ���� ���� ����� �� �� ���� ��ġ�ϴ� ���� �ִٸ� Ȥ�� ���ٸ� �̶�� �ǹ�
-- > ANY, < ANY : ���� ���� ��� �� �߿��� �� ���� ū / ���� ���
--                ���� ���� �� ���� ũ��? / ���� ū ������ �۳�?
-- > ALL, < ALL : ��� �� ���� ū / ���� ���
-- EXISTS / NOT EXISTS : ���� �����ϳ�? / �������� �ʴ���?

-- 200�� ����� �����ϳ�.. all true(��ü ��ȸ) ���� 100�� ����̸� all false(�ƹ��͵� ��ȸ �ȵ�)
SELECT *
  FROM EMPLOYEE
 WHERE EXISTS (SELECT *
                 FROM EMPLOYEE
                WHERE EMP_ID = 200);

-- �μ��� �ְ� �޿��� �޴� ������ �̸�, ����, �μ�, �޿� ��ȸ
SELECT
       DEPT_CODE
     , MAX(SALARY)
  FROM EMPLOYEE
 GROUP BY DEPT_CODE;
 
SELECT
       EMP_NAME
     , JOB_CODE
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY IN (
                   SELECT MAX(SALARY)
                     FROM EMPLOYEE
                    GROUP BY DEPT_CODE
                 );

-- SELECT ������ ���������� ����� �� �ִ�.
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_TITLE
     , CASE
         WHEN EMP_ID IN(SELECT DISTINCT MANAGER_ID
                          FROM EMPLOYEE
                         WHERE MANAGER_ID IS NOT NULL
                       )
         THEN '������'
         ELSE '����'
       END AS ����
  FROM EMPLOYEE E
  LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = DEPT_ID);

-- �븮 ������ ������ �߿��� ���� ������ �ּ� �޿����� ���� �޴� ������
-- ���, �̸�, ����, �޿��� ��ȸ�ϼ���
-- ��, > ANY Ȥ�� < ANY ������ ���
SELECT
       *
  FROM EMPLOYEE E 
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
 WHERE J.JOB_NAME = '����';

SELECT
       E.EMP_ID
     , E.EMP_NAME
     , J.JOB_NAME
     , E.SALARY
  FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE J.JOB_NAME = '�븮'
AND E.SALARY > ANY (
                    SELECT MIN(E.SALARY)
                      FROM EMPLOYEE E
                      JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
                     WHERE J.JOB_NAME = '����'
                   );

-- ���� ������ �޿��� ���� ū �� ���� ���� �޴� ���� ������
-- ���, �̸�, ����, �޿��� ��ȸ�ϼ���
-- ��, > ALL Ȥ�� < ALL �����ڸ� ���.
SELECT 
       SALARY
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE J.JOB_NAME = '����';

SELECT
       E.EMP_ID
     , E.EMP_NAME
     , J.JOB_NAME
     , E.SALARY
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE J.JOB_NAME = '����'
AND E.SALARY > ALL(
                    SELECT SALARY
                      FROM EMPLOYEE E
                      JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
                     WHERE J.JOB_NAME = '����'
                  );

-- �ڱ� ������ ��� �޿��� �ް� �ִ� ������
-- ���, �̸�, ����, �޿��� ��ȸ�ϼ���
-- ��, �޿��� �޿� ����� ���������� ����ϼ��� TRUNC(�÷���, -5)

SELECT
       JOB_CODE
     , TRUNC(SALARY, -5)
FROM EMPLOYEE;

SELECT
       E.EMP_ID
     , E.EMP_NAME
     , J.JOB_NAME
     , TRUNC(E.SALARY, -5) �޿�
  FROM EMPLOYEE E
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
 WHERE SALARY IN ( -- �ڱ� ���ް� ��ġ�ϴ��� ���ΰ� ���� �ȵǾ����� -> ������ ���߿� �������� ���
                  SELECT TRUNC(AVG(SALARY), -5)
                    FROM EMPLOYEE
                   GROUP BY JOB_CODE
                 );

-- ������ ���߿� ���������� �̿��� �ذ�
SELECT
       EMP_ID
     , EMP_NAME
     , JOB_CODE
     , SALARY
  FROM EMPLOYEE
  -- ���� ���� IN���� ó�������� ���� ���� (JOB_CODE, SALARY)ó�� ������ �������
 WHERE (JOB_CODE, SALARY) IN (
                              SELECT JOB_CODE
                                   , TRUNC(AVG(SALARY), -5)
                                FROM EMPLOYEE
                               GROUP BY JOB_CODE
                             );
                             
-- ����� �������� ���� �μ�, ���� ���޿� �ش��ϴ� �����
-- �̸�, ����, �μ�, �Ի��� ��ȸ
SELECT
       DEPT_CODE
     , JOB_CODE
FROM EMPLOYEE
WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8, 1) = 2;

SELECT
       EMP_NAME
     , JOB_CODE
     , DEPT_CODE
     , HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) IN (
                                SELECT DEPT_CODE
                                     , JOB_CODE
                                  FROM EMPLOYEE
                                 WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8, 1) = 2
                               )
  AND EMP_ID NOT IN (
                      SELECT EMP_ID
                        FROM EMPLOYEE
                       WHERE SUBSTR(EMP_NO, 8, 1) = '2'
                         AND ENT_YN = 'Y'
  );
  
SELECT 
       EMP_NAME
     , JOB_CODE
     , DEPT_CODE
     , HIRE_DATE
  FROM EMPLOYEE
 WHERE DEPT_CODE IN (SELECT DEPT_CODE
                       FROM EMPLOYEE
                      WHERE SUBSTR(EMP_NO, 8, 1) = '2'
                        AND ENT_YN = 'Y')
   AND JOB_CODE IN (SELECT JOB_CODE
                      FROM EMPLOYEE
                     WHERE SUBSTR(EMP_NO, 8, 1) = '2'
                       AND ENT_YN = 'Y')
   AND EMP_ID NOT IN (SELECT EMP_ID
                        FROM EMPLOYEE
                       WHERE SUBSTR(EMP_NO, 8, 1) = '2'
                         AND ENT_YN = 'Y');

-- SELECT��, FROM��, WHERE��, HAVING��, ORDER BY��
-- DML ���� : INSERT��, UPDATE��
-- DDL ���� : CREATE TABLE ��, CREATE VIEW ��

-- FROM ������ ���������� ����� �� �ִ� : ���̺� ��ſ� ���
-- �ζ��� ��(INLINE VIEW) ��� ��
SELECT
       JOB_CODE
     , TRUNC(AVG(SALARY), -5) AS JOBAVG
  FROM EMPLOYEE
 GROUP BY JOB_CODE;
 
SELECT
       EMP_NAME
     , JOB_NAME
     , SALARY
  FROM (SELECT JOB_CODE
             , TRUNC(AVG(SALARY), -5) AS JOBAVG
          FROM EMPLOYEE
         GROUP BY JOB_CODE) V
  JOIN EMPLOYEE E ON(JOBAVG = SALARY AND E.JOB_CODE = V.JOB_CODE)
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
  ORDER BY JOB_NAME;

SELECT
       EMP_NAME
     , DEPT_TITLE AS �μ���
     , JOB_NAME AS �����̸�
  FROM EMPLOYEE E
  LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

SELECT 
       EMP_NAME
     , �μ���
     , �����̸�
       -- DEPT_TITLE�� ������ ������ (�μ���)���� ���������
       -- �ζ��� �信���� ������ ��Ī����
 FROM (SELECT EMP_NAME
            , DEPT_TITLE AS �μ���
            , JOB_NAME AS �����̸�
         FROM EMPLOYEE E
         LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
         JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE))
 WHERE �μ���='�λ������';

-- TOP-N �� ������ �� ������
-- �ζ��� �並 Ȱ���� TOP-N �м�
SELECT
       ROWNUM    
     , EMP_NAME
     , SALARY
  FROM EMPLOYEE
 WHERE ROWNUM >= 5
 -- 5���� ũ�ų� ���� �� ���� ���ϴ� ������?
 -- ù�࿡ 1�� �پ��µ� WHERE�� FALSE�� �Ǹ鼭 1FALSE 1FALSE �ݺ� -> ��� ���� ����
 ORDER BY SALARY DESC;

SELECT
       EMP_NAME
     , SALARY
  FROM EMPLOYEE
 ORDER BY SALARY DESC;

-- ORDER BY �� ����� ROWNUM�� �̿��Ͽ� TOP-N �м�
-- ROWNUM�� ���� �����ϴ� �÷��� �ƴ� ���� �÷�(pseudo column)
-- WHERE������ �ٿ���(true��) SELECT *FROM EMPLOYEE ORDER BY SALARY DESC�� WHERE�� ���� ��� Ʈ��
-- 5���� ū ���� ��ȸ�� �� ���� ������ �ϸƻ����ϴ�.
SELECT
       ROWNUM
     , EMP_NAME
     , SALARY
  FROM (SELECT *FROM EMPLOYEE ORDER BY SALARY DESC)
  -- FROM (SELECT ROWNUM RNUM, EMP_NAME, SALARY FROM EMPLOYEE ORDER BY SALARY DESC)
  -- ��ȸ�غ��� ���� RNUM�� ���׹��� (�̹� �ο��� ��)
 WHERE ROWNUM <= 5;
 
-- �޿� ����� 3�� �ȿ� ��� �μ���
-- �μ��ڵ�� �μ���, ��ձ޿��� ��ȸ�ϼ���
select *from department;
select *from employee;
SELECT 
       E.DEPT_CODE
     , D.DEPT_TITLE
     , FLOOR(AVG(SALARY)) ��ձ޿�
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
 GROUP BY DEPT_CODE, D.DEPT_TITLE
 ORDER BY FLOOR(AVG(SALARY)) DESC;

SELECT
       �μ��ڵ�
     , �μ���
     , ��ձ޿�
  FROM (SELECT E.DEPT_CODE �μ��ڵ�
             , D.DEPT_TITLE �μ���
             , FLOOR(AVG(SALARY)) ��ձ޿�
          FROM EMPLOYEE E
          JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
         GROUP BY DEPT_CODE, D.DEPT_TITLE
         ORDER BY FLOOR(AVG(SALARY)) DESC)
 WHERE ROWNUM <= 3;
 
-- ���� �������� �޿��� ���� ���� �޴� ������
-- �̸�, �޿�, ���� ��ȸ
-- RANK() : ������ ���� ������ ����� ������ �ο� �� ��ŭ �ǳ� �ٰ� ���� ������ ���(1, 2, 2, 4)
-- DENSE_RANK() : �ߺ��Ǵ� ���� ������ ����� ���� ����� ó��(1, 2, 2, 3)

SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) ���� FROM EMPLOYEE;
-- ���⼭�� ������� ��Ī�� where ���� �� �� ���� 
-- �� ������ ����� ���̺� ó�� from�� ���(�ζ��κ�)

-- RANK()�� �̿��� TOP-N
SELECT
       *
  FROM (SELECT EMP_NAME
             , SALARY
             , RANK() OVER(ORDER BY SALARY DESC) ����
          FROM EMPLOYEE)
 WHERE ���� <= 5;
 
-- ���� ���̺��� ���ʽ��� ������ ������ ���� 5����
-- ���, �̸�, �μ���, ���޸�, �Ի����� ��ȸ�Ͻÿ�

SELECT *FROM department;

SELECT
       E.EMP_ID
     , E.EMP_NAME
     , E.DEPT_CODE
     , J.JOB_NAME
     , E.HIRE_DATE
     , D.DEPT_TITLE
     , SALARY * 12 + SALARY * NVL2(BONUS, BONUS, 0) ����
     , RANK() OVER(ORDER BY (SALARY * 12 + SALARY * NVL2(BONUS, BONUS, 0)) DESC) ����
  FROM EMPLOYEE E
  JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID);
  
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_TITLE
     , JOB_NAME
     , HIRE_DATE
 FROM (SELECT E.EMP_ID
            , E.EMP_NAME
            , E.DEPT_CODE
            , J.JOB_NAME
            , E.HIRE_DATE
            , D.DEPT_TITLE
            , SALARY * 12 + SALARY * NVL2(BONUS, BONUS, 0) ����
            , RANK() OVER(ORDER BY (SALARY * 12 + SALARY * NVL2(BONUS, BONUS, 0)) DESC) ����
         FROM EMPLOYEE E
         JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
         JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID))
 WHERE ���� <= 5;
 
-- ���������� �ִ� ����鸸
-- ���, �����, ������������ ������
SELECT 
       EMP_ID
     , EMP_NAME
     , ����������
FROM EMPLOYEE E 
JOIN (
       SELECT MANAGER_ID
            , COUNT(MANAGER_ID) ����������
         FROM EMPLOYEE
        GROUP BY manager_id) TMP 
  ON (E.EMP_ID = TMP.MANAGER_ID);

