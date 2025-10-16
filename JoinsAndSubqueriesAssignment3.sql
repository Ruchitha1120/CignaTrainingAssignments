CREATE TABLE Dept(
Deptno NUMBER PRIMARY KEY,
Dname VARCHAR2(20),
Loc VARCHAR2(20)
);

INSERT INTO Dept VALUES(10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO Dept VALUES(20, 'RESEARCH', 'INDIA');
INSERT INTO Dept VALUES(30, 'SALES', 'USA');
INSERT INTO Dept VALUES(40, 'OPERATIONS', 'UK');

CREATE TABLE Emps(
Empno NUMBER PRIMARY KEY,
Ename VARCHAR2(20),
Job VARCHAR2(20),
salary NUMBER(10,2),
Deptno NUMBER,
CONSTRAINT fk_dept FOREIGN KEY(Deptno) REFERENCES Dept(Deptno)
);

INSERT INTO Emps VALUES (101, 'SMITH', 'CLERK', 1200, 20);
INSERT INTO Emps VALUES (102, 'ALLEN', 'SALESMAN', 1600, 30);
INSERT INTO Emps VALUES (103, 'WARD', 'SALESMAN', 1250, 30);
INSERT INTO Emps VALUES (104, 'JONES', 'MANAGER', 2975, 20);
INSERT INTO Emps VALUES (105, 'MARTIN', 'SALESMAN', 1250, 30);
INSERT INTO Emps VALUES (106, 'BLAKE', 'MANAGER', 2850, 30);
INSERT INTO Emps VALUES (107, 'CLARK', 'MANAGER', 2450, 10);
INSERT INTO Emps VALUES (108, 'SCOTT', 'ANALYST', 3000, 20);
INSERT INTO Emps VALUES (109, 'KING', 'PRESIDENT', 5000, 10);
INSERT INTO Emps VALUES (110, 'TURNER', 'SALESMAN', 1500, 30);
INSERT INTO Emps VALUES (111, 'ADAMS', 'CLERK', 1100, 20);

SELECT * from Emps;
SELECT * FROM Dept;

--Display employee names along with their department
Select e.Ename, d.Dname 
From Emps e
JOIN Dept d ON e.Deptno= d.Deptno;

--List all the employess with their job titles and the location of their department
SELECT e.Ename, e.Job, d.Loc 
FROM Emps e JOIN Dept d 
ON e.Deptno = d.Deptno;

--display employees who work in the sales department
SELECT e.Ename, e.Job, e.Salary 
FROM Emps e JOIN Dept d ON 
e.Deptno= d.Deptno
WHERE d.Dname ='SALES';

--List all employees along with their department name and location including departments that have no employees
SELECT e.Ename, d.Dname,d.Loc
FROM Dept d
LEFT JOIN Emps e ON e.Deptno= d.Deptno;

--Display all departments and employees even if some employees are not assigned to any department
SELECT e.Ename, d.Dname From Emps e
FULL OUTER JOIN Dept d ON e.Deptno=d.Deptno;

--show each department name and total salary paid to its employee
SELECT d.Dname, SUM(e.Salary) AS Total_Salary
FROM Dept D
JOIN Emps e ON e.Deptno= d.Deptno GROUP BY d.Dname;

--Find departments that have more than 3 employees display dname and number of employees
SELECT d.Dname, COUNT(e.Empno) AS No_of_employees FROM  Dept d
JOIN Emps e ON e.Deptno=d.Deptno
GROUP BY d.Dname
HAVING COUNT(e.Empno)>3;

--display employees who work in the same location as the Accounting department
SELECT Ename from Emps WHERE Deptno IN(
SELECT Deptno FROM Dept WHERE Loc=(SELECT Loc FROM Dept WHERE Dname ='ACCOUNTING'))

--For each department display the employee who as the highest salary
SELECT e.Ename, e.Salary,d.Dname
FROM Emps e
JOIN Dept d ON e.Deptno=d.Deptno
WHERE e.Salary =(
SELECT MAX(Salary) FROM Emps WHERE Deptno=e.Deptno);

-- list employees whose salary is greater than the average salary of their department
SELECT e.Ename,e.Salary, d.Dname FROM Emps e
JOIN Dept d ON e.Deptno = d.Deptno
WHERE e.Salary>(SELECT AVG(Salary) FROM Emps WHERE Deptno= e.Deptno);
-------------------------------------------------------------------------

--Subqueries
--Types of Subqueries
--1. Single-row Subquery

SELECT Ename, Salary
FROM Emps
WHERE Salary > (SELECT AVG(Salary) FROM Emps);

--2.Multi-row Subquery
SELECT Ename, Deptno
FROM Emps
WHERE Deptno IN (SELECT Deptno FROM Dept WHERE Loc = 'INDIA');

--3. Multi-column Subquery
SELECT Empno, Ename, Job, Deptno
FROM Emps
WHERE (Job, Deptno) IN
(SELECT Job, Deptno FROM Emps WHERE Empno = 103);

--4. Correlated Subquery
SELECT e.Ename, e.Salary, e.Deptno
FROM Emps e
WHERE e.Salary > (SELECT AVG(Salary)
FROM Emps
WHERE Deptno = e.Deptno);

--5. Subqueries in Different Clauses
--a. In the WHERE Clause
SELECT *
FROM Emps
WHERE Deptno IN (SELECT Deptno FROM Dept WHERE Loc = 'USA');

--b. In the HAVING Clause
SELECT Deptno, AVG(Salary)
FROM Emps
GROUP BY Deptno
HAVING AVG(Salary) > (SELECT AVG(Salary) FROM Emps);

--c. In the SELECT Clause
SELECT e.Ename,
(SELECT Dname FROM Dept d WHERE d.Deptno = e.Deptno) AS department
FROM Emps e;

