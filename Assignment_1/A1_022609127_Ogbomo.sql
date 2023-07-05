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
END;


--QUESTION 3
-- Write a stored procedure for the EMPLOYEE table which
-- takes employee number and education level upgrade as input - and -
-- increases the education level of the employee based on the input.
-- Valid input is:
-- - “H” (for high school diploma) – and – this will update the edlevel to 16
-- - “C” (for college diploma) – and – this will update the edlevel to 19
-- - “U” (for university degree) – and – this will update the edlevel to 20
-- - “M” (for masters) – and – this will update the edlevel to 23
-- - “P” (for PhD) – and – this will update the edlevel to 25
--     - Make sure you handle the error condition of incorrect education
-- level input – and – non-existent employee number
-- - Also make sure you never reduce the existing education level of
-- the employee. They can only stay the same or go up.
-- - A message should be provided for all three error cases.
-- - When no errors occur, the output should look like:
-- - EMP OLD EDUCATION NEW EDUCATION
-- WHAT TO HAND IN: A copy of your stored procedure and the output of
-- the a set of calls which test all input conditions and error handling.
-- Total of 8 calls and 8 output.

CREATE OR REPLACE PROCEDURE upgrade_education_level(emp_num IN NUMBER, edu_code IN CHAR)
    IS
    invalid_employee EXCEPTION;
    invalid_education_code EXCEPTION;
    found               BOOLEAN := FALSE;
    old_education_level EMPLOYEE.EDLEVEL %TYPE;
    new_education_level EMPLOYEE.EDLEVEL %TYPE;
    CURSOR employee_cursor
        IS
        SELECT EMPNO,
               FIRSTNAME,
               MIDINIT,
               LASTNAME,
               EDLEVEL
        FROM EMPLOYEE
        ORDER BY FIRSTNAME
            FOR UPDATE OF EDLEVEL;
BEGIN
    IF (edu_code != 'H' AND edu_code != 'C' AND edu_code != 'U' AND edu_code != 'M' AND edu_code != 'P') THEN
        RAISE invalid_education_code;
    END IF;

    --TRAVERSE THE EMPLOYEE TABLE USING CURSOR TO FIND THE TARGET EMPLOYEE NUMBER
    FOR emp in employee_cursor
        LOOP
        -- IF EMPLOYEE NUMBER MATCHES TARGET EMPLOYEE ID
        -- UPDATE THE EMPLOYEES INFO IN REGARDS TO THE EDU_CODE...
            IF (emp.EMPNO = emp_num) THEN
                found := TRUE;
                -- SAVE THE OLD EDUCATION LEVEL
                old_education_level := emp.EDLEVEL;

                -- MATCH THE EDU_CODE TO THE CORRECT SELECTION STATEMENT...
                IF (edu_code = 'H') THEN
                    --“H” (for high school diploma) – and – this will update the edlevel to 16
                    UPDATE EMPLOYEE
                    SET EMPLOYEE.EDLEVEL = 16
                    WHERE EMPLOYEE.EMPNO = emp.EMPNO;
                    COMMIT; --SAVE CHANGES TO THE TABLE
                    SELECT EDLEVEL --GET UPDATED EDUCATION LEVEL INTO VARIABLE
                    INTO
                        new_education_level
                    FROM EMPLOYEE
                    WHERE EMPLOYEE.EMPNO = emp.EMPNO;
                ELSIF (edu_code = 'C') THEN
                    --“C” (for college diploma) – and – this will update the edlevel to 19
                    UPDATE EMPLOYEE
                    SET EMPLOYEE.EDLEVEL = 19
                    WHERE EMPLOYEE.EMPNO = emp.EMPNO;
                    COMMIT; --SAVE CHANGES TO THE TABLE
                    SELECT EDLEVEL --GET UPDATED EDUCATION LEVEL INTO VARIABLE
                    INTO
                        new_education_level
                    FROM EMPLOYEE
                    WHERE EMPLOYEE.EMPNO = emp.EMPNO;
                ELSIF (edu_code = 'U') THEN
                    --“U” (for university degree) – and – this will update the edlevel to 20
                    UPDATE EMPLOYEE
                    SET EMPLOYEE.EDLEVEL = 20
                    WHERE EMPLOYEE.EMPNO = emp.EMPNO;
                    COMMIT; --SAVE CHANGES TO THE TABLE
                    SELECT EDLEVEL --GET UPDATED EDUCATION LEVEL INTO VARIABLE
                    INTO
                        new_education_level
                    FROM EMPLOYEE
                    WHERE EMPLOYEE.EMPNO = emp.EMPNO;
                ELSIF (edu_code = 'M') THEN
                    --“M” (for masters) – and – this will update the edlevel to 23
                    UPDATE EMPLOYEE
                    SET EMPLOYEE.EDLEVEL = 23
                    WHERE EMPLOYEE.EMPNO = emp.EMPNO;
                    COMMIT; --SAVE CHANGES TO THE TABLE
                    SELECT EDLEVEL --GET UPDATED EDUCATION LEVEL INTO VARIABLE
                    INTO
                        new_education_level
                    FROM EMPLOYEE
                    WHERE EMPLOYEE.EMPNO = emp.EMPNO;
                ELSIF (edu_code = 'P') THEN
                    --“P” (for PhD) – and – this will update the edlevel to 25
                    UPDATE EMPLOYEE
                    SET EMPLOYEE.EDLEVEL = 25
                    WHERE EMPLOYEE.EMPNO = emp.EMPNO;
                    COMMIT; --SAVE CHANGES TO THE TABLE
                    SELECT EDLEVEL --GET UPDATED EDUCATION LEVEL INTO VARIABLE
                    INTO
                        new_education_level
                    FROM EMPLOYEE
                    WHERE EMPLOYEE.EMPNO = emp.EMPNO;
                END IF;
                EXIT;
            END IF;
        END LOOP;

    IF (NOT found) THEN
        RAISE invalid_employee;
    END IF;
    -- DISPLAY EMPLOYEE, FORMER EDUCATION, AND NEW EDUCATION LEVELS
    DBMS_OUTPUT.put_line('Employee: ' || emp_num || CHR(10) || 'OLD EDUCATION LEVEL: ' || old_education_level ||
                         CHR(10) ||
                         'NEW EDUCATION LEVEL: ' || new_education_level);

EXCEPTION
    WHEN
        invalid_education_code THEN DBMS_OUTPUT.put_line('UPGRADE_EDUCATION_LEVEL: ' || edu_code
        || ' is invalid...' || CHR(10));
    WHEN
        invalid_employee THEN DBMS_OUTPUT.put_line('SALARY: Oops employee number: '
        || emp_num || ' was not found. ' ||
                                                   CHR(10) || '.');
    WHEN OTHERS THEN DBMS_OUTPUT.put_line('UPGRADE_EDUCATION_LEVEL: Oops something went wrong...' || CHR(10));
END;

BEGIN
    upgrade_education_level(000330, 'H');
    DBMS_OUTPUT.put_line(CHR(10));
    upgrade_education_level(000330, 'C');
    DBMS_OUTPUT.put_line(CHR(10));
    upgrade_education_level(000330, 'U');
    DBMS_OUTPUT.put_line(CHR(10));
    upgrade_education_level(000330, 'M');
    DBMS_OUTPUT.put_line(CHR(10));
    upgrade_education_level(000330, 'P');
    DBMS_OUTPUT.put_line(CHR(10));
    upgrade_education_level(7777777, 'H');
    DBMS_OUTPUT.put_line(CHR(10));
    upgrade_education_level(000330, 'Z');
END;
