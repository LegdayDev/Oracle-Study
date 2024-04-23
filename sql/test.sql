--
SELECT DEPTNO, 사원수
FROM (SELECT DEPTNO, COUNT(EMPNO) AS 사원수 FROM emp GROUP BY deptno ORDER BY 사원수 DESC)
WHERE ROWNUM <= 1;

--
SELECT e.EMPNO, e.ENAME, e.JOB, d.DNAME
FROM EMP e
         INNER JOIN DEPT d ON e.deptno = d.DEPTNO
WHERE (e.JOB, e.SAL) IN (SELECT JOB, MIN(SAL)
                         FROM EMP
                         GROUP BY JOB)
ORDER BY JOB DESC;

--
SELECT empno, ename, deptno, HIREDATE
FROM emp
WHERE HIREDATE IN
      (SELECT MIN(HIREDATE)
       FROM emp e
                INNER JOIN dept d ON e.DEPTNO = d.DEPTNO
       GROUP BY e.DEPTNO);

--
SELECT d.DEPTNO, d.DNAME, DECODE(COUNT(e.empno), 0, '없음', COUNT(e.empno)) 사원수
FROM DEPT d
         LEFT OUTER JOIN EMP e
                         ON d.deptno = e.DEPTNO
GROUP BY d.deptno, d.DNAME
ORDER BY d.DEPTNO;

--
SELECT e1.empno, e1.ename, e1.mgr
FROM EMP e1
         LEFT OUTER JOIN EMP e2 ON e1.empno = e2.empno
ORDER BY empno DESC;