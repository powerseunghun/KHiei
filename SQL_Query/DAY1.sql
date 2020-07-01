-- DAY 1 수업내용

-- EMPLOYEE 테이블에서 모든 정보 조회
select *from employee;

-- EMPLOYEE 테이블에서 사번과, 이름 조회
select EMP_ID, EMP_NAME from employee;

-- EMPLOYEE 테이블에서 사번, 이름, 주민번호, 부서코드, 직급코드, 급여 조회
desc employee;
select *from employee;
select emp_id, emp_name, emp_no, dept_code, job_code, salary from employee;

-- EMPLOYEE 테이블에서 부서코드가 D9인 사원의 모든 컬럼 정보 조회
select *from employee where dept_code = 'D9';

-- EMPLOYEE 테이블에서 직급코드가 J1인 직원의 모든 컬럼 조회
select *from employee where job_code='J1';
desc employee;

-- EMPLOYEE 테이블에서 급여가 300만원 이상인 사원의
-- 사번, 이름, 부서코드, 급여를 조회
select emp_id, emp_name, dept_code, job_code from employee where salary >= 300000;

select /*작성자::호출함수정보*/
       emp_id       /* 사원번호 */
     , emp_name     /* 사원명 */
     , dept_code    /* 부서코드 */
     , job_code     /* 급여 */
  from employee 
 where salary >= 300000;

-- 컬럼에 별칭 짓기
-- AS + 별칭을 기술하여 별칭을 지을 수 있다.

SELECT 
       EMP_NAME AS 사원명
     , SALARY 급여
     , (SALARY + (SALARY * NVL(BONUS, 0))) * 12 연봉
FROM EMPLOYEE;

-- 임의로 지정한 문자열을 SELECT절에서 사용할 수 있다.
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , '원' "단위"
FROM EMPLOYEE;

-- DISTINCT 키워드는 중복된 컬럼 값을 제거하여 조회한다.
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE
ORDER BY JOB_CODE ASC /*DESC*/;

-- DISTINCT 키워드는 SELECT 절에서 한 번만 사용할 수 있다.
-- 여러 개의 컬럼을 묶어서 중복을 제외한다. (JOB_CODE와 DEPT_CODE를 쌍으로)
SELECT DISTINCT JOB_CODE, /*DISTINCT*/ DEPT_CODE
FROM EMPLOYEE;

-- WHERE 절
-- 테이블에서 조건을 만족하는 행을 골라냄
-- 여러 개의 조건을 만족하는 행을 골라낼 때
-- AND 혹은 OR 연산자를 사용할 수 있다.

-- 부서코드가 D6이고 급여를 200만원보다 많이 받는 직원의
-- 이름, 부서코드, 급여 조회
SELECT 
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D6'
   AND SALARY >= 2000000;

-- 보너스가 NULL인 직원의
-- 사번, 이름, 급여, 보너스 조회
SELECT 
       EMP_ID
     , EMP_NAME
     , SALARY
     , BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;
desc employee;

-- 연결 연산자를 이용하여 여러 컬럼을 하나의 컬럼인 것처럼 연결할 수 있다. (||)
-- 컬럼과 컬럼 연결
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- 컬럼과 커리 연결
SELECT EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.'
FROM EMPLOYEE;

-- 비교 연산자
-- = 같냐?, > 크냐?, < 작냐?, >= 크거나 같냐?, <= 작거나 같냐?
-- !=, ^=, <> 같지 않냐?
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';

-- EMPLOYEE 테이블에서 급여를 350만원 이상 550만원 이하를 받는 직원의
-- 사번, 이름, 급여, 부서코드, 직급코드를 조회하세요.
SELECT 
       EMP_ID
     , EMP_NAME
     , SALARY
     , DEPT_CODE
     , JOB_CODE 
  FROM EMPLOYEE 
 WHERE SALARY >= 3500000 
   AND SALARY <= 5500000;
   
-- BETWEEN AND 사용
-- 컬럼명 BETWWEEN 하한값 AND 상한값
-- : 하한값 이상 상한값 이하의 값
SELECT 
       EMP_ID
     , EMP_NAME
     , SALARY
     , DEPT_CODE
     , JOB_CODE 
  FROM EMPLOYEE 
 WHERE /*NOT*/ SALARY BETWEEN 3500000 AND 5500000;
 
-- LIKE 연산자
-- 컬럼명 LIKE '문자패턴'
-- 문자패턴 : '글자%' (글자로 시작하는 값),
--           '%글자%' (글자가 포함된 값),
--           '%글자' (글자로 끝나는 값)

-- EMPLOYEE 테이블에서 성이 김씨인 직원의
-- 사번, 이름, 입사일 조회
 SELECT 
       EMP_ID
     , EMP_NAME
     , HIRE_DATE 
  FROM EMPLOYEE 
 WHERE EMP_NAME 
  /*NOT*/
  LIKE '김%';
  
-- EMPLOYEE 테이블에서 '하'가 이름에 포함된 직원의
-- 이름, 주민번호, 부서코드 조회
select *from employee;
SELECT 
       EMP_NAME
     , EMP_NO
     , DEPT_CODE 
  FROM EMPLOYEE 
 WHERE EMP_NAME 
  LIKE '%하%';
  
-- EMPLOYEE 테이블에서 국번이 9로 시작하는 직원의
-- 사번, 이름, 전화번호를 조회하세요
-- 와일드카드 : _(글자 한 자리), %(0개 이상의 글자)
select *from employee;
SELECT 
       EMP_ID
     , EMP_NAME
     , PHONE 
  FROM EMPLOYEE 
 WHERE PHONE 
  LIKE '___9%';
  
-- EMPLOYEE 테이블에서 전화번호 국번이 4자리이면서
-- 9로 시작하는 직원의 사번, 이름, 전화번호 조회
SELECT EMP_ID, EMP_NAME, PHONE FROM EMPLOYEE WHERE PHONE LIKE '___9_______';

select *from employee;

-- EMPLOYEE 테이블에서 이메일 _앞이 3자리인 직원
SELECT EMP_ID, EMP_NAME, EMAIL FROM EMPLOYEE WHERE EMAIL LIKE '___#_%' ESCAPE '#';

-- 이씨 성이 아닌 직원의 사번, 이름, 이메일주소 조회
SELECT 
       EMP_ID
     , EMP_NAME
     , EMAIL 
  FROM EMPLOYEE 
 WHERE NOT EMP_NAME LIKE '이%';
 
-- IN 연산자 : 비교하려는 값 목록에 일치하는 값이 있는지 확인
SELECT *FROM EMPLOYEE WHERE EMP_NAME IN ('선동일', '송종기');

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE /*NOT*/ IN ('D6', 'D8');

/*
연산자 우선순위
1. 산술연산자
2. 연결연산자
3. 비교연산자
4. IS NULL / IS NOT NULL, LIKE / NOT LIKE, IN / NOT IN
5. BETWEEN AND / NOT BETWEEN AND
6. NOT(논리부정연산자)
7. AND
8. OR
*/

-- J7직급이거나 J2직급인 직원들 중 급여가 200만원 이상인 직원의 이름, 급여, 직급코드 조회
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE = 'J7'
OR JOB_CODE = 'J2'
AND SALARY >= 2000000;
-- 조회 결과는 우선순위 때문에
-- J2 직급의 급여가 200만원 이상 받는 직원이거나
-- J7 직급인 직원의 이름, 급여, 직급코드 조회

SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7'
OR JOB_CODE = 'J2')
AND SALARY >= 2000000;