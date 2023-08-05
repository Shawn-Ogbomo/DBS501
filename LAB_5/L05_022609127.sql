/*Name: Shawn Ogbomo
 Student# 022609127
 Date 08/01/2023
 Section DBS501NSC
 Instructor Riyadh Al-Essawi*/

--SET SERVEROUTPUT ON;

--Question 1
-- Write a trigger which is called trigcom which is activated when an INSERT or
-- UPDATE takes place against the STAFF table. The trigger will check two
--     compensation items:
--     (a) Ensure that the COMMISSION amount is no more than 25% of the SALARY
--     (b) Ensure that the sum of COMMISSION and SALARY is at least 50,000.
--     If either (a) or (b) is true, you will report an appropriate message by recording
--     a record in a SALARY table.
--     There should be a different code depending on which rule was broken
--     No record should be INSERTed into the SALARY table if both rules (a) and (b)
--     are adhered to.
--     The SALARY table should have the following columns:
--     - Employee ID (ID)
--     - Date (Today’s date)
--     - Salary
--     - Commission
--     - Error Code
--     Make sure you test your trigger with 8 different situations – 3 INSERTS and 3
-- UPDATES:
-- - INSERT 1: One that works correctly – no rule broken – no record added to
-- the SALARY
-- - INSERT 2: One that fails on rule (a) – record added to SALARY
-- - INSERT 3: One that fails on rule (b) – record added to SALARY
-- - INSERT 4: One that fails on both (a) and (b) – record added to SALARY
-- - UPDATE 1: One that works correctly – no rule broken – no record added to
-- the SALARY
-- - UPDATE 2: One that fails on rule (a) – record added to SALARY
-- - UPDATE 3: One that fails on rule (b) – record added to SALARY
-- - UPDATE 4: One that fails on both (a) and (b) – record added to SALARY
-- You output should include the execution of the 4 INSERTs and 4 UPDATES.
-- Show the output of the STAFF table with the new / updated records. Show the
-- output of the SALAUD table with the 6 recorded error records


CREATE OR REPLACE TRIGGER trigcom
    AFTER
        INSERT OR UPDATE
    ON STAFF
    FOR EACH ROW
    WHEN (new.id > 0)
DECLARE
    transaction_type VARCHAR2(10);
    emp_id           STAFF.ID %TYPE;
    emp_sal          STAFF.SALARY %TYPE;
    emp_comm         STAFF.COMM %TYPE;
    err_code         VARCHAR2(35);
    NO_DATA EXCEPTION;
BEGIN
    transaction_type := CASE
                            WHEN INSERTING THEN 'INSERT'
                            WHEN UPDATING THEN 'UPDATE'
        END;

    emp_id := :new.ID;
    emp_sal := :new.SALARY;
    emp_comm := :new.COMM;


    DBMS_OUTPUT.PUT_LINE(emp_id || CHR(10) || emp_sal || CHR(10) || emp_comm);

    IF emp_comm > (0.25 * emp_sal) AND (emp_comm + emp_sal < 50000) THEN
        err_code := 'Both comm and salary are invalid...';
    ELSIF emp_comm > 0.25 * emp_sal THEN
        err_code := 'comm is invalid';
    ELSIF emp_comm + emp_sal < 50000 THEN
        err_code := 'salary is invalid...';
    ELSE
        RAISE NO_DATA;
    END IF;


    INSERT INTO SALARY_AUDIT(EMPLOYEE_ID, TRANSACTION, "DATE", SALARY, COMM, ERROR_MESSAGE)
    VALUES (emp_id, transaction_type, SYSDATE, emp_sal, emp_comm, err_code);
EXCEPTION
    WHEN NO_DATA THEN
        DBMS_OUTPUT.PUT_LINE('Oops, no data to record');
    When OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Oops, something went wrong...');
END;
/


BEGIN
    INSERT INTO STAFF(id, name, dept, job, years, salary, comm)
    VALUES (222, 'Jenny', 20, 'mgr', 10, 49988, 12);

    INSERT INTO STAFF(id, name, dept, job, years, salary, comm)
    VALUES (333, 'Rudy', 38, 'Sales', 5, 60000, 17000);

    INSERT INTO STAFF(id, name, dept, job, years, salary, comm)
    VALUES (444, 'Shawn', 15, 'Clerk', 8, 40000, 12);

    INSERT INTO STAFF(id, name, dept, job, years, salary, comm)
    VALUES (777, 'Sarah', 15, 'Clerk', 7, 30000, 8000);
END;