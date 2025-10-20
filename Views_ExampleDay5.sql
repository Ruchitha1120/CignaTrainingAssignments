--Example 1: view showing employee and department details

CREATE OR REPLACE VIEW show_emp_details AS
SELECT e.Empno,e.Ename,e.Salary,d.Dname FROM Emps e
JOIN Dept d ON e.Deptno = d.Deptno;

SELECT * FROM show_emp_details;

--Example 2: Inline View showing top 3 salaries

SELECT * FROM ( SELECT Empno, Ename, Salary
FROM emps
ORDER BY Salary DESC)
WHERE ROWNUM<=3;

--Example 3: MaterialiZed View

CREATE  MATERIALIZED VIEW mv_dept_summary
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND  
AS
SELECT  Deptno, COUNT(*) AS emp_count, AVG(Salary) AS avg_salary
FROM Emps
GROUP BY Deptno; 

SELECT * from mv_dept_summary;

INSERT INTO Emps VALUES(2244,'STEVE','MANAGER',9975,40);

EXEC DBMS_MVIEW.REFRESH('mv_dept_summary');
