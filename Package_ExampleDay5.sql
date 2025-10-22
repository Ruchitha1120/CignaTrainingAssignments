--Create package
CREATE OR REPLACE PACKAGE emp_action_pck IS
    PROCEDURE cal_bonus(p_emp_id IN NUMBER, p_bonus IN NUMBER);
    FUNCTION get_total_compensation(p_emp_id IN NUMBER) RETURN NUMBER;
END emp_action_pck;

--Create package body
CREATE OR REPLACE PACKAGE BODY emp_action_pck IS
    PROCEDURE cal_bonus(p_emp_id IN NUMBER, p_bonus IN NUMBER) IS
    BEGIN
        UPDATE Emps SET Salary = Salary+p_bonus
        WHERE Empno = p_emp_id;
        COMMIT;
   END cal_bonus;
   
   FUNCTION get_total_compensation(p_emp_id IN NUMBER) RETURN NUMBER IS
        v_salary NUMBER;
        BEGIN
        SELECT Salary INTO v_salary FROM Emps WHERE Empno = p_emp_id;
        RETURN v_salary * 12;
    END get_total_compensation;
END emp_action_pck;

--Invoke package
EXEC emp_action_pck.cal_bonus(103, 500);
SELECT emp_action_pck.get_total_compensation(103) FROM dual;

SELECT * FROM emps WHERE empno=103;
