--Example 1: validating data before insert or update

CREATE OR REPLACE TRIGGER data_validation
BEFORE INSERT OR UPDATE of Salary ON Emps
FOR EACH ROW
BEGIN
     if :New.Salary<0 THEN 
        RAISE_APPLICATION_ERROR(-20001, 'Salary cannot be negative');
    END IF;
END;

--Invoking the Trigger
SELECT * FROM Emps;
INSERT INTO Emps VALUES(1110, 'APPU','MANAGER',-2000, 20);
UPDATE Emps SET Salary = -7000 WHERE Empno= 103;

--Example 2: Aduit Changes(After UPDATE Trigger)

CREATE TABLE emp_audit (
    empno NUMBER,
    old_salary NUMBER,
    new_salary NUMBER,
    changed_on DATE
);

--Create a Trigger
CREATE OR REPLACE TRIGGER Aduit_trigger
AFTER UPDATE of Salary ON Emps
FOR EACH ROW
BEGIN 
    INSERT INTO Emp_Audit(empno, old_salary, new_salary, changed_on)
    VALUES(:old.Empno, :old.Salary, :new.Salary, SYSDATE);
END;

--Invoking the trigger
UPDATE Emps set Salary = 3000 where empno =  103;
SELECT * FROM emp_audit;

     
