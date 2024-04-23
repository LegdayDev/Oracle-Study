/* ==== DDL문 학습(CREATE, UPDATE, UPDATE, DROP/DELETE) ==== */
-- CREATE 문 : CREATE TABLE ~
CREATE TABLE DEPT_tmp AS
SELECT *
FROM DEPT d;
SELECT *
FROM DEPT_TMP;

-- UPDATE 문 : UPDATE SET ~
UPDATE DEPT_TMP
SET LOC='SEOUL'; -- 해당열 전체 수정

SELECT *
FROM DEPT_TMP;

-- 부서번호가 40인 부서명을 DATABASE 로 수정
UPDATE DEPT_TMP
SET DNAME = 'DATABASE'
WHERE DEPTNO = 40;

-- 부서명이 DATABASE 인 컬럼의 LOC를 BUSAN 으로 수정
UPDATE DEPT_TMP
SET LOC='BUSAN'
WHERE DNAME = 'DATABASE';
SELECT *
FROM DEPT_TMP;
-- UPDATE 문에 서브쿼리 적용
-- DEPT 테이블의 DEPTNO 가 40인 컬럼에서 DNAME, LOC 를 뽑아서 DEPT_TMP 의 DEPTNO 가 40인 컬럼 DNAME, LOC 변경
UPDATE DEPT_TMP
SET (DNAME, LOC) = (SELECT DNAME, LOC FROM DEPT WHERE DEPTNO = 40)
WHERE DEPTNO = 40;

-- DELETE 문 : DELETE FROM ~
-- 임의의 테이블 생성
CREATE TABLE EMP_TMP AS
SELECT *
FROM EMP;

-- 조건절이 없으면 모든 컬럼을 삭제 !!
-- JOB 이 SALESMAN 인 컬럼을 삭제
DELETE
FROM EMP_TMP
WHERE JOB = 'SALESMAN';

SELECT *
FROM EMP_TMP;
-- DELETE 문은 DML 문이다. DDL 문에서 삭제를 담당하는 것은 DROP 이다.
DROP TABLE EMP_TMP;

/* ==== Transaction 학습 ==== */
-- 학습용 테이블 생성
CREATE TABLE DEPT_TCL AS (SELECT *
                          FROM DEPT d);

-- 컬럼추가
INSERT INTO DEPT_TCL
VALUES (50, 'DATABASE', 'BUSAN');

-- 컬럼변경 : DEPTNO 40 번 컬럼 LOC 를 BUSAN 으로 변경
UPDATE DEPT_TCL
SET LOC='BUSAN'
WHERE DEPTNO = 40;

-- 컬럼삭제 : DNAME 이 RESEARCH 인 컬럼을 삭제
DELETE
FROM DEPT_TCL
WHERE DNAME = 'RESEARCH';

SELECT *
FROM DEPT_TCL;

-- COMMIT 이전으로 되돌린다.(auto commit을 끄면된다.)
ROLLBACK;

/* ==== VIEW ==== */

-- VIEW 생성
CREATE VIEW VM_EMP AS
(
SELECT EMPNO, ENAME, JOB, DEPTNO
FROM EMP
WHERE DEPTNO = 20);

-- VIEW 조회
SELECT *
FROM VM_EMP;

-- VIEW 삭제
DROP VIEW VM_EMP;

/* ==== 데이터 사전 ==== */

-- 사용가능한 데이터 사전
SELECT *
FROM DICT;

-- 현재계정(ADAM)이 가지고 있는 테이블 조회
SELECT TABLE_NAME
FROM USER_TABLES;

-- 현재 계정이 접속가능한 모든 테이블
SELECT OWNER, TABLE_NAME
FROM ALL_TABLES;

-- 관리권한을 가진 사용자만 접근  가능한 테이블
SELECT *
FROM DBA_TABLES;

/* ==== 시퀀스 ==== */

-- 학습용 테이블 생성
-- 1<>1 은 빈 결과 집합을 반환
CREATE TABLE DEPT_SEQ AS (SELECT *
                          FROM DEPT
                          WHERE 1 <> 1);
-- 시퀀스 생성
CREATE SEQUENCE SEQ_DEPT_SEQUENCE
    INCREMENT BY 10 -- 증가 값
    START WITH 10 -- 시작 값
    MAXVALUE 90 -- 최대 값
    MINVALUE 0 -- 최소 값
    NOCYCLE
    CACHE 2;

-- 시퀀스 조회
SELECT *
FROM USER_SEQUENCES;

-- 시퀀스이름.NEXTVAL
INSERT INTO DEPT_SEQ (DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPT_SEQUENCE.NEXTVAL, 'DATABASE', 'BUSAN');

INSERT INTO DEPT_SEQ (DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPT_SEQUENCE.NEXTVAL, 'DATABASE1', 'SEOUL');

SELECT *
FROM DEPT_SEQ
ORDER BY DEPTNO;

-- 시퀀스 수정
ALTER SEQUENCE SEQ_DEPT_SEQUENCE INCREMENT BY 3 MAXVALUE 99 CYCLE;

-- 시퀀스 삭제
DROP SEQUENCE SEQ_DEPT_SEQUENCE;

/* ==== DDL ==== */

-- CREATE 문 : 테이블 생성
CREATE TABLE EMP_DDL
(
    EMPNO    NUMBER(4),
    ENAME    VARCHAR2(10),
    JOB      VARCHAR2(9),
    MGR      NUMBER(4),
    HIREDATE DATE,
    SAL      NUMBER(7, 2),
    COMM     NUMBER(7, 2),
    DEPTNO   NUMBER(2)
);

-- 원본의 일부만 복사해서 테이블 생성
CREATE TABLE EMP_DDL1 AS
SELECT *
FROM EMP
WHERE DEPTNO = 30;

-- 원본 테이블의 빈컬럼을 복사하여 생성
CREATE TABLE EMP_DDL2 AS
SELECT *
FROM EMP
WHERE 1 <> 1;

-- ALTER 문 : 테이블을 수정
-- 컬럼 추가 : ALTER TABLE 테이블명 ADD 컬럼명 컬럼속성
ALTER TABLE EMP_DDL1
    ADD HP VARCHAR2(20);

-- 컬럼명 수정 : ALTER TABLE 테이블명 RENAME COLUMN 컬럼명 TO 바꿀컬럼명
ALTER TABLE EMP_DDL1 RENAME COLUMN HP TO TEL;

-- 컬럼 타입 변경 : ALTER TABLE 테이블명 MODIFY 컬럼명 컬럼속성
ALTER TABLE EMP_DDL1
    MODIFY EMPNO NUMBER(10);

-- 컬럼 삭제 : ALTER TABLE 테이블명 DROP COLUMN 컬럼명
ALTER TABLE EMP_DDL1
    DROP COLUMN TEL;

SELECT *
FROM EMP_DDL1;

-- TRUNCATE 문 : 전체 데이터 삭제(테이블 초기상태로 만듬)
TRUNCATE TABLE EMP_DDL1;

-- DROP 문 : 테이블 삭제
DROP TABLE EMP_DDL1;
DROP TABLE EMP_DDL2;
DROP TABLE EMP_DDL;

/* ==== 제약 조건 ==== */

-- NOT NULL 제약조건
CREATE TABLE TBL_EX
(
    LOGIN_ID VARCHAR2(20) NOT NULL, -- NOT NULL 제약조건 추가
    LOGIN_PW VARCHAR2(20) NOT NULL, -- NOT NULL 제약조건 추가
    TEL      VARCHAR2(20)
);

INSERT INTO TBL_EX
VALUES ('ADMIN', '1234', '010-7777-7777');

INSERT INTO TBL_EX(LOGIN_ID, LOGIN_PW)
VALUES ('ADMIN2', '567');

-- INSERT INTO TBL_EX
-- VALUES ('ADMIN', '010-7777-7777'); NOT NULL 제약조건 위배

-- NOT NULL 제약조건 추가할 때 해당 컬럼에 NULL 이 있으면 안된다.
-- ALTER TABLE TBL_EX
--     MODIFY TEL NOT NULL;

UPDATE TBL_EX
SET TEL = '010-1234-1234'
WHERE LOGIN_ID = 'ADMIN2';

-- UNIQUE 제약조건
CREATE TABLE TBL_UNIQ
(
    LOGIN_ID VARCHAR(20) UNIQUE,
    LOGIN_PW VARCHAR(20) NOT NULL,
    TEL      VARCHAR(20)
);

-- PRIMARY KET 제약조건
CREATE TABLE TBL_UNIQ2
(
    LOGIN_ID VARCHAR(20) PRIMARY KEY,
    LOGIN_PW VARCHAR(20) NOT NULL,
    TEL      VARCHAR(20)
);

-- 제약조건 확인 명령어
SELECT OWNER, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS;

/* ==== CHECK ==== */

CREATE TABLE TBL_CHK
(
    LOGIN_ID VARCHAR2(20)
        CONSTRAINT TBLCK_LOGINID_PK PRIMARY KEY,                  -- PK 제약조건
    LOGIN_PW VARCHAR2(20)
        CONSTRAINT TBLCK_LOGINPW_CK CHECK (LENGTH(LOGIN_PW) > 3), -- LOGIN_PW 컬럼의 크기를 체크
    TEL      VARCHAR(20)
);

SELECT *
FROM EMP;
SELECT *
FROM DEPT;
/* ==== 문제 ==== */
-- 1. EMP 테이블에서 사원번호가 7521인 사원의 직업과 같고, 사원번호가 7934인 사원의 급여보다 많은 사원의 사번, 이름 , 직업, 급여를 출력
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE JOB = (SELECT JOB FROM EMP WHERE EMPNO = 7521)
  AND SAL > (SELECT SAL FROM EMP WHERE EMPNO = 7934);

-- 2. 직업별로 최소 급여를 받는 사원의 정보를 사원번호, 이름, 업무, 부서명으로 출력하시오(직업별 내림차순)
SELECT e.EMPNO, e.ENAME, e.JOB, d.DNAME
FROM EMP e
         INNER JOIN DEPT d ON e.deptno = d.DEPTNO
WHERE (e.JOB, e.SAL) IN (SELECT JOB, MIN(SAL)
                         FROM EMP
                         GROUP BY JOB)
ORDER BY JOB DESC;

-- 3. 각 사원별 커미션(COMM)이 0 또는 NULL 이고 부서 위치가 'GO'로 끝나는 사원의 정보를 사원번호, 사원이름, 커미션, 부서번호, 부서명, 부서위치를 출력하시오(커미션이 NULL 이면 0으로 출력)
SELECT e.EMPNO, e.ENAME, DECODE(e.COMM, NULL, 0, e.COMM) AS COMM, e.DEPTNO, d.DNAME, d.LOC
FROM EMP e
         INNER JOIN DEPT d ON e.DEPTNO = d.DEPTNO
WHERE d.LOC LIKE '%GO';