/* ==== NULL 처리 내장함수 ==== */
-- NVL(col , val) : col 이 NULL 이면 val으로 대체한다.
SELECT NVL(COMM, 0)
FROM EMP;

-- NVL2(col1, col2, val) : col1 이 NULL 이 아니면 col2 로 출력, NULL 이면 0으로 대체
SELECT NVL2(COMM, COMM * 1.1, 0)
FROM EMP;

/* ==== 조건함수 ==== */
-- DECODE 함수는 조건식(IF)와 같다.
-- DECODE(col, search1, result1, search2, result2, ... default) : col 의 조건이 search1 이면 resul1, 조건이 다 안맞으면 default 로 변환
SELECT EMPNO,
       ENAME,
       JOB,
       SAL,
       DECODE(JOB, 'MANAGER', SAL * 1.1, 'SALESMAN', SAL * 1.05, 'ALALYST', SAL, SAL * 1.03) AS UP_SAL
FROM EMP;
SELECT *
FROM BONUS;

-- CASE함수 : DECODE 와 마찬가지로 조건식이지만 DECODE 보다 성능이 좋다.
SELECT EMPNO,
       ENAME,
       JOB,
       SAL,
       CASE JOB
           WHEN 'MANAGER' THEN SAL * 1.1
           WHEN 'SALESMAN' THEN SAL * 1.5
           WHEN 'ALALYST' THEN SAL
           ELSE SAL * 1.03
           END AS UP_SAL
FROM EMP;

-- 행 제한하기 : EMP 테이블의 14개의 row 를 나눠서 출력하기
SELECT ROWNUM,
       EMPNO,
       ENAME,
       JOB,
       MGR,
       HIREDATE,
       SAL,
       COMM,
       DEPTNO
FROM EMP
WHERE ROWNUM < 6;

SELECT *
FROM (SELECT ROWNUM AS NUM,
             EMPNO,
             ENAME,
             JOB,
             MGR,
             HIREDATE,
             SAL,
             COMM,
             DEPTNO
      FROM EMP)
WHERE NUM BETWEEN 6 AND 10;

SELECT *
FROM (SELECT ROWNUM AS NUM,
             EMPNO,
             ENAME,
             JOB,
             MGR,
             HIREDATE,
             SAL,
             COMM,
             DEPTNO
      FROM EMP)
WHERE NUM BETWEEN 11 AND 14;

-- DBMS_RANDOM.VALUE(1,5)-8

/* ==== 다중함수(집계함수) ==== */
-- SUM , MIN, MAX, COUNT, AVG 가 있다.

-- COUNT(col) : 테이블에서 col 의 갯수를 카운팅하여 반환
SELECT COUNT(ENAME)
FROM EMP;

-- COUNT() 함수는 NULL 값을 제외하고 카운팅한다!!
SELECT COUNT(COMM)
FROM EMP;

-- 문제 : EMP 테이블에서 부서번호가 30일 직원수를 계산
SELECT COUNT(EMPNO)
FROM EMP
WHERE DEPTNO = 30;

-- SUM(col) : col 의 정수형 데이터의 합을 출력
SELECT SUM(COMM)
FROM EMP;

SELECT SUM(SAL)          AS 중복포함_전체,
       SUM(DISTINCT SAL) AS 중복제거,
       SUM(ALL SAL)      AS 중복포함_전체
FROM EMP;

-- MAX(col), MIN(col) : col 컬럼의 정수형 데이터 최대,최소값을 출력
SELECT MAX(SAL), MIN(SAL)
FROM EMP
WHERE DEPTNO = 10;

-- 문제 : 20번 부서에서 신입과 최고참의 입사일
SELECT MAX(HIREDATE) AS 신입_입사일, MIN(HIREDATE) AS 최고참_입사일
FROM EMP
WHERE DEPTNO = 20;

-- 문제 : 30번 부서에 월급 평ㄱ윤
SELECT ROUND(AVG(SAL))
FROM EMP
WHERE DEPTNO = 30;

-- 각 부서의 평균월급
SELECT '10' 부서명, ROUND(AVG(SAL)) 평균월급
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT '20' 부서명, ROUND(AVG(SAL)) 평균월급
FROM EMP
WHERE DEPTNO = 20
UNION
SELECT '20' 부서명, ROUND(AVG(SAL)) 평균월급
FROM EMP
WHERE DEPTNO = 30;

/* ==== GROUP BY : 그룹화 ==== */
-- GROUP BY : 컬럼을 그룹별로 묶어준다.
SELECT DEPTNO, JOB, AVG(SAL) AS 월급평균
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

-- Group By 에 조건식이 필요하면 where 이 아닌 having 을 사용.
-- WHERE 절에는 집계함수를 사용할 수 없다.
-- 부서번호와 직업별로 그룹화한뒤 월급의 평균이 2000 이상인 데이터를 출력
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
HAVING AVG(sal) >= 2000
ORDER BY DEPTNO, JOB;

/* ==== JOIN ==== */

-- Oracle 조인
-- 두 개의 테이블의 같은 컬럼을 WHERE 절에 적어주면 INNER JOIN 이 된다.
-- 별칭을 사용하는게 편함.
SELECT e.EMPNO, e.ENAME, d.DEPTNO, d.DNAME
FROM EMP e,
     DEPT d
WHERE e.DEPTNO = d.DEPTNO;

SELECT e.EMPNO, e.ENAME, d.DEPTNO, d.DNAME
FROM EMP e,
     DEPT d
WHERE e.DEPTNO = d.DEPTNO
ORDER BY d.DEPTNO, e.DEPTNO;
-- 등가조인(일치하는 열이 있는 경우)

-- JOIN 후 조건절도 가능하다.
SELECT e.EMPNO, e.ENAME, d.DEPTNO, d.DNAME, SAL
FROM EMP e,
     DEPT d
WHERE e.DEPTNO = d.DEPTNO
  AND SAL >= 3000;

SELECT *
FROM EMP e,
     SALGRADE s
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL;

-- OUTTER JOIN : NULL 값을 출력하기 위한 JOIN
SELECT e.EMPNO, e.ENAME, e.MGR, e2.EMPNO, e2.ENAME, e2.MGR
FROM EMP e,
     EMP e2
WHERE e.mgr = e2.empno(+)
ORDER BY e.EMPNO;

-- 위 JOIN 방법은 Oracle DB에서만 해당하는 JOIN 방법이다.
-- ANSI 표준 방법을 쓰면 웬만한 DB에서 다 사용할 수 있다.

-- INNER JOIN : ON 키워드를 통해 공통컬럼을 지정한다.
SELECT e.EMPNO, e.ENAME, d.DEPTNO, d.DNAME, SAL
FROM EMP e
         INNER JOIN DEPT d
                    ON e.DEPTNO = d.DEPTNO
WHERE SAL >= 3000
ORDER BY d.DEPTNO, e.empno;

/*
 OUTTER JOIN : INNER JOIN 과 다르게 공통 컬럼이 아닌 행까지 모두 출력한다
 Driving 테이블 기준에 따라 LEFT OUTER JOIN, RIGHT OUTER JOIN 으로 나뉜다.
 Driving Table : JOIN실행 시 가장 먼저 엑세스 되서 AccessPath를 주도하는 테이블
 Driven Table : JOIN실행 시 나중에 엑세스 되는 테이블
 */
SELECT e.EMPNO,
       e.ENAME,
       e.MGR,
       e2.EMPNO AS MEG_EMPNO,
       e2.ENAME AS MGR_ENAME
FROM EMP e
         LEFT OUTER JOIN EMP e2 ON (e.mgr = e2.empno);

-- FULL OUTER JOIN : 모든 열이 출력
SELECT e.EMPNO,
       e.ENAME,
       e.MGR,
       e2.EMPNO AS MEG_EMPNO,
       e2.ENAME AS MGR_ENAME
FROM EMP e
         FULL OUTER JOIN EMP e2 ON (e.MGR = e2.EMPNO);

/* ==== 서브쿼리 ==== */

SELECT *
FROM (SELECT ROWNUM, e.* FROM EMP e)
WHERE ROWNUM BETWEEN 1 AND 5;

SELECT *
FROM (SELECT ROWNUM AS num, e.* FROM EMP e)
WHERE num BETWEEN 6 AND 10;

-- 문제 : 급여를 내림차순으로 정렬한 다음 상위 5명 정보 출력
SELECT *
FROM (SELECT * FROM EMP ORDER BY SAL DESC)
WHERE ROWNUM < 6;

-- 문제 : SCOTT 보다 높은급여
SELECT *
FROM EMP
WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'SCOTT');

-- 문제 : 평균월급 이상
SELECT *
FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP);

-- 문제 : 'ALLEN'의 추가수당보다 높은 추가수당을 받는사람
SELECT *
FROM EMP
WHERE COMM > (SELECT COMM FROM EMP WHERE ENAME = 'ALLEN');

/* ==== 문제 풀기 ==== */
-- 1. EMP 테이블에서 부서 인원이 4명보다 많은 부서의 부서번호, 인원수, 급여의 합
SELECT DEPTNO, COUNT(DEPTNO) AS 부서인원, SUM(SAL) 총급여
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(DEPTNO) > 4;

-- 2. EMP 테이블에서 가장 많은 사원이 속해있는 부서번호와 사원수를 출력하라
SELECT DEPTNO, 사원수
FROM (SELECT DEPTNO, COUNT(EMPNO) AS 사원수
      FROM EMP
      GROUP BY DEPTNO
      ORDER BY 사원수 DESC)
WHERE ROWNUM <= 1;

-- 3. EMP 테이블에서 가장 많은 사원을 갖는 MGR 의 사원번호를 출력하라
SELECT MGR
FROM (SELECT MGR, COUNT(EMPNO) AS 사원수
      FROM EMP
      GROUP BY MGR
      ORDER BY 사원수 DESC)
WHERE ROWNUM <= 1;

-- 4. EMP 테이부서블에서 부서번호가 10인 사원수와 번호가 30일 사원수를 각각 출력하라
SELECT COUNT(DECODE(DEPTNO, 10, 0)) 부서번호_10_사원수, COUNT(DECODE(DEPTNO, 30, 0)) 부서번호_30_사원수
FROM EMP;