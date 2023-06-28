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
-- IF SUCCESSFUL, DISPLAY THE APPROPRIATE DATE ON THECONSOLE.

    FOR i in 1..months_list.LAST
        LOOP
            IF (months_list(i) <= 0 OR months_list(i) > 12) THEN
                RAISE invalid_month;
            END IF;
            last_day_of_month := TO_NUMBER((EXTRACT(DAY FROM LAST_DAY((EXTRACT(YEAR FROM SYSDATE)) || '-' ||
                                                                      (months_list(i)) || '-' ||
                                                                      (1)))));
            FOR j in days_list.FIRST..days_list.LAST
                LOOP
                    IF (days_list(j) > last_day_of_month) THEN
                        RAISE invalid_day;
                    END IF;
                    target_date := TO_DATE(
                                TO_CHAR(TO_DATE(months_list(months_list(i)), 'MM'), 'MON') || ' ' ||
                                days_list(j) || ' ' ||
                                year, 'MON DD YYYY');
                    day_in_week := TO_CHAR(target_date, 'DAY');
                    DBMS_OUTPUT.put_line(day_in_week || ', ' || TO_CHAR(target_date, 'Month') || ' ' || days_list(j) ||
                                         ', ' || year ||
                                         CHR(10));
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

--2 + 80
BEGIN
    array_date((1, 4, 5, 6), (11, 5, 6, 7));
END;