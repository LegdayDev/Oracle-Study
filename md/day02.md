## 2일차 학습

### 목차
> 1. 공부할 테이블 생성(https://github.com/LegdayDev/Oracle-Study/blob/master/sql/table_sample.sql)
> 2. SELECT 문 학습
> 3. ORDER BY 학습
> 3. WHERE 조건절 학습
---
### SELECT 문 학습
- SELECT 문은 데이터를 조회할 때 사용하는 명령어이다.
- 기본적인 구조는 아래와 같다.
    ```sql
    SELECT 컬럼명1, 컬럼명2,...
    FROM 테이블명;
    ```
- 특정 컬럼명이 아니고 테이블에 전체 컬럼명을 조회할 때는 `*` 을 사용한다.
    ```sql
    SELECT * FROM 테이블명;
    ```
- 컬럼에 별칭을 지정하여 출력할 수 있다. 이 때 `AS` 키워드를 사용한다.
    ```sql
    SELECT 컬럼명 AS 컬럼
    FROM 테이블명;
    ```
- `AS` 는 생략이 가능하고 별칭은 공백이 있을 경우 "" 로 감싸줘야 한다.
- 특정 컬럼이 중복데이터가 출력이 되면 `DISTINCT` 키워드로 중복을 제거할 수 있다.
  - 출력 시 중복이 되는것이지 테이블에 수정이 일어나지 않는다.
    ```sql
    SELECT DISTINCT JOB
    FROM EMP;
    ```
- `DUAL` 이라는 이름의 가상 테이블을 이용할 수 있다.
- _컬럼명에 연산을 적어주면 연산결과가 행에 나타난다._
    ```sql
    SELECT 2 + 3
    FROM DUAL;
    ```
- 똑같이 별칭도 가능하다.
    ```sql
    SELECT 5 * 5 AS VIVID
    FROM DUAL;
    ```
- 하지만, **문자와 숫자를 더해주면 숫자로 인식**되어 연산결과가 나타나는데 문자처럼 연결할려면 `||` 를 이용한다.
    ```sql
    SELECT '(' || ENAME || ', ' || JOB || ')' AS "EMPLOYEE AND JOB"
    FROM EMP;
    ```
- EMP 테이블의 사원별 연간 총수입을 나타나는 얘제이다.
    ```sql
    SELECT ENAME, SAL * 12 + COMM AS 연간총수입
    FROM emp;
    ```
- `NULL` 과 관련된 연산은 무조건 결과값이 `NULL` 이다.
---
### ORDER BY 학습
- `ORDER BY` 는 데이터 정렬시 사용한다.
- 기본값은 `오름차순(ASC)` 이다. `ASC` 키워드 생략 가능하다. 
    ```sql
    SELECT *
    FROM EMPO
    ORDER BY SAL; -- SAL 컬럼 기준으로 오름차순 정렬한다.
    ```
- 내림차순으로 출력할려면 `DESC` 를 사용한다.
    ```sql
    SELECT *
    FROM EMP
    ORDER BY SAL DESC;
    ```
---
### WHERE 조건절 학습
- 데이터를 조회할 때 `WHERE` 절을 사용하여 조건을 걸 수 있다.
    ```sql
    SELECT 컬럼명
    FROM 테이블명
    WHERE 조건식
    ```
- 조건식은 `AND` 나 `OR` 로 여러 조건식을 연결할 수 있다.
    ```sql
    SELECT ENAME, HIREDATE, SAL
    FROM EMP
    where SAL >= 2500
      AND SAL < 3000; -- SAL(월급) 이 2500 이상 3000이하인 조건
    ```
- `BETWEEN` 연산자는 데이터의 범위를 조건으로 걸 수 있다. -> `BETWEEN A AND B` : A 와 B 사이(이상,이하)
- `EMP` 테이블에서 입사일이 81년 5월 1일과 81년 12월 3일 사이에 입사한 데이터를 조회하는 예제이다.
    ```sql
    SELECT ENAME, SAL, HIREDATE
    FROM EMP
    WHERE HIREDATE BETWEEN '1981-05-01' AND '1981-12-3';
    ```
- **날짜를 조회**할 때는 `TO_DATE()` 라는 함수를 사용할 수 있다.
    ```sql
    SELECT ENAME, SAL, HIREDATE
    FROM EMP
    WHERE HIREDATE BETWEEN TO_DATE('19810501', 'YYYYMMDD') and TO_DATE('19811203', 'YYYYMMDD');
    ```
- **여러 조건을 동시에 충족**해야 할 때 `IN()` 함수를 사용해야 한다.
```sql
SELECT ENAME, JOB, SAL
FROM EMP
WHERE JOB IN ('MANAGER', 'CLERK', 'SALESMAN');
```
- 조건의 반대 값을 구할려면 `NOT` 키워드를 사용한다.
    ```sql
    SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE EMPNO NOT IN (7566, 7782, 7934);
    ```
- 데이터의 특정 문자가 있나 없는지 구할려면 `LKIE` 를 사용한다.
    ```sql
    SELECT 컬럼
    FROM 테이블명
    WHERE 컬럼 LIKE 문자조건;
    ```
- 문자를 조회할 때 `_` , `%` 를 사용한다.
  - `_` : 한 글자를 의미한다.
  - `%` : 전체를 의미한다.
- 'S' 로 시작하는 모든 문자를 조회하는 예제이다.
    ```sql
    SELECT *
    FROM EMP
    WHERE ENAME LIKE '_L%';
    ```
- 두 번째 글자가 L로 시작하는 모든 문자를 조회하는 예제이다.
    ```sql
    SELECT *
    FROM EMP
    WHERE ENAME LIKE '_L%';
    ```
- ENAME 에 'S' 를 포함하고 DEPTNO 가 20인 데이터를 조회하는 예제이다.
    ```sql
    SELECT ENAME, DEPTNO
    FROM EMP
    WHERE ENAME NOT LIKE '%S%'
      AND DEPTNO = 20;
    ```