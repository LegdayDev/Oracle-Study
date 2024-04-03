-- SELECT 문 연습

-- 전체 컬럼 조회
SELECT *
FROM emp;

-- 특정 컬럼 조회(사원번호, 사원명, 월급)
SELECT EMPNO, ENAME, SAL
FROM emp;

-- 컬럼에 별칭(alias)을 사용 : AS
-- 별칭에 공백이 있으면 "" 로 묶어줘야 한다.
SELECT ENAME AS 사원명, SAL AS 월급
FROM emp;

-- AS 생략 가능
SELECT ENAME 사원명, SAL 월급
FROM emp;

-- 사원번호, 사원이름, 월급, 연봉을 구하고 컬럼명은 "사원번호" , "사원이름", "월급", "연봉" 으로 출력
SELECT EMPNO as 사원번호, ENAME as 사원이름, SAL as 월급, (SAL * 12) as 연봉
From EMP;

-- 특정컬럼 중복을 제거 : DISTINCT
SELECT DISTINCT JOB
FROM EMP;

SELECT ALL JOB, DEPTNO
FROM EMP;

-- 가상의 테이블 : DUAL
SELECT 'RONALDO'
FROM dual;

-- 컬럼명에 연산이 들어가면 결과값이 행에 출력
SELECT 2 + 3
FROM DUAL;
SELECT 'ABC', 2 + 3
FROM DUAL;

-- 연산결과 별칭을 주면 결과값을 행에 출력하고 컬럼명은 별칭
SELECT 2 + 3 AS RESULT
FROM DUAL;
SELECT 5 * 5 AS VIVID
FROM DUAL;

-- 숫자와 문자가 연산이 되면 숫자로 타입이 정해진다.
SELECT 1 + '5'
FROM DUAL;
SELECT '1' + '5'
FROM DUAL;

-- 문자의 연결은 || 를 사용
SELECT 1 || '5'
FROM DUAL;

-- 사원명과 업무로 연결(SMITH, CLERK) 표시 컬럼명은 EMPLOYEE AND JOB
SELECT '(' || ENAME || ', ' || JOB || ')' AS "EMPLOYEE AND JOB"
FROM EMP;

-- 사원별 연간 총수입을 나타내시오(별칭은 연간총수입)
SELECT ENAME, SAL * 12 + COMM AS 연간총수입
FROM emp;
-- NULL 값 때문에 데이터가 제대로 안나옴
-- NULL 값은 0으로 계산하고 더한다.
SELECT ENAME,
       CASE
           WHEN COMM IS NULL THEN (SAL + 0)
           ELSE (SAL + COMM) end as 연간총수입
FROM emp;

-- 정렬 : ODER BY 컬럼명
-- 디폴트 값은 오름 차순(ASC)§
SELECT *
FROM EMP
ORDER BY SAL;
-- 내림차순은 DESC
SELECT *
FROM EMP
ORDER BY SAL DESC;

-- WHERE 절 : 데이터 조회시 조건을 걸어야 할 때 쓰인다.
SELECT *
FROM EMP
WHERE EMPNO = 7839;

-- 사번이 7698인 사원명과 업무, 급여를 출력
SELECT ENAME, JOB, SAL
FROM EMP
WHERE EMPNO = 7698;

-- SMITH 의 사원명, 부서, 월급
SELECT ENAME, JOB, SAL
FROM EMP
WHERE ENAME = 'SMITH';

-- 월급이 3000 이 아닌 사람 : !=
SELECT *
FROM EMP
WHERE SAL != 3000;

-- 월급이 5000이 아닌 사람 : <>(ANSI 표준)
SELECT *
FROM EMP
WHERE SAL <> 5000;

-- 월급이 6000이 아닌 사람 : NOT
SELECT *
FROM EMP
WHERE NOT SAL = 6000;

-- 문자비교도 가능, 첫 글자를 기준
SELECT *
FROM EMP
WHERE ENAME >= 'M';

-- 월급이 2500 이상 3000 미만의 사원,입사일,월급 출력
SELECT ENAME, HIREDATE, SAL
FROM EMP
where SAL >= 2500
  AND SAL < 3000;

-- 월급이 2000 이상 3000 이하가 아닌 사원,입사일,월급 출력
SELECT ENAME, SAL, HIREDATE
FROM EMP
WHERE NOT SAL >= 2000
  AND SAL <= 3000;

-- BETWEEN 연산자 : 컬럼명 BETWEEN 100 AND 200 -> 100과 200사이의 데이터(이상,이하)
SELECT *
FROM EMP
WHERE SAL BETWEEN 2500 AND 3000;

-- 81년 5월 1일과 81년 12월 3일 사이에 입사사원을 출력
SELECT ENAME, SAL, HIREDATE
FROM EMP
WHERE HIREDATE BETWEEN '1981-05-01' AND '1981-12-3';
-- TO_DATE() 를 사용하여 날짜 비교
SELECT ENAME, SAL, HIREDATE
FROM EMP
WHERE HIREDATE BETWEEN TO_DATE('19810501', 'YYYYMMDD') and TO_DATE('19811203', 'YYYYMMDD');

-- 1987년도 입사한 사원명, 월급, 입사날짜를 출력
SELECT ENAME, SAL, HIREDATE
FROM EMP
WHERE HIREDATE BETWEEN TO_DATE('19810101', 'YYYYMMDD') and TO_DATE('19811231', 'YYYYMMDD');

-- 여러 조건을 충족 시켜야 할 때 : 컬럼명 IN(조건1, 조건2, ....)
SELECT ENAME, JOB, SAL
FROM EMP
WHERE JOB IN ('MANAGER', 'CLERK', 'SALESMAN');

-- 반대는 NOT IN()
-- 사원번호가 7566, 7782, 7934 인 사원을 제외한 사원번호, 사원명, 월급을 출력
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO NOT IN (7566, 7782, 7934);

-- 부서번호가 30이고, 월급이 2000 이하를 받는 81년 5월 1일 이전에 입사한 사원의 이름,급여,부서번호,입사일 출력
SELECT ENAME, SAL, DEPTNO, HIREDATE
FROM EMP
WHERE DEPTNO = 30
  AND SAL <= 2000
  AND HIREDATE < TO_DATE('19810501', 'YYYYMMDD');

-- 부서번호가 10 또는 30인 사원이 월급이 2000 ~ 5000 사이의 사원명, 급여, 부서번호
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN (10, 30)
  AND SAL BETWEEN 2000 AND 5000;

-- JOB 이 MANAGER 또는 SALESMAN 이고 급여가 1600, 2975, 2850이 아닌 사원명, 입사일, 급여, 부서번호 출력
SELECT ENAME, JOB, HIREDATE, SAL, DEPTNO
FROM EMP
WHERE JOB IN ('MANAGER', 'SALESMAN')
  AND SAL NOT IN (1600, 2975, 2850);

/* ================================================================================= */
-- 특정 키워드를 찾을 때는 LIKE 를 사용
-- S% : S 로 시작되는 모든 문자
SELECT *
FROM EMP
WHERE ENAME LIKE 'S%';

-- _는 한글자를 의미한다. _L% 은 두번쨰 글자에 L이 오는 모든 문자
SELECT *
FROM EMP
WHERE ENAME LIKE '_L%';

-- 1) 사원이름 중에 'S' 가 포합되지 않는 부서번호가 20인 사원의 이름, 부서번호, 조회
SELECT ENAME, DEPTNO
FROM EMP
WHERE ENAME NOT LIKE '%S%'
  AND DEPTNO = 20;

-- 2) 입사일이 1981.06.01 ~ 1981.12.31 입사자 중 부서명이 30인 사원의 부서번호, 사원명, 직업 입사일 조회(입사일 오름차순)
SELECT DEPTNO, ENAME, JOB, HIREDATE
FROM EMP
WHERE HIREDATE BETWEEN TO_DATE('19810601', 'YYYYMMDD') AND TO_DATE('19811231', 'YYYYMMDD')
  AND DEPTNO = 30
ORDER BY HIREDATE ASC;