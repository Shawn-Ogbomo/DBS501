/*Name: Shawn Ogbomo
 Student# 022609127
 Date 07/03/2023
 Section DBS501NSC
 Instructor Riyadh Al-Essawi*/


--SET SERVEROUTPUT ON;
--QUESTION 1
-- Write a stored procedure called array_date that takes in as input up to 31
-- numbers in an array – and – an array of up to 12 numbers and then returns the
-- day of the week for each day in the first array for each month in the second
-- array. For instance:
-- If I call array_date([1, 5, 7], [2, 4]) the output would be:
-- Tuesday, February 1, 2022
-- Saturday, February 5, 2022
-- Monday, February 7, 2022
-- Friday, April 1, 2022
-- Tuesday, April 5, 2022
-- Thursday, April 7, 2022

CREATE OR REPLACE TYPE int_array IS VARRAY(31) OF INTEGER;

CREATE OR REPLACE PROCEDURE array_date(days_list int_array, months_list int_array)
    IS
    days_limit   NUMBER := 31;
    months_limit NUMBER := 12;

    too_many_days EXCEPTION;
    too_many_months EXCEPTION;
    invalid_day EXCEPTION;
    invalid_month EXCEPTION;

    -- VARIABLES TO HOLD THE DATE
    day_in_week       VARCHAR2(15 CHAR);
    year              NUMBER := TO_NUMBER(EXTRACT(YEAR FROM SYSDATE));
    target_date       DATE;
    last_day_of_month NUMBER;
BEGIN
    -- GET SIZE OF TWO ARRAYS
    -- IF THE DAYS ARRAY HAS MORE THAN 31 VALUES
    -- THROW AN EXCEPTION
    IF (days_list.COUNT >= days_limit) THEN
        RAISE too_many_days;
    END IF;

    -- IF THE MONTHS ARRAY HAS MORE THAN 12 DAYS
    -- THROW AN EXCEPTION

    IF (months_list.COUNT >= months_limit) THEN
        RAISE too_many_months;
    END IF;

    -- TRAVERSE THE ARRAY OF DAYS AND MONTHS.
-- EVALUATE EACH INDEX AGAINST THE INVARIANT TO GET THE DATE
-- IF SUCCESSFUL, DISPLAY THE APPROPRIATE DATE ON THE CONSOLE.

    FOR i in months_list.FIRST..months_list.LAST
        LOOP
            IF (months_list(i) <= 0 OR months_list(i) > 12) THEN
                RAISE invalid_month;
            END IF;
            last_day_of_month := TO_NUMBER(extract(DAY FROM LAST_DAY(TO_DATE(
                    TO_CHAR('1' || ' ' || TO_CHAR(TO_DATE(months_list(i), 'MM'), 'MON') || ' ' || TO_CHAR(year)),
                    'DD MON YYYY'))));

            FOR j in days_list.FIRST..days_list.LAST
                LOOP
                    IF (days_list(j) > last_day_of_month) THEN
                        RAISE invalid_day;
                    END IF;

                    target_date := TO_DATE(
                                TO_CHAR(days_list(j)) || ' ' || TO_CHAR(TO_DATE(months_list(i), 'MM'), 'MON') || ' ' ||
                                TO_CHAR(year), 'DD MM YYYY');

                    day_in_week := TO_CHAR(target_date, 'DAY');
                    DBMS_OUTPUT.put_line(day_in_week || ', ' || TO_CHAR(target_date, 'Month') || ' ' || days_list(j) ||
                                         ', ' || year || CHR(10));
                END LOOP;
        END LOOP;

EXCEPTION
    WHEN
        invalid_day THEN
        DBMS_OUTPUT.put_line('You have entered an invalid day' || CHR(10));
    WHEN too_many_days THEN
        DBMS_OUTPUT.put_line('You have entered too many day values.' || CHR(10) || 'The amount permitted is: ' ||
                             days_limit || CHR(10));
    WHEN too_many_months THEN
        DBMS_OUTPUT.put_line('You have entered too many month values.' || CHR(10) || 'The amount permitted is: ' ||
                             months_limit || CHR(10));
    WHEN invalid_month THEN
        DBMS_OUTPUT.put_line('You have entered an invalid month.' || CHR(10) || 'The months range from 1-12: ' ||
                             CHR(10));
    WHEN
        OTHERS THEN DBMS_OUTPUT.put_line('Oops something went wrong...' || CHR(10));
END;

DECLARE
    days   int_array;
    months int_array;
BEGIN -- 2+ 80
    days := int_array(1, 5, 7);
    months := int_array(2, 4);
    array_date(days, months);

    days := int_array(-1, 3, 4);
    months := int_array(15, 66, 23);
    array_date(days, months);

    days := int_array(44, 3, 4);
    months := int_array(7, 6, 3);
    array_date(days, months);
END;


-- --QUESTION 2
-- Write a stored procedure called name_fun which will go through each
-- last_name in the employees table and do the following:
-- - If the name starts with a vowel – ignore the name (use CASE function)
-- - If the name does not being with a vowel – replace all vowels in the name with
-- a ’*’
-- - Right pad each name with a ‘+’ so that each name printed as 15 characters in
-- total
-- Example:
-- Adamson – would be ignored
-- Smith – would become Sm*th++++++++++


--CREATE PROCEDURE TO UPDATE THE LASTNAME IN THE EMPLOYEES TABLE

CREATE OR REPLACE PROCEDURE replace_string(string_in IN OUT VARCHAR2, vowel IN CHAR)
    IS
    --HOLDS STRING BEFORE MODIFICATION
    string_previous VARCHAR2(12);
BEGIN
    string_previous := string_in;
    string_in := REPLACE(string_in, vowel, '*');

    --UPDATE THE RECORD RECORD IN THE TABLE THAT MATCHES THE INCOMING STRING
    UPDATE
        EMPLOYEES
    SET LAST_NAME = string_in
    WHERE LAST_NAME = string_previous;
EXCEPTION
    WHEN
        OTHERS THEN DBMS_OUTPUT.put_line('REPLACE_STRING: Oops something went wrong...' || CHR(10));
END;


CREATE OR REPLACE PROCEDURE PAD_RIGHT(internal_string_in IN OUT VARCHAR2, sz IN NUMBER, delimiter IN CHAR)
    IS
    internal_string_previous VARCHAR2(12);
BEGIN
    internal_string_previous := internal_string_in;
    internal_string_in := RPAD(internal_string_in, sz, delimiter);

    UPDATE
        EMPLOYEES
    SET LAST_NAME = internal_string_in
    WHERE LAST_NAME = internal_string_previous;
EXCEPTION
    WHEN
        OTHERS THEN DBMS_OUTPUT.put_line('PAD_RIGHT: Oops something went wrong...' || CHR(10));
END;


CREATE OR REPLACE PROCEDURE name_fun
    IS
    -- CREATE A CURSOR TO TRAVERSE THE EMPLOYEE TABLE
    CURSOR emp_lastname_cursor
        IS
        SELECT LAST_NAME
        FROM EMPLOYEES
        ORDER BY LAST_NAME
            FOR UPDATE OF LAST_NAME;
    --CREATE A VARIABLE TO HOLD THE FIRST CHARACTER OF THE LAST NAME
    first_letter_lname CHAR;
BEGIN
    -- USE ITERATION TO TRAVERSE THE EMPLOYEE TABLE
    -- SWITCH THE FIRST LETTER
    -- SWITCH THE FIRST CHARACTER IN THE LAST NAME
    --IF
    --CASE a || e || i || o || u
    -- REPLACE ALL OF THE VOWELS WITH A *      USE REPLACE
    -- RIGHT PAD + TO THE NED OF THE STRING UNTIL THE TOTAL EMPLOYEE LASTNAME COUNT IS 15
    -- DISPLAY THE LAST NAME WITH THE CHANGES
    --ELSE SKIP THE NAME GO TO THE NEXT RECORD

    FOR emp_lname in emp_lastname_cursor
        LOOP
            first_letter_lname := SUBSTR(emp_lname.LAST_NAME, 1, 1);
            IF first_letter_lname != 'A' AND first_letter_lname != 'E' AND first_letter_lname != 'I'
                AND first_letter_lname != 'O' AND first_letter_lname != 'U' THEN
                FOR i in 2..LENGTH(emp_lname.LAST_NAME)
                    LOOP
                        CASE SUBSTR(emp_lname.LAST_NAME, i, 1)
                            WHEN 'a' THEN REPLACE_STRING(emp_lname.LAST_NAME, 'a');
                            WHEN 'e' THEN REPLACE_STRING(emp_lname.LAST_NAME, 'e');
                            WHEN 'i' THEN REPLACE_STRING(emp_lname.LAST_NAME, 'i');
                            WHEN 'o' THEN REPLACE_STRING(emp_lname.LAST_NAME, 'o');
                            WHEN 'u' THEN REPLACE_STRING(emp_lname.LAST_NAME, 'u');
                            ELSE CONTINUE;
                            END CASE;
                    END LOOP;
                --  SET RIGHT PAD THE STRING WITH + TILL THE COUNT IS 15
                PAD_RIGHT(emp_lname.LAST_NAME, 15, '+');
                DBMS_OUTPUT.PUT_LINE(emp_lname.LAST_NAME);
            END IF;
        END LOOP;
EXCEPTION
    WHEN
        OTHERS THEN DBMS_OUTPUT.put_line('Name_FUN: Oops something went wrong...' || CHR(10));
END;

BEGIN
    name_fun();
END;