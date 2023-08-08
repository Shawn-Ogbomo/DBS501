CREATE OR REPLACE TYPE int_array IS VARRAY(20) OF INTEGER;

--QUESTION1
--(0%) This is preparation – It is very important to ensure you have
-- successfully ingested the data into both tables and have the exact
-- number of rows specified below. Double check this.
-- - Create the EMPLOYEE table and STAFF table based on DDL in the
-- dbs501-assignment-DDL file
-- - Take file dbs501-assignment-employee and load this data into an
-- employee table.
-- - Take file dbs501-assignment-staff and load this data into a staff
-- table
-- - Make sure all records have been successfully loaded or your result
-- sets may be incorrect
-- - Perform a SELECT COUNT(*) from both tables to ensure there is
-- an exact match with rows

SELECT COUNT(*)
FROM STAFF;
SELECT COUNT(*)
FROM EMPLOYEE;

--QUESTION 2
--(20%) Write a function called my_median which takes the values in
-- a column (like salary) as input and will output the mathematical median
-- of the values in that column.
-- The definition of median is:
-- X is the ordered list of elements
-- n is the number of elements in the list
-- Median(X) = X [(n+1)/2], if n is odd
-- Median(X) = (X [n/2] + X[(n/2)+1])/2, if n is event
-- Example:
-- Ordered list X = {5, 7, 10, 12, 15, 17}
-- Median(X) = ((X(3)+X(4))/2) = (10+12)/2 = 11
-- Ordered list X = {3, 5, 8, 15, 16}
-- Median(X) = X(3) = 8
-- Remember the list must be ordered, so, you must first ensure the list is
-- ordered in your UDF. If the list input is:
-- X = {5, 2, 8, 1, 5} you must first order the list to X = {1, 2, 5, 5, 8}
-- WHAT TO HAND IN: A copy of your user defined function and the
-- output of 3 calls showing your UDF works properly. Make sure to
-- handle errors (like an empty list). Your 3 calls should be:
-- - A list with an event amount of elements
-- - A list with an odd amount of elements
-- - An empty list


CREATE OR REPLACE FUNCTION my_median(list IN OUT int_array)
    RETURN NUMBER
    IS
    list_size Number(7, 2);
    invalid_list EXCEPTION;
    first_middle  NUMBER;
    second_middle NUMBER;
    temp          NUMBER;
BEGIN
    list_size := list.COUNT;

    IF (list_size = 0 OR list_size = 1) THEN
        RAISE invalid_list;
    END IF;

    --SORT THE LIST
    for i in 1..list.COUNT
        LOOP
            for j in 1..list.COUNT
                LOOP
                    IF list(i) < list(j) THEN
                        temp := list(i);
                        list(i) := list(j);
                        list(j) := temp;
                    END IF;
                END LOOP;
        END LOOP;


    --IS THE NUMBER ODD?
    IF (MOD(list_size, 2) = 1) THEN
        RETURN list((list_size + 1) / 2);
    END IF;

    first_middle := list(list_size / 2);
    second_middle := list((list_size / 2) + 1);

    RETURN (first_middle + second_middle) / 2;
EXCEPTION
    WHEN
        invalid_list THEN
        DBMS_OUTPUT.PUT_LINE('Cant find median with a list size of 0 or 1...');
        RETURN NULL;
END;

DECLARE
    vals   int_array;
    result NUMBER(7, 2);
BEGIN
    vals := int_array(6, 5, 6, 5, 4, 3, 21);
    result := my_median(vals);
    --MEDIAN WITH AN ODD LIST
    DBMS_OUTPUT.PUT_LINE(result);

    --MEDIAN WITH AN EVEN LIST
    vals := int_array(6, 10, 412, 55, 74, 3, 21, 100);
    result := my_median(vals);
    DBMS_OUTPUT.PUT_LINE(result);

    --MEDIAN WITH AN ONLY 1 VALUE
    vals := int_array(6);
    result := my_median(vals);
    DBMS_OUTPUT.PUT_LINE(result);

    --MEDIAN WITH AN EMPTY LIST SIZE
    vals := int_array(6);
    result := my_median(vals);
    DBMS_OUTPUT.PUT_LINE(result);
END;


--QUESTION 3
--(20%) Write a function called my_mode which takes the values in a
-- column (like department) as input and will output the mathematical
-- mode of the values in that column.
-- The definition of mode is the value which occurs most frequently in the
-- list. There are three cases:
-- A – There is one mode in the list
-- B – There are multiple modes in the list
-- C – There are no modes in the list
-- Example of A:
-- X = {1, 2, 3, 4, 2, 6, 5, 5, 2, 3, 2}
-- Mode = 2, since 2 occurs 4 times
-- Example of B:
-- X = {1, 2, 7, 4, 3, 2, 6, 5, 5, 8, 0}
-- Mode = 2, 5 – since both numbers occurs twice while all others are
-- once
-- Example of C:
-- X = {1, 2, 3, 4, 5, 6, 7, 8. 9. 0}
-- There is no mode since all numbers occur exactly once
-- WHAT TO HAND IN: A copy of your user defined function and the
-- output of 4 calls showing your UDF works properly. Make sure to
-- handle errors (like an empty list). Your 4 calls should be:
-- - A list with zero modes

CREATE OR REPLACE FUNCTION my_mode(list int_array)
    RETURN INT_ARRAY
    IS
    list_size Number(7, 2);
    invalid_list EXCEPTION;
    no_mode EXCEPTION;
    total_occurrences NUMBER;
    occurrences       int_array;
    pos               NUMBER;
    max_occurrences   NUMBER;
    modes             int_array;
    found_duplicates  BOOLEAN;
BEGIN
    list_size := list.COUNT;

    occurrences := int_array(-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1);
    IF list_size = 0 THEN
        RAISE invalid_list;
    END IF;

    IF list_size = 1 THEN
        RAISE no_mode;
    END IF;

    pos := 1;

    for i in 1..list.COUNT
        LOOP
            total_occurrences := 0;
            for j in 1..list.COUNT
                LOOP
                    IF list(j) = list(i) THEN
                        total_occurrences := total_occurrences + 1;
                    END IF;
                    IF (j = list.COUNT) THEN
                        occurrences(pos) := total_occurrences;
                        pos := pos + 1;
                    END IF;
                END LOOP;
        END LOOP;

    --FIND THE MAX NUMBER OF OCCURRENCES IN THE ARRAY OCCURRENCES
    max_occurrences := occurrences(1);

    for i in 1..occurrences.COUNT
        LOOP
            IF occurrences(i) > max_occurrences THEN
                max_occurrences := occurrences(i);
            END IF;
        END LOOP;

    IF max_occurrences = 1 THEN
        RAISE no_mode;
    END IF;

    -- GET MODE
    modes := int_array(-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1);
    pos := 1;
    found_duplicates := false;
    for i in 1..occurrences.COUNT
        LOOP
            IF occurrences(i) = max_occurrences THEN
                for j in i..list.COUNT
                    LOOP
                        for k in 1..list.COUNT
                            LOOP
                                IF list(j) = modes(k) THEN
                                    found_duplicates := true;
                                    EXIT;
                                END IF;
                            END LOOP;
                        IF found_duplicates = false THEN
                            modes(pos) := list(i);
                            pos := pos + 1;
                            EXIT;
                        END IF;
                        found_duplicates := false;
                        EXIT;
                    END LOOP;
            END IF;
        END LOOP;
    RETURN modes;

EXCEPTION
    WHEN
        invalid_list THEN
        DBMS_OUTPUT.PUT_LINE('Cannot  find the mode of an empty list...');
        RETURN NULL;
    WHEN
        no_mode THEN
        DBMS_OUTPUT.PUT_LINE('No mode...');
        RETURN NULL;
    WHEN
        OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Oops something went wrong...');
        RETURN NULL;
END;

DECLARE
    vals  int_array;
    modes int_array;
BEGIN
    --CALL WITH AN EMPTY LIST
    vals := int_array();
    modes := my_mode(vals);

    for i in 1..modes.COUNT
        LOOP
            IF modes(i) != -1 THEN
                DBMS_OUTPUT.PUT_LINE(modes(i) || chr(10));
            END IF;
        END LOOP;

    --CALL WITH 0 MODES
    vals := int_array(1, 2, 3, 4, 5);
    modes := my_mode(vals);

    --CALL WITH 1 MODE
    vals := int_array(1, 2, 3, 4, 5, 7, 7);
    modes := my_mode(vals);

    for i in 1..modes.COUNT
        LOOP
            IF modes(i) != -1 THEN
                DBMS_OUTPUT.PUT_LINE(modes(i) || chr(10));
            END IF;
        END LOOP;

    --CALL WITH 2 MODES
    vals := int_array(1, 2, 3, 4, 5, 7, 7, 11, 11, 0, 0, 0, 99, 100);
    modes := my_mode(vals);

    for i in 1..modes.COUNT
        LOOP
            IF modes(i) != -1 THEN
                DBMS_OUTPUT.PUT_LINE(modes(i) || chr(10));
            END IF;
        END LOOP;
END;