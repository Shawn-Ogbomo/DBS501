CREATE TYPE days_array AS varray(31) OF INTEGER;
CREATE TYPE months_array AS varray(12) OF INTEGER;
CREATE OR REPLACE PROCEDURE array_date(days_list days_array, months_list months_array)
AS
DECLARE
    max_days   NUMBER := 31;
    max_months NUMBER := 12;

    too_many_days EXCEPTION;
    too_many_months EXCEPTION;
    invalid_month EXCEPTION;
    invalid_day EXCEPTION;
    empty_array EXCEPTION;

    -- GET THE CURRENT YEAR
    year         NUMBER  := (EXTRACT(YEAR FROM SYSDATE));

    -- CREATE AN EXCEPTION FOR FRACTIONAL VALUES
    -- MONTHS AND DAYS CANNOT BE FRACTIONAL

    -- BOOLEAN TO DETERMINE IF THE YEAR IS A LEAP-YEAR
    is_leap_year BOOLEAN := FALSE ;

    -- MAX DAYS FOR EACH MONTH
    max_days_jan NUMBER  := 31;
    max_days_feb NUMBER  := 28;
    max_days_mar NUMBER  := 31;
    max_days_apr NUMBER  := 30;
    max_days_may NUMBER  := 31;
    max_days_jun NUMBER  := 30;
    max_days_jul NUMBER  := 31;
    max_days_aug NUMBER  := 31;
    max_days_sep NUMBER  := 30;
    max_days_oct NUMBER  := 31;
    max_days_nov NUMBER  := 30;
    max_days_dec NUMBER  := 31;

    -- MONTH NUMBERS
    jan          NUMBER  := 1;
    feb          NUMBER  := 2;
    mar          NUMBER  := 3;
    apr          NUMBER  := 4;
    may          NUMBER  := 5;
    jun          NUMBER  := 6;
    jul          NUMBER  := 7;
    aug          NUMBER  := 8;
    sep          NUMBER  := 9;
    oct          NUMBER  := 10;
    nov          NUMBER  := 11;
    dec          NUMBER  := 12;
BEGIN
    -- GET SIZE OF TWO ARRAYS

    IF (days_list.COUNT = 0 OR months_list.COUNT = 0) THEN
        RAISE empty_array;
    END IF;

    -- IF THE DAYS ARRAY HAS MORE THAN 31 VALS
    -- THROW AN EXCEPTION 

    IF (days_list.COUNT >= max_days) THEN
        RAISE too_many_days;
    END IF;


    -- IF THE MONTHS ARRAY HAS MORE THAN 12 DAYS
    -- THROW AN EXCEPTION 

    IF (months_list.COUNT >= max_months) THEN
        RAISE too_many_months;
    END IF;


    IF (MOD(year, 4) = 0) THEN
        IF (MOD(year, 100) = 0) THEN
            IF (MOD(year, 400)) THEN
                is_leap_year := TRUE;
            ELSE
                is_leap_year := FALSE;
            END IF;
        ELSE
            is_leap_year := TRUE;
        END IF;
    END IF;


    IF (is_leap_year = TRUE) THEN
        max_days_feb := 29;
    END IF;


-- TRAVERSE THE ARRAY OF DAYS AND MONTHS AND EVALUATE EACH INDEX AGAINST THE INVARIANT TO GET THE DATE

    FOR target_month in months_list
        LOOP
            IF (target_month <= 0 || target_month > max_months) THEN
                RAISE invalid_month;
            END IF;
            FOR target_day in days_list
                LOOP
                    CASE
                        WHEN target_month = jan THEN {
                    -- IF THE DAY IS GREATER THAN THE MAX DAYS FOR JAN 
                        --THROW AN EXCEPTION 
                            IF (target_day <= 0 OR target_day > max_days_jan) THEN
                                RAISE invalid_day;
                            END IF;

                            DBMS_OUTPUT.PUT_LINE('January ' || target_day || ', ' || year || CHR(10));
                            }
                        WHEN target_month = feb THEN {
                -- IF THE DAY IS GREATER THAN THE MAX DAYS FOR JAN 
                        --THROW AN EXCEPTION 
                            DBMS_OUTPUT.PUT_LINE('FEB ' || target_day || ', ' || year || CHR(10));

                            }
                        WHEN target_month = mar THEN {
                -- IF THE DAY IS GREATER THAN THE MAX DAYS FOR JAN 
                        --THROW AN EXCEPTION 
                            DBMS_OUTPUT.PUT_LINE('MAR ' || target_day || ', ' || year || CHR(10));

                            }
                        WHEN target_month = apr THEN {
                -- IF THE DAY IS GREATER THAN THE MAX DAYS FOR JAN 
                        --THROW AN EXCEPTION 
                            DBMS_OUTPUT.PUT_LINE('APR ' || target_day || ', ' || year || CHR(10));

                            }
                        WHEN target_month = may THEN {
                -- IF THE DAY IS GREATER THAN THE MAX DAYS FOR JAN 
                        --THROW AN EXCEPTION 
                            DBMS_OUTPUT.PUT_LINE('MAY ' || target_day || ', ' || year || CHR(10));

                            }
                        WHEN target_month = jun THEN {
                -- IF THE DAY IS GREATER THAN THE MAX DAYS FOR JAN 
                        --THROW AN EXCEPTION 
                            DBMS_OUTPUT.PUT_LINE('JUN ' || target_day || ', ' || year || CHR(10));

                            }
                        WHEN target_month = jul THEN {
                -- IF THE DAY IS GREATER THAN THE MAX DAYS FOR JAN 
                        --THROW AN EXCEPTION 
                            DBMS_OUTPUT.PUT_LINE('JUL ' || target_day || ', ' || year || CHR(10));

                            }
                        WHEN target_month = aug THEN {
                -- IF THE DAY IS GREATER THAN THE MAX DAYS FOR JAN 
                        --THROW AN EXCEPTION 
                            DBMS_OUTPUT.PUT_LINE('AUG ' || target_day || ', ' || year || CHR(10));

                            }
                        WHEN target_month = sep THEN {
                -- IF THE DAY IS GREATER THAN THE MAX DAYS FOR JAN 
                        --THROW AN EXCEPTION 
                            DBMS_OUTPUT.PUT_LINE('SEP ' || target_day || ', ' || year || CHR(10));

                            }
                        WHEN target_month = oct THEN {
                -- IF THE DAY IS GREATER THAN THE MAX DAYS FOR JAN 
                        --THROW AN EXCEPTION 
                            DBMS_OUTPUT.PUT_LINE('OCT ' || target_day || ', ' || year || CHR(10));

                            }
                        WHEN target_month = nov THEN {
                -- IF THE DAY IS GREATER THAN THE MAX DAYS FOR JAN 
                        --THROW AN EXCEPTION 
                            DBMS_OUTPUT.PUT_LINE('NOV ' || target_day || ', ' || year || CHR(10));

                            }
                        WHEN target_month = dec THEN {
                -- IF THE DAY IS GREATER THAN THE MAX DAYS FOR JAN 
                        --THROW AN EXCEPTION 
                            DBMS_OUTPUT.PUT_LINE('DEC ' || target_day || ', ' || year || CHR(10));

                            }
                        ELSE RAISE CASE_NOT_FOUND;
                        END CASE;
                END LOOP;
        END LOOP;

EXCEPTION
    WHEN
        CASE_NOT_FOUND THEN DBMS_OUTPUT.PUT_LINE('Invalid month...' || CHR(10));

    WHEN
        too_many_days THEN DBMS_OUTPUT.put_line('The maximum amount of days permitted is ' || max_days || CHR(10) ||
                                                'You entered: ' || days_list.COUNT || CHR(10));

    WHEN
        too_many_months THEN DBMS_OUTPUT.put_line('The maximum amount of months permitted is ' || max_months ||
                                                  CHR(10) || 'You entered: ' || months_list.COUNT || CHR(10));

    WHEN
        invalid_month THEN DBMS_OUTPUT.put_line('The month: ' || || ' is invalid...' || CHR(10)); --invalid month

    WHEN
        invalid_day THEN DBMS_OUTPUT.put_line('The day: ' || || ' is invalid...' || CHR(10)); --invalid day

    WHEN
        empty_array THEN DBMS_OUTPUT.put_line('An array is empty' || CHR(10));

    WHEN
        OTHERS THEN DBMS_OUTPUT.put_line('Oops something went wrong...' || CHR(10));
END;

DECLARE

BEGIN
    array_date((1, 5, 7), (2, 4));
END;