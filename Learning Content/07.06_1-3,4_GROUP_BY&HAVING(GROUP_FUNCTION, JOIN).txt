-- ROLLUP 함수 : 그룹별로 중간 집계 처리하는 함수
-- GROUP BY 절에서만 사용하는 함수
-- 그룹 별로 계산된 결과값들에 대한 집계가 자동으로 추가됨
SELECT
       JOB_CODE
     , SUM(SALARY)
  FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 1;

-- 인자로 전달받은 그룹 중에 가장 먼저 지정한 그룹 별 합계와
-- 총 합계를 구한다.
SELECT
       DEPT_CODE
     , JOB_CODE
     , SUM(SALARY)
  FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;

-- CUBE 함수 : 그룹별 산출한 결과를 집계하는 함수.
SELECT
       JOB_CODE
     , SUM(SALARY)
  FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY 1;

-- 그룹으로 지정된 모든 그룹에 대한 합계와 총 합계를 구한다.
SELECT
       DEPT_CODE
     , JOB_CODE
     , SUM(SALARY)
  FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;

-- GROUPING : 
-- ROLLUP이나 CUBE에 의한 집계 산출물이 인자로 전달받은 컬럼 집합의
-- 산출물이면 0을 반환하고, 아니면 1을 반환한다.
SELECT
       DEPT_CODE
     , JOB_CODE
     , SUM(SALARY)
     , GROUPING(DEPT_CODE) "부서별 그룹 묶인 상태"
     , GROUPING(JOB_CODE) "직급별 그룹 묶인 상태"
  FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;


SELECT
       DEPT_CODE
     , JOB_CODE
     , SUM(SALARY)
     , CASE WHEN GROUPING(DEPT_CODE) = 0
                 AND GROUPING(JOB_CODE) = 1
            THEN '부서별합계'
            WHEN GROUPING(DEPT_CODE) = 1
                 AND GROUPING(JOB_CODE) = 0
            THEN '직급별합계'
            WHEN GROUPING(DEPT_CODE) = 1
                 AND GROUPING(JOB_CODE) = 1
            THEN '총합계'
            ELSE '그룹별합계'
       END AS 구분
  FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;

-- SET OPERATION(집합연산)
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
 
-- UNION ALL : 여러 개의 쿼리 결과를 하나로 합치는 연산자
--             UNION과의 차이점은 중복 영역을 모두 포함시킨다.
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
 
-- INTERSECT : 여러 개의 SELECT한 결과에서 공통 부분만 결과로 도출
--             수학에서의 교집합과 비슷하다.
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
 
-- MINUS : 선행 SELECT 결과에서 다음 SELECT 결과와 겹치는 부분을 제외한
--         나머지 부분만 추출, 수학에서 차집합과 비슷하다.
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
 
-- GROUPING SETS : 그룹별로 처리된 여러 개의 SELECT문을 하나로 합친 결과를 원할 때
-- 사용한다. SET OPERATOR(집합연산자) 사용한 결과와 동일한 결과를 얻을 수 있다.
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

-- JOIN : 두 개의 테이블을 하나로 합쳐서 결과를 조회한다.
-- 오라클 전용
-- FROM 절에 '.'로 구분해서 합치게될 테이블명을 기술하고
-- WHERE 절에 합치기에 사용할 컬럼명을 명시한다.

-- 연결에 사용할 두 컬럼명이 다른 경우
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , DEPT_TITLE
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID;

-- 연결에 사용할 두 컬럼명이 같은 경우
SELECT
       EMP_ID
     , EMP_NAME
     , EMPLOYEE.JOB_CODE
     , JOB_NAME
  FROM EMPLOYEE, JOB
 WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
 
-- 테이블에 별칭 사용
SELECT
       EMP_ID
     , EMP_NAME
     , E.JOB_CODE
     , JOB_NAME
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
   AND EMP_ID = 200;

-- ANSI 표준

-- 연결에 사용할 컬럼명이 같은 경우 USING(컬럼명) 사용
SELECT
       EMP_ID
     , EMP_NAME
     , JOB_CODE
     , JOB_NAME
  FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- 연결에 사용할 컬럼명이 다른 경우 ON()을 사용
SELECT 
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , DEPT_TITLE
  FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- 연결에 사용할 컬럼명이 같은 경우도 ON()을 사용할 수 있다.
SELECT
       E.EMP_ID
     , E.EMP_NAME
     , E.JOB_CODE
     , J.JOB_NAME
  FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);

-- 부서 테이블과 지역 테이블을 조인하여 테이블에 모든 데이터 조회하세요.
-- ANSI 표준
SELECT
       *
  FROM DEPARTMENT 
JOIN LOCATION ON(DEPARTMENT.LOCATION_ID = LOCATION.LOCAL_CODE);

SELECT
       *
  FROM DEPARTMENT D
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE);

-- ORACLE 전용
SELECT
       *
  FROM DEPARTMENT D, LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE;

-- JOIN은 기본이 EQUAL JOIN 이다. (EQU JOIN이라고도 함, 등가 조인이라고도 함)
-- 연결되는 컬럼의 값이 일치하는 행들만 조인됨

-- 일치하는 값이 없는 행은 조인에서 제외되는 것을 INNER JOIN이라고 한다. 

-- JOIN의 기본은 INNER JOIN & EQU JOIN 이다.

-- OUTER JOIN : 두 테이블의 지정하는 컬럼값이 일치하지 않는 행도 조인에 포함시킨다.
--              반드시 OUTER JOIN임을 명시해야 한다.
-- 1. LEFT OUTER JOIN : 합치기에 사용한 두 테이블 중 왼편에 기술된 테이블의 행의 수를
--                      기준으로 JOIN
-- 2. RIGHT OUTER JOIN : 합치기에 사용한 두 테이블 중 오른편에 기술된 테이블의 행의 수를
--                       기준으로 JOIN
-- 3. FULL OUTER JOIN : 합치기에 사용한 두 테이블이 가진 모든 행을
--                      결과에 포함하여 JOIN

SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- LEFT OUTER JOIN
-- ANSI 표준
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
--LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- ORACLE 전용
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID(+);

-- RIGHT OUTER JOIN
-- ANSI 표준
SELECT
       E.EMP_NAME
     , D.DEPT_TITLE
  FROM EMPLOYEE E
--RIGHT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID);
RIGHT OUTER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID);

-- ORACLE 전용
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE E, DEPARTMENT D
 WHERE E.DEPT_CODE(+) = D.DEPT_ID;

-- FULL OUTER JOIN
-- ANSI 표준
SELECT
       E.EMP_NAME
     , D.DEPT_TITLE
  FROM EMPLOYEE E
--FULL OUTER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID);
FULL JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID);

-- ORACLE 전용으로는 FULL OUTER JOIN을 하지 못한다.
SELECT
       E.EMP_NAME
     , D.DEPT_TITLE
  FROM EMPLOYEE E, DEPARTMENT D;
--WHERE DEPT_CODE(+) = D.DEPT_ID(+);

-- CROSS JOIN : 카테이션 곱이라고도 한다.
--              조인되는 테이블의 각 행들이 모두 매핑된 데이터가 검색되는 방법이다.
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
 CROSS JOIN DEPARTMENT;

-- NON EQUAL JOIN(NON EQU JOIN, 비 등가 조인)
-- 지정한 컬럼의 값이 일치하는 경우가 아닌
-- 값의 범위에 포함되는 행들을 연결하는 방식
-- ANSI 표준
SELECT
       E.EMP_NAME
     , E.SALARY
     , E.SAL_LEVEL
     , S.SAL_LEVEL
  FROM EMPLOYEE E
  JOIN SAL_GRADE S ON(E.SALARY >= S.MIN_SAL
                 AND E.SALARY <= S.MAX_SAL);
                 
SELECT * FROM SAL_GRADE;

-- ORACLE 전용
SELECT
       E.EMP_NAME
     , E.SALARY
     , E.SAL_LEVEL
     , S.SAL_LEVEL
  FROM EMPLOYEE E, SAL_GRADE S
 WHERE E.SALARY >= S.MIN_SAL AND E.SALARY <= S.MAX_SAL;

-- SELF JOIN : 같은 테이블을 조인하는 경우
--             자기 자신 테이블고 조인을 맺는 방식이다.
-- ORACLE 전용
SELECT
       E1.EMP_ID
     , E1.EMP_NAME 사원이름
     , E1.DEPT_CODE
     , E1.MANAGER_ID
     , E2.EMP_NAME 관리자이름
  FROM EMPLOYEE E1, EMPLOYEE E2
 WHERE E1.MANAGER_ID = E2.EMP_id;

-- ANSI 표준
SELECT
       E1.EMP_ID
     , E1.EMP_NAME 사원명
     , E1.DEPT_CODE
     , E1.MANAGER_ID
     , E2.EMP_NAME
  FROM EMPLOYEE E1
  JOIN EMPLOYEE E2 ON (E1.MANAGER_ID = E2.EMP_ID);

-- 다중 JOIN : N개의 테이블을 조회할 때 사용
-- ANSI 표준
-- 조인 순서 중요함
SELECT
       E.EMP_ID
     , E.EMP_NAME
     , E.DEPT_CODE
     , D.DEPT_TITLE
     , L.LOCAL_NAME
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);

-- ORACLE 전용
-- ORACLE 전용 구문은 조인 순서 상관 없음
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

-- 직급이 대리이면서 아시아 지역에 근무하는 직원 조회
-- 사번, 이름, 직급명, 부서명, 근무지역명, 급여를 조회하세요
SELECT *FROM EMPLOYEE;
SELECT *FROM DEPARTMENT;
SELECT *FROM JOB;  -- JOB_NAME
SELECT *FROM LOCATION;

-- ANSI 표준
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
 WHERE J.JOB_NAME = '대리' 
   AND L.LOCAL_NAME LIKE '%ASIA%';

-- ORACLE 전용
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
   AND J.JOB_NAME = '대리' 
   AND L.LOCAL_NAME LIKE '%ASIA%';