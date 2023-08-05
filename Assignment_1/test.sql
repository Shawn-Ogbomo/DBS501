-- SELECT NAME
-- FROM STAFF
-- WHERE NAME LIKE 'A%'
--    OR NAME LIKE 'E%'
--    OR NAME LIKE 'I%'
--    OR NAME LIKE 'O%'
--    OR NAME LIKE 'U%';

DECLARE
    nom1 VARCHAR2(9) := 'Edwards';
    nom  VARCHAR(9);
BEGIN
    SELECT NAME
    INTO nom
    FROM STAFF
    WHERE NAME = nom1;

    DBMS_OUTPUT.PUT_LINE(nom);
END;