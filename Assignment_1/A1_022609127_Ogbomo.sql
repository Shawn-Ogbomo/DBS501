/*Name: Shawn Ogbomo
 Student# 022609127
 Date 07/03/2023
 Section DBS501NSC
 Instructor Riyadh Al-Essawi
 Assignment 1*/

-- SET SERVEROUTPUT ON;
--QUESTION 1
--EMPLOYEE ROW COUNT
SELECT COUNT(*)
FROM EMPLOYEE;

--STAFF ROW COUNT
SELECT COUNT(*)
FROM STAFF;

--QUESTION 2
-- Write a stored procedure called salary for the EMPLOYEE
-- table which takes, as input, an employee number and a rating of either
-- 1, 2 or 3.
-- - The stored procedure should perform the following changes:
-- - If the employee was rated a 1 – they receive a $10,000 salary
-- increase, additional $300 in bonus and an additional 5% of salary
-- as commission
-- - If the employee was rated a 2 – they receive a $5,000 salary
-- increase, additional $200 in bonus and an additional 2% of salary
-- as commission
-- - If the employee was rated a 3 – they receive a $2,000 salary
-- increase with no change to their variable pay
-- - Use the “old” salary (before increase) to calculate the “new”
-- bonus and/or commission amount
-- - Make sure you handle two types of errors: (1) A non-existent
-- employee – and – (2) A non-valid rating. Both should have an
-- appropriate message.
-- - The stored procedure should return the employee number,
-- previous compensation and new compensation (all three
-- compensation components showed separately)
-- - EMP OLD SALARY OLD BONUS OLD COMM NEW SALARY
-- NEW BONUS NEW COMM
-- - Demonstrate that your stored procedure works correctly by
-- running it 5 times: Three times with a valid employee number
-- and a 1 rating, 2 rating and 3 rating. Once with an invalid
-- employee number. Once with an invalid rating level.
-- WHAT TO HAND IN: A copy of your stored procedure and the output of
-- the 5 calls described above.
CREATE OR REPLACE PROCEDURE salary(emp_num IN NUMBER, rating IN NUMBER)
    IS
    invalid_employee EXCEPTION;
    invalid_rating EXCEPTION;
    found            BOOLEAN := FALSE;
    max_rating       NUMBER  := 3;
    old_salary       EMPLOYEE.SALARY %TYPE;
    new_salary       EMPLOYEE.SALARY %TYPE;
    old_compensation EMPLOYEE.COMM %TYPE;
    new_compensation EMPLOYEE.COMM %TYPE;
    old_bonus        EMPLOYEE.BONUS %TYPE;
    new_bonus        EMPLOYEE.BONUS %TYPE;
    CURSOR employee_cursor
        IS
        SELECT EMPNO,
               FIRSTNAME,
               MIDINIT,
               LASTNAME,
               WORKDEPT,
               PHONENO,
               HIREDATE,
               JOB,
               EDLEVEL,
               SEX,
               BIRTHDATE,
               SALARY,
               BONUS,
               COMM
        FROM EMPLOYEE
        ORDER BY FIRSTNAME
            FOR UPDATE OF SALARY , BONUS, COMM;
BEGIN
    -- CHECK VALIDITY OF THE RATING
    IF (rating < 0 OR rating > max_rating) THEN
        RAISE invalid_rating;

    END IF;

    --TRAVERSE THE EMPLOYEE TABLE USING CURSOR TO FIND THE TARGET EMPLOYEE NUMBER
    FOR emp in employee_cursor
        LOOP
        -- IF EMPLOYEE NUMBER MATCHES TARGET EMPLOYEE ID
        -- UPDATE THE EMPLOYEES INFO IN REGARDS TO THE RATING...
            IF (emp.EMPNO = emp_num) THEN
                found := TRUE;
                -- SAVE THE OLD COMPENSATION COMPONENTS
                old_salary := emp.SALARY;
                old_compensation := emp.COMM;
                old_bonus := emp.BONUS;

                --UPDATE THE COMPENSATION COMPONENTS
                IF (rating = 1) THEN
                    --they receive a $10,000 salary increase.
                    -- Additional $300 in bonus.
                    -- An additional 5% of salary as commission
                    UPDATE EMPLOYEE
                    SET EMPLOYEE.SALARY = EMPLOYEE.SALARY + 10000,
                        EMPLOYEE.BONUS  = EMPLOYEE.BONUS + 300,
                        EMPLOYEE.COMM   = EMPLOYEE.COMM + (old_salary * 0.05)
                    WHERE EMPLOYEE.EMPNO = emp.EMPNO;
                    COMMIT; --SAVE CHANGES TO THE TABLE
                    SELECT SALARY, --GET UPDATED COMPENSATION COMPONENTS INTO VARIABLES
                           COMM,
                           BONUS
                    INTO
                        new_salary,
                        new_compensation,
                        new_bonus
                    FROM EMPLOYEE
                    WHERE EMPLOYEE.EMPNO = emp.EMPNO;
                ELSIF (rating = 2) THEN
                    --they receive a $5,000 salary increase
                    -- AN additional $200 in bonus
                    -- An additional 2% of salary as commission
                    UPDATE EMPLOYEE
                    SET EMPLOYEE.SALARY = EMPLOYEE.SALARY + 5000,
                        EMPLOYEE.BONUS  = EMPLOYEE.BONUS + 200,
                        EMPLOYEE.COMM   = EMPLOYEE.COMM + (old_salary * 0.02)
                    WHERE EMPLOYEE.EMPNO = emp.EMPNO;
                    COMMIT; --SAVE CHANGES TO THE TABLE
                    SELECT SALARY, --GET UPDATED COMPENSATION COMPONENTS INTO VARIABLES
                           COMM,
                           BONUS
                    INTO
                        new_salary,
                        new_compensation,
                        new_bonus
                    FROM EMPLOYEE
                    WHERE EMPLOYEE.EMPNO = emp.EMPNO;

                ELSIF (rating = 3) THEN
                    --they receive a $2,000 salary increase with no change to their variable pay
                    UPDATE EMPLOYEE
                    SET EMPLOYEE.SALARY = EMPLOYEE.SALARY + 2000
                    WHERE EMPLOYEE.EMPNO = emp.EMPNO;
                    COMMIT; --SAVE CHANGES TO THE TABLE
                    SELECT SALARY, --GET UPDATED COMPENSATION COMPONENTS INTO VARIABLES
                           COMM,
                           BONUS
                    INTO
                        new_salary,
                        new_compensation,
                        new_bonus
                    FROM EMPLOYEE
                    WHERE EMPLOYEE.EMPNO = emp.EMPNO;
                END IF;
                EXIT;
            END IF;
        END LOOP;

    IF (NOT found) THEN
        RAISE invalid_employee;
    END IF;
    --DISPLAY COMPENSATION COMPONENTS...
    DBMS_OUTPUT.put_line('EMPNO: ' || emp_num || CHR(10) ||
                         'OLD_SALARY: ' || old_salary || CHR(10) ||
                         'NEW SALARY: ' || new_salary || CHR(10) ||
                         'OLD BONUS: ' || old_bonus || CHR(10) ||
                         'NEW BONUS: ' || new_bonus || CHR(10) ||
                         'OLD COMPENSATION: ' || old_compensation || CHR(10) ||
                         'NEW COMPENSATION: ' || new_compensation || CHR(10));
EXCEPTION
    WHEN
        invalid_rating THEN DBMS_OUTPUT.put_line('SALARY: Oops ' || rating || ' is an invalid rating. ' || CHR(10) ||
                                                 'Please enter a rating > 0 and <= ' || max_rating || '.');
    WHEN
        invalid_employee THEN DBMS_OUTPUT.put_line('SALARY: Oops employee number: ' || emp_num || ' was not found. ' ||
                                                   CHR(10) || '.');
    WHEN OTHERS THEN DBMS_OUTPUT.put_line('SALARY: Oops something went wrong...' || CHR(10));
END;


BEGIN
    SALARY(000330, 1);
    DBMS_OUTPUT.put_line(CHR(10));
    SALARY(200010, 2);
    DBMS_OUTPUT.put_line(CHR(10));
    SALARY(000330, 3);
    DBMS_OUTPUT.put_line(CHR(10));
    SALARY(000140, 2);
    DBMS_OUTPUT.put_line(CHR(10));
    --INVALID
    SALARY(000330, 75);
    DBMS_OUTPUT.put_line(CHR(10));
    --INVALID
    SALARY(7777777, 2);
--     ROLLBACK;
END ;