CREATE OR REPLACE TYPE int_array IS VARRAY(31) OF INTEGER;

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