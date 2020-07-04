-- DAY 2 수업내용

-- 함수 (FUNCTION): 컬럼 값을 일겅서 계산한 결과를 리턴함
-- 단일행 (SINGLE ROW) : 컬럼에 기록된 N개의 값을 읽어서 N개의 결과를 리턴
-- 그룹(GROUP) 함수 : 컬럼에 기록된 N개의 값을 읽어서 한 개의 결과를 리턴

-- SELECT 절에 단일행 함수와 그룹 함수를 함게 사용하지 못한다.
-- : 결과 행의 갯수가 다르기 때문

-- 함수를 사용할 수 있는 위치
-- : SELECT 절, WHERE 절, GROUP BY 절, HAVING 절, ORDER BY 절

-- 그룹 함수 : SUM, AVG, MAX, MIN, COUNT
-- SUM(숫자 | 숫자가 기록된 컬럼명) : 합계를 구하여 리턴
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- AVG(숫자가 기록된 컬럼명) : 평균을 구하여 리턴
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- MIN(컬럼명) : 컬럼에서 가장 작은 값 리턴
-- 취급하는 자료형은 ANY TIME임
SELECT MIN(EMAIL), MIN(HIRE_DATE), MIN(SALARY)
FROM EMPLOYEE;

-- MAX(컬럼명) : 컬럼에서 가장 큰 값 리턴
-- 취급하는 자료형은 ANY TYPE임
SELECT MAX(EMAIL), MAX(HIRE_DATE), MAX(SALARY)
FROM EMPLOYEE;

-- COUNT(* | 컬럼명) : 행의 갯수를 헤아려서 리턴
-- COUNT([DISTINCT] 컬럼명) : 중복을 제거한 행 갯수 리턴
-- COUNT(컬럼명) : NULL을 제외한 실제 값이 기록된 행 갯수 리턴
SELECT COUNT(*), COUNT(DEPT_CODE), COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

SELECT
       AVG(BONUS)
     , AVG(DISTINCT BONUS)
     , AVG(NVL(BONUS, 0))
FROM EMPLOYEE;

-- 단일행 함수
-- 문자 관련 함수
-- : LENGTH, LENGTHB, SUBSTR, UPPER, LOWER,, INSTR, ...
SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL;

-- INSTR('문자열' | 컬럼명, '문자', '찾을 위치의 시작값', [빈도])
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;  --  -1 역방향 탐색 (뒤에서 첫 번째)
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '@', -1) 위치
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 사원명, 이메일, @이후를 제외한 아이디 조회
SELECT
       EMP_NAME
     , EMAIL
     , SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') -1)
FROM EMPLOYEE;

-- LPAD / RPAD : 주어진 컬럼 문자열에 임의의 문자열을 덧붙여 길이 N의 문자열을 반환
SELECT LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT LPAD(EMAIL, 10)
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 10)
FROM EMPLOYEE;

-- LTRIM/RTRIM : 주어진 컬럼이나 문자열 왼쪽/오른쪽에서
--               지정한 문자 혹은 문자열을 제거한 나머지를 반환하는 함수
SELECT LTRIM('   KH') FROM DUAL;
SELECT LTRIM('   KH', ' ') FROM DUAL;
SELECT LTRIM('000123456', '0') FROM DUAL;
SELECT LTRIM('123123KH', '123') FROM DUAL;
SELECT LTRIM('123123KH123', '123') FROM DUAL;  -- 제거할 게 없으면 바로 반환.
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;    -- 구분자는 순서 상관없이 패턴임
SELECT LTRIM('5782KH', '0123456789') FROM DUAL;

SELECT RTRIM('KH   ') FROM DUAL;
SELECT RTRIM('KH   ', ' ') FROM DUAL;
SELECT RTRIM('123456000', '0') FROM DUAL;
SELECT RTRIM('KH123123', '123') FROM DUAL;
SELECT RTRIM('KHACABACC', 'ABC') FROM DUAL;
SELECT RTRIM('KH5782', '0123456789') FROM DUAL;

-- TRIM : 주어진 컬럼이나 문자열의 앞/뒤에 지정한 문자를 제거
SELECT TRIM('   KH   ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM(LEADING 'Z' FROM 'ZZZ123456ZZZ') FROM DUAL;
SELECT TRIM(TRAILING 'Z' FROM 'ZZZ123456ZZZ') FROM DUAL;
SELECT TRIM(BOTH 'Z' FROM 'ZZZ123456ZZZ') FROM DUAL;

-- SUBSTR : 컬럼이나 문자열에서 지정한 위치로부터
--          지정한 갯수의 문자열을 잘라서 리턴하는 함수이다.
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;
SELECT SUBSTR('쇼우 미 더 머니', 2, 5) FROM DUAL;

-- EMPLOYEE 테이블에서 사원이름, 주민번호 성별자리
SELECT *FROM EMPLOYEE;
SELECT INSTR(EMP_NO, '-') FROM EMPLOYEE;

SELECT
       EMP_NAME
     , SUBSTR(EMP_NO ,INSTR(EMP_NO, '-') + 1, 1)
FROM EMPLOYEE;

-- LOWER / UPPER / INITCAP
-- : LOWER(문자열 | 컬럼) : 소문자로 변경해주는 함수
SELECT LOWER('Welcome To My World')
FROM DUAL;

-- : UPPER(문자열 | 컬럼) : 대문자로 변경해주는 함수
SELECT UPPER('Welcome To My World')
FROM DUAL;

-- : INITCAP(문자열 | 컬럼) : 앞글자만 대문자로 변경해주는 함수
SELECT INITCAP('welcome to my world')
FROM DUAL;

-- CONCAT : 문자열 혹은 컬럼 두 개를 입력받아 하나로 합친 후 리턴
SELECT CONCAT('가나다라', 'ABCD')
FROM DUAL;

SELECT ('가나다라' || 'ABCD')
FROM DUAL;

-- REPLACE : 컬럼 혹은 문자열을 입력받아
--           변경하고자 하는 문자열을
--           변경하려고 하는 문자열을 바꾼 후 리턴
SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동')
FROM DUAL;

-- EMPLOYEE 테이블에서 직원들의 주민번호를 조회하여
-- 사원명, 생년, 생월, 생일을 각각 분리하여 조회
-- 단 컬럼 별칭은 사원명, 생년, 생월, 생일로 한다.
SELECT
       EMP_NAME 사원명
       , SUBSTR(EMP_NO, 1, 2) 생년
       , SUBSTR(EMP_NO, 3, 2) 생월
       , SUBSTR(EMP_NO, 5, 2) 생일
FROM EMPLOYEE;

-- 여직원들의 모든 컬럼 정보 조회
SELECT *FROM EMPLOYEE;
SELECT *FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2;

-- 날짜 데이터에서도 SUBSTR을 사용할 수 있다.
-- 직원들의 입사일에서 입사년도, 입사월, 입사날짜를 분리 조회
SELECT
       HIRE_DATE
     , SUBSTR(HIRE_DATE, 1, 2) 입사년도
     , SUBSTR(HIRE_DATE, 4, 2) 입사월
     , SUBSTR(HIRE_DATE, 7, 2) 입사날짜
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 사원명, 주민번호 조회
-- 단, 주민번호는 생년월일만 보이게 하고 '-' 이ㅣ후의 값은 '*'로 바꿔서 출력
SELECT *FROM EMPLOYEE;
SELECT EMP_NAME, CONCAT(SUBSTR(EMP_NO, 1, 7), '*******') 주민번호
FROM EMPLOYEE;

SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 7) || '*******' 주민번호
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 7), 14, '*') 주민번호
FROM EMPLOYEE;

-- 숫자 처리 함수 : ABS, MOD, ROUND, FLOOR, TRUNC, CEIL
-- ABS(숫자 | 숫자로 된 컬럼명) : 절대값 구하는 함수
SELECT ABS(-10), ABS(10) FROM DUAL;

-- MOD(숫자 | 숫자로 된 컬럼명, 숫자 | 숫자로 된 컬럼명)
-- : 두 수를 나누어서 나머지를 구하는 함수
-- 처음 인자는 나누어지는 수, 두 번째 인자는 나눌 수
SELECT MOD(10, 5), MOD(10, 3) FROM DUAL;

-- ROUND(숫자 | 숫자로 된 컬럼명, [위치])
--: 반올림해서 리턴하는 함수 .이 0번째 위치
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.456, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 2) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;
SELECT ROUND(123.456, -1) FROM DUAL;

-- FLOOR(숫자 | 숫자로 된 컬럼명) : 내림처리 하는 함수
SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(123.678) FROM DUAL;

-- TRUNC(숫자 | 숫자로 된 컬럼명, [위치]) : 내림처리(절삭) 함수
SELECT TRUNC(123.678) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456, 2) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;

-- CEIL(숫자 | 숫자로 된 컬럼명) : 올림처리 함수
SELECT CEIL(123.456) FROM DUAL;

SELECT
       ROUND(123.456)
     , FLOOR(123.456)
     , TRUNC(123.456)
     , CEIL(123.456)
FROM DUAL;

-- 날짜 처리 함수 : SYSDATE, MONTHS_BETWEEN, AND_MONTHS,
--                 NEXT_DAY, LAST_DAY, EXTRACT
-- SYSDATE : 시스템에 저장되어 있는 날짜를 반환하는 함수
SELECT SYSDATE FROM DUAL;

-- MONTHS_BETWEEN(날짜, 날짜)
-- : 두 날짜의 개월 수 차이를 숫자로 리턴하는 함수
SELECT EMP_NAME, HIRE_DATE, CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) -- 근무 개월 수
FROM EMPLOYEE;

-- ADD_MONTHS(날짜, 숫자)
-- : 날짜에 숫자만큼 개월 수를 더한 날짜를 리턴
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사 후 6개월이 되는 날짜 조회
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 근무년수가 20년 이상인 직원 조회
SELECT *
FROM EMPLOYEE
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;

SELECT *
FROM EMPLOYEE
WHERE ADD_MONTHS(HIRE_DATE, 240) <= SYSDATE;

-- NEXT_DAY(기준날짜, 요일)
-- : 기준 날짜에서 구하려는 요일에 가장 가까운 날짜 리턴
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;

-- LAST_DAY(날짜) : 해당 월의 마지막 날짜를 구하여 리턴
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

-- EMPLOYEE 테이블에서 사원명, 입사일, 입사한 월의 근무일수를 조회하세요
SELECT EMP_NAME, HIRE_DATE,
       LAST_DAY(HIRE_DATE) - HIRE_DATE + 1
FROM EMPLOYEE;

-- EXTRACT : 년, 월, 일 정보를 추출하여 리턴하는 함수
-- EXTRACT(YEAR FROM 날짜) : 년도만 추출
-- EXTRACT(MONTH FROM 날짜) : 월만 추출
-- EXTRACT(DAY FROM 날짜) : 날짜만 추출
SELECT
       EXTRACT(YEAR FROM SYSDATE) 년도
     , EXTRACT(MONTH FROM SYSDATE) 월
     , EXTRACT(DAY FROM SYSDATE) 날짜
FROM DUAL;

-- EMPLOYEE 테이블에서 사원이름, 입사년, 입사월, 입사일 조회
SELECT
       EMP_NAME 사원이름
     , EXTRACT(YEAR FROM HIRE_DATE) 입사년
     , EXTRACT(MONTH FROM HIRE_DATE) 입사월
     , EXTRACT(DAY FROM HIRE_DATE) 입사일
FROM EMPLOYEE
--WHERE 사원이름 = '김해술'
-- ORDER BY EMP_NAME ASC;
-- ORDER BY EMP_NAME DESC;
-- ORDER BY 사원이름;
-- ORDER BY 1;
--ORDER BY 입사년 ASC, 사원이름 ASC;
ORDER BY 입사년 ASC, 사원이름 DESC;

-- EMPLOYEE 테이블에서 직원들의 사원명과 근무 년수 조회
-- 단, MONTHS_BETWEEN 사용
SELECT *FROM EMPLOYEE;

SELECT
       EMP_NAME
     , HIRE_DATE
     , CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) 근무년수
FROM EMPLOYEE;

SELECT EMP_NAME, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 근무년수
FROM EMPLOYEE;

ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';

-- 형변환 함수
SELECT *
FROM EMPLOYEE
WHERE EMP_ID = 200;

-- 형변환 함수
-- TO_CHAR(날짜, [포맷]) : 날짜형 데이터를 문자열로 변경
-- TO_CHAR(숫자, [포맷]) : 숫자형 데이터를 문자열로 변경
SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '99999') FROM DUAL; -- 모자라면 모자라는 대로 냅둠
SELECT TO_CHAR(1234, '00000') FROM DUAL; -- 모자라면 모자라는 곳은 0으로 채움
SELECT TO_CHAR(1234, '999') FROM DUAL; -- 포맷팅 불가(자릿수 안맞음)
SELECT TO_CHAR(1234, '000') FROM DUAL; -- 포맷팅 불가(자릿수 안맞음)
SELECT TO_CHAR(1234, 'L99999') FROM DUAL; -- 화폐기호(원화)
SELECT TO_CHAR(1234, '$99999') FROM DUAL; -- 화폐기호(달러)
SELECT TO_CHAR(1234, 'L99,999') FROM DUAL; -- 화폐기호(원화) 천원 단위 콤마
SELECT TO_CHAR(1234, '$99,999') FROM DUAL; -- 화폐기호(달러) 천원 단위 콤마

-- 직원 테이블에서 사원명, 급여 조회
-- 급여는 '\9,000,000' 형식으로 출력
SELECT *FROM employee;
SELECT EMP_NAME, TO_CHAR(SALARY, 'L99,999,999') AS 급여
FROM EMPLOYEE;

-- 날짜 데이터에 포맷 적용시 TO_CHAR 함수 사용
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-fmMM-DD DAY') FROM DUAL; -- fm은 0제거
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL; -- DAY는 DY의 풀네임 DAY : 목요일, DY : 목
SELECT TO_CHAR(SYSDATE, 'YEAR, Q') || '분기' FROM DUAL; -- Q는 분기를 의미 YEAR는 영어로 TEWENTY TWENTY

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') 입사일
FROM EMPLOYEE;

-- 한글 지원 안됨(년, 월, 일)
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY년 MM월 DD일') 입사일
FROM EMPLOYEE;
-- 따옴표 추가해서 텍스트로 처리
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') 입사일
FROM EMPLOYEE;

SELECT
       EMP_NAME
     , HIRE_DATE
     , TO_CHAR(HIRE_DATE, 'YYYY/MM/DD HH24:MI:SS') 상세입사일
FROM EMPLOYEE;

-- 오늘 날짜에 대해 년도 4자리, 년도 2자리, 년도 이름으로 출력
SELECT
       TO_CHAR(SYSDATE, 'YYYY')
     , TO_CHAR(SYSDATE, 'YY')
     , TO_CHAR(SYSDATE, 'RRRR')
     , TO_CHAR(SYSDATE, 'RR')
     , TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- RR과 YY의 차이
-- 년도 바꿀 때(TO_DATE 사용시) Y를 적용하면
-- 현재 세기(2000년) 적용
-- R은 50년 이상이면 이전 세기(1900년),
-- 50년 미만이면 현재 세기(2000년) 적용
SELECT TO_CHAR(TO_DATE('980630', 'YYMMDD'), 'YYYY-MM-DD')
FROM DUAL;
SELECT TO_CHAR(TO_DATE('980630', 'RRMMDD'), 'YYYY-MM-DD')
FROM DUAL;

-- 오늘 날짜에서 월만 출력
SELECT
       TO_CHAR(SYSDATE, 'MM')
     , TO_CHAR(SYSDATE, 'MONTH')
     , TO_CHAR(SYSDATE, 'MON')
     , TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-- 오늘 날짜에서 일만 출력(DDD/DD/D)
-- DDD : 1년 중에 몇 일 째 인지
-- DD : 달 기준 몇 일 째 인지
-- D : 그 주에서 몇 일 째인지
SELECT
       TO_CHAR(SYSDATE, '"1년 기준 " DDD "일 째"')
     , TO_CHAR(SYSDATE, '"달 기준 " DD "일 째"')
     , TO_CHAR(SYSDATE, '"주 기준 " D "일 째"')
FROM DUAL;

-- 오늘 날짜에서 분기와 요일 출력 처리
SELECT
       TO_CHAR(SYSDATE, 'Q"분기"')
     , TO_CHAR(SYSDATE, 'DAY')
     , TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

-- 직원 테이블에서 이름, 입사일 조회
-- 입사일에 포맷 적용함
-- '2018년 6월 15일 (수)' 형식으로 출력 처리 하세요
SELECT* FROM EMPLOYEE;
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'RRRR"년" fmMM"월" DD"일" ') || TO_CHAR(HIRE_DATE, '"("DY")"') 입사일
FROM EMPLOYEE;

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'RRRR"년" fmMM"월" DD"일" (DY)') 입사일 FROM EMPLOYEE;

-- TO_DATE : 문자형 데이터 혹은 숫자형 데이터를 날짜로 변환하여 리턴
SELECT TO_DATE('20100101', 'RRRRMMDD') FROM DUAL;
SELECT TO_CHAR(TO_DATE('20100101', 'RRRRDDMM'), 'RRRR, MON') FROM DUAL;

SELECT TO_DATE('041030 143000', 'RRMMDD HH24MISS') FROM DUAL;
SELECT TO_CHAR(TO_DATE('041030 143000', 'RRMMDD HH24MISS'), 'DD-MON-RR HH:MI:SS PM')
FROM DUAL;

-- 직원 테이블에서 2000년도 이후에 입사한 사원의
-- 사번, 이름, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE HIRE_DATE >= TO_DATE(20000101, 'RRRRMMDD')
--WHERE HIRE_DATE >= 20000101;
WHERE HIRE_DATE >= '20000101';

-- TO_NUMBER : 문자 데이터를 숫자로 바꿀 때 사용
SELECT TO_NUMBER('123456789') FROM DUAL;

-- 자동 형변환
SELECT '123' + '456' FROM DUAL;
-- 숫자로 된 문자열만 가능하다.
SELECT '123' + '456A' FROM DUAL;

-- EMPLOYEE 테이블에서 사번이 홀수인 직원의 정보를 조회
SELECT *
FROM EMPLOYEE
WHERE MOD(TO_NUMBER(EMP_ID), 2) = 1;
--WHERE MOD(EMP_ID, 2) = 1;

SELECT '1,000,000' + '5000,000' FROM DUAL;

-- 콤마 명시해주면 TO_NUMBER 가능
SELECT
       TO_NUMBER('1,000,000', '99,999,999')
     + TO_NUMBER('500,000', '999,999')
FROM DUAL;

-- 과제
-- 자바 워크북 01
-- : 제출 파일 명 : JAVA_WORKSHOP01_홍길동.zip
-- 오라클 워크북
-- : basic select 전체
-- : select - 함수 1 ~ 9번
-- : 제출 파일 명 : DAY2_HOMEWORK_HONGGILDONG.sql
