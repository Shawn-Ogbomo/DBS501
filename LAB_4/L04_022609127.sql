/*Name: Shawn Ogbomo
 Student# 022609127
 Date 07/20/2023
 Section DBS501NSC
 Instructor Riyadh Al-Essawi*/

--SET SERVEROUTPUT ON;


--QUESTION 1
--  Write a function called pig_latin that takes in as input a name – you can
-- use
--     the name column from the staff table – which is CHAR(9). For each name, it
-- will return the Pig Latin version of the name. See below the definition of Pig
-- Latin:
-- If the word does not
-- begin with a vowel – it takes the first letter and puts it at
-- the end of the word then adds “ay”. Examples:
-- Harrison -> arrisonhay
-- Smith -> mithsay
-- If the word does
-- begin with a vowel – it simply adds “ay” to the end of the
-- word. Examples:
-- Anderson -> Andersonay
-- Urly -> Urlyay
-- For the purposes of this task a vowel is: “a”, “e”, “I”, “o” or “u”
-- Make sure you test the function on several rows which include both cases
-- above.

CREATE OR REPLACE PROCEDURE pig_latin(target_name STAFF.NAME%TYPE)
    IS
    name_cpy             STAFF.NAME%TYPE;
    first_letter_of_name VARCHAR2(1) := SUBSTR(target_name, 1, 1);
    pig_latin_postfix    VARCHAR2(2) := 'ay';
BEGIN
    --CHECK IF THE TARGET NAME EXISTS IN THE STAFF TABLE
    SELECT NAME
    INTO name_cpy
    FROM STAFF
    WHERE NAME = target_name;

    -- IF TARGET NAME EXISTS CHECK IF IT STARTS WITH A VOWEL
    -- IF IT CONTAINS A VOWEL DISPLAY THE PIG_LATIN VERSION OF THE NAME
    -- ELSE
    --DISPLAY AN ERROR MESSAGE
    IF (first_letter_of_name IN ('A', 'E', 'I', 'O', 'U')) THEN
        DBMS_OUTPUT.PUT_LINE(TRIM(first_letter_of_name FROM name_cpy) || first_letter_of_name || pig_latin_postfix);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Sorry the name: ' || name_cpy || ' does not start with a vowel...');
    END IF;
    -- IF THE SELECT INTO IS UNSUCCESSFUL
-- DISPLAY A MESSAGE STATING THE THE TARGET NAME WAS NOT FOUND IN THE STAFF TABLE
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Sorry the name: ' || target_name ||
                                                 ' does not exist in the staff table..');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Oops, something went wrong...');
END;

DECLARE
    name  VARCHAR2(9) := 'Edwards';
    name2 VARCHAR2(9) := 'Shawn';
    name3 VARCHAR2(9) := 'Lu';
    name4 VARCHAR2(9) := 'Abrahams';
BEGIN
    pig_latin(name);
    pig_latin(name2);
    pig_latin(name3);
    pig_latin(name4);
END;
--QUESTION 2
-- . Write a function called experience which takes an integer as input – you can
-- use the years column in the staff table – and returns a character string as
-- follows:
-- If 0 <= years <= 4 then return “Junior”
-- If 5 <= years <= 9 then return “Intermediate”
-- If 10 <= years then return “Experienced”
-- Make sure you test the function on several rows which includes various years
-- values

CREATE OR REPLACE FUNCTION experience(years STAFF.YEARS%TYPE)
    RETURN Varchar2
    IS
BEGIN
    IF (0 <= years AND years <= 4) THEN
        RETURN 'Junior';
    ELSIF (5 <= years AND years <= 9) THEN
        RETURN 'Intermediate';
    ELSIF (10 <= years) THEN
        RETURN 'Experienced';
    END IF;

    RETURN 'Invalid experience...';
END;

DECLARE
    CURSOR staff_cursor
        IS
        SELECT NAME, YEARS
        FROM STAFF;
    title VARCHAR2(21);
BEGIN
    --TRAVERSE STAFF TABLE AND DISPLAY THE EMPLOYEES LEVEL OF EXPERIENCE
    -- IF THE YEARS FIELD IS NULL
    -- DISPLAY INVALID EXPERIENCE
    FOR employee in staff_cursor
        LOOP
            title := EXPERIENCE(employee.YEARS);
            DBMS_OUTPUT.PUT_LINE('Name: ' || employee.NAME || CHR(10) || 'Years: ' || employee.Years || CHR(10) ||
                                 title);
            DBMS_OUTPUT.PUT_LINE(CHR(10));
        END LOOP;
END;