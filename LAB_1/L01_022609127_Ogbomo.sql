/*Name: Shawn Ogbomo
 Student# 022609127
 Date 06/01/2023
 Section DBS501NSC
 Instructor Riyadh Al-Essawi*/
SET SERVEROUTPUT ON;

--Question 1 
--1. Write a store procedure called even_odd which gets an integer number and 
--prints
--The number is even.
--If a number is divisible by 2.
--Otherwise, it prints 
--The number is odd.

CREATE OR REPLACE PROCEDURE even_odd (x NUMBER)
IS
BEGIN
-- NUMBER IS 0 OR NEG
IF (x = 0 OR x < 0) THEN 
    DBMS_OUTPUT.put_line('Cannot divide by 0 or a negetive number...');
    RETURN;
END IF;

--NUMBER IS EVEN
IF(MOD(x,2) = 0) THEN 
     DBMS_OUTPUT.put_line(x || ' is even...');
     RETURN;
END IF;
--NUMBER IS ODD
IF(MOD (x,2) = 1) THEN
    DBMS_OUTPUT.put_line(x ||' is odd...');
     RETURN;
END IF;
EXCEPTION WHEN OTHERS
THEN
DBMS_OUTPUT.put_line('Error. Something went wrong...');
END;

BEGIN
even_odd(2);
even_odd(1);
even_odd(3);
even_odd(0);
even_odd(-1);
END;


--Question 2
--Write a store procedure called factorial that gets an integer number n and 
--calculates and displays its factorial. You must use a LOOP to calculate the 
--results.

CREATE OR REPLACE PROCEDURE calc_factorial (maximum NUMBER)
IS
-- VARIABLE TO STORE RESULT AND VARIABLE TO USE AS ITTERATOR
num_result NUMBER(9,2) :=1;
num_begin NUMBER (9,2) := 1;

BEGIN
-- 0 FACTORIAL AND 1 FACTORIAL IS 1 
IF( maximum = 0 OR maximum = 1 ) THEN
    num_result := 1;
    DBMS_OUTPUT.put_line(num_result);
    RETURN;
END IF;

 IF(maximum < 0) THEN
        DBMS_OUTPUT.put_line('Error, cannot calculate the factorial of a negetive number...');
        RETURN;
END IF;

-- CALCULATE THE FACTORIAL OF MAXIMUM (VALUE IN PARAMETER)
FOR i IN num_begin..maximum    
LOOP
-- ASSIGN THE PRODUCT OF 1 * ITERATOR VARIABLE + 1  TO RESULT
num_result := num_result * (num_begin);
num_begin := num_begin +1;
END LOOP;

DBMS_OUTPUT.put_line(num_result);
EXCEPTION WHEN OTHERS
THEN
DBMS_OUTPUT.put_line('Error. Something went wrong...');
END;


BEGIN 
calc_factorial(3);
calc_factorial(0);
calc_factorial(1);
calc_factorial(-1);
calc_factorial(10);
calc_factorial(20);
END;

--Question 3
--The company wants to calculate the employees’ annual salary:
--The first year of employment, the amount of salary is the base salary which is 
--$10,000.
--Every year after that, the salary increases by 5%.
--Write a stored procedure named calculate_salary which gets an employee ID 
--and for that employee calculates the salary based on the number of years the 
--employee has been working in the company. (Use a loop construct to 
--calculate the salary).
--The procedure calculates and prints the salary.
--Sample output:
--First Name: first_name 
--Last Name: last_name
--Salary: $9999,99
--If the employee does not exists, the procedure displays a proper message.
CREATE OR REPLACE PROCEDURE calculate_salary(emp_id_x NUMBER)
IS
base_salary NUMBER(9,2) := 10000;
current_year NUMBER(9,2) := TO_NUMBER(TO_CHAR(sysdate,'YYYY'));
num_years NUMBER(9,2) := 0; 
yearly_raise NUMBER(9,2):= 5;
total_salary NUMBER(9,2) := 0;
found NUMBER(9,2) := 0;
CURSOR year_cursor IS
SELECT HIRE_DATE, FIRST_NAME,LAST_NAME, EMPLOYEE_ID
FROM EMPLOYEES;
BEGIN
--TRAVERSE EMPLOYEE TABLE
FOR item in year_cursor
LOOP
num_years := current_year - TO_NUMBER(EXTRACT(YEAR FROM TO_DATE(item.HIRE_DATE,'DD-MON-YY')));        

IF (num_years > 1 AND emp_id_x = item.EMPLOYEE_ID) THEN 
total_salary := (((num_years * yearly_raise) / 100) * base_salary) + base_salary;
DBMS_OUTPUT.put_line('First Name: '|| item.First_NAME);
DBMS_OUTPUT.put_line('Last Name: '|| item.LAST_NAME);
DBMS_OUTPUT.put_line('Salary: '|| total_salary);
DBMS_OUTPUT.NEW_LINE;
found := 1;
ELSIF (num_years = 1 AND emp_id_x = item.EMPLOYEE_ID)THEN 
DBMS_OUTPUT.put_line('First Name: '|| item.First_NAME);
DBMS_OUTPUT.put_line('Last Name: '|| item.LAST_NAME);
DBMS_OUTPUT.put_line('Salary: '|| base_salary);
DBMS_OUTPUT.NEW_LINE;
found := 1;
END IF;
END LOOP;
IF (found = 0 ) THEN 
DBMS_OUTPUT.put_line('Employee id: ' || emp_id_x || ' not found...');
END IF;
EXCEPTION WHEN OTHERS
THEN
DBMS_OUTPUT.put_line('Error. Something went wrong...');
END;

BEGIN
calculate_salary(107);
calculate_salary(106);
calculate_salary(108);
END;

--Question 4 
--Create a stored procedure named find_employee. This procedure gets an 
--employee number and prints the following employee information:
--First name 
--Last name 
--Email
--Phone 
--Hire date 
--Job title
--The procedure gets a value as the employee ID of type NUMBER.
--See the following example for employee ID 107: 
--First name: Summer
--Last name: Payn
--Email: summer.payne@example.com
--Phone: 515.123.8181
--Hire date: 07-JUN-16
--Job title: Public Accountant
--The procedure display a proper error message if any error occurs.

CREATE OR REPLACE PROCEDURE find_employee(id NUMBER)
IS
--VARIBLE TO MARK EMPLOYEE AS FOUND
found NUMBER(9,2) := 0;
--ITTERATOR TO STORE AN EMPLOYEE
CURSOR employees_cursor IS
SELECT FIRST_NAME, LAST_NAME, EMAIL, PHONE, HIRE_DATE, JOB_TITLE, EMPLOYEE_ID
FROM EMPLOYEES;
--TRAVERSE ALL THE EMPLOYEES IN THE EMPLOYEE TABLE
BEGIN
FOR item in employees_cursor
LOOP
-- IF THE EMPLOYEE IS FOUND, DISPLAY HIS/HER INFO
IF (id = item.EMPLOYEE_ID) THEN 
DBMS_OUTPUT.put_line('First Name: '|| item.First_NAME);
DBMS_OUTPUT.put_line('Last Name: '|| item.LAST_NAME);
DBMS_OUTPUT.put_line('Email: '|| item.EMAIL);
DBMS_OUTPUT.put_line('Phone: '|| item.PHONE);
DBMS_OUTPUT.put_line('Hire date: '|| item.HIRE_DATE);
DBMS_OUTPUT.put_line('Job title: '|| item.JOB_TITLE);
DBMS_OUTPUT.NEW_LINE;
found := 1;
RETURN;
END IF;
END LOOP;
--EMPLOYEE NOT FOUND
IF (found = 0 ) THEN 
DBMS_OUTPUT.put_line('Employee id: ' || id || ' not found...');
END IF;
EXCEPTION WHEN OTHERS
THEN
DBMS_OUTPUT.put_line('Error. Something went wrong...');
END;

BEGIN 
find_employee(5);
find_employee(6);
find_employee(200);
END;