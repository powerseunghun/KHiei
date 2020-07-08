-- DAY 5 수업내용
-- SUBQUERY(서브쿼리)
-- 서브쿼리 : 쿼리문 안에서 사용된 쿼리문

-- 사원명이 노옹철인 사람의 부서 조회
SELECT
       DEPT_CODE
  FROM EMPLOYEE
 WHERE EMP_NAME='노옹철';

-- 부서코드가 D9인 직원 조회
SELECT
       EMP_NAME
  FROM EMPLOYEE
 WHERE DEPT_CODE='D9';
 
-- 부서코드가 노옹철 사원과 같은 소속의 직원 명단 조회
SELECT
       EMP_NAME
  FROM EMPLOYEE
 WHERE DEPT_CODE = (
                    SELECT DEPT_CODE
                      FROM EMPLOYEE
                     WHERE EMP_NAME='노옹철'
                   )
   AND EMP_NAME <> '노옹철';
   
-- 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의
-- 사번, 이름, 직급코드, 급여를 조회하세요
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

-- 서브쿼리의 유형
-- 단일행 서브쿼리 : 서브쿼리의 조회 결과값이 1개의 행일 때
--                  연산자로 사용가능
-- 다중행 서브쿼리 : 서브쿼리의 조회 결과값이 여러 개의 행일 때
--                  만약 부서코드 D9, D7이면 IN (서브쿼리)
-- 다중열 서브쿼리 : 서브쿼리의 조회 결과값이 여러 컬럼일 때
-- 다중행 다중열 서브쿼리 : 서브쿼리의 조회 결과 행 수와 열 수가 여러 개일 때

-- 서브쿼리 유형에 따라 서브쿼리 앞에 붙는 연산자가 다름
-- 단일행 서브쿼리 앞에는 일반 비교연산자 사용
-- >, <, >=, <=, =, !=/^=/<>

-- 노옹철 사원의 급여보다 많이 받는 직원의
-- 사번, 이름, 부서, 직급, 급여를 조회하세요
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
                  WHERE EMP_NAME='노옹철'
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
                  WHERE EMP_NAME = '노옹철'
                );
 
-- 가장 적은 급여를 받는 직원의
-- 사번, 이름, 직급, 부서, 급여, 입사일 조회
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

-- 서브쿼리는 SELECT, FROM, WHERE, HAVING, ORDER BY절에서도 사용이 가능하다. (GROUP BY만 제외)
-- 부서별 급여의 합계 중 가장 큰 부서의 부서명, 급여 합계를 구하세요
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

-- 다중행 서브쿼리
-- 다중행 서브쿼리 앞에는 일반 비교연산자 사용 못함
-- IN / NOT IN : 여러 개의 결과값 중 한 개라도 일치하는 값이 있다면 혹은 없다면 이라는 의미
-- > ANY, < ANY : 여러 개의 결과 값 중에서 한 개라도 큰 / 작은 경우
--                가장 작은 값 보다 크냐? / 가장 큰 값보다 작냐?
-- > ALL, < ALL : 모든 값 보다 큰 / 작은 경우
-- EXISTS / NOT EXISTS : 값이 존재하냐? / 존재하지 않느냐?

-- 200번 사원이 존재하냐.. all true(전체 조회) 만약 100번 사원이면 all false(아무것도 조회 안됨)
SELECT *
  FROM EMPLOYEE
 WHERE EXISTS (SELECT *
                 FROM EMPLOYEE
                WHERE EMP_ID = 200);

-- 부서별 최고 급여를 받는 직원의 이름, 직급, 부서, 급여 조회
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

-- SELECT 절에도 서브쿼리를 사용할 수 있다.
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_TITLE
     , CASE
         WHEN EMP_ID IN(SELECT DISTINCT MANAGER_ID
                          FROM EMPLOYEE
                         WHERE MANAGER_ID IS NOT NULL
                       )
         THEN '관리자'
         ELSE '직원'
       END AS 구분
  FROM EMPLOYEE E
  LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = DEPT_ID);

-- 대리 직급의 직원들 중에서 과장 직급의 최소 급여보다 많이 받는 직원의
-- 사번, 이름, 직급, 급여를 조회하세요
-- 단, > ANY 혹은 < ANY 연산자 사용
SELECT
       *
  FROM EMPLOYEE E 
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
 WHERE J.JOB_NAME = '과장';

SELECT
       E.EMP_ID
     , E.EMP_NAME
     , J.JOB_NAME
     , E.SALARY
  FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE J.JOB_NAME = '대리'
AND E.SALARY > ANY (
                    SELECT MIN(E.SALARY)
                      FROM EMPLOYEE E
                      JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
                     WHERE J.JOB_NAME = '과장'
                   );

-- 차장 직급의 급여의 가장 큰 값 보다 많이 받는 과장 직급의
-- 사번, 이름, 직급, 급여를 조회하세요
-- 단, > ALL 혹은 < ALL 연산자를 사용.
SELECT 
       SALARY
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE J.JOB_NAME = '차장';

SELECT
       E.EMP_ID
     , E.EMP_NAME
     , J.JOB_NAME
     , E.SALARY
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE J.JOB_NAME = '과장'
AND E.SALARY > ALL(
                    SELECT SALARY
                      FROM EMPLOYEE E
                      JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
                     WHERE J.JOB_NAME = '차장'
                  );

-- 자기 직급의 평균 급여를 받고 있는 직원의
-- 사번, 이름, 직급, 급여를 조회하세요
-- 단, 급여와 급여 평균은 만원단위로 계산하세요 TRUNC(컬럼명, -5)

SELECT
       JOB_CODE
     , TRUNC(SALARY, -5)
FROM EMPLOYEE;

SELECT
       E.EMP_ID
     , E.EMP_NAME
     , J.JOB_NAME
     , TRUNC(E.SALARY, -5) 급여
  FROM EMPLOYEE E
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
 WHERE SALARY IN ( -- 자기 직급과 일치하는지 여부가 아직 안되어있음 -> 다중행 다중열 서브쿼리 사용
                  SELECT TRUNC(AVG(SALARY), -5)
                    FROM EMPLOYEE
                   GROUP BY JOB_CODE
                 );

-- 다중행 다중열 서브쿼리를 이용한 해결
SELECT
       EMP_ID
     , EMP_NAME
     , JOB_CODE
     , SALARY
  FROM EMPLOYEE
  -- 다중 행은 IN으로 처리하지만 다중 열은 (JOB_CODE, SALARY)처럼 저렇게 묶어야함
 WHERE (JOB_CODE, SALARY) IN (
                              SELECT JOB_CODE
                                   , TRUNC(AVG(SALARY), -5)
                                FROM EMPLOYEE
                               GROUP BY JOB_CODE
                             );
                             
-- 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 사원의
-- 이름, 직급, 부서, 입사일 조회
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

-- SELECT절, FROM절, WHERE절, HAVING절, ORDER BY절
-- DML 구문 : INSERT문, UPDATE문
-- DDL 구문 : CREATE TABLE 문, CREATE VIEW 문

-- FROM 절에서 서브쿼리를 사용할 수 있다 : 테이블 대신에 사용
-- 인라인 뷰(INLINE VIEW) 라고 함
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
     , DEPT_TITLE AS 부서명
     , JOB_NAME AS 직급이름
  FROM EMPLOYEE E
  LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

SELECT 
       EMP_NAME
     , 부서명
     , 직급이름
       -- DEPT_TITLE로 적으면 오류남 (부서명)으로 적어줘야함
       -- 인라인 뷰에서는 무조건 별칭으로
 FROM (SELECT EMP_NAME
            , DEPT_TITLE AS 부서명
            , JOB_NAME AS 직급이름
         FROM EMPLOYEE E
         LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
         JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE))
 WHERE 부서명='인사관리부';

-- TOP-N 몇 위부터 몇 위까지
-- 인라인 뷰를 활용한 TOP-N 분석
SELECT
       ROWNUM    
     , EMP_NAME
     , SALARY
  FROM EMPLOYEE
 WHERE ROWNUM >= 5
 -- 5보다 크거나 같을 때 동작 안하는 이유는?
 -- 첫행에 1이 붙었는데 WHERE가 FALSE가 되면서 1FALSE 1FALSE 반복 -> 결과 집합 없음
 ORDER BY SALARY DESC;

SELECT
       EMP_NAME
     , SALARY
  FROM EMPLOYEE
 ORDER BY SALARY DESC;

-- ORDER BY 한 결과에 ROWNUM을 이용하여 TOP-N 분석
-- ROWNUM은 실제 존재하는 컬럼이 아닌 가상 컬럼(pseudo column)
-- WHERE절에서 붙여짐(true시) SELECT *FROM EMPLOYEE ORDER BY SALARY DESC는 WHERE절 생략 모두 트루
-- 5보다 큰 것을 조회할 수 없는 이유도 일맥상통하다.
SELECT
       ROWNUM
     , EMP_NAME
     , SALARY
  FROM (SELECT *FROM EMPLOYEE ORDER BY SALARY DESC)
  -- FROM (SELECT ROWNUM RNUM, EMP_NAME, SALARY FROM EMPLOYEE ORDER BY SALARY DESC)
  -- 조회해보면 원래 RNUM은 뒤죽박죽 (이미 부여가 됨)
 WHERE ROWNUM <= 5;
 
-- 급여 평균이 3위 안에 드는 부서의
-- 부서코드와 부서명, 평균급여를 조회하세요
select *from department;
select *from employee;
SELECT 
       E.DEPT_CODE
     , D.DEPT_TITLE
     , FLOOR(AVG(SALARY)) 평균급여
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
 GROUP BY DEPT_CODE, D.DEPT_TITLE
 ORDER BY FLOOR(AVG(SALARY)) DESC;

SELECT
       부서코드
     , 부서명
     , 평균급여
  FROM (SELECT E.DEPT_CODE 부서코드
             , D.DEPT_TITLE 부서명
             , FLOOR(AVG(SALARY)) 평균급여
          FROM EMPLOYEE E
          JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
         GROUP BY DEPT_CODE, D.DEPT_TITLE
         ORDER BY FLOOR(AVG(SALARY)) DESC)
 WHERE ROWNUM <= 3;
 
-- 직원 정보에서 급여를 가장 많이 받는 순으로
-- 이름, 급여, 순위 조회
-- RANK() : 동일한 순위 이후의 등수를 동일한 인원 수 만큼 건너 뛰고 다음 순위를 계산(1, 2, 2, 4)
-- DENSE_RANK() : 중복되는 순위 이후의 등수를 이후 등수로 처리(1, 2, 2, 3)

SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위 FROM EMPLOYEE;
-- 여기서는 순위라는 별칭을 where 절에 쓸 수 없음 
-- 이 쿼리의 결과를 테이블 처럼 from에 사용(인라인뷰)

-- RANK()를 이용한 TOP-N
SELECT
       *
  FROM (SELECT EMP_NAME
             , SALARY
             , RANK() OVER(ORDER BY SALARY DESC) 순위
          FROM EMPLOYEE)
 WHERE 순위 <= 5;
 
-- 직원 테이블에서 보너스를 포함한 연봉이 높은 5명의
-- 사번, 이름, 부서명, 직급명, 입사일을 조회하시오

SELECT *FROM department;

SELECT
       E.EMP_ID
     , E.EMP_NAME
     , E.DEPT_CODE
     , J.JOB_NAME
     , E.HIRE_DATE
     , D.DEPT_TITLE
     , SALARY * 12 + SALARY * NVL2(BONUS, BONUS, 0) 연봉
     , RANK() OVER(ORDER BY (SALARY * 12 + SALARY * NVL2(BONUS, BONUS, 0)) DESC) 순위
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
            , SALARY * 12 + SALARY * NVL2(BONUS, BONUS, 0) 연봉
            , RANK() OVER(ORDER BY (SALARY * 12 + SALARY * NVL2(BONUS, BONUS, 0)) DESC) 순위
         FROM EMPLOYEE E
         JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
         JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID))
 WHERE 순위 <= 5;
 
-- 관리직원이 있는 사원들만
-- 사번, 사원명, 관리직원수를 구하자
SELECT 
       EMP_ID
     , EMP_NAME
     , 관리직원수
FROM EMPLOYEE E 
JOIN (
       SELECT MANAGER_ID
            , COUNT(MANAGER_ID) 관리직원수
         FROM EMPLOYEE
        GROUP BY manager_id) TMP 
  ON (E.EMP_ID = TMP.MANAGER_ID);

