-- DAY 8 수업내용

-- TCL(Transaction Control Language)
-- : 트랜젝션 제어 언어
-- COMMIT과 ROLLBACK이 있다.

-- 트랜젝션
-- 한꺼번에 수행되어야 할 최소의 작업 단위를 말한다.
-- 논리적 작업 단위(Logical Unit of Work : LUW)

-- 원자성
-- 하나의 트랜젝션으로 이루어진 작업은 반드시 한꺼번에 완료(COMMIT)
-- 되어야 하며, 그렇지 않으면 한꺼번에 취소 (ROLLBACK) 되어야 한다.

-- COMMIT : 트랜젝션작업이 정상 완료되면 변경 내용을 영구히 저장
-- ROLLBACK : 트랜젝션 작업을 취소하고 최근 COMMIT 한 시점으로 이동
-- SAVEPOINT 세이브 포인트명 : 현재 트랜젝션 작업 시점에 이름을 정해줌
--                           하나의 트랜젝션 안에 구역을 나눔
-- ROLLBACK TO 세이브포인트명 : 트랜젝션 작업을 취소하고
--                            SAVEPOINT 시점으로 이동

CREATE TABLE USER_TBL (
  USERNO NUMBER UNIQUE,
  ID VARCHAR2(20) PRIMARY KEY,
  PASSWORD CHAR(20) NOT NULL
);

INSERT INTO USER_TBL VALUES(1, 'test1', 'pass01');
INSERT INTO USER_TBL VALUES(2, 'test2', 'pass02');
INSERT INTO USER_TBL VALUES(3, 'test3', 'pass03');
COMMIT;

SELECT *FROM USER_TBL;

INSERT INTO USER_TBL VALUES(4, 'test4', 'pass04');

SELECT *FROM USER_TBL;

ROLLBACK;

SELECT *FROM USER_TBL;

INSERT INTO USER_TBL VALUES (4, 'test4', 'pass04');
SAVEPOINT SP1;

INSERT INTO USER_TBL VALUES (5, 'test5', 'pass05');

SELECT *FROM USER_TBL;

-- SAVE POINT로 복구 (4개 저장 시점) 만약 ROLLBACK만 한다면 (3개 저장 시점으로)
-- 만약 ROLLBACK 하고, ROLLBACK TO SP1 하게 되면 오류 (맞지 않음)
-- 대신 ROLLBACK TO SP1 하고 ROLLBACK은 가능.
ROLLBACK TO SP1;

SELECT *FROM USER_TBL;

ROLLBACK;

SELECT *FROM USER_TBL;

-- 복습 진도에 포함 안시켜도 됨 어떤게 된다 / 안된다 정도만
-- DDL
-- ALTER : 객체를 수정하는 구문
-- 테이블객체 수정 : ALTER TABLE 테이블명 수정할 내용
-- 컬럼 추가/삭제/변경, 제약조건 추가/삭제/변경
-- 테이블명 변경, 제약조건 이름 변경

-- 컬럼 추가
SELECT *FROM DEPT_COPY;

-- NULL 값으로 채워짐
ALTER TABLE DEPT_COPY 
ADD (LNAME VARCHAR2(20));

-- 컬럼 삭제
ALTER TABLE DEPT_COPY
DROP COLUMN LNAME;

SELECT *FROM DEPT_COPY;

-- 컬럼 생성 시 DEFAULT값 지정
ALTER TABLE DEPT_COPY
ADD (CNAME VARCHAR2(20) DEFAULT '한국');

SELECT *FROM DEPT_COPY;

-- 컬럼에 제약조건 추가
CREATE TABLE DEPT_COPY2
AS SELECT *FROM DEPARTMENT;

-- NOT NULL 제약조건만 복사되었음..
SELECT *FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2
ADD CONSTRAINT PK_DEPT_ID2 PRIMARY KEY(DEPT_ID);
ALTER TABLE DEPT_COPY2
ADD CONSTRAINT UN_DEPT_TITLE2 UNIQUE (DEPT_TITLE);
-- NOT NULL / NULL은 MODIFY & 만약 제약 조건 이름 붙이려면 
-- CONSTRAINT를 뒤에 붙여줘야함
ALTER TABLE DEPT_COPY2
MODIFY LOCATION_ID CONSTRAINT NN_LID NOT NULL;

-- 컬럼의 자료형 수정

-- 변경 전
---------------------------------
-- DEPT_ID CHAR(2 BYTE)
-- DEPT_TITLE VARCHAR2(35 BYTE)
-- LOCATION_ID CHAR(2 BYTE)
---------------------------------
ALTER TABLE DEPT_COPY2
MODIFY DEPT_ID CHAR(3)
MODIFY DEPT_TITLE VARCHAR2(30)
MODIFY LOCATION_ID VARCHAR2(2);

-- 변경후
---------------------------------
-- DEPT_ID CHAR(3 BYTE)
-- DEPT_TITLE VARCHAR2(30 BYTE)
-- LOCATION_ID VARCHAR(2 BYTE)
---------------------------------

-- 컬럼의 크기를 줄이는 경우에는
-- 변경하려는 크기를 초과하는 값이 없을 때만 변경할 수 있다.
ALTER TABLE DEPT_COPY2
MODIFY DEPT_TITLE VARCHAR2(10);

-- DEFAULT 값 변경
SELECT *FROM DEPT_COPY;

ALTER TABLE DEPT_COPY
MODIFY CNAME DEFAULT '미국';

-- 기존 DEFAULT 값이 바뀌지는 않음 '한국' -> '미국' (X)
SELECT *FROM DEPT_COPY;

INSERT INTO DEPT_COPY
VALUES ('D0', '생산부', 'L2', DEFAULT);

-- 새롭게 입력되는 행은 '미국' DEFAULT 값으로.
SELECT *FROM DEPT_COPY;

-- 컬럼 삭제
ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_TITLE;

SELECT *FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2
DROP COLUMN LOCATION_ID;

SELECT *FROM DEPT_COPY2;

-- 이거는 기억해 둘 필요가 있어요.
-- 모든 컬럼은 삭제 불가 (최소 1개 이상의 컬럼이 남아있어야 함)
-- 테이블이 1개 이상 있어야 테이블로서의 가치가 있다.
ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_ID;

-- 내 자신 테이블을 참조. (순환참조) EMPLOYEE 테이블의 EMPLOYEE_ID 와 MANAGER_ID
-- 만약 EMPLOYEE 테이블에 200번 사원이 입력되었다고 하자(첫번째 데이터)
-- MANAGER_ID는 NULL이 되어야 하고 
-- 2번째 부터서야 MANAGER_ID에 200 작성 가능
-- 그러므로 MANAGER_ID는 NOT NULL 제약조건이 사용되면 안됨.

-- NULL 제약조건, 필수 참여, 선택 참여 (EMP/DEPT) / (EMP/HOBBY)
-- FK를 NULL값을 허용하지 않는다면
-- 첫번째 부터 값이 들어갈 수 없음..
-- 따라서 선택적 참여로 설정해줘야함
CREATE TABLE TB1 (
  PK NUMBER PRIMARY KEY,
  FK NUMBER REFERENCES TB1,
  COL1 NUMBER,
  CHECK (PK > 0 AND COL1 > 0)
);

-- 컬럼 삭제 시 참조하고 있는 컬럼이 있다면 삭제하지 못한다.
ALTER TABLE TB1
DROP COLUMN PK;

-- 제약조건도 함께 삭제
ALTER TABLE TB1
DROP COLUMN PK CASCADE CONSTRAINTS;

SELECT *FROM TB1;

-- 컬럼 삭제 : DROP COLUMN 삭제할 컬럼명 또는 DROP (삭제할 컬럼명)
-- 데이터가 기록되어 있어도 삭제됨
-- 삭제된 컬럼은 ROLLBACK으로 복구가 불가능 (DDL 구문은 AUTO COMMIT)
-- 테이블에는 최소 한 개의 컬럼이 존재해야 함.
SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY
DROP (CNAME);

SELECT * FROM DEPT_COPY;

-- 여러개 컬럼 삭제
ALTER TABLE DEPT_COPY
DROP (DEPT_TITLE, LOCATION_ID);

SELECT * FROM DEPT_COPY;

-- ROLLBACK 불가
ROLLBACK;

-- 제약조건 삭제
CREATE TABLE CONST_EMP (
  ENAME VARCHAR2(20) NOT NULL,
  ENO VARCHAR2(15) NOT NULL,
  MARRIAGE CHAR(1) DEFAULT 'N',
  EID CHAR(3),
  EMAIL VARCHAR2(30),
  JID CHAR(2),
  MID CHAR(3),
  DID CHAR(2),
  -- 테이블 레벨로 제약조건 설정
  CONSTRAINT CK_MARRIAGE CHECK (MARRIAGE IN ('Y', 'N')),
  CONSTRAINT PK_EID PRIMARY KEY(EID),
  CONSTRAINT UN_ENO UNIQUE(ENO),
  CONSTRAINT UN_EMAIL UNIQUE(EMAIL),
  CONSTRAINT FK_JID FOREIGN KEY(JID)
  REFERENCES JOB(JOB_CODE) ON DELETE SET NULL,
  CONSTRAINT FK_MID FOREIGN KEY(MID)
  REFERENCES CONST_EMP ON DELETE SET NULL,
  CONSTRAINT FK_DID FOREIGN KEY(DID)
  REFERENCES DEPARTMENT ON DELETE CASCADE
);

-- 제약조건 1개 삭제 시
ALTER TABLE CONST_EMP
DROP CONSTRAINT CK_MARRIAGE;

-- 제약조건 여러 개 삭제 시
ALTER TABLE CONST_EMP
DROP CONSTRAINT FK_DID
DROP CONSTRAINT FK_JID
DROP CONSTRAINT FK_MID;

-- NOT NULL 제약조건 삭제 시 MODIFY 사용
ALTER TABLE CONST_EMP
-- MODIFY (ENAME NULL, ENO NULL)
MODIFY ENAME NULL
MODIFY ENO NULL;

-- 컬럼의 이름 변경
CREATE TABLE DEPT_COPY3
AS SELECT *FROM DEPARTMENT;

SELECT *FROM DEPT_COPY3;

-- RENAME COLUMN A TO B 사용
ALTER TABLE DEPT_COPY3
RENAME COLUMN DEPT_ID TO DEPT_CODE;

SELECT *FROM DEPT_COPY3;

-- 제약조건 이름 변경
ALTER TABLE DEPT_COPY3
ADD CONSTRAINT PK_DEPT_CODE3 PRIMARY KEY(DEPT_CODE);

-- RENAME CONSTRAINT A TO B
ALTER TABLE DEPT_COPY3
RENAME CONSTRAINT PK_DEPT_CODE3 TO PK_DCODE;

-- 테이블 이름 변경
ALTER TABLE DEPT_COPY3
RENAME TO DEPT_TEST;

SELECT *FROM DEPT_COPY3;
SELECT *FROM DEPT_TEST;

-- 테이블 삭제
DROP TABLE DEPT_TEST; --CASCADE CONSTRAINT 제약조건도 함께 삭제;

-- 사용자 계정 삭제 (오류) - 사용자 계정 삭제는 System 권한
DROP USER jinho;

SELECT
       UC.TABLE_NAME
     , UCC.COLUMN_NAME
     , UC.CONSTRAINT_NAME
     , UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC
  JOIN USER_CONS_COLUMNS UCC ON(UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
 WHERE UC.TABLE_NAME = 'DEPT_COPY2';

-- 데이터 딕셔너리(DATA DICTIONARY)
-- 자원을 효율적으로 관리하기 위해 다양한 정보를 저장하는 시스템 테이블
-- 사용자가 테이블을 생성하거나, 사용자를 변경하는 등의 작업을 할 때
-- 데이터베이스 서버에 의해 자동으로 갱신되는 테이블
-- 사용자는 데이터 딕셔너리 내용을 직접 수정하거나 삭제할 수 없음

-- 원본 테이블을 커스터마이징해서 보여주는 원본 테이블의 가상 테이블 객체(VIEW)

-- 3개의 딕셔너리 뷰로 나뉨
-- 1. DBA_XXX : 데이터베이스 관리자만 접근 가능한 객체 등의 정보 조회
-- 2. ALL_XXX : 자신의 계정 + 권한을 부여받은 객체의 정보 조회
-- 3. USER_XXX : 자신의 계정이 소유한 객체등에 관한 정보 조회

SELECT * FROM DBA_USERS;

-- OR REPLACE는 기존에 존재한다면 대체해라.
CREATE OR REPLACE VIEW V_EMP(사번, 이름, 부서)
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE
     FROM EMPLOYEE;
    
-- 시스템 계정에서 GRANT CREATE VIEW TO EMPLOYEE;
 
-- 뷰
SELECT * FROM V_EMP;

-- 인라인 뷰
SELECT *FROM (SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서 FROM EMPLOYEE);

-- 뷰 객체 삭제
DROP VIEW V_EMP;

-- VIEW(뷰)
-- SELECT 쿼리문을 저장한 객체이다.
-- 실질적인 데이터를 저장하고 있지 않음
-- 테이블을 사용하는 것과 동일하게 사용할 수 있다.
-- CREATE [OR REPLACE] VIEW 뷰이름 AS 서브쿼리

-- 사번, 이름, 직급명, 부서명, 근무지역을 조회하고
-- 그 결과를 V_RESULT_EMP라는 뷰를 생성해서 저장하세요
CREATE OR REPLACE VIEW V_RESULT_EMP AS
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE, L.LOCAL_NAME
  FROM EMPLOYEE E -- 베이스테이블
  LEFT JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
  LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);
     
SELECT *FROM V_RESULT_EMP
WHERE EMP_ID = 205;

-- 뷰에 대한 정보를 확인하는 데이터 딕셔너리
SELECT *FROM USER_VIEWS;

-- 베이스 테이블의 정보가 변경되면 VIEW도 같이 변경된다.
COMMIT;

SELECT *FROM EMPLOYEE WHERE EMP_ID = 205;

-- DML 명령어로 조작이 불가능한 경우
-- 1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
-- 2. 뷰에 포함되지 않은 컬럼중에,
--    베이스가 되는 테이블 컬럼이 NOT NULL 제약조건이 지정된 경우
-- 3. 산술표현식으로 정의된 경우
-- 4. JOIN을 이용해 여러 테이블을 연결한 경우
-- 5. DISTINCT를 포함한 경우
-- 6. 그룹함수나 GROUP BY 절을 포함한 경우

-- 시퀀스(SEQUENCE)
-- 자동 번호 발생기 역할을 하는 객체
-- 순차적으로 정수 값을 자동으로 생성해줌
/*
  CREATE SEQUENCE 시퀀스 이름
  [INCREMENT BY 숫자] -- 다음 값에 대한 증가치, 생략하면 자동 1 기본
  [START WITH 숫자] -- 처음 발생시킬 값 지정, 생략하면 자동 1 기본
  [MAXVALUE 숫자 | NOMAXVALUE] -- 발생시킬 최대값 지정 (10의 27승까지)
  [MINVALUE 숫자 | NOMINVALUE] -- 발생시킬 최솟값 지정 (-10의 26승까지)
  [CYCLE | NOCYCLE] -- 값 순환,
  CYCLE : 0 ~ 10 -> 10 다음에 0
  NOCYCLE : 10 다음에는 에러 발생
  [CACHE 바이트크기 | NOCACHE] -- 캐시 사용 여부, 기본값은 20바이트, 최소는 2바이트
  CACHE -> 빠르지만 중간에 종료시 값이 이어서
  NOCACHE -> 캐시 사용 보다 느림
*/

CREATE SEQUENCE SEQ_EMPID
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

-- 에러 한 번도 값 발생하지 않아서
SELECT SEQ_EMPID.CURRVAL FROM DUAL;

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;

-- 시퀀스 변경 
-- START WITH 는 ALTER로 변경 불가 (DROP 후 다시 생성해야함)
-- 현재 값 변경도 DROP후 다시 생성해야함
-- 하지만 INCREMENT 값 수정 후 다시 변경해 놓을 수 있음

-- 현재 시퀀스가 222이고 100으로 바꿔야 한다면
-- ALTER SEQUENCE [SEQUENCE_NAME] INCREMENT BY -122;
-- SELECT [SEQUENCE_NAME].CURRVAL FROM DUAL  확인하고
-- ALTER SEQUENCE [SEQUENCE_NAME] INCREMENT BY 1;
ALTER SEQUENCE SEQ_EMPID
INCREMENT BY 10
MAXVALUE 400
NOCYCLE
NOCACHE;

-- SELECT 문에서 사용 가능
-- INSERT 문에서 SELECT 구문에서 사용 가능
-- INSERT 문에서 VALUES절에서 사용 가능 (실질적으론 이것)
-- UPDATE 문에서 SET절에서 사용 가능

-- 단, 서브쿼리의 SELECT 문에서 사용 불가
-- VIEW의 SELECT 절에서 사용 불가
-- DISTINCT 키워드가 있는 SELECT 문에서 사용 불가
-- GROUP BY, HAVING 절이 있는 SELECT문에서 사용 불가
-- ORDER BY 절에서 사용 불가
-- CREATE TABLE, ALTER TABLE의 DEFAULT값으로 사용 불가

CREATE SEQUENCE SEQ_EID
START WITH 300
INCREMENT BY 1
MAXVALUE 10000
NOCYCLE
NOCACHE;

INSERT INTO EMPLOYEE
VALUES (SEQ_EID.NEXTVAL, '홍길동', '666666-6666666',
        'hong_gd@kh.or.kr', '01012344444', 'D2', 'J7', 'S1',
        5000000, 0.1, 200, SYSDATE, NULL, DEFAULT);

SELECT *FROM EMPLOYEE;

ROLLBACK;

DROP SEQUENCE SEQ_EID;

CREATE SEQUENCE SEQ_EID2;

-- 인덱스 (INDEX)
-- : SQL 명령문의 처리 속도를 향상시키기 위해서
-- 컬럼에 대해 생성하는 오라클 객체이다.
-- 인덱스 내부 구조는 이진 트리 형식으로 구성되어 있다.
-- 인덱스를 생성하는 것은 처리 속도를 향상시키는 장점을 가지고 있지만,
-- 반드시 인덱스를 사용하는 것이 좋은 것은 아니다.

-- 장점
-- 검색 속도가 빨라짐

-- 단점
-- 인덱스를 위한 추가 저장 공간이 필요함
-- 인덱스를 생성하는데 시간이 걸림
-- 데이터의 변경 작업(INSERT/UPDATE/DELETE)이 자주 일어나는 경우 오히려 성능이 저하됨

-- 인덱스를 관리하는 데이터 딕셔너리
SELECT *FROM USER_IND_COLUMNS;

-- 쿼리 실행 후 F10 -> OPTIMIZER
-- HINT 주석을 이용해 OPTIMIZER에게 스캔 방식 알림
-- F10 이용해 확인 해 보면 FULL SCAN -> INDEX ROWID로 바뀜
SELECT /*+ INDEX_DESC(EMPLOYEE 엔터티1_PK) */ EMP_NAME
FROM EMPLOYEE;

SELECT *
FROM EMPLOYEE
WHERE EMP_ID > '0';

-- 인덱스의 종류
-- 1. 고유 인덱스 (UNIQUE INDEX)
-- 2. 비고유 인덱스 (NON UNIQUE INDEX)
-- 3. 단일 인덱스 (SINGLE INDEX)
-- 4. 결합 인덱스 (COMPOSITE INDEX)
-- 5. 함수 기반 인덱스 (FUNCTION BASED INDEX)

-- 동의어(SYNONYM)
-- 다른 데이터베이스 가진 객체에 대한 별명 혹은 줄임말
-- 여러 사용자가 테이블을 공유하는 경우
-- 다른 사용자가 테이블에 접근할 때 '사용자명.테이블명'으로 표현함
-- 동의어를 사용하면 간단하게 사용할 수 있다.
-- EMPLOYEE.EMPLOYEE -> EMP로 조회

-- 생성방법
-- CREATE SYNONYM 줄임말 FOR 사용자명.객체명;

CREATE SYNONYM EMP FOR EMPLOYEE;

SELECT *FROM EMP;
SELECT *FROM EMPLOYEE;