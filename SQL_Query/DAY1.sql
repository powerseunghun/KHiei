-- DAY 1 ��������

-- EMPLOYEE ���̺��� ��� ���� ��ȸ
select *from employee;

-- EMPLOYEE ���̺��� �����, �̸� ��ȸ
select EMP_ID, EMP_NAME from employee;

-- EMPLOYEE ���̺��� ���, �̸�, �ֹι�ȣ, �μ��ڵ�, �����ڵ�, �޿� ��ȸ
desc employee;
select *from employee;
select emp_id, emp_name, emp_no, dept_code, job_code, salary from employee;

-- EMPLOYEE ���̺��� �μ��ڵ尡 D9�� ����� ��� �÷� ���� ��ȸ
select *from employee where dept_code = 'D9';

-- EMPLOYEE ���̺��� �����ڵ尡 J1�� ������ ��� �÷� ��ȸ
select *from employee where job_code='J1';
desc employee;

-- EMPLOYEE ���̺��� �޿��� 300���� �̻��� �����
-- ���, �̸�, �μ��ڵ�, �޿��� ��ȸ
select emp_id, emp_name, dept_code, job_code from employee where salary >= 300000;

select /*�ۼ���::ȣ���Լ�����*/
       emp_id       /* �����ȣ */
     , emp_name     /* ����� */
     , dept_code    /* �μ��ڵ� */
     , job_code     /* �޿� */
  from employee 
 where salary >= 300000;

-- �÷��� ��Ī ����
-- AS + ��Ī�� ����Ͽ� ��Ī�� ���� �� �ִ�.

SELECT 
       EMP_NAME AS �����
     , SALARY �޿�
     , (SALARY + (SALARY * NVL(BONUS, 0))) * 12 ����
FROM EMPLOYEE;

-- ���Ƿ� ������ ���ڿ��� SELECT������ ����� �� �ִ�.
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , '��' "����"
FROM EMPLOYEE;

-- DISTINCT Ű����� �ߺ��� �÷� ���� �����Ͽ� ��ȸ�Ѵ�.
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE
ORDER BY JOB_CODE ASC /*DESC*/;

-- DISTINCT Ű����� SELECT ������ �� ���� ����� �� �ִ�.
-- ���� ���� �÷��� ��� �ߺ��� �����Ѵ�. (JOB_CODE�� DEPT_CODE�� ������)
SELECT DISTINCT JOB_CODE, /*DISTINCT*/ DEPT_CODE
FROM EMPLOYEE;

-- WHERE ��
-- ���̺��� ������ �����ϴ� ���� ���
-- ���� ���� ������ �����ϴ� ���� ��� ��
-- AND Ȥ�� OR �����ڸ� ����� �� �ִ�.

-- �μ��ڵ尡 D6�̰� �޿��� 200�������� ���� �޴� ������
-- �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT 
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D6'
   AND SALARY >= 2000000;

-- ���ʽ��� NULL�� ������
-- ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT 
       EMP_ID
     , EMP_NAME
     , SALARY
     , BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;
desc employee;

-- ���� �����ڸ� �̿��Ͽ� ���� �÷��� �ϳ��� �÷��� ��ó�� ������ �� �ִ�. (||)
-- �÷��� �÷� ����
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- �÷��� Ŀ�� ����
SELECT EMP_NAME || '�� ������ ' || SALARY || '�� �Դϴ�.'
FROM EMPLOYEE;

-- �� ������
-- = ����?, > ũ��?, < �۳�?, >= ũ�ų� ����?, <= �۰ų� ����?
-- !=, ^=, <> ���� �ʳ�?
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';

-- EMPLOYEE ���̺��� �޿��� 350���� �̻� 550���� ���ϸ� �޴� ������
-- ���, �̸�, �޿�, �μ��ڵ�, �����ڵ带 ��ȸ�ϼ���.
SELECT 
       EMP_ID
     , EMP_NAME
     , SALARY
     , DEPT_CODE
     , JOB_CODE 
  FROM EMPLOYEE 
 WHERE SALARY >= 3500000 
   AND SALARY <= 5500000;
   
-- BETWEEN AND ���
-- �÷��� BETWWEEN ���Ѱ� AND ���Ѱ�
-- : ���Ѱ� �̻� ���Ѱ� ������ ��
SELECT 
       EMP_ID
     , EMP_NAME
     , SALARY
     , DEPT_CODE
     , JOB_CODE 
  FROM EMPLOYEE 
 WHERE /*NOT*/ SALARY BETWEEN 3500000 AND 5500000;
 
-- LIKE ������
-- �÷��� LIKE '��������'
-- �������� : '����%' (���ڷ� �����ϴ� ��),
--           '%����%' (���ڰ� ���Ե� ��),
--           '%����' (���ڷ� ������ ��)

-- EMPLOYEE ���̺��� ���� �达�� ������
-- ���, �̸�, �Ի��� ��ȸ
 SELECT 
       EMP_ID
     , EMP_NAME
     , HIRE_DATE 
  FROM EMPLOYEE 
 WHERE EMP_NAME 
  /*NOT*/
  LIKE '��%';
  
-- EMPLOYEE ���̺��� '��'�� �̸��� ���Ե� ������
-- �̸�, �ֹι�ȣ, �μ��ڵ� ��ȸ
select *from employee;
SELECT 
       EMP_NAME
     , EMP_NO
     , DEPT_CODE 
  FROM EMPLOYEE 
 WHERE EMP_NAME 
  LIKE '%��%';
  
-- EMPLOYEE ���̺��� ������ 9�� �����ϴ� ������
-- ���, �̸�, ��ȭ��ȣ�� ��ȸ�ϼ���
-- ���ϵ�ī�� : _(���� �� �ڸ�), %(0�� �̻��� ����)
select *from employee;
SELECT 
       EMP_ID
     , EMP_NAME
     , PHONE 
  FROM EMPLOYEE 
 WHERE PHONE 
  LIKE '___9%';
  
-- EMPLOYEE ���̺��� ��ȭ��ȣ ������ 4�ڸ��̸鼭
-- 9�� �����ϴ� ������ ���, �̸�, ��ȭ��ȣ ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE FROM EMPLOYEE WHERE PHONE LIKE '___9_______';

select *from employee;

-- EMPLOYEE ���̺��� �̸��� _���� 3�ڸ��� ����
SELECT EMP_ID, EMP_NAME, EMAIL FROM EMPLOYEE WHERE EMAIL LIKE '___#_%' ESCAPE '#';

-- �̾� ���� �ƴ� ������ ���, �̸�, �̸����ּ� ��ȸ
SELECT 
       EMP_ID
     , EMP_NAME
     , EMAIL 
  FROM EMPLOYEE 
 WHERE NOT EMP_NAME LIKE '��%';
 
-- IN ������ : ���Ϸ��� �� ��Ͽ� ��ġ�ϴ� ���� �ִ��� Ȯ��
SELECT *FROM EMPLOYEE WHERE EMP_NAME IN ('������', '������');

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE /*NOT*/ IN ('D6', 'D8');

/*
������ �켱����
1. ���������
2. ���Ῥ����
3. �񱳿�����
4. IS NULL / IS NOT NULL, LIKE / NOT LIKE, IN / NOT IN
5. BETWEEN AND / NOT BETWEEN AND
6. NOT(������������)
7. AND
8. OR
*/

-- J7�����̰ų� J2������ ������ �� �޿��� 200���� �̻��� ������ �̸�, �޿�, �����ڵ� ��ȸ
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE = 'J7'
OR JOB_CODE = 'J2'
AND SALARY >= 2000000;
-- ��ȸ ����� �켱���� ������
-- J2 ������ �޿��� 200���� �̻� �޴� �����̰ų�
-- J7 ������ ������ �̸�, �޿�, �����ڵ� ��ȸ

SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7'
OR JOB_CODE = 'J2')
AND SALARY >= 2000000;