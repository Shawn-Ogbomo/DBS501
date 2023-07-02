-- SET SERVEROUTPUT ON;
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
--     months int_array := (11, 5, 6, 7);
BEGIN -- 2+ 80
    days := int_array(1, 5, 7);
    months := int_array(2, 4);
    array_date(days, months);
END;