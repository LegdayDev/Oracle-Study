/* ==========================내장함수 학습========================== */
-- UPPER(column) , LOWER(column) : column 을 대문자/소문자로 변환시켜준다.
SELECT ENAME, LOWER(ENAME)
FROM EMP;


-- INITCAP(columne) : 첫글자만 대문자 나머지는 소문자로 출력
SELECT ENAME, INITCAP(ENAME)
FROM EMP;

-- LENGTH() : 컬럼 길이를 출력
SELECT ENAME, LENGTH(ENAME)
FROM EMP;

-- 문제 : 사원명이 5글자 이상인 사원 출력
SELECT *
FROM EMP
WHERE LENGTH(ENAME) >= 5;

-- LENGTHB() : 컬럼의 바이트 크기를 구한다.
SELECT LENGTH('오라클') 길이, LENGTHB('오라클') 바이트크기
FROM DUAL;

-- SUBSTR(column, start_index, len): 문자열의 일부를 추출하는 함수
-- column 에서 start_index 부터 len 길이만큼 잘라서 출력한다.(참고로 SQL 에서는 시작 인덱스가 1이다.)
-- SUBSTR(column, index) : column 에서 5번쨰 인덱스를 출력한다.
SELECT SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5)
FROM EMP;

-- 문제 : SUBSTR() 함수를 사용해서 모든 사원의 이름을 세번째부터 출력
SELECT ENAME, SUBSTR(ENAME, 3, LENGTH(ENAME) - 2)
FROM EMP;

-- INSTR() : 특정 문자의 위치를 찾는 함수(없다면 0을 반환)
SELECT ENAME, INSTR(ENAME, 'A')
FROM EMP;

SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR_EX, INSTR('HELLO, ORACLE!', 'L') AS INSTR_EX2
FROM DUAL;

-- 문제 : 사원이름중에 'S' 가 들어있는 사원 정보 출력(LIKE 또는 INSTR() 사용)
SELECT *
FROM EMP
WHERE ENAME LIKE '%S%';

SELECT *
FROM EMP
WHERE INSTR(ENAME, 'S') != 0;

-- REPLACE() : 문자를 변환하는 함수
-- REPLACE(str, find, change) : str 문자열에서 find 단어를 change 단어로 교체
SELECT '010-1234-5678' AS 전화번호, REPLACE('010-1234-5678', '-', ' ') AS "하이픈(-)이 없는 전화번호"
FROM DUAL;

-- LPAD() , RPAD() : 빈 공간을 메꿔주는 함수
-- LPAD(STR, 10, '#') : STR 왼쪽을 #으로 총 10글자가 되도록 채운다.
SELECT 'ORACLE' AS             "기본문자열",
       LPAD('ORACLE', 10, '#') LAPD1,
       RPAD('ORACLE', 10, '#') RPAD1,
       LPAD('ORACLE', 10)      LPAD2,
       RPAD('ORACLE', 10)      RPAD2
FROM DUAL;

-- 주민번호, 전화번호의 끝에 7자리, 4자리를 * 처리
SELECT RPAD('970327-', 14, '*') AS 주민번호
FROM DUAL;
SELECT RPAD('010-1234-', 13, '*') AS 전화번호
FROM DUAL;

-- TRIM() , RTRIM(), LTRIM() : 특정문자나 공백을 지워주는 함수
SELECT '[' || TRIM(' __ORACLE__ ') || ']' AS TRIN
FROM DUAL;

-- 왼쪽 공백을 삭제
SELECT '[' || TRIM(LEADING FROM ' __ORACLE__ ') || ']' AS TRIM_READING
FROM DUAL;

-- 오른쪽 공백을 삭제
SELECT '[' || TRIM(TRAILING FROM ' __ORACLE__ ') || ']' AS TRIM_TRAILING
FROM DUAL;

-- 양쪽 공백을 삭제
SELECT '[' || TRIM(BOTH FROM ' __ORACLE__ ') || ']' AS TRIM_BOTH
FROM DUAL;

-- ROUND() : 반올림 함수
-- ROUND(value, n) : n 번째 자리에서 반올림한다.(n 이 음수면 소수점 왼쪽에서 카운팅해서 반올림한다)
SELECT ROUND(1234.5678), ROUND(1234.5678, 2), ROUND(1234.5678, 3), ROUND(1238.5678, -1)
FROM DUAL;

-- TRUNC() : 버림 함수
-- TRUNC(value, n) : ROUND() 와 마찬가지로 n 번째 자리에서 버린다(음수는 소수 왼쪽부터 카운팅해서 버린다)
SELECT TRUNC(1234.5678), TRUNC(1234.5678, 1), TRUNC(1234.5678, -1)
FROM DUAL;

-- MOD() : 나머지를 구하는 함수
-- MOD(A,B) : A 를 B로 나눈 나머지를 반환한다.(소수도 가능)
SELECT MOD(3, 2), MOD(10.23, 5.21)
FROM DUAL;

-- 문제 : 각 사원별 시급을 계산하여 부서번호, 사원명, 시급을 출력
-- 조건 : 한달 근무는 하루 8시간 20일씩 , 부서별로 오름차순, 시급은 소수2자리, 시급이 높은순으로
SELECT DEPTNO, ENAME, ROUND((SAL / 8) / 20, 1) AS 시급
from EMP
ORDER BY DEPTNO ASC, 시급 DESC;

/* ==========================집합연산자 학습========================== */
-- 집합연산자 학습
-- UNION : 두개의 테이블을 합친다.(단, 행의 갯수가 맞아야한다.)
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 20;

-- MINUS : 차집합
-- 전체 데이터에서 부서번호가 10번인 데이터를 뺀 나머지를 조회
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;

-- INTERSECT : 교집합
-- 전체 데이터에서 부서번호가 10번인 교집합 데이터를 출력
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;

/* ==========================날짜함수 학습========================== */
-- SYSDATE : 현재 시간을 의미한다.(-1 하면 하루전, +1 은 내일을 뜻함)
SELECT SYSDATE AS NOW, SYSDATE - 1 AS YESTERDAY, SYSDATE + 1 AS TOMORROW
FROM DUAL;

-- ADD_MONTHS() : 현재 달의 추가
SELECT SYSDATE AS NOW, ADD_MONTHS(SYSDATE, 3) AS 석달후
FROM DUAL;

-- 문제 : 입사 10주년이 되는 사원들 출력
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 120) AS 입사_10주년_날짜
FROM EMP;

-- MONTHS_BETWEEN(A, B) : A 날짜와 B 날짜의 개월차를 반환한다.(소수점으로 나온다)
SELECT EMPNO, ENAME, HIREDATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE))
FROM EMP;

-- NEXT_DAY(SYSDATE, '월') : SYSDATE 의 바로 다음에 오는 날짜
-- LAST_DAY() : 해당 날짜가 속한 달의 마지막 날
SELECT SYSDATE, NEXT_DAY(SYSDATE, '월'), LAST_DAY(SYSDATE)
FROM DUAL;

/* ==========================형변환함수 학습========================== */
-- 암묵적 형변환 : 컬럼에서 숫자+문자 를 실행하면 Oracle 에서 자동으로 정수로 형변환하여 500이 더해진다.
SELECT EMPNO, ENAME, EMPNO + '500' AS 암묵적_형변환
FROM EMP
WHERE ENAME = 'SCOTT';

-- 문자 'ABCD'를 암묵적 형변환에 의해 숫자로 변경되면 잘못된 수치기 때문에 에러가 뜬다
/* 수치 에러 !!
   SELECT 'ABCD' + EMPNO, EMPNO
   FROM EMP
   WHERE ENAME = 'SCOTT';
*/

-- 암묵적 형변환의 반대로는 명시적 형변환이 있다.
-- 명시적 형변환이란 사용자가 강제로 형변환을 한 것을 말한다.

/* 명시적 형변환 함수 종류
   TO_CHAR() : 숫자 또는 날짜 데이터를 문자 데이터로 변환
   TO_NUMBER() : 문자 또는 날짜 데이터를 숫자 데이터로 변환
   TO_DATE() : 문자 또는 숫자 데이터를 날짜 데이터로 변환
*/

-- TO_CHAR(date, format) : 날짜를 형식에 맞게 바꿔서 출력
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') AS 현재날짜시간
FROM DUAL;
/* format 종류
   CC : 세기
   YYYY : 연도
   YY : 연도(뒤 2자리)
   MM : 월
   MON : 월(약어)
   MONTH : 월(전체)
   DD : 일
   DDD : 365일
   DY : 요일(약어)
   DAY : 풀어
   W : 주
   HH24 : 24시간
   HH/HH12 : 12시간
   MI : 분
   SS : 초
   AM/PM/A.M/P.M : 오전/오후
*/

-- 현재시간(SYSDATE)에서 월로 형변환하여 출력
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'MM')    AS MM,
       TO_CHAR(SYSDATE, 'MON')   AS MON,
       TO_CHAR(SYSDATE, 'MONTH') AS MONTH,
       TO_CHAR(SYSDATE, 'DD')    AS DD,
       TO_CHAR(SYSDATE, 'DY')    AS DY,
       TO_CHAR(SYSDATE, 'DAY')   AS DAY
FROM DUAL;

-- 언어를 설정하여 달을 각 국가에 맞춰서 출력
SELECT SYSDATE                                                  AS 현재시간,
       TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN')    AS MON_K,
       TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE')  AS MON_J,
       TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH')   AS MON_E,
       TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = KOREAN')  AS MONTH_K,
       TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH') AS MONTH_E
FROM DUAL;

-- 시간표시
SELECT SYSDATE                           AS 현재시간,
       TO_CHAR(SYSDATE, 'HH24:MI:SS')    AS HH24MISS,
       TO_CHAR(SYSDATE, 'HH12:MI:SS AM') AS HHMISS_AM,
       TO_CHAR(SYSDATE, 'HH:MI,SS P.M.') AS HHMISS_PM
FROM DUAL;

-- 문자 데이터 -> 날짜 데이터로 출력
SELECT TO_DATE('2019-04-04', 'YYYY-MM-DD') AS TO_DATE,
       TO_DATE('20100301', 'YYYY-MM-DD')   as TO_DATE2
FROM DUAL;

-- 문제 : 1981년 12월 1일 이후에 입사한 사원 정보 출력
SELECT *
FROM EMP
WHERE HIREDATE >= TO_DATE('1981-12-01', 'YYYY-MM-DD');