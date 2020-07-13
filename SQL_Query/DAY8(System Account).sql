GRANT CREATE VIEW TO EMPLOYEE;
GRANT CREATE SYNONYM TO EMPLOYEE;

SELECT *FROM EMPLOYEE.EMPLOYEE;
SELECT *FROM EMPLOYEE.DEPARTMENT;

CREATE PUBLIC SYNONYM DEPT FOR EMPLOYEE.DEPARTMENT;

DROP SYNONYM DEPT;

-- <사용자 관리>
-- : 사용자의 계정과 암호 설정, 권한 부여
-- 오라클 데이터베이스를 설치하면 기본적으로 제공되는 계정
-- 1. SYS
-- 2. SYSTEM
-- 3. SCOTT(교육용 샘플계정) : 11G부터 별도로 생성해야함
-- 4. HR (샘플계정) : 처음에는 잠겨져 있고, 11G에서는 없음

-- 보안을 위한 데이터베이스 관리자
-- : 사용자가 데이터베이스 객체(테이블, 뷰 등)에 대해
--   특정 권한을 가질 수 있게 하는 권한이 있음
--   다수의 사용자가 공유하는 데이터베이스 정보에 대한 보안 설정
--   데이터베이스에 접근하는 사용자마다 서로 다른 권한과 롤을 부여함
-- 권한 : 사용자가 특정 테이블에 접근할 수 있도록 하거나
--        해당 테이블에 SQL(SELECT/INSERT/UPDATE/DELETE)문을
--        사용할 수 있도록 제한을 두는 것

-- 시스템권한 : 데이터베이스 관리자가 가지고 있는 권한
--             CREATE USER(사용자 계정 만들기)
--             DROP USER(사용자 계정 삭제)
--             DROP ANY TABLE (임의의 테이블 삭제)
--             QUERY REWRITE (함수 기반 인덱스 생성 권한) (어려움)
--             BACKUP ANY TABLE (테이블 백업)

-- 시스템 관리자가 사용자에게 부여하는 권한
-- CREATE SESSION (데이터베이스에 접속)
-- CREATE TABLE (테이블 생성)
-- CREATE VIEW (뷰 생성)
-- CREATE SEQUENCE (시퀀스 생성)
-- CREATE PROCEDURE (프로시져 생성 권한)

-- SAMPLE / SAMPLE 유저 생성
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;

GRANT CREATE SESSION TO SAMPLE;

-- 테이블 만드는 권한.. 그래도 아직 테이블 생성 안됨(테이블 스페이스 할당 안됨)
GRANT CREATE TABLE TO SAMPLE;

-- 테이블 스페이스(TABLE SPACE) : 테이블 뿐만 아니라
-- : 테이블, 뷰, 등 그 밖에 데이터베이스 객체들이 저장되는 테이블상의 장소
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;

-- WITH ADMIN OPTION
-- : 사용자에게 시스템 권한을 부여할 때 사용
--   권한을 부여받은 사용자는 다른 사용자에게 권한을 지정할 수 있음
GRANT CREATE SESSION TO SAMPLE
WITH ADMIN OPTION;

-- 객체 권한 : 테이블이나 뷰, 시퀀스, 함수 등 각 객체별로
--            DML(SELECT/INSERT/UPDATE/DELETE)를 할 수 있는 권한을 부여함
-- GRANT 권한종류 [(컬럼명)] | ALL
-- ON 객체명 | ROLE 이름 | PUBLIC
-- TO 사용자이름;

-- 권한 종류        설정 객체
-- ALTER          TABLE, SEQUENCE
-- DELETE         TABLE, VIEW
-- EXECUTE        PROCEDURE
-- INDEX          TABLE
-- REFERENCES     TABLE
-- INSERT         TABLE, VIEW
-- SELECT         TABLE, VIEW, SEQUENCE
-- UPDATE         TABLE, VIEW

-- SAMPLE에게 EMPLOYEE의 EMPLOYEE 테이블 조회 권한
GRANT SELECT ON EMPLOYEE.EMPLOYEE TO SAMPLE;

-- WITH GRANT OPTION
-- : 사용자가 해당 객체에 접근할 수 있는 권한을 부여받으면서
--   그 권한을 다른 사용자에게 다시 부여할 수 있는 권한 옵션
GRANT SELECT ON EMPLOYEE.EMPLOYEE TO SAMPLE
WITH GRANT OPTION;

-- 권한 철회
-- : REVOKE 명령어 사용
REVOKE SELECT ON EMPLOYEE.EMPLOYEE FROM SAMPLE;

-- <데이터베이스 ROLE - 권한제어>
-- : 사용자마다 일일히 권한을 부여하는 것은 번거롭기 때문에
--   간편하게 권한을 부여할 수 있는 방법으로 ROLE을 제공한다.

-- 롤(ROLE)
-- : 사용자에게 보다 간편하게 부여할 수 있도록
--   여러 개의 권한을 묶어놓은 것

-- 롤의 종류
-- 1. 사전에 정의된 롤
-- : 오라클 설치 시 시스템에서 기본적으로 제공됨
-- CONNECT ROLE
-- 시스템 권한 8가지를 묶어 놓음
-- CREATE SESSION, ALTER SESSION
-- CREATE TABLE, CREATE VIEW
-- CREATE SYNONYM, CREATE SEQUENCE
-- CREATE CLUSTER, CREATE DATABASE LINK

-- RESOURCE ROLE
-- : 사용자가 객체를 생성할 수 있도록 하는 권한을 묶어 놓음
-- CREATE CLUSTER, CREATE PROCEDURE
-- CREATE SEQUENCE, CREATE TABLE,
-- CREATE TRIGGER

-- 9버젼 이후에는 CONNECT, RESOURCE에 권한이 변경됨
-- CONNECT ROLE : CREATE SESSION 
-- RESOURCE : CREATE CLUSTER, CREATE PROCEDURE,
--            CREATE SEQUENCE, CREATE TABLE
--            CREATE TRIGGER, CREATE TYPE,
--            CREATE INDEXTYPE, CREATE OPERATOR

-- 2. 사용자가 정의하는 롤
-- : CREATE ROLE 명령으로 롤 생성
--   롤 생성은 반드시 DBA 권한이 있는 사용자만 할 수 있음
-- CREATE ROLE 롤이름;         -- 1. 롤생성
-- GRANT 권한종류 TO 롤이름;    -- 2. 생성된 롤에 권한 추가
-- GRANT 롤이름 TO 사용자이름;  -- 3. 사용자에게 롤 부여

-- 꼭 봐두도록 하세요
CREATE ROLE MYROLE;
GRANT CREATE SESSION, CREATE TABLE TO MYROLE;
GRANT MYROLE TO SAMPLE;

-- 꼭 봐두도록 하세요
-- 관리자 계정과 사용자 계정
-- 관리자계정 : 데이터베이스에 대한 생성과 관리를 담당하는 슈퍼유저(Super User)계정이며,
--             오브젝트(Object)의 생성, 변경, 삭제 등의 작업이 가능하다.
--             데이터베이스에 대한 모든 권한과 책임을 가지는 계정이다.
-- 사용자계정 : 데이터베이스에 대하여 질의(Query), 갱신, 보고서 작성 등의 작업을 수행하는 계정
--             일반 계정은 보안을 위하여 업무에 필요한 최소한의 권한을 가지는 것을
--             원칙으로 한다.
