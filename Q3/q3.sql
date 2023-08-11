create table DBS501_232NSC28.student_info
(
    FIRST_NAME VARCHAR(50),
    LAST_NAME  VARCHAR(50),
    STUDENT_ID VARCHAR(9),
    EMAIL      VARCHAR(40)
);

create table DBS501_232NSC28.Courses
(
    COURSE_NAME VARCHAR(50),
    COURSE_ID   VARCHAR2(3),
    "LEVEL"     NUMBER,
    DESCRIPTION VARCHAR(50)
);

create table DBS501_232NSC28.Grade
(
    STUDENT_ID      VARCHAR2(9),
    COURSE_ID       VARCHAR2(3),
    GRADE_NO        NUMBER(7, 2),
    GRADE_CHARACTER CHAR(2)
);


INSERT INTO STUDENT_INFO(FIRST_NAME, LAST_NAME, STUDENT_ID, EMAIL)
VALUES ('Shawn', 'Ogbomo', '784569832', 'Shawn_O@123.com');

INSERT INTO STUDENT_INFO(FIRST_NAME, LAST_NAME, STUDENT_ID, EMAIL)
VALUES ('Jenny', 'Bing', '111222333', 'Jenny_B@123.com');

INSERT INTO STUDENT_INFO(FIRST_NAME, LAST_NAME, STUDENT_ID, EMAIL)
VALUES ('Jack', 'Jones', '777888999', 'Jack_J@123.com');

INSERT INTO STUDENT_INFO(FIRST_NAME, LAST_NAME, STUDENT_ID, EMAIL)
VALUES ('Kevin', 'Black', '000111222', 'Kevin_B@123.com');

INSERT INTO STUDENT_INFO(FIRST_NAME, LAST_NAME, STUDENT_ID, EMAIL)
VALUES ('Lue', 'Green', '333333333', 'Lue_G@123.com');

INSERT INTO STUDENT_INFO(FIRST_NAME, LAST_NAME, STUDENT_ID, EMAIL)
VALUES ('Shawn', 'Love', '555555555', 'Shawn_L@123.com');

INSERT INTO STUDENT_INFO(FIRST_NAME, LAST_NAME, STUDENT_ID, EMAIL)
VALUES ('Sarah', 'Ding', '444444444', 'Sarah_D@123.com');

INSERT INTO STUDENT_INFO(FIRST_NAME, LAST_NAME, STUDENT_ID, EMAIL)
VALUES ('Lewis', 'Franks', '222222222', 'Lewis_F@123.com');

INSERT INTO STUDENT_INFO(FIRST_NAME, LAST_NAME, STUDENT_ID, EMAIL)
VALUES ('Mark', 'Christmas', '888888888', 'Mark_C@123.com');

INSERT INTO STUDENT_INFO(FIRST_NAME, LAST_NAME, STUDENT_ID, EMAIL)
VALUES ('Ruth', 'Holiday', '547896383', 'Ruth_H@123.com');



INSERT INTO COURSES(course_name, course_id, "LEVEL", description)
VALUES ('OOP', 'ZZZ', 1000, 'intro to object oriented programming');

INSERT INTO COURSES(course_name, course_id, "LEVEL", description)
VALUES ('NET', 'AAA', 2000, 'advanced networks');

INSERT INTO COURSES(course_name, course_id, "LEVEL", description)
VALUES ('MAT', 'VVV', 1000, 'intro to discrete mathematics');

INSERT INTO COURSES(course_name, course_id, "LEVEL", description)
VALUES ('CA', 'BBB', 1000, 'intro to computer architecture');

INSERT INTO COURSES(course_name, course_id, "LEVEL", description)
VALUES ('SYS', 'CCC', 1000, 'intro to software design');

INSERT INTO COURSES(course_name, course_id, "LEVEL", description)
VALUES ('DSA', 'EEE', 1000, 'intro to data structures and algorithms');

INSERT INTO COURSES(course_name, course_id, "LEVEL", description)
VALUES ('Comp', 'FFF', 1000, 'intro to compilers');

INSERT INTO COURSES(course_name, course_id, "LEVEL", description)
VALUES ('DBS', 'GGG', 1000, 'intro to databases');

INSERT INTO COURSES(course_name, course_id, "LEVEL", description)
VALUES ('SYSA', 'HHH', 2000, 'advanced software design');

INSERT INTO COURSES(course_name, course_id, "LEVEL", description)
VALUES ('ENG', 'JJJ', 1000, 'intro to english');

--QUESTION 1
-- - write a trigger name GRADES after
-- Insert,
-- update data
-- on Grade table to :
--     a - evaluate the grade- no to calculate the grade_character and reinsert in grade_table
--     for example:
--
--     (student_id, course_id, grade_no)
-- values (1, 1, 90)
--
-- on table will be (student_id, course_id, grade_no and grade_character) (1,1,90, A +)

CREATE VIEW GRADES_MASTER AS
SELECT STUDENT_ID,
       COURSE_ID,
       GRADE_NO,
       GRADE_CHARACTER
FROM GRADE;

CREATE OR REPLACE TRIGGER GRADES
    INSTEAD OF
        INSERT OR UPDATE
    ON GRADES_MASTER
    FOR EACH ROW

DECLARE
    s_student_id GRADE.STUDENT_ID%TYPE;
    s_grade_num  GRADE.GRADE_NO%TYPE;
BEGIN
    s_grade_num := :new.GRADE_NO;
    s_student_id := :new.STUDENT_ID;

    IF s_grade_num >= 90 AND s_grade_num <= 100 THEN
        INSERT INTO GRADE(STUDENT_ID, COURSE_ID, GRADE_NO, GRADE_CHARACTER)
        VALUES (s_student_id,:new.COURSE_ID,:new.GRADE_NO,'A+');

    ELSIF s_grade_num >= 85.00 AND s_grade_num <= 89.99 THEN
        INSERT INTO GRADE(STUDENT_ID, COURSE_ID, GRADE_NO, GRADE_CHARACTER)
        VALUES (s_student_id,:new.COURSE_ID,:new.GRADE_NO,'A');

    ELSIF s_grade_num >= 80.00 AND s_grade_num <= 84.00 THEN
        INSERT INTO GRADE(STUDENT_ID, COURSE_ID, GRADE_NO, GRADE_CHARACTER)
        VALUES (s_student_id,:new.COURSE_ID,:new.GRADE_NO,'A-');

    ELSIF s_grade_num >= 77.00 AND s_grade_num <= 79.00 THEN
        INSERT INTO GRADE(STUDENT_ID, COURSE_ID, GRADE_NO, GRADE_CHARACTER)
        VALUES (s_student_id,:new.COURSE_ID,:new.GRADE_NO,'B+');

    ELSIF s_grade_num >= 73.00 AND s_grade_num <= 76.00 THEN
        INSERT INTO GRADE(STUDENT_ID, COURSE_ID, GRADE_NO, GRADE_CHARACTER)
        VALUES (s_student_id,:new.COURSE_ID,:new.GRADE_NO,'B');

    ELSIF s_grade_num >= 70.00 AND s_grade_num <= 72.00 THEN
        INSERT INTO GRADE(STUDENT_ID, COURSE_ID, GRADE_NO, GRADE_CHARACTER)
        VALUES (s_student_id,:new.COURSE_ID,:new.GRADE_NO,'B-');

    ELSIF s_grade_num >= 67.00 AND s_grade_num <= 69.00 THEN
        INSERT INTO GRADE(STUDENT_ID, COURSE_ID, GRADE_NO, GRADE_CHARACTER)
        VALUES (s_student_id,:new.COURSE_ID,:new.GRADE_NO,'C+');

    ELSIF s_grade_num >= 63.00 AND s_grade_num <= 66.00 THEN
        INSERT INTO GRADE(STUDENT_ID, COURSE_ID, GRADE_NO, GRADE_CHARACTER)
        VALUES (s_student_id,:new.COURSE_ID,:new.GRADE_NO,'C');

    ELSIF s_grade_num >= 60.00 AND s_grade_num <= 62.00 THEN
        INSERT INTO GRADE(STUDENT_ID, COURSE_ID, GRADE_NO, GRADE_CHARACTER)
        VALUES (s_student_id,:new.COURSE_ID,:new.GRADE_NO,'C-');

    ELSIF s_grade_num >= 57.00 AND s_grade_num <= 59.00 THEN
        INSERT INTO GRADE(STUDENT_ID, COURSE_ID, GRADE_NO, GRADE_CHARACTER)
        VALUES (s_student_id,:new.COURSE_ID,:new.GRADE_NO,'D+');
    ELSIF s_grade_num >= 53.00 AND s_grade_num <= 56.00 THEN
        INSERT INTO GRADE(STUDENT_ID, COURSE_ID, GRADE_NO, GRADE_CHARACTER)
        VALUES (s_student_id,:new.COURSE_ID,:new.GRADE_NO,'D');

    ELSIF s_grade_num >= 50.00 AND s_grade_num <= 52.00 THEN
        INSERT INTO GRADE(STUDENT_ID, COURSE_ID, GRADE_NO, GRADE_CHARACTER)
        VALUES (s_student_id,:new.COURSE_ID,:new.GRADE_NO,'D-');

    ELSIF s_grade_num >= 0 AND s_grade_num <= 49.99 THEN
        INSERT INTO GRADE(STUDENT_ID, COURSE_ID, GRADE_NO, GRADE_CHARACTER)
        VALUES (s_student_id,:new.COURSE_ID,:new.GRADE_NO,'F');
    END IF;

EXCEPTION
    WHEN
        OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Oops, something went wrong...');
END;
/


DECLARE

BEGIN
    INSERT INTO GRADES_MASTER(STUDENT_ID, COURSE_ID, GRADE_NO, GRADE_CHARACTER)
    VALUES ('784569832', 'ZZZ', 95, NULL);

    INSERT INTO GRADES_MASTER(STUDENT_ID, COURSE_ID, GRADE_NO, GRADE_CHARACTER)
    VALUES ('784569832', 'ZZZ', 86, NULL);

    INSERT INTO GRADES_MASTER(STUDENT_ID, COURSE_ID, GRADE_NO, GRADE_CHARACTER)
    VALUES ('111222333', 'AAA', 75, NULL);

    INSERT INTO GRADES_MASTER(STUDENT_ID, COURSE_ID, GRADE_NO, GRADE_CHARACTER)
    VALUES ('222222222', 'VVV', 65, NULL);

    INSERT INTO GRADES_MASTER(STUDENT_ID, COURSE_ID, GRADE_NO, GRADE_CHARACTER)
    VALUES ('888888888', 'BBB', 76, NULL);
END;