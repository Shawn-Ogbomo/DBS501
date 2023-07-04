SET DEFINE OFF;

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

INSERT ALL
    INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate,
                  salary, bonus, comm)
VALUES ("000010", "CHRISTINE", "I", "HAAS", "A00", "3978", 19950101, "PRES    ", 18, "F", 19630824, +0152750.00, +0001000.00, +0004220.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000020", "MICHAEL", "L", "THOMPSON", "B01", "3476", 20031010, "MANAGER ", 18, "M", 19780202, +0094250.00, +0000800.00, +0003300.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000030", "SALLY", "A", "KWAN", "C01", "4738", 20050405, "MANAGER ", 20, "F", 19710511, +0098250.00, +0000800.00, +0003060.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000050", "JOHN", "B", "GEYER", "E01", "6789", 19790817, "MANAGER ", 16, "M", 19550915, +0080175.00, +0000800.00, +0003214.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000060", "IRVING", "F", "STERN", "D11", "6423", 20030914, "MANAGER ", 16, "M", 19750707, +0072250.00, +0000500.00, +0002580.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000070", "EVA", "D", "PULASKI", "D21", "7831", 20050930, "MANAGER ", 16, "F", 20030526, +0096170.00, +0000700.00, +0002893.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000090", "EILEEN", "W", "HENDERSON", "E11", "5498", 20000815, "MANAGER ", 16, "F", 19710515, +0089750.00, +0000600.00, +0002380.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000100", "THEODORE", "Q", "SPENSER", "E21", "0972", 20000619, "MANAGER ", 14, "M", 19801218, +0086150.00, +0000500.00, +0002092.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000110", "VINCENZO", "G", "LUCCHESSI", "A00", "3490", 19880516, "SALESREP", 19, "M", 19591105, +0066500.00, +0000900.00, +0003720.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000120", "SEAN", " ", "O'CONNELL", "A00", "2167", 19931205, "CLERK   ", 14, "M", 19721018, +0049250.00, +0000600.00, +0002340.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000130", "DELORES", "M", "QUINTANA", "C01", "4578", 20010728, "ANALYST ", 16, "F", 19550915, +0073800.00, +0000500.00, +0001904.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000140", "HEATHER", "A", "NICHOLLS", "C01", "1793", 20061215, "ANALYST ", 18, "F", 19760119, +0068420.00, +0000600.00, +0002274.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000150", "BRUCE", " ", "ADAMSON", "D11", "4510", 20020212, "DESIGNER", 16, "M", 19770517, +0055280.00, +0000500.00, +0002022.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000160", "ELIZABETH", "R", "PIANKA", "D11", "3782", 20061011, "DESIGNER", 17, "F", 19800412, +0062250.00, +0000400.00, +0001780.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000170", "MASATOSHI", "J", "YOSHIMURA", "D11", "2890", 19990915, "DESIGNER", 16, "M", 19810105, +0044680.00, +0000500.00, +0001974.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000180", "MARILYN", "S", "SCOUTTEN", "D11", "1682", 20030707, "DESIGNER", 17, "F", 19790221, +0051340.00, +0000500.00, +0001707.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000190", "JAMES", "H", "WALKER", "D11", "2986", 20040726, "DESIGNER", 16, "M", 19820625, +0050450.00, +0000400.00, +0001636.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000200", "DAVID", " ", "BROWN", "D11", "4501", 20020303, "DESIGNER", 16, "M", 19710529, +0057740.00, +0000600.00, +0002217.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000210", "WILLIAM", "T", "JONES", "D11", "0942", 19980411, "DESIGNER", 17, "M", 20030223, +0068270.00, +0000400.00, +0001462.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000220", "JENNIFER", "K", "LUTZ", "D11", "0672", 19980829, "DESIGNER", 18, "F", 19780319, +0049840.00, +0000600.00, +0002387.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000230", "JAMES", "J", "JEFFERSON", "D21", "2094", 19961121, "CLERK   ", 14, "M", 19800530, +0042180.00, +0000400.00, +0001774.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000240", "SALVATORE", "M", "MARINO", "D21", "3780", 20041205, "CLERK   ", 17, "M", 20020331, +0048760.00, +0000600.00, +0002301.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000250", "DANIEL", "S", "SMITH", "D21", "0961", 19991030, "CLERK   ", 15, "M", 19691112, +0049180.00, +0000400.00, +0001534.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000260", "SYBIL", "P", "JOHNSON", "D21", "8953", 20050911, "CLERK   ", 16, "F", 19761005, +0047250.00, +0000300.00, +0001380.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000270", "MARIA", "L", "PEREZ", "D21", "9001", 20060930, "CLERK   ", 15, "F", 20030526, +0037380.00, +0000500.00, +0002190.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000280", "ETHEL", "R", "SCHNEIDER", "E11", "8997", 19970324, "OPERATOR", 17, "F", 19760328, +0036250.00, +0000500.00, +0002100.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000290", "JOHN", "R", "PARKER", "E11", "4502", 20060530, "OPERATOR", 12, "M", 19850709, +0035340.00, +0000300.00, +0001227.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000300", "PHILIP", "X", "SMITH", "E11", "2095", 20020619, "OPERATOR", 14, "M", 19761027, +0037750.00, +0000400.00, +0001420.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000310", "MAUDE", "F", "SETRIGHT", "E11", "3332", 19940912, "OPERATOR", 12, "F", 19610421, +0035900.00, +0000300.00, +0001272.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000320", "RAMLAL", "V", "MEHTA", "E21", "9990", 19950707, "FIELDREP", 16, "M", 19620811, +0039950.00, +0000400.00, +0001596.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000330", "WING", " ", "LEE", "E21", "2103", 20060223, "FIELDREP", 14, "M", 19710718, +0045370.00, +0000500.00, +0002030.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("000340", "JASON", "R", "GOUNOT", "E21", "5698", 19770505, "FIELDREP", 16, "M", 19560517, +0043840.00, +0000500.00, +0001907.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("200010", "DIAN", "J", "HEMMINGER", "A00", "3978", 19950101, "SALESREP", 18, "F", 19730814, +0046500.00, +0001000.00, +0004220.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("200120", "GREG", " ", "ORLANDO", "A00", "2167", 20020505, "CLERK   ", 14, "M", 19721018, +0039250.00, +0000600.00, +0002340.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("200140", "KIM", "N", "NATZ", "C01", "1793", 20061215, "ANALYST ", 18, "F", 19760119, +0068420.00, +0000600.00, +0002274.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("200170", "KIYOSHI", " ", "YAMAMOTO", "D11", "2890", 20050915, "DESIGNER", 16, "M", 19810105, +0064680.00, +0000500.00, +0001974.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("200220", "REBA", "K", "JOHN", "D11", "0672", 20050829, "DESIGNER", 18, "F", 19780319, +0069840.00, +0000600.00, +0002387.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("200240", "ROBERT", "M", "MONTEVERDE", "D21", "3780", 20041205, "CLERK   ", 17, "M", 19840331, +0037760.00, +0000600.00, +0002301.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("200280", "EILEEN", "R", "SCHWARTZ", "E11", "8997", 19970324, "OPERATOR", 17, "F", 19660328, +0046250.00, +0000500.00, +0002100.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("200310", "MICHELLE", "F", "SPRINGER", "E11", "3332", 19940912, "OPERATOR", 12, "F", 19610421, +0035900.00, +0000300.00, +0001272.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("200330", "HELENA", " ", "WONG", "E21", "2103", 20060223, "FIELDREP", 14, "F", 19710718, +0035370.00, +0000500.00, +0002030.00)

INTO EMPLOYEE(emp_no, firstname, midinit, lastname, workdept, phoneno, hiredate, job, edlevel, sex, birthdate, salary,
              bonus, comm)
VALUES ("200340", "ROY", "R", "ALONZO", "E21", "5698", 19970705, "FIELDREP", 16, "M", 19560517, +0031840.00, +0000500.00, +0001907.00)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (10, "Sanders", 20, "Mgr  ", 7, +98357.50, )

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (20, "Pernal", 20, "Sales", 8, +78171.25, +00612.45)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (30, "Marenghi", 38, "Mgr  ", 5, +77506.75, )

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (40, "O'Brien", 38, "Sales", 6, +78006.00, +00846.55)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (50, "Hanes", 15, "Mgr  ", 10, +80659.80, )

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (60, "Quigley", 38, "Sales", , +66808.30, +00650.25)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (70, "Rothman", 15, "Sales", 7, +76502.83, +01152.00)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (80, "James", 20, "Clerk", , +43504.60, +00128.20)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (90, "Koonitz", 42, "Sales", 6, +38001.75, +01386.70)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (100, "Plotz", 42, "Mgr  ", 7, +78352.80, )

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (110, "Ngan", 15, "Clerk", 5, +42508.20, +00206.60)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (120, "Naughton", 38, "Clerk", , +42954.75, +00180.00)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (130, "Yamaguchi", 42, "Clerk", 6, +40505.90, +00075.60)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (140, "Fraye", 51, "Mgr  ", 6, +91150.00, )

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (150, "Williams", 51, "Sales", 6, +79456.50, +00637.65)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (160, "Molinare", 10, "Mgr  ", 7, +82959.20, )

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (170, "Kermisch", 15, "Clerk", 4, +42258.50, +00110.10)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (180, "Abrahams", 38, "Clerk", 3, +37009.75, +00236.50)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (190, "Sneider", 20, "Clerk", 8, +34252.75, +00126.50)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (200, "Scoutten", 42, "Clerk", , +41508.60, +00084.20)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (210, "Lu", 10, "Mgr  ", 10, +90010.00, )

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (220, "Smith", 51, "Sales", 7, +87654.50, +00992.80)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (230, "Lundquist", 51, "Clerk", 3, +83369.80, +00189.65)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (240, "Daniels", 10, "Mgr  ", 5, +79260.25, )

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (250, "Wheeler", 51, "Clerk", 6, +74460.00, +00513.30)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (260, "Jones", 10, "Mgr  ", 12, +81234.00, )

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (270, "Lea", 66, "Mgr  ", 9, +88555.50, )

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (280, "Wilson", 66, "Sales", 9, +78674.50, +00811.50)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (290, "Quill", 84, "Mgr  ", 10, +89818.00, )

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (300, "Davis", 84, "Sales", 5, +65454.50, +00806.10)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (310, "Graham", 66, "Sales", 13, +71000.00, +00200.30)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (320, "Gonzales", 66, "Sales", 4, +76858.20, +00844.00)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (330, "Burke", 66, "Clerk", 1, +49988.00, +00055.50)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (340, "Edwards", 84, "Sales", 7, +67844.00, +01285.00)

INTO STAFF(ID, NAME, DEPT, JOB, YEARS, SALARY, COMM)
VALUES (350, "Gafney", 84, "Clerk", 5, +43030.50, +00188.00)