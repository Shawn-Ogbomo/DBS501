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
    f_name           EMPLOYEE.FIRSTNAME%TYPE;
    m_init           EMPLOYEE.MIDINIT%TYPE;
    l_name           EMPLOYEE.LASTNAME%TYPE;
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
                -- SAVE THE EMPLOYEES NAME
                f_name := emp.FIRSTNAME;
                l_name := emp.LASTNAME;
                m_init := emp.MIDINIT;
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
                         'NAME: ' || f_name || ' ' || m_init || ' ' || l_name || CHR(10) ||
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
    f_name              EMPLOYEE.FIRSTNAME%TYPE;
    m_init              EMPLOYEE.MIDINIT%TYPE;
    l_name              EMPLOYEE.LASTNAME%TYPE;
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
                -- SAVE THE EMPLOYEES NAME
                f_name := emp.FIRSTNAME;
                l_name := emp.LASTNAME;
                m_init := emp.MIDINIT;
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
    DBMS_OUTPUT.put_line('Employee: ' || emp_num || CHR(10) ||
                         'NAME: ' || f_name || ' ' || m_init || ' ' || l_name || CHR(10) ||
                         'OLD EDUCATION LEVEL: ' || old_education_level || CHR(10) ||
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

--QUESTION 4
-- For the following use the same tables that you have been
-- using for the labs. Make sure that the data has been DELETEd and reloaded so you have a fresh copy of the data in each table.
-- find_customer (customer_id IN NUMBER, found OUT NUMBER);
-- This procedure has an input parameter to receive the customer ID and
-- an output parameter named found.
-- This procedure looks for the given customer ID in the database. If the
-- customer exists, it sets the variable found to 1. Otherwise, the found
-- variable is set to 0.
--     Make sure to handle the situation when no data was found.
--     This stored procedure will print out an appropriate message about
--     customer ID being found or not found, using the found variable.
--          OK
--
--
--find_product (product_id IN NUMBER, price OUT
--     products.list_price%TYPE);
-- This procedure has an input parameter to receive the product ID and an
-- output parameter named price.
-- This procedure looks for the given product ID in the database. If the
-- product exists, it stores the product’s list_price in the variable price.
-- Otherwise, the price variable is set to 0.
--     Make sure to handle the situation where no data is found.
--     This stored procedure will print out an appropriate message about the
--     price of the product, using the variables described.
--          OK
--
--
--add_order (customer_id IN NUMBER, new_order_id OUT NUMBER)
--     This procedure has an input parameter to receive the customer ID and
--     an output parameter named new_order_id.
--     To add a new order for the given customer ID, you need to generate
--     the new order Id. To calculate the new order Id, find the maximum
--     order ID in the orders table and increase it by 1.
--     This procedure inserts the following values in the orders table:
--     new_order_id
--     customer_id (input parameter)
--     'Shipped' (The value for the order status)
--     56 (The sales person ID)
--     sysdate (order date which is the current date)
--     This stored procedure will print out the information associated with the
--                                                                              order being added including the information above and appropriate
-- text summarizing the order information.
--ok

-- add_order_item (orderId IN order_items.order_id%type,
--  itemId IN order_items.item_id%type,
--  productId IN order_items.product_id%type,
--  quantity IN order_items.quantity%type,
--  price IN order_items.unit_price%type)

-- This procedure has five IN parameters. It stores the values of these
-- parameters to the table order_items.
-- This procedure needs to handle errors such as an invalid order ID
-- OK

-- display_order (orderId IN NUMBER)
-- This procedure has an input parameter to receive the order ID and no
-- output parameters.
-- This procedure will display the order items associated with a particular
-- order ID.
-- The information to be displayed should include:
--                                                                              • Order ID
--                                                                              • Customer ID
-- Then should display a row for each item in the order including:
--                                                                              • Item ID
--                                                                              • Product ID
--                                                                              • Quantity
--                                                                              • Price
-- Then should print a statement showing the total price of the entire
-- order.
-- There should be an appropriate message for a non-existent order ID


-- master_proc (task IN NUMBER,
-- parm1 IN NUMBER)
-- This procedure is a master procedure for four of the five procedures
-- above.
-- If task = 1, then, call find_customer(parm1)
-- If task = 2, then, call find_product(parm1)
-- If task = 3, then, call add_order(parm1)
-- If task = 4, then, call display-order(parm1)
-- In all cases, parm1 is the single input parameter required for the
-- specific function.
-- You need to handle appropriate error messages here as well.
-- What to include in your SQL file:
-- In your SQL file, you should include all of your:
-- CREATE OR REPLACE PROCEDURE commands (5)
-- CALL commands (14)


-- What to include in your OUTPUT file:
-- In your output file, you should include:
-- 1 – find_customer – with a valid customer ID
-- 2 – find_customer – with an invalid customer ID
-- 3 – find_product – with a valid product ID
-- 4 – find_product – with an invalid product ID
-- 5 – add_order – with a valid customer ID
-- 6 – add_order – with an invalid customer ID
-- 7 – add_order_item – should execute successfully 5 times
-- 8 – add_order_item – should execute with an invalid order ID
-- 9 – display_order – with a valid order ID which has at least 5 order
-- items
-- 10 – display_order – with an invalid order ID
-- For 1 – 6 and 9 – 10 – your call should be to the master_proc
-- procedure. It will call the actual procedure itself.


CREATE OR REPLACE PROCEDURE find_customer(customer_id IN NUMBER, found OUT NUMBER)
    IS
    --CREATE A CURSOR TO TRAVERSE THE CUSTOMERS TABLE
    CURSOR cust_cursor
        IS
        SELECT CUSTOMER_ID, NAME
        FROM CUSTOMERS;
BEGIN
    --TRAVERSE THE CUSTOMERS TABLE USING THE CURSOR
    FOR c in cust_cursor
        LOOP
            --THE CUSTOMER EXISTS, DISPLAY THEIR NAME AND ID
            IF (c.CUSTOMER_ID = customer_id) THEN
                found := 1;
                DBMS_OUTPUT.PUT_LINE(found || CHR(10) || 'Found: ' || C.CUSTOMER_ID || CHR(10) || 'Name: ' || c.NAME);
                EXIT;
            END IF;
        END LOOP;
--CUSTOMER ID IS NOT FOUND
    found := 0;
    DBMS_OUTPUT.PUT_LINE(found || CHR(10) || 'Sorry there is nobody with the id: ' || customer_id ||
                         ' in the database...');
EXCEPTION
    WHEN OTHERS THEN DBMS_OUTPUT.put_line('FIND_CUSTOMER: Oops something went wrong...' || CHR(10));
END;

CREATE OR REPLACE PROCEDURE find_product(product_id IN NUMBER, price OUT products.list_price%TYPE)
    IS
--CREATE A CURSOR TO TRAVERSE THE PRODUCTS TABLE
    CURSOR p_cursor
        IS
        SELECT PRODUCT_ID,
               PRODUCT_NAME,
               DESCRIPTION,
               LIST_PRICE
        FROM PRODUCTS;
BEGIN
    --TRAVERSE THE PRODUCTS TABLE
    FOR p in p_cursor
        LOOP
            -- THE PRODUCT ID EXISTS
            IF (p.PRODUCT_ID = product_id) THEN
                price := p.LIST_PRICE;
                DBMS_OUTPUT.PUT_LINE('Product found!' || CHR(10) || p.PRODUCT_ID || CHR(10) || p.PRODUCT_NAME ||
                                     CHR(10) || P.DESCRIPTION || CHR(10) || p.LIST_PRICE);
                EXIT;
            END IF;
        END LOOP;
    -- PRODUCT NOT FOUND
    price := 0;
    DBMS_OUTPUT.PUT_LINE('Sorry the Product you are looking for does not exist...');
EXCEPTION
    WHEN OTHERS THEN DBMS_OUTPUT.put_line('FIND_PRODUCT: Oops something went wrong...' || CHR(10));
END;


CREATE OR REPLACE PROCEDURE add_order(customer_id IN NUMBER, new_order_id OUT NUMBER)
    IS
    found NUMBER := 0;
BEGIN
    --SEARCH FOR THE CUSTOMER IN THE DATABASE
    find_customer(customer_id, found);
    --FOUND CUSTOMER
    IF (found = 1) THEN
        --CREATE A NEW ORDER ID, MAX + 1
        SELECT (MAX(ORDER_ID) + 1)
        INTO
            new_order_id
        FROM ORDERS;
        -- INSERT THE NEW ORDER INTO THE ORDERS TABLE...
        INSERT INTO ORDERS(ORDER_ID, CUSTOMER_ID, STATUS, SALESMAN_ID, ORDER_DATE)
        VALUES (new_order_id, customer_id, 'Shipped', 56, SYSDATE);
        COMMIT;
        --DISPLAY THE ORDER CONTENTS
        DBMS_OUTPUT.PUT_LINE('Order appended to the database!' || CHR(10) || new_order_id || CHR(10) || customer_id ||
                             CHR(10) || 'Shipped' || CHR(10) || 'Salesman id: ' || 56 ||
                             (TO_CHAR(SYSDATE, 'DD-MON-YY')));
    END IF;
    --IF CUSTOMER NOT FOUND, FIND_CUSTOMER WILL DISPLAY ITS OWN ERROR MESSAGE...
EXCEPTION
    WHEN OTHERS THEN DBMS_OUTPUT.put_line('ADD_ORDER: Oops something went wrong...' || CHR(10));
END;

-- CREATE OR REPLACE PROCEDURE add_order_item(orderId IN order_items.order_id%type, itemId IN order_items.item_id%type,
--                                            productId IN order_items.product_id%type,
--                                            quantity IN order_items.quantity%type,
--                                            price IN order_items.unit_price%type)
--     IS
--
-- BEGIN
--
-- END;


CREATE OR REPLACE PROCEDURE display_order(orderId IN NUMBER)
    IS
-- CREATE CURSOR TO TRAVERSE THE ORDERS TABLE JOIN ORDERS AND ORDER ITEMS HERE ON ORDER_ID
    id ORDERS.ORDER_ID%TYPE; --VARIABLE TO VALIDATE THE ORDER ID...
    CURSOR o_cursor
        IS
        SELECT o.ORDER_ID,
               o.CUSTOMER_ID,
               oi.ITEM_ID,
               oi.PRODUCT_ID,
               oi.QUANTITY,
               oi.UNIT_PRICE
        FROM ORDERS o
                 LEFT JOIN ORDER_ITEMS OI ON o.ORDER_ID = OI.ORDER_ID
        WHERE o.ORDER_ID = orderId;
BEGIN
    SELECT ORDER_ID
    INTO id
    FROM ORDERS
    WHERE ORDER_ID = orderId;

    FOR item in o_cursor
        LOOP
            DBMS_OUTPUT.PUT_LINE('Order ID: ' || item.ORDER_ID || CHR(10) ||
                                 'Customer ID : ' || item.CUSTOMER_ID || CHR(10) ||
                                 'Item ID: ' || item.ITEM_ID || CHR(10) ||
                                 'Product ID: ' || item.PRODUCT_ID || CHR(10) ||
                                 'QTY: ' || item.QUANTITY || CHR(10) ||
                                 'Unit Price: ' || item.UNIT_PRICE);
            DBMS_OUTPUT.PUT_LINE(CHR(10));
        END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('DISPLAY_ORDER. Sorry the order: ' || orderId ||
                                                 'does not exist in the database...');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('DISPLAY_ORDER: Oops something went wrong...');
END;