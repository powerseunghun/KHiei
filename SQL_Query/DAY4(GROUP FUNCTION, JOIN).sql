-- ROLLUP �Լ� : �׷캰�� �߰� ���� ó���ϴ� �Լ�
-- GROUP BY �������� ����ϴ� �Լ�
-- �׷� ���� ���� ������鿡 ���� ���谡 �ڵ����� �߰���
SELECT
       JOB_CODE
     , SUM(SALARY)
  FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 1;

-- ���ڷ� ���޹��� �׷� �߿� ���� ���� ������ �׷� �� �հ��
-- �� �հ踦 ���Ѵ�.
SELECT
       DEPT_CODE
     , JOB_CODE
     , SUM(SALARY)
  FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;

-- CUBE �Լ� : �׷캰 ������ ����� �����ϴ� �Լ�.
SELECT
       JOB_CODE
     , SUM(SALARY)
  FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY 1;

-- �׷����� ������ ��� �׷쿡 ���� �հ�� �� �հ踦 ���Ѵ�.
SELECT
       DEPT_CODE
     , JOB_CODE
     , SUM(SALARY)
  FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;

-- GROUPING : 
-- ROLLUP�̳� CUBE�� ���� ���� ���⹰�� ���ڷ� ���޹��� �÷� ������
-- ���⹰�̸� 0�� ��ȯ�ϰ�, �ƴϸ� 1�� ��ȯ�Ѵ�.
SELECT
       DEPT_CODE
     , JOB_CODE
     , SUM(SALARY)
     , GROUPING(DEPT_CODE) "�μ��� �׷� ���� ����"
     , GROUPING(JOB_CODE) "���޺� �׷� ���� ����"
  FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;


SELECT
       DEPT_CODE
     , JOB_CODE
     , SUM(SALARY)
     , CASE WHEN GROUPING(DEPT_CODE) = 0
                 AND GROUPING(JOB_CODE) = 1
            THEN '�μ����հ�'
            WHEN GROUPING(DEPT_CODE) = 1
                 AND GROUPING(JOB_CODE) = 0
            THEN '���޺��հ�'
            WHEN GROUPING(DEPT_CODE) = 1
                 AND GROUPING(JOB_CODE) = 1
            THEN '���հ�'
            ELSE '�׷캰�հ�'
       END AS ����
  FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;

-- SET OPERATION(���տ���)
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5'
 UNION
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY > 3000000;
 
-- UNION ALL : ���� ���� ���� ����� �ϳ��� ��ġ�� ������
--             UNION���� �������� �ߺ� ������ ��� ���Խ�Ų��.
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE='D5'
UNION ALL
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY > 3000000;
 
-- INTERSECT : ���� ���� SELECT�� ������� ���� �κи� ����� ����
--             ���п����� �����հ� ����ϴ�.
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE='D5'
INTERSECT
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY > 3000000;
 
-- MINUS : ���� SELECT ������� ���� SELECT ����� ��ġ�� �κ��� ������
--         ������ �κи� ����, ���п��� �����հ� ����ϴ�.
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5'
MINUS
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY > 3000000;
 
-- GROUPING SETS : �׷캰�� ó���� ���� ���� SELECT���� �ϳ��� ��ģ ����� ���� ��
-- ����Ѵ�. SET OPERATOR(���տ�����) ����� ����� ������ ����� ���� �� �ִ�.
SELECT
       DEPT_CODE
     , JOB_CODE
     , MANAGER_ID
     , FLOOR(AVG(SALARY))
  FROM EMPLOYEE
GROUP BY GROUPING SETS(
        (DEPT_CODE, JOB_CODE, MANAGER_ID)
      , (DEPT_CODE, MANAGER_ID)
      , (JOB_CODE, MANAGER_ID)
);

-- JOIN : �� ���� ���̺��� �ϳ��� ���ļ� ����� ��ȸ�Ѵ�.
-- ����Ŭ ����
-- FROM ���� '.'�� �����ؼ� ��ġ�Ե� ���̺���� ����ϰ�
-- WHERE ���� ��ġ�⿡ ����� �÷����� ����Ѵ�.

-- ���ῡ ����� �� �÷����� �ٸ� ���
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , DEPT_TITLE
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID;

-- ���ῡ ����� �� �÷����� ���� ���
SELECT
       EMP_ID
     , EMP_NAME
     , EMPLOYEE.JOB_CODE
     , JOB_NAME
  FROM EMPLOYEE, JOB
 WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
 
-- ���̺� ��Ī ���
SELECT
       EMP_ID
     , EMP_NAME
     , E.JOB_CODE
     , JOB_NAME
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
   AND EMP_ID = 200;

-- ANSI ǥ��

-- ���ῡ ����� �÷����� ���� ��� USING(�÷���) ���
SELECT
       EMP_ID
     , EMP_NAME
     , JOB_CODE
     , JOB_NAME
  FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- ���ῡ ����� �÷����� �ٸ� ��� ON()�� ���
SELECT 
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , DEPT_TITLE
  FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- ���ῡ ����� �÷����� ���� ��쵵 ON()�� ����� �� �ִ�.
SELECT
       E.EMP_ID
     , E.EMP_NAME
     , E.JOB_CODE
     , J.JOB_NAME
  FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);

-- �μ� ���̺�� ���� ���̺��� �����Ͽ� ���̺� ��� ������ ��ȸ�ϼ���.
-- ANSI ǥ��
SELECT
       *
  FROM DEPARTMENT 
JOIN LOCATION ON(DEPARTMENT.LOCATION_ID = LOCATION.LOCAL_CODE);

SELECT
       *
  FROM DEPARTMENT D
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE);

-- ORACLE ����
SELECT
       *
  FROM DEPARTMENT D, LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE;

-- JOIN�� �⺻�� EQUAL JOIN �̴�. (EQU JOIN�̶�� ��, � �����̶�� ��)
-- ����Ǵ� �÷��� ���� ��ġ�ϴ� ��鸸 ���ε�

-- ��ġ�ϴ� ���� ���� ���� ���ο��� ���ܵǴ� ���� INNER JOIN�̶�� �Ѵ�. 

-- JOIN�� �⺻�� INNER JOIN & EQU JOIN �̴�.

-- OUTER JOIN : �� ���̺��� �����ϴ� �÷����� ��ġ���� �ʴ� �൵ ���ο� ���Խ�Ų��.
--              �ݵ�� OUTER JOIN���� ����ؾ� �Ѵ�.
-- 1. LEFT OUTER JOIN : ��ġ�⿡ ����� �� ���̺� �� ���� ����� ���̺��� ���� ����
--                      �������� JOIN
-- 2. RIGHT OUTER JOIN : ��ġ�⿡ ����� �� ���̺� �� ������ ����� ���̺��� ���� ����
--                       �������� JOIN
-- 3. FULL OUTER JOIN : ��ġ�⿡ ����� �� ���̺��� ���� ��� ����
--                      ����� �����Ͽ� JOIN

SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- LEFT OUTER JOIN
-- ANSI ǥ��
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
--LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- ORACLE ����
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID(+);

-- RIGHT OUTER JOIN
-- ANSI ǥ��
SELECT
       E.EMP_NAME
     , D.DEPT_TITLE
  FROM EMPLOYEE E
--RIGHT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID);
RIGHT OUTER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID);

-- ORACLE ����
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE E, DEPARTMENT D
 WHERE E.DEPT_CODE(+) = D.DEPT_ID;

-- FULL OUTER JOIN
-- ANSI ǥ��
SELECT
       E.EMP_NAME
     , D.DEPT_TITLE
  FROM EMPLOYEE E
--FULL OUTER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID);
FULL JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID);

-- ORACLE �������δ� FULL OUTER JOIN�� ���� ���Ѵ�.
SELECT
       E.EMP_NAME
     , D.DEPT_TITLE
  FROM EMPLOYEE E, DEPARTMENT D;
--WHERE DEPT_CODE(+) = D.DEPT_ID(+);

-- CROSS JOIN : ī���̼� ���̶�� �Ѵ�.
--              ���εǴ� ���̺��� �� ����� ��� ���ε� �����Ͱ� �˻��Ǵ� ����̴�.
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
 CROSS JOIN DEPARTMENT;

-- NON EQUAL JOIN(NON EQU JOIN, �� � ����)
-- ������ �÷��� ���� ��ġ�ϴ� ��찡 �ƴ�
-- ���� ������ ���ԵǴ� ����� �����ϴ� ���
-- ANSI ǥ��
SELECT
       E.EMP_NAME
     , E.SALARY
     , E.SAL_LEVEL
     , S.SAL_LEVEL
  FROM EMPLOYEE E
  JOIN SAL_GRADE S ON(E.SALARY >= S.MIN_SAL
                 AND E.SALARY <= S.MAX_SAL);
                 
SELECT * FROM SAL_GRADE;

-- ORACLE ����
SELECT
       E.EMP_NAME
     , E.SALARY
     , E.SAL_LEVEL
     , S.SAL_LEVEL
  FROM EMPLOYEE E, SAL_GRADE S
 WHERE E.SALARY >= S.MIN_SAL AND E.SALARY <= S.MAX_SAL;

-- SELF JOIN : ���� ���̺��� �����ϴ� ���
--             �ڱ� �ڽ� ���̺�� ������ �δ� ����̴�.
-- ORACLE ����
SELECT
       E1.EMP_ID
     , E1.EMP_NAME ����̸�
     , E1.DEPT_CODE
     , E1.MANAGER_ID
     , E2.EMP_NAME �������̸�
  FROM EMPLOYEE E1, EMPLOYEE E2
 WHERE E1.MANAGER_ID = E2.EMP_id;

-- ANSI ǥ��
SELECT
       E1.EMP_ID
     , E1.EMP_NAME �����
     , E1.DEPT_CODE
     , E1.MANAGER_ID
     , E2.EMP_NAME
  FROM EMPLOYEE E1
  JOIN EMPLOYEE E2 ON (E1.MANAGER_ID = E2.EMP_ID);

-- ���� JOIN : N���� ���̺��� ��ȸ�� �� ���
-- ANSI ǥ��
-- ���� ���� �߿���
SELECT
       E.EMP_ID
     , E.EMP_NAME
     , E.DEPT_CODE
     , D.DEPT_TITLE
     , L.LOCAL_NAME
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);

-- ORACLE ����
-- ORACLE ���� ������ ���� ���� ��� ����
SELECT
       E.EMP_ID
     , E.EMP_NAME
     , E.DEPT_CODE
     , D.DEPT_TITLE
     , L.LOCAL_NAME
  FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
 WHERE E.DEPT_CODE = D.DEPT_ID 
   AND D.LOCATION_ID = L.LOCAL_CODE;
-- WHERE D.LOCATION_ID = L.LOCAL_CODE
--   AND E.DEPT_CODE = D.DEPT_ID;

-- ������ �븮�̸鼭 �ƽþ� ������ �ٹ��ϴ� ���� ��ȸ
-- ���, �̸�, ���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�ϼ���
SELECT *FROM EMPLOYEE;
SELECT *FROM DEPARTMENT;
SELECT *FROM JOB;  -- JOB_NAME
SELECT *FROM LOCATION;

-- ANSI ǥ��
SELECT
       E.EMP_ID
     , E.EMP_NAME
     , J.JOB_NAME
     , D.DEPT_TITLE
     , L.LOCAL_NAME
     , E.SALARY
  FROM EMPLOYEE E
  JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
 WHERE J.JOB_NAME = '�븮' 
   AND L.LOCAL_NAME LIKE '%ASIA%';

-- ORACLE ����
SELECT
       E.EMP_ID
     , E.EMP_NAME
     , J.JOB_NAME
     , D.DEPT_TITLE
     , L.LOCAL_NAME
     , E.SALARY
  FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
 WHERE E.JOB_CODE = J.JOB_CODE 
   AND E.DEPT_CODE = D.DEPT_ID 
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND J.JOB_NAME = '�븮' 
   AND L.LOCAL_NAME LIKE '%ASIA%';