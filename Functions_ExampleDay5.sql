--Example 1: Function to return hello world

CREATE OR REPLACE FUNCTION hello_world RETURN VARCHAR2
IS 
BEGIN
    RETURN 'Hello WORLD!';
END;

--Invoke the function
SELECT hello_world() as Result from dual; -- temporary table

--Example 2: Function to return greeting message based on name
CREATE OR REPLACE FUNCTION greet(name IN VARCHAR2) RETURN VARCHAR2
IS
BEGIN 
    RETURN 'Hello, '|| name || '!';
END;

--Invoke the function
SELECT greet('Ruchi') as Result FROM dual;

-- Example 3: calucate tax

CREATE OR REPLACE FUNCTION cal_tax(p_amount IN NUMBER) RETURN NUMBER
IS
BEGIN
     RETURN p_amount * 0.10;
END;

--Invoke the function
SELECT cal_tax(5000)as tax from dual;

--Example 4: function with database queries- to get employee salary

CREATE OR REPLACE FUNCTION emp_sal(emp_id IN NUMBER) RETURN NUMBER
IS
    v_salary NUMBER;
BEGIN
    SELECT Salary INTO v_salary FROM Emps WHERE Empno = emp_id;
    RETURN v_salary;
EXCEPTION 
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;

--Invoke the function
SELECT emp_sal(103) as tot_sal FROM dual;
