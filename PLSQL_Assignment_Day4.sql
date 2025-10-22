--1. Calculate Simple Interest
DECLARE
    principle NUMBER;
    rate NUMBER;
    time NUMBER;
    SI NUMBER;
BEGIN
    principle:= 10000;
    rate:= 5;
    time:=2;
    SI:= (principle*rate*time)/100;
    DBMS_OUTPUT.PUT_LINE('principle: '||principle);
    DBMS_OUTPUT.PUT_LINE('rate: '||rate);
    DBMS_OUTPUT.PUT_LINE('time: '||time);
    DBMS_OUTPUT.PUT_LINE('SI: '||SI);
END;

--2. Employee bonus calculation
DECLARE
    emp_name VARCHAR2(20);
    salary NUMBER;
    Bonus NUMBER;
BEGIN
    emp_name:='Rucitha';
    salary:= 50000;
    IF salary > 50000 THEN
        Bonus:= 0.10* salary;
    ELSE
        Bonus:= 0.15* salary;
   END IF;
    DBMS_OUTPUT.put_line('Employee_name: '||emp_name);
    DBMS_OUTPUT.put_line('Employee_salary: '||salary);
    DBMS_OUTPUT.put_line('Employee_bonus: '||Bonus);
END;

--3. Retrive and Display Department Details
DECLARE
    v_dept Dept%ROWTYPE;
BEGIN
    SELECT * INTO v_dept FROM Dept WHERE Deptno= 10;
    DBMS_OUTPUT.PUT_LINE('Department_name: '||v_dept.Dname || ' ,Department_Location: '|| v_dept.Loc);
END;

--4. Student marks management
DECLARE
    TYPE stu_marks IS TABLE OF NUMBER
    INDEX BY VARCHAR2(20);
    v_student stu_marks;
    v_key VARCHAR2(20);
    total NUMBER:=0;
    count_student NUMBER:=0;
    avg_marks NUMBER:=0;
BEGIN
    v_student('Ruchitha'):= 99;
    v_student('Bob'):= 60;
    v_student('Alice'):= 79;
    v_student('John'):= 90;
    v_student('James'):= 85;
    v_key:= v_student.FIRST;
    WHILE v_key IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE(v_key||'->'||v_student(v_key));
        total:= total+ v_student(v_key);
        count_student:= count_student+1;
        v_key:= v_student.NEXT(v_key);
        END LOOP;
        avg_marks:= total/count_student; 
        DBMS_OUTPUT.put_line('total marks: '|| total);
        DBMS_OUTPUT.put_line('Average marks: '|| avg_marks);
END;

--5. Country- capital loopup
DECLARE
    TYPE Country_capital IS TABLE OF VARCHAR2(50)
    INDEX BY VARCHAR2(50);
    country Country_capital;
    v_key VARCHAR2(50);
BEGIN
    country('India'):= 'Delhi';
    country('USA'):= 'Washington';
    country('france'):= 'paris';
    country('japan'):= 'tokyo';
    country('Australia'):= 'canberra';
    
    v_key:= '&v_key';
    IF country.EXISTS(v_key)THEN
        DBMS_OUTPUT.PUT_LINE('the capital of '||v_key || ' is ' || country(v_key));
    ELSE
        DBMS_OUTPUT.PUT_LINE('Country not found');
    END IF;
END;
