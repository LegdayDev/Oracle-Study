## 3일차 학습

### 목차
> 1. 내장함수 학습
> 2. 관계연산자 학습
> 3. 날짜 함수 학습
> 4. 형 변환 함수 학습
---

### 1. 내장함수 학습
> 오라클 내장함수는 `단일행 함수`, `집계 함수`, `분석 함수` 가 있다.
1. [단일행 함수](https://docs.oracle.com/database/121/SQLRF/functions002.htm#SQLRF51178) : 하나의 데이터를 이용하여 변환 또는 계산을 수행
2. [집계 함수](https://docs.oracle.com/database/121/SQLRF/functions003.htm#SQLRF20035) : 데이터를 집계하여 계산 처리를 수행하는 함수
3. [분석 함수](https://docs.oracle.com/database/121/SQLRF/functions004.htm#SQLRF06174) : 행 그룹을 기반으로 집계 값을 계산


| 함수명                    | 설명                                 |
|------------------------|------------------------------------|
| `UPPER(column) `         | column 을 대문자로 변환                   |
| `LOWER(column)`          | column 을 소문자로 변환                   |
| `INITCAP(column)`        | column 첫 글자를 대문자로 변환 나머지는 소문자      |
| `LENGTH(column)`         | column 의 길이를 반환한다                  |
| `LENGTHB(column)`        | column 의 Byte 크기를 반환한다             |
| `SUBSTR(column, i, len)` | column 의 i번째 부터 len 만큼의 길이를 잘라서 반환 |
| `REPLACE(column, a, b)`  | column 에서 a를 찾아 b로 교체한다            |
| `LPAD(column, len, a)`   | column 을 len 길이만큼 왼쪽에 a를 채운다.|
| `RPAD(column, len, b)`   | LPAD 와 반대로 오른쪽부터 b 를 채운다.|
| `TRIM(column)`           | column 의 양쪽 공백을 지워준다.|
| `LTRIM(column, a)`       | column 의 왼쪽에 있는 a를 전부제거(값이 없으면 공백제거)|
| `RTRIM(column, a)`       | LTRIM() 과 반대로 오른쪽부터 제거|
| `ROUND(value, n)`        | value 의 n 번째 소수점자리에서 반올림한다(n이 음수면 자연수 1의 자리부터)|
| `TRUNC(value, n)`        | value 의 n 번쨰 자리부터 버린다|
| `MOD(a, b)`              | a 를 b 로 나눈 나머지를 반환한다|

---
### 2. 집합연산자 학습
> 집합 연산자의 종류로는 `UNION` , `UNION ALL` , `INTERSECT` , `MINUS`  이 있다.

- `UNION` : **합집합**을 의미하며, ***두 개의 데이터 집합이 있으면 각 집합 원소(SELECT 결과)를 모두 포함***한 결과가 반환된다.
    ```sql
    SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE DEPTNO = 10
    UNION
    SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE DEPTNO = 20;
    ```
- `UNION ALL` : UNION 과 같지만 ***중복을 허용하지 않기 때문에 중복컬럼을 제외하고 합집합을 계산***한다.
- `MINUS` : **차집합**을 의미한다. 즉, ***한 데이터 집합을 기준으로 다른 데이터 집합과 공통된 항목을 제외한 결과***만 출력
    ```sql
    SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    MINUS
    SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE DEPTNO = 10;
    ```
- `INTERSECT` : **교집합**을 의미한다. 즉, ***데이터 집합에서 공통된 항목만 추출***한다.
    ```sql
    SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    INTERSECT
    SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE DEPTNO = 10;
    ```
---
### 3. 날짜함수 학습
> 날짜 함수는 `DATE` 함수나 `TIMESTAMP` 함수와 같은 ***날짜형을 대상으로 연산을 수행해 결과를 반환***하는 함수다.
- `SYSDATE` : **현재 일자와 시간**을 `DATE` 형으로 반환한다.
- `SYSTIMESTAMP` : **현재 일자와 시간**을 `TIMESTAMP` 형으로 반환한다.
  ```sql
  SELECT SYSDATE AS NOW, SYSDATE - 1 AS YESTERDAY, SYSDATE + 1 AS TOMORROW
  FROM DUAL;
  ```
- `ADD_MONTHS(date, integer)` : 매개변수로 들어온 날짜(date)에 `integer` 만큼의 _**월을 더한 날짜를 반환**_
  ```sql
  SELECT SYSDATE AS NOW, ADD_MONTHS(SYSDATE, 3) AS 석달후
  FROM DUAL;
  ```
- `MONTHS_BETWEEN(date1, date2)` : 두 날짜 사이의 개월 수를 반환한다.
- 아래 예제는 EMP 테이블에서 입사 10주년이 되는 사원을 출력하는 예제이다.
  ```sql
  SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 120) AS 입사_10주년_날짜
  FROM EMP;
  ```
- `LAST_DAY(date)` : date 날짜를 기준으로 ***해당 월의 마지막 일자를 반환***한다.
  ```sql
  SELECT LAST_DAY(SYSDATE)
  FROM DUAL;
  ```
- `NEXT_DAY(date, char)` : date를 ***char에 명시한 날짜로 다음 주 주중 일자를 반환***한다.
  ```sql
  SELECT SYSDATE, NEXT_DAY(SYSDATE, '월')
  FROM DUAL;
  ```
- `ROUND(date, format)`, `TRUNC(date, format)` : **숫자 함수이면서 날짜 함수**로도 쓰인다. ***fotmat에 따라 반올림, 버림 날짜를 반환***한다.
---
### 4. 형 변환 함수 학습
> 형 변환 함수란 **서로 다른 유형의 데이터 타입으로 변환해 결과를 반환**하는 함수를 말한다.
> `묵시적 형변환`, `명시적 형변환`으로 나뉜다.

- `묵시적 형변환` : `Oracle` 에서 ***자동으로 형변환***을 해주는 것을 묵시적 형변환이라 한다.
- 아래 예제와 같이 `숫자+문자` 연산 시 **문자를 자동으로 숫자로 바꿔 연산결과를 반환**한다.
  ```sql
  SELECT EMPNO, ENAME, EMPNO + '500' AS 암묵적_형변환
  FROM EMP
  WHERE ENAME = 'SCOTT';
  ```
- `명시적 형변환` : **변환 함수**를 통해 ***형변환을 사용자(개발자)가 직접 처리***하는 것이다.
  - `TO_CHAR()` : 숫자 또는 날짜 데이터를 문자 데이터로 변환
  - `TO_NUMBER()` : 문자 또는 날짜 데이터를 숫자 데이터로 변환
  - `TO_DATE()` : 문자 또는 숫자 데이터를 날짜 데이터로 변환
- 숫자나 날짜에 따라 자주 사용하는 포맷을 정리하면 다음과 같다.
  - `CC` : 세기
  - `YYYY` : 연도
  - `YY` : 연도(뒤 2자리)
  - `MM` : 월
  - `MON` : 월(약어)
  - `MONTH` : 월(전체)
  - `DD` : 일
  - `DDD` : 365일
  - `DY` : 요일(약어)
  - `DAY` : 풀어
  - `W` : 주
  - `HH24` : 24시간
  - `HH/HH12` : 12시간
  - `MI` : 분
  - `SS` : 초
  - `AM/PM/A.M/P.M` : 오전/오후
- 아래 예제는 월을 여러 포맷으로 형변환하여 출력한다.
  ```sql
  SELECT SYSDATE,
         TO_CHAR(SYSDATE, 'MM')    AS MM,
         TO_CHAR(SYSDATE, 'MON')   AS MON,
         TO_CHAR(SYSDATE, 'MONTH') AS MONTH,
         TO_CHAR(SYSDATE, 'DD')    AS DD,
         TO_CHAR(SYSDATE, 'DY')    AS DY,
         TO_CHAR(SYSDATE, 'DAY')   AS DAY
  FROM DUAL;
  ```
- 각 나라의 언어로 변환하여 출력할 수 있다.
  ```sql
  SELECT SYSDATE                                                  AS 현재시간,
         TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN')    AS MON_K,
         TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE')  AS MON_J,
         TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH')   AS MON_E,
         TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = KOREAN')  AS MONTH_K,
         TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH') AS MONTH_E
  FROM DUAL;
  ```
