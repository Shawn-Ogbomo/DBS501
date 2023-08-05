create table SALARY_AUDIT
(
    EMPLOYEE_ID   NUMBER(7, 2),
    TRANSACTION   VARCHAR(6),
    "DATE"        DATE,
    SALARY        NUMBER(7, 2),
    COMM          NUMBER(7, 2),
    ERROR_MESSAGE VARCHAR(35)
);

select * from user_errors where type = 'TRIGGER' and name = 'TRIGCOM';