--   Example 1: Simple Greeting Procedure
--   Purpose: Takes a name as input and returns a personalized greeting.

CREATE OR REPLACE PROCEDURE greet_user(p_name IN VARCHAR2, p_greeting OUT VARCHAR2)
IS
BEGIN
    p_greeting := 'Hello, ' || p_name || '! Welcome to Oracle!';
END greet_user;

--Invoke the procedure
DECLARE
    v_message VARCHAR2(100);
BEGIN
    greet_user('Ruchitha', v_message);
    DBMS_OUTPUT.PUT_LINE(v_message);
END;

--Example 2: calculate bonus for employee

CREATE OR REPLACE PROCEDURE cal_bonus(p_salary IN NUMBER, p_bonus OUT NUMBER)
IS
BEGIN
    IF p_salary > 5000 THEN
        p_bonus:= p_salary*0.10;
    ELSE
        p_bonus:= p_salary*0.05;
    END IF;
END cal_bonus;

--Invoke Procedure
DECLARE
    v_bonus NUMBER;
BEGIN
    cal_bonus(5000,v_bonus);
    DBMS_OUTPUT.PUT_LINE('Bonus: $'|| v_bonus);
    
    cal_bonus(7000,v_bonus);
    DBMS_OUTPUT.PUT_LINE('Bonus: $'|| v_bonus);
END;

--Example 3 get department salary summary

CREATE OR REPLACE PROCEDURE sal_summary(p_deptno IN NUMBER, p_total_sal OUT NUMBER, p_count OUT NUMBER)
IS 
BEGIN
     SELECT SUM(Salary), count(*) INTO p_total_sal, p_count from Emps WHERE Deptno = p_deptno;
     IF p_count =0  THEN
        p_total_sal:=0;
        p_count:=0;
    END IF;
END sal_summary;

--Invoke Procedure
DECLARE
    p_total_sal NUMBER;
    p_count NUMBER;
BEGIN
    sal_summary(10, p_total_sal, p_count);
    DBMS_OUTPUT.PUT_LINE('Dept no:10 ' || p_count|| ' employees, total salary: $'||p_total_sal);
END;
