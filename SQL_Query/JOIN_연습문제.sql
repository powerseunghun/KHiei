------------------------------------
-- JOIN_연습문제
------------------------------------

-- 1. 2020년 12월 25일이 무슨 요일인지 조회하시오.
SELECT 
       TO_CHAR(TO_DATE('201225'), 'day') 
  FROM DUAL;

-- 2. 주민번호가 70년대 생이면서 성별이 여자이고, 성이 전씨인 직원들의 
-- 사원명, 주민번호, 부서명, 직급명을 조회하시오.(1명)
-- ANSI 표준
SELECT
       E.EMP_NAME
     , E.EMP_NO
     , D.DEPT_ID
     , J.JOB_NAME
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
 WHERE E.EMP_NAME LIKE '전%' AND SUBSTR(E.EMP_NO, 8, 1) = 2;
 
-- ORACLE 전용
SELECT
       E.EMP_NAME
     , E.EMP_NO
     , D.DEPT_ID
     , J.JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID 
AND E.JOB_CODE = J.JOB_CODE
AND SUBSTR(E.EMP_NO, 8, 1) = 2
AND E.EMP_NAME LIKE '전%';
 
-- 3. 가장 나이가 적은 직원의 사번, 사원명, 나이, 부서명, 직급명을 조회하시오.(1명)
-- ANSI 표준
SELECT
       E.EMP_ID 사번
     , E.EMP_NAME 사원명
     , TO_CHAR(SYSDATE, 'RRRR') - TO_CHAR(TO_DATE(SUBSTR(E.EMP_NO, 1, 2), 'RR'), 'RRRR') 나이
     , D.DEPT_TITLE 부서명
     , J.JOB_NAME 직급명
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
 WHERE EMP_NO = (SELECT MAX(EMP_NO) FROM EMPLOYEE);
 
-- ORACLE 전용
SELECT
       E.EMP_ID 사번
     , E.EMP_NAME 사원명
     , TO_CHAR(SYSDATE, 'RRRR') - TO_CHAR(TO_DATE(SUBSTR(E.EMP_NO, 1, 2), 'RR'), 'RRRR') 나이
     , D.DEPT_TITLE 부서명
     , J.JOB_NAME
  FROM EMPLOYEE E, DEPARTMENT D, JOB J
 WHERE E.DEPT_CODE = D.DEPT_ID
   AND E.JOB_CODE = J.JOB_CODE
   AND EMP_NO = (SELECT MAX(EMP_NO) FROM EMPLOYEE);
   
-- 4. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오 (1명)
-- ANSI 표준
SELECT
       E.EMP_ID
     , E.EMP_NAME
     , D.DEPT_TITLE
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
 WHERE E.EMP_NAME LIKE '%형%';
 
-- ORACLE 전용
SELECT
       E.EMP_ID
     , E.EMP_NAME
     , D.DEPT_TITLE
  FROM EMPLOYEE E, DEPARTMENT D
 WHERE E.DEPT_CODE = D.DEPT_ID
   AND E.EMP_NAME LIKE '%형%';
   
-- 5. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.(9명)
SELECT *FROM EMPLOYEE;
SELECT *FROM DEPARTMENT;
SELECT *FROM LOCATION;
SELECT *FROM JOB;

-- ANSI 표준
SELECT
       E.EMP_NAME 사원명
     , J.JOB_NAME 직급명
     , E.DEPT_CODE 부서코드
     , D.DEPT_TITLE 부서명
  FROM EMPLOYEE E
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
 WHERE D.DEPT_TITLE LIKE '%해외영업%';

-- ORACLE 전용
SELECT
       E.EMP_NAME 사원명
     , J.JOB_NAME 직급명
     , E.DEPT_CODE 부서코드
     , D.DEPT_TITLE 부서명
  FROM EMPLOYEE E, DEPARTMENT D, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
   AND E.DEPT_CODE = D.DEPT_ID
   AND D.DEPT_TITLE LIKE '%해외영업%';
   
-- 6. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.(8명)

-- ANSI 표준
SELECT
       E.EMP_NAME
     , E.BONUS
     , D.DEPT_TITLE
     , L.LOCAL_NAME
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
 WHERE BONUS IS NOT NULL;
 
-- ORACLE 전용
SELECT
       E.EMP_NAME
     , E.BONUS
     , D.DEPT_TITLE
     , L.LOCAL_NAME
  FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
 WHERE E.DEPT_CODE = D.DEPT_ID
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND BONUS IS NOT NULL;

-- 7. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.(3명)

-- ANSI 표준
SELECT
       E.EMP_NAME
     , J.JOB_NAME
     , D.DEPT_TITLE
     , L.LOCAL_NAME
  FROM EMPLOYEE E
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
 WHERE E.DEPT_CODE = 'D2';
 
-- ORACLE 전용
SELECT
       E.EMP_NAME
     , J.JOB_NAME
     , D.DEPT_TITLE
     , L.LOCAL_NAME
  FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
 WHERE E.JOB_CODE = J.JOB_CODE
   AND E.DEPT_CODE = D.DEPT_ID
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND E.DEPT_CODE = 'D2';

-- 8. 급여 테이블의 등급별 최소급여(MIN_SAL)보다 많이 받는 직원들의
-- 사원명, 직급명, 급여, 연봉을 조회하시오.
-- 연봉에 보너스포인트를 적용하시오.(20명)

-- ANSI 표준
SELECT
       E.EMP_NAME
     , J.JOB_CODE
     , E.SALARY
     , E.SALARY * 12 + (E.SALARY * NVL(BONUS, 0)) 연봉
  FROM EMPLOYEE E
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
  JOIN SAL_GRADE S ON(E.SAL_LEVEL = S.SAL_LEVEL)
 WHERE E.SALARY > S.MIN_SAL;

-- ORACLE 전용
SELECT
       E.EMP_NAME
     , J.JOB_CODE
     , E.SALARY
     , E.SALARY * 12 + (E.SALARY * NVL(BONUS, 0)) 연봉
  FROM EMPLOYEE E, JOB J, SAL_GRADE S
 WHERE E.JOB_CODE = J.JOB_CODE
   AND E.SAL_LEVEL = S.SAL_LEVEL
   AND E.SALARY > S.MIN_SAL;
   
-- 9. 한국(KO)과 일본(JP)에 근무하는 직원들의 사원명, 부서명, 지역명, 국가명을 조회하시오.(15명)

-- ANSI 표준
SELECT
       E.EMP_NAME
     , D.DEPT_TITLE
     , L.LOCAL_NAME
     , L.NATIONAL_CODE
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
 WHERE L.NATIONAL_CODE = 'KO'
    OR L.NATIONAL_CODE = 'JP';

-- ORACLE 전용
SELECT
       E.EMP_NAME
     , D.DEPT_TITLE
     , L.LOCAL_NAME
     , L.NATIONAL_CODE
  FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
 WHERE E.DEPT_CODE = D.DEPT_ID
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND (L.NATIONAL_CODE = 'KO' OR L.NATIONAL_CODE = 'JP');

-- 10. 같은 부서에 근무하는 직원들의 사원명, 부서코드, 동료이름을 조회하시오. 
-- self join 사용 (60명)

-- ANSI 표준
SELECT
       E1.EMP_NAME
     , E1.DEPT_CODE
     , E2.EMP_NAME
FROM EMPLOYEE E1
JOIN EMPLOYEE E2 ON(E1.EMP_NAME <> E2.EMP_NAME)
WHERE E1.DEPT_CODE = E2.DEPT_CODE
ORDER BY 1;

-- ORACLE 전용
SELECT
       E1.EMP_NAME
     , E1.DEPT_CODE
     , E2.EMP_NAME
  FROM EMPLOYEE E1, EMPLOYEE E2
 WHERE E1.EMP_NAME <> E2.EMP_NAME
   AND E1.DEPT_CODE = E2.DEPT_CODE
 ORDER BY 1;
 
-- 11. 보너스포인트가 없는 직원들 중에서 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
-- 단 JOIN과 IN 사용할 것(8명)

-- ANSI 표준
SELECT
       E.EMP_NAME
     , J.JOB_NAME
     , E.SALARY
  FROM EMPLOYEE E
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
 WHERE E.BONUS IS NULL
   AND E.JOB_CODE IN('J4', 'J7');

-- ORACLE 전용
SELECT
       E.EMP_NAME
     , J.JOB_NAME
     , E.SALARY
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
   AND E.BONUS IS NULL
   AND E.JOB_CODE IN('J4', 'J7');
   
-- 12. 재직중인 직원과 퇴사한 직원의 수를 조회하시오.
SELECT
       COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(ENT_YN, 1, 1), 'N', '재직', '퇴사');
       