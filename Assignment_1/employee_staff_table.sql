--SET DEFINE OFF;

DROP TABLE employee;
DROP TABLE staff;

-- Create the EMPLOYEE table
create table employee
(
    EMPNO     char(6),
    FIRSTNAME varchar(12),
    MIDINIT   char(1),
    LASTNAME  varchar(15),
    WORKDEPT  char(3),
    PHONENO   char(4),
    HIREDATE  date,
    JOB       char(8),
    EDLEVEL   smallint,
    SEX       char(1),
    BIRTHDATE date,
    SALARY    decimal(9, 2),
    BONUS     decimal(9, 2),
    COMM      decimal(9, 2)
);

-- Create the STAFF table
create table staff
(
    ID     smallint,
    NAME   varchar(9),
    DEPT   smallint,
    JOB    char(5),
    YEARS  smallint,
    SALARY decimal(7, 2),
    COMM   decimal(7, 2)
);

DELETE
FROM employee;
DELETE
FROM staff;


--EMPLOYEE INSERTS...
INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000010', 'CHRISTINE', 'I', 'HAAS', 'A00', '3978', (DATE '1995-01-01'), 'PRES    ', 18, 'F',
        (DATE '1963-08-24'), +0152750.00, +0001000.00, +0004220.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000020', 'MICHAEL', 'L', 'THOMPSON', 'B01', '3476', (DATE '2003-10-10'), 'MANAGER ', 18, 'M',
        (DATE '1978-02-02'), +0094250.00, +0000800.00, +0003300.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000030', 'SALLY', 'A', 'KWAN', 'C01', '4738', (DATE '2005-04-05'), 'MANAGER ', 20, 'F', (DATE '1971-05-11'),
        +0098250.00, +0000800.00, +0003060.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000050', 'JOHN', 'B', 'GEYER', 'E01', '6789', (DATE '1979-08-17'), 'MANAGER ', 16, 'M', (DATE '1955-09-15'),
        +0080175.00, +0000800.00, +0003214.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('0060', 'IRVING', 'F', 'STERN', 'D11', '6423', (DATE '2003-09-14'), 'MANAGER ', 16, 'M', (DATE '1975-07-07'),
        +0072250.00, +0000500.00, +0002580.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000070', 'EVA', 'D', 'PULASKI', 'D21', '7831', (DATE '2005-09-30'), 'MANAGER ', 16, 'F', (DATE '2003-05-26'),
        +0096170.00, +0000700.00, +0002893.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000090', 'EILEEN', 'W', 'HENDERSON', 'E11', '5498', (DATE '2000-08-15'), 'MANAGER ', 16, 'F',
        (DATE '1971-05-15'), +0089750.00, +0000600.00, +0002380.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000100', 'THEODORE', 'Q', 'SPENSER', 'E21', '0972', (DATE '2000-06-19'), 'MANAGER ', 14, 'M',
        (DATE '1980-12-18'), +0086150.00, +0000500.00, +0002092.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000110', 'VINCENZO', 'G', 'LUCCHESSI', 'A00', '3490', (DATE '1988-05-16'), 'SALESREP', 19, 'M',
        (DATE '1959-11-05'), +0066500.00, +0000900.00, +0003720.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000120', 'SEAN', null, 'O''CONNELL', 'A00', '2167', (DATE '1993-12-05'), 'CLERK   ', 14, 'M',
        (DATE '1972-10-18'), +0049250.00, +0000600.00, +0002340.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000130', 'DELORES', 'M', 'QUINTANA', 'C01', '4578', (DATE '2001-07-28'), 'ANALYST ', 16, 'F',
        (DATE '1955-09-15'), +0073800.00, +0000500.00, +0001904.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000140', 'HEATHER', 'A', 'NICHOLLS', 'C01', '1793', (DATE '2006-12-15'), 'ANALYST ', 18, 'F',
        (DATE '1976-01-19'), +0068420.00, +0000600.00, +0002274.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000150', 'BRUCE', ' ', 'ADAMSON', 'D11', '4510', (DATE '2002-02-12'), 'DESIGNER', 16, 'M',
        (DATE '1977-05-17'), +0055280.00, +0000500.00, +0002022.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000160', 'ELIZABETH', 'R', 'PIANKA', 'D11', '3782', (DATE '2006-10-11'), 'DESIGNER', 17, 'F',
        (DATE '1980-04-12'), +0062250.00, +0000400.00, +0001780.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000170', 'MASATOSHI', 'J', 'YOSHIMURA', 'D11', '2890', (DATE '1999-09-15'), 'DESIGNER', 16, 'M',
        (DATE '1981-01-05'), +0044680.00, +0000500.00, +0001974.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000180', 'MARILYN', 'S', 'SCOUTTEN', 'D11', '1682', (DATE '2003-07-07'), 'DESIGNER', 17, 'F',
        (DATE '1979-02-21'), +0051340.00, +0000500.00, +0001707.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000190', 'JAMES', 'H', 'WALKER', 'D11', '2986', (DATE '2004-07-26'), 'DESIGNER', 16, 'M',
        (DATE '1982-06-25'), +0050450.00, +0000400.00, +0001636.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000200', 'DAVID', ' ', 'BROWN', 'D11', '4501', (DATE '2002-03-03'), 'DESIGNER', 16, 'M', (DATE '1971-05-29'),
        +0057740.00, +0000600.00, +0002217.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000210', 'WILLIAM', 'T', 'JONES', 'D11', '0942', (DATE '1998-04-11'), 'DESIGNER', 17, 'M', (DATE '2003-02-23'),
        +0068270.00,
        +0000400.00, +0001462.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000220', 'JENNIFER', 'K', 'LUTZ', 'D11', '0672', (DATE '1998-08-29'), 'DESIGNER', 18, 'F', (DATE '1978-03-19'),
        +0049840.00,
        +0000600.00, +0002387.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000230', 'JAMES', 'J', 'JEFFERSON', 'D21', '2094', (DATE '1996-11-21'), 'CLERK   ', 14, 'M',
        (DATE '1980-05-30'), +0042180.00,
        +0000400.00, +0001774.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000240', 'SALVATORE', 'M', 'MARINO', 'D21', '3780', (DATE '2004-12-05'), 'CLERK   ', 17, 'M',
        (DATE '2002-03-31'), +0048760.00,
        +0000600.00, +0002301.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000250', 'DANIEL', 'S', 'SMITH', 'D21', '0961', (DATE '1999-10-30'), 'CLERK   ', 15, 'M', (DATE '1969-11-12'),
        +0049180.00,
        +0000400.00, +0001534.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000260', 'SYBIL', 'P', 'JOHNSON', 'D21', '8953', (DATE '2005-09-11'), 'CLERK   ', 16, 'F', (DATE '1976-10-05'),
        +0047250.00,
        +0000300.00, +0001380.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000270', 'MARIA', 'L', 'PEREZ', 'D21', '9001', (DATE '2006-09-30'), 'CLERK   ', 15, 'F', (DATE '2003-05-26'),
        +0037380.00,
        +0000500.00, +0002190.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000280', 'ETHEL', 'R', 'SCHNEIDER', 'E11', '8997', (DATE '1997-03-24'), 'OPERATOR', 17, 'F',
        (DATE '1976-03-28'), +0036250.00,
        +0000500.00, +0002100.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000290', 'JOHN', 'R', 'PARKER', 'E11', '4502', (DATE '2006-05-30'), 'OPERATOR', 12, 'M', (DATE '1985-07-09'),
        +0035340.00,
        +0000300.00, +0001227.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000300', 'PHILIP', 'X', 'SMITH', 'E11', '95', (DATE '2002-06-19'), 'OPERATOR', 14, 'M', (DATE '1976-10-27'),
        +0037750.00,
        +0000400.00, +0001420.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000310', 'MAUDE', 'F', 'SETRIGHT', '1', '3332', (DATE '1994-09-12'), 'OPERATOR', 12, 'F', (DATE '1961-04-21'),
        +0035900.00,
        +0000300.00, +0001272.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000320', 'RAMLAL', 'V', 'MEHTA', 'E21', '9990', (DATE '1995-07-07'), 'FIELDREP', 16, 'M', (DATE '1962-08-11'),
        +0039950.00,
        +0000400.00, +0001596.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000330', 'WING', ' ', 'LEE', 'E21', '2103', (DATE '2006-02-23'), 'FIELDREP', 14, 'M', (DATE '1971-07-18'),
        +0045370.00, +0000500.00,
        +0002030.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('000340', 'JASON', 'R', 'GOUNOT', 'E21', '5698', (DATE '1977-05-05'), 'FIELDREP', 16, 'M', (DATE '1956-05-17'),
        +0043840.00,
        +0000500.00, +0001907.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('200010', 'DIAN', 'J', 'HEMMINGER', 'A00', '3978', (DATE '1995-01-01'), 'SALESREP', 18, 'F',
        (DATE '1973-08-14'), +0046500.00,
        +0001000.00, +0004220.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('200120', 'GREG', ' ', 'ORLANDO', 'A00', '2167', (DATE '2002-05-05'), 'CLERK   ', 14, 'M',
        (DATE '1972-10-18'), +0039250.00, +0000600.00, +0002340.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('200140', 'KIM', 'N', 'NATZ', 'C01', '1793', (DATE '2006-12-15'), 'ANALYST ', 18, 'F', (DATE '1976-01-19'),
        +0068420.00, +0000600.00, +0002274.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('200170', 'KIYOSHI', ' ', 'YAMAMOTO', 'D11', '2890', (DATE '2005-09-15'), 'DESIGNER', 16, 'M',
        (DATE '1981-01-05'), +0064680.00, +0000500.00, +0001974.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('200220', 'REBA', 'K', 'JOHN', 'D11', '0672', (DATE '2005-08-29'), 'DESIGNER', 18, 'F', (DATE '1978-03-19'),
        +0069840.00, +0000600.00, +0002387.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('200240', 'ROBERT', 'M', 'MONTEVERDE', 'D21', '3780', (DATE '2004-12-05'), 'CLERK   ', 17, 'M',
        (DATE '1984-03-31'), +0037760.00, +0000600.00, +0002301.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('200280', 'EILEEN', 'R', 'SCHWARTZ', 'E11', '8997', (DATE '1997-03-24'), 'OPERATOR', 17, 'F',
        (DATE '1966-03-28'), +0046250.00, +0000500.00, +0002100.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('200310', 'MICHELLE', 'F', 'SPRINGER', 'E11', '3332', (DATE '1994-09-12'), 'OPERATOR', 12, 'F',
        (DATE '1961-04-21'), +0035900.00, +0000300.00, +0001272.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('200330', 'HELENA', ' ', 'WONG', 'E21', '2103', (DATE '2006-02-23'), 'FIELDREP', 14, 'F', (DATE '1971-07-18'),
        +0035370.00, +0000500.00, +0002030.00);

INSERT INTO EMPLOYEE(empno, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                     salary, bonus, comm)
VALUES ('200340', 'ROY', 'R', 'ALONZO', 'E21', '5698', (DATE '1997-07-05'), 'FIELDREP', 16, 'M', (DATE '1956-05-17'),
        +0031840.00, +0000500.00, +0001907.00);


--STAFF INSERTS...
INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (10, 'Sanders', 20, 'Mgr  ', 7, +98357.50, null);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (20, 'Pernal', 20, 'Sales', 8, +78171.25, +00612.45);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (30, 'Marenghi', 38, 'Mgr  ', 5, +77506.75, null);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (40, 'O''Brien', 38, 'Sales', 6, +78006.00, +00846.55);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (50, 'Hanes', 15, 'Mgr  ', 10, +80659.80, null);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (60, 'Quigley', 38, 'Sales', null, +66808.30, +00650.25);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (70, 'Rothman', 15, 'Sales', 7, +76502.83, +01152.00);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (80, 'James', 20, 'Clerk', null, +43504.60, +00128.20);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (90, 'Koonitz', 42, 'Sales', 6, +38001.75, +01386.70);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (100, 'Plotz', 42, 'Mgr  ', 7, +78352.80, null);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (110, 'Ngan', 15, 'Clerk', 5, +42508.20, +00206.60);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (120, 'Naughton', 38, 'Clerk', null, +42954.75, +00180.00);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (130, 'Yamaguchi', 42, 'Clerk', 6, +40505.90, +00075.60);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (140, 'Fraye', 51, 'Mgr  ', 6, +91150.00, null);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (150, 'Williams', 51, 'Sales', 6, +79456.50, +00637.65);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (160, 'Molinare', 10, 'Mgr  ', 7, +82959.20, null);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (170, 'Kermisch', 15, 'Clerk', 4, +42258.50, +00110.10);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (180, 'Abrahams', 38, 'Clerk', 3, +37009.75, +00236.50);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (190, 'Sneider', 20, 'Clerk', 8, +34252.75, +00126.50);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (200, 'Scoutten', 42, 'Clerk', null, +41508.60, +00084.20);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (210, 'Lu', 10, 'Mgr  ', 10, +90010.00, null);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (220, 'Smith', 51, 'Sales', 7, +87654.50, +00992.80);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (230, 'Lundquist', 51, 'Clerk', 3, +83369.80, +00189.65);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (240, 'Daniels', 10, 'Mgr  ', 5, +79260.25, null);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (250, 'Wheeler', 51, 'Clerk', 6, +74460.00, +00513.30);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (260, 'Jones', 10, 'Mgr  ', 12, +81234.00, null);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (270, 'Lea', 66, 'Mgr  ', 9, +88555.50, null);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (280, 'Wilson', 66, 'Sales', 9, +78674.50, +00811.50);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (290, 'Quill', 84, 'Mgr  ', 10, +89818.00, null);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (300, 'Davis', 84, 'Sales', 5, +65454.50, +00806.10);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (310, 'Graham', 66, 'Sales', 13, +71000.00, +00200.30);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (320, 'Gonzales', 66, 'Sales', 4, +76858.20, +00844.00);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (330, 'Burke', 66, 'Clerk', 1, +49988.00, +00055.50);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (340, 'Edwards', 84, 'Sales', 7, +67844.00, +01285.00);

INSERT INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (350, 'Gafney', 84, 'Clerk', 5, +43030.50, +00188.00);