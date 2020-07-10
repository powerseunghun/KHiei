-- DAY 7 수업내용

-- DML(Data Manipulation Language) : 데이터 조작 언어
-- INSERT, UPDATE, DELTEE, SELECT
-- C(CREATE) : INSERT
-- R(READ) : SELECT
-- U(UPDATE) : UPDATE
-- D(DELETE) : DELETE
-- 테이블에 값을 삽입하거나, 수정하거나, 삭제하거나, 조회하는 언어
-- 테이블의 구조에는 변화가 없다

-- INSERT : 새로운 행을 추가하는 구문이다.
--          테이블의 행 갯수가 증가한다.

-- INSERT INTO 테이블명 (컬럼명, 컬럼명, 컬럼명, ....)
-- VALUES (데이터, 데이터, 데이터, ....)

-- 테이블의 모든 컬럼에 대해 값을 INSERT 하는 경우
-- 테이블명 뒤에 컬럼명들을 생략할 수 있다.
-- INSERT INTO 테이블명
-- VALUES (데이터, 데이터, 데이터, ...);

INSERT
  INTO EMPLOYEE.EMPLOYEE
(
  EMP_ID, EMP_NAME, EMP_NO
, EMAIL, PHONE, DEPT_CODE
, JOB_CODE, SAL_LEVEL, SALARY
, BONUS, MANAGER_ID, HIRE_DATE
, ENT_DATE, ENT_YN
)
VALUES
(
  900, '장채현', '901123-1080503'
, 'jang_ch@kh.or.kr', '01055559512', 'D1'
, 'J7', 'S3', 4300000
, 0.2, '200', SYSDATE
, NULL, DEFAULT
);

COMMIT;

SELECT *FROM EMPLOYEE 
WHERE EMP_ID=900;

-- INSERT시에 VALUES 대신 서브쿼리를 이용할 수 있다.
CREATE TABLE EMP_01 (
  EMP_ID NUMBER, 
  EMP_NAME VARCHAR2(30),
  DEPT_TITLE VARCHAR2(30)
);

SELECT *FROM EMP_01;

INSERT INTO EMP_01(
  SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
);

-- INSERT ALL : INSERT 시에 사용하는 서브쿼리가 같은 경우
--              두 개 이상의 테이블에 INSERT ALL을 이용하여
--              한 번에 데이터를 삽입할 수 있다.
--              단, 각 서브쿼리의 조건절이 같아야 한다.
CREATE TABLE EMP_DEPT_D1
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
     FROM EMPLOYEE
    WHERE 1 = 0;
    
CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
     FROM EMPLOYEE
    WHERE 1 = 0;
    
SELECT *FROM EMP_DEPT_D1;
SELECT *FROM EMP_MANAGER;

-- EMP_DEPT_D1 테이블에 EMPLOYEE 테이블에 있는 부서코드가 D1인 직원을 조회하여
-- 사번, 이름, 소속부서, 입사일을 삽입하고,
-- EMP_MANAGER 테이블에 EMPLOYEE 테이블에 있는 부서코드가 D1인 직원을 조회해서
-- 사번, 이름, 관리자 사번을 삽입하세요.
INSERT INTO EMP_DEPT_d1 (
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
   WHERE DEPT_CODE = 'D1'
);

INSERT INTO EMP_MANAGER (
  SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
   WHERE DEPT_CODE = 'D1'
);

SELECT *FROM EMP_DEPT_D1;
SELECT *FROM EMP_MANAGER;

DELETE FROM EMP_DEPT_D1;
DELETE FROM EMP_MANAGER;

INSERT ALL
INTO EMP_DEPT_D1 VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D1';

-- EMPLOYEE 테이블에서 입사일을 기준으로 2000년 1월 1일 이전에 입사한 사원의
-- 사번, 이름, 입사일, 급여를 조회하여 EMP_OLD 테이블에 삽입하고
-- 그 이후에 입사한 사원은 EMP_NEW 테이블에 삽입하세요
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
     FROM EMPLOYEE
    WHERE 1 = 0;

CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
     FROM EMPLOYEE
    WHERE 1 = 0;

SELECT *FROM EMPLOYEE WHERE HIRE_DATE > TO_DATE('2000/01/01', 'RRRR/MM/DD');

SELECT *FROM EMPLOYEE;
INSERT ALL
    WHEN HIRE_DATE < TO_DATE('2000/01/01', 'RRRR/MM/DD') THEN
        INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
    ELSE INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
--    WHEN HIRE_DATE <= '2000/01/01'
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
  FROM EMPLOYEE;
  
SELECT *FROM EMP_OLD;
SELECT *FROM EMP_NEW;

-- UPDATE : 테이블에 기록된 컬럼의 값을 수정하는 구문이다.
--          테이블의 전체 행 갯수는 변화가 없다.
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- UPDATE 테이블명 SET 컬럼명 = 바꿀값, 컬럼명 = 바꿀값, ...
-- [WHERE 컬럼명 비교연산자 비교값];
UPDATE /*홍길동::com.kh.jdbc.model.dao.DAO.updateDepartment()*/
       DEPT_COPY
   SET DEPT_TITLE = '전략기획팀'
 WHERE DEPT_ID = 'D9';

-- UPDATE 시에도 서브쿼리를 이용할 수 있다.
-- UPDATE 테이블명
--    SET 컬럼명 = (서브쿼리)
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
     FROM EMPLOYEE;

SELECT *FROM EMP_SALARY
 WHERE EMP_NAME IN ('유재식', '방명수');
 
-- 평상시 유재식 사원을 부러워하던 방명수 사원의
-- 급여와 보너스율을 유재식 사원과 동일하게 변경해주기로 했다.
-- 이를 반영하는 UPDATE문을 작성해보세요
UPDATE EMP_SALARY
  SET SALARY = (SELECT SALARY
                  FROM EMPLOYEE
                 WHERE EMP_NAME='유재식'),
      BONUS = (SELECT BONUS
                 FROM EMPLOYEE
                WHERE EMP_NAME='유재식')
 WHERE EMP_NAME = '방명수';
 
UPDATE EMP_SALARY
  SET (SALARY, BONUS) = (SELECT SALARY
                              , BONUS 
                           FROM EMPLOYEE 
                          WHERE EMP_NAME='유재식')
 WHERE EMP_NAME = '방명수';

-- 다중열 서브쿼리를 이용한 UPDATE 문
-- 방명수 사원이 급여 인상 소식을 소문을 내는 바람에 인상 소식을 전해들은
-- 다른 직원들이 단체로 파업을 진행했다.
-- 노옹철, 전형돈, 정중하, 하동운 사원의 급여와 보너스를
-- 유재식 사원의 급여와 보너스가 같게 변경하는 UPDATE 문을 작성하세요
SELECT *FROM EMP_SALARY WHERE EMP_NAME IN('노옹철', '전형돈', '정중하', '하동운', '유재식');

UPDATE EMP_SALARY
  SET (SALARY, BONUS) = (SELECT SALARY
                              , BONUS 
                           FROM EMPLOYEE 
                          WHERE EMP_NAME='유재식')
 WHERE EMP_NAME IN ('노옹철', '전형돈', '정중하', '하동운', '유재식');

-- 다중행 서브쿼리를 이용한 UPDATE
-- EMP_SALARY 테이블에서 아시아 근무지역에 근무하는 직원의
-- 보너스를 0.5로 변경하시오

-- My SOURCE
UPDATE (SELECT *
          FROM EMP_SALARY ES
          JOIN DEPARTMENT D ON (ES.DEPT_CODE = D.DEPT_ID)
          JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)) TMP
   SET TMP.BONUS = 0.5
 WHERE TMP.LOCAL_NAME LIKE 'ASIA%';

-- instructor SOURCE
SELECT EMP_ID
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
  JOIN LOCATION L ON (LOCATION_ID = LOCAL_CODE)
 WHERE LOCAL_NAME LIKE 'ASIA%';

UPDATE EMP_SALARY
   SET BONUS = 0.5
 WHERE EMP_ID IN (SELECT EMP_ID
                    FROM EMPLOYEE E
                    JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
                    JOIN LOCATION L ON (LOCATION_ID = LOCAL_CODE)
                   WHERE LOCAL_NAME LIKE 'ASIA%');

-- UPDATE 시 변경할 값은 해당 컬럼에 대한 제약조건에 위배되지 않아야 한다.
UPDATE EMPLOYEE
   SET DEPT_CODE = '65'   -- FOREIGN KEY 제약조건 위배됨
 WHERE DEPT_CODE = 'D6';
 
UPDATE EMPLOYEE
   SET EMP_NAME = NULL    -- NOT NULL 제약조건 위배됨
 WHERE EMP_ID = 200;

UPDATE EMPLOYEE
   SET EMP_NO = '621235-1985634'  -- UNIQUE 제약조건 위배됨
 WHERE EMP_ID = 201;

-- UPDATE에서 DEFAULT를 사용할 수 있다.
UPDATE EMPLOYEE
   SET ENT_YN = DEFAULT
 WHERE EMP_ID = 222;

SELECT EMP_ID, EMP_NAME, ENT_YN
  FROM EMPLOYEE
 WHERE EMP_ID = 222;
 
ROLLBACK;

-- DELETE : 테이블의 행을 삭제하는 구문이다.
--          테이블의 행의 갯수가 줄어든다.
-- DELETE FROM 테이블명 WHERE 조건설정
-- 만약 WHERE 조건을 설정하지 않으면 모든 행이 다 삭제 된다.
COMMIT;

DELETE FROM EMPLOYEE;
SELECT *FROM EMPLOYEE;
ROLLBACK;

DELETE FROM EMPLOYEE
WHERE EMP_ID = 900;

ROLLBACK;

-- FOREIGN KEY 제약조건이 설정되어 있는 경우
-- 참조되고 있는 값에 대해서는 삭제할 수 없다.
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';      -- FOREIGN KEY 제약조건 위배

-- FOREIGN KEY 제약조건이 설정되어 있어도
-- 참조되고 있지 않는 값에 대해서는 삭제 가능
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D3';     -- 참조되고 있지 않는 값. 삭제 가능
ROLLBACK;

-- TRUCATE : 테이블의 전체 행을 삭제할 시 사용한다.
--           DELETE 보다 수행 속도가 빠르다.
--           ROLLBACK을 통해 데이터를 복구할 수 없다.
SELECT * FROM EMP_SALARY;
COMMIT;

DELETE FROM EMP_SALARY;

SELECT * FROM EMP_SALARY;

ROLLBACK;

SELECT *FROM EMP_SALARY;

TRUNCATE TABLE EMP_SALARY;

SELECT *FROM EMP_SALARY;
ROLLBACK;

-- MERGE : 구조가 같은 두 개의 테이블을 하나로 합치는 기능을 한다.
--         테이블에서 지정하는 조건의 값이 존재하면 UPDATE
--         조건의 값이 없으면 INSERT 됨
CREATE TABLE EMP_M01
AS SELECT *FROM EMPLOYEE;

CREATE TABLE EMP_M02
AS SELECT * FROM EMPLOYEE
  WHERE JOB_CODE = 'J7';

SELECT * FROM EMP_M01;
SELECT * FROM EMP_M02;

INSERT INTO EMP_M02
VALUES (999, '김진호', '561016-1234567', 'kim_jh@kh.or.kr',
        '01011112222', 'D9', 'J4', 'S1', 9000000, 0.5, NULL,
        SYSDATE, NULL, DEFAULT);

SELECT *FROM EMP_M02;

UPDATE EMP_M02 SET SALARY = 0;

MERGE INTO EMP_M01 USING EMP_M02 ON (EMP_M01.EMP_ID = EMP_M02.EMP_ID)
WHEN MATCHED THEN
UPDATE SET
EMP_M01.EMP_NAME = EMP_M02.EMP_NAME,
EMP_M01.EMP_NO = EMP_M02.EMP_NO,
EMP_M01.EMAIL = EMP_M02.EMAIL,
EMP_M01.PHONE = EMP_M02.PHONE,
EMP_M01.DEPT_CODE = EMP_M02.DEPT_CODE,
EMP_M01.JOB_CODE = EMP_M02.JOB_CODE,
EMP_M01.SAL_LEVEL = EMP_M02.SAL_LEVEL,
EMP_M01.SALARY = EMP_M02.SALARY,
EMP_M01.BONUS = EMP_M02.BONUS,
EMP_M01.MANAGER_ID = EMP_M02.MANAGER_ID,
EMP_M01.HIRE_DATE = EMP_M02.HIRE_DATE,
EMP_M01.ENT_DATE = EMP_M02.ENT_DATE,
EMP_M01.ENT_YN = EMP_M02.ENT_YN
WHEN NOT MATCHED THEN
INSERT VALUES (EMP_M02.EMP_ID, EMP_M02.EMP_NAME,
               EMP_M02.EMP_NO, EMP_M02.EMAIL,
               EMP_M02.PHONE, EMP_M02.DEPT_CODE,
               EMP_M02.JOB_CODE, EMP_M02.SAL_LEVEL, 
               EMP_M02.SALARY, EMP_M02.BONUS,
               EMP_M02.MANAGER_ID, EMP_M02.HIRE_DATE,
               EMP_M02.ENT_DATE, EMP_M02.ENT_YN);

SELECT *FROM EMP_M01 WHERE JOB_CODE = 'J7' OR EMP_ID = 999;

-- book workshp