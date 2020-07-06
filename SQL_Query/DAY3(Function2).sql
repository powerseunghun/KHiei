-- DAY3 수업내용
-- NULL 처리 함수
-- NVL(컬럼명, 컬럼값이 NULL일 때 바꿀 값)

SELECT
       EMP_NAME
     , BONUS
     , NVL(BONUS, 0)
FROM EMPLOYEE;

-- NVLL2 (컬럼명, 바꿀값1, 바꿀값2)
-- 해당 컬럼이 값이 있으면 바꿀값1로 변경
-- 해당 컬럼이 NULL 이면 바꿀값2로 변경

-- 직원정보에서 보너스포인트가 NULL인 경우 0.5로
-- 보너스 포인트가 NULL이 아닌 경우 0.7로 변경하여 조회
SELECT
       EMP_NAME
     , BONUS
     , NVL2(BONUS, 0.7, 0.5)
FROM EMPLOYEE;

-- 선택함수
-- 여러 가지 경우에 선택할 수 있는 기능을 제공한다.
-- DECODE(계산식 | 컬럼명, 조건값1, 선택값1, 조건값2, 선택값2, ...)

SELECT
       EMP_ID
     , EMP_NAME
     , EMP_NO
     , DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여')
FROM EMPLOYEE;

-- 마지막 인자로 조건값 없이 선택값을 작성하면
-- 아무것도 해당ㅇ하지 않을 때 마지막에 작성한 선택값을 무조건 선택한다. 마치 ELSE

SELECT
       EMP_ID
     , EMP_NAME
     , EMP_NO
     , DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '여')
FROM EMPLOYEE;

-- 직원의 급여를 인상하고자 한다.
-- 직급코드가 J7인 직원은 급여의 10%를 인상하고
-- 직급코드가 J6인 직원은 급여의 15%를 인상하고
-- 직급코드가 J5인 직원은 급여의 20%를 인상한다.
-- 그 외 직급의 직원은 급여의 5%만 인상한다.
-- 직원 테이블에서 직원명, 직급코드, 급여, 인상급여(위 조건)을 조회하세요
SELECT
       EMP_NAME
     , JOB_CODE
     , SALARY
     , DECODE(JOB_CODE, 'J7', SALARY + SALARY * 0.1,
                        'J6', SALARY + SALARY * 0.15,
                        'J5', SALARY + SALARY * 0.20,
                              SALARY + SALARY * 0.05) 인상급여
FROM EMPLOYEE;

-- CASE
--   WHEN 조건식 THEN 결과값
--   WHEN 조건식 THEN 결과값
--   ELSE 결과값
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
       END AS 인상급여
FROM EMPLOYEE;

-- 사번, 사원명, 급여를 EMPLOYEE 테이블에서 조회하고
-- 급여가 500만원을 초과하면 '고급'
-- 급여가 300 ~ 500만원이면 '중급'
-- 그 이하는 '초급'으로 출력하고 별칭은 '구분'으로 한다.
select *from employee;
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , CASE
         WHEN SALARY > 5000000 THEN '고급'
         WHEN SALARY >= 3000000 THEN '중급'
         ELSE '초급'
       END AS 구분
FROM EMPLOYEE;

-- GROUP은 같은 값을 가지고 있음
-- HAVING은 그룹핑이 되어 있는 상태에서 조건을 걸러내어 출력함

-- ORDER BY 절 : SELECT한 컬럼을 가지고 정렬할 때 사용함
-- ORDER BY 컬럼명 | 컬럼별칭 |  컬럼나열순번 [ASC] | DESC [NULLS FIRST | LAST]
-- ORDER BY 컬럼명 정렬방식, 컬럼명 정렬 방식, 컬럼명 정렬 방식, ....
-- 첫 번째 기준으로 하는 컬럼에 대해 정렬하고
-- 같은 값 들에 대해 두 번째 기준으로 하는 컬럼에 대해 다시 정렬
-- SELECT 구문의 맨 마지막에 위치
-- 실행 순서도 맨 마지막
/*
5 SELECT 컬럼명 AS 별칭, 계산식, 함수식
1 FROM 참조테이블명
2 WHERE 컬럼명 | 함수식 비교연산자 비교값
3 GROUP BY 그룹을 묶을 컬럼명
4 HAVING 그룹함수식 비교연산자 비교값
6 ORDER BY 컬럼명 | 별칭 | 컬럼순번 정렬방식 [NULLS FIRST | LAST]
*/

-- GROUP BY가 없을 시
-- COUNT(*) 행은 1개, DEPT_CODE는 여러개 이므로 오류 발생
SELECT
       COUNT(*) 사원수
     , DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 만약 DEPT_CODE 만 넣어주면 오류 발생
-- JOB_CODE까지 GROUP함수에 넣어주어야함
SELECT
       DEPT_CODE
     , JOB_CODE
     , SUM(SALARY)
     , COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1;

-- 직원 테이블에서 부서 코드별 그룹을 지정하여
-- 부서코드, 그룹별 급여의 합계
SELECT
       DEPT_CODE
     , SUM(SALARY)
     , CEIL(AVG(SALARY))
     , COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1;

-- 직원 테이블에서 직급 코드, 보너스를 받는 사원 수를 조회하여
-- 직급코드 순으로 오름차순 정렬하세요
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

-- 직원 테이블에서 주민번호 8번째 자리를 조회하여
-- 1이면 남, 2이면 여로 결과 조회하고
-- 성별별 급여 평균(정수처리), 급여 합계
-- 인원수를 내림차순 정렬 하세요.
SELECT *FROM EMPLOYEE;
SELECT
      DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') 성별
    , CEIL(AVG(SALARY)) 합계
    , COUNT(*) 인원수
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여')
ORDER BY 인원수 DESC;

-- GROUP BY 절 : 같은 값들이 여러 개 기록된 컬럼을 하나의 그룹으로 묶음
-- GROUP BY 컬럼명 | 함수식, ...
-- 여러 개의 값을 묶어서 하나의 그룹으로 지정할 수도 있다.

-- HAVING 절 : 그룹함수로 구해올 그룹에 대해 조건을 설정할 때 사용
-- HAVING 컬럼명 | 함수식 비교연산자 비교값

-- WHERE 로 먼저 거르고 그룹화.
SELECT
       DEPT_CODE
     , FLOOR(AVG(SALARY)) 평균
  FROM EMPLOYEE
 WHERE SALARY > 3000000
 GROUP BY DEPT_CODE
 ORDER BY 1;

-- HAVING 그룹 중에서 조건에 만족하는 그룹만
SELECT
       DEPT_CODE
     , FLOOR(AVG(SALARY)) 평균
  FROM EMPLOYEE
 GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) > 3000000
 ORDER BY 1;

-- 부서별 그룹의 급여 합계 중 9백만원을 초과하는 부서의
-- 부서코드, 급여 합계 조회
SELECT
       DEPT_CODE
     , SUM(SALARY) "급여 합계"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 9000000
ORDER BY 1;

-- 급여 합계가 가장 많은 부서의 부서코드와 급여 합계를 구하세요
SELECT
       *
FROM
(SELECT
       DEPT_CODE
     , SUM(SALARY) 급여합계
FROM EMPLOYEE
GROUP BY DEPT_CODE) b
WHERE b.급여합계=17700000;
--WHERE b.급여합계=b.MAX(SUM(SALARY));

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

-- 과제
-- 자바 워크샵02
-- 제출 파일명 : JAVA_WORKSHOP02_NAME.zip

-- 이렇게 하나 (파일 명은 상관없고 zip 파일만 이름 포맷팅..중요함)
-- 오라클 워크북 SELECT - 함수 10 ~ 14번(15번 아직 안배움)
-- 오라클 워크북 SELECT - OPTION 1~5번

-- 이렇게 하나 (파일 명은 상관없고 zip 파일만 이름 포맷팅..중요함)
-- 함수 연습문제 1~7번(employee에서 풀 수 있음)
-- 제출 파일명 : DAY3_HOMEWORK_NAME.zip
-- 파일이 두개가 될거라 압축
