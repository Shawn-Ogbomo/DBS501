/*Name: Shawn Ogbomo
 Student# 022609127
 Date 06/01/2023
 Section DBS501NSC
 Instructor Riyadh Al-Essawi*/

--1. Write a store procedure called factorial that gets an integer number n and 
--calculates and displays its factorial. You must use RECURSION to calculate the 
--results.
--Example:
--0! = 1
--1! = fact(1) = 1
--2! = fact(2) = 2 * 1 = 2
--3! = fact(3) = 3 * 2 * 1 = 6
--. . .
--n! = fact(n) = n * (n-1) * (n-2) * . . . * 2 * 1
--n! = fact(n) = n * (n-1)!

CREATE OR REPLACE PROCEDURE factorial(x_num IN NUMBER, x_fact out Number)
AS
BEGIN
    -- NUMBER IS 0

    IF (x_num = 0) THEN
        x_fact := 1;

-- NUM IS > 0
    ELSE
        -- RECURSIVE CALL TO FIND FACTORIAL OF X_NUM
        factorial(x_num - 1, x_fact);
        x_fact := x_num * x_fact;
    END IF;

EXCEPTION
    WHEN OTHERS
        THEN
            DBMS_OUTPUT.put_line('Error. Something went wrong...');
END;

DECLARE
    z number;

BEGIN
    factorial(10, z);
    dbms_output.put_line(z);
    factorial(0, z);
    dbms_output.put_line(z);
    factorial(1, z);
    dbms_output.put_line(z);
    factorial(5, z);
    dbms_output.put_line(z);
    factorial(12, z);
    dbms_output.put_line(z);
END;

--Question 2
-- Write a stored procedure called fibonacci that gets an integer number n and 
--calculates the sum of the Fibonacci sequence up to that point.
--Example:
--f(0) = 0
--f(1) = 1
--f(2) = f(1) + f(0) = 1 + 0 = 1
--f(3) = f(2) + f(1) = 1 + 1 = 2
--f(4) = f(3) + f(2) = 2 + 1 = 3
--�
--f(n) = f(n-1) + f(n-2)

CREATE OR REPLACE PROCEDURE fibonacci(num_limit IN NUMBER, num_result out NUMBER)
AS
BEGIN
    IF (num_limit < 0) THEN
        DBMS_OUTPUT.put_line('Cant find the fibonacci number at a negative position...');
        RETURN;
    END IF;
    num_result := ROUND(POWER(((1 + SQRT(5)) / 2), num_limit) / sqrt(5));
EXCEPTION
    WHEN OTHERS
        THEN
            DBMS_OUTPUT.put_line('Error. Something went wrong...');
END;

DECLARE
    x_sum NUMBER;


BEGIN
    fibonacci(0, x_sum);
    dbms_output.put_line(x_sum);
    fibonacci(2, x_sum);
    dbms_output.put_line(x_sum);
    fibonacci(3, x_sum);
    dbms_output.put_line(x_sum);
    fibonacci(4, x_sum);
    dbms_output.put_line(x_sum);
    fibonacci(10, x_sum);
    dbms_output.put_line(x_sum);
    fibonacci(38, x_sum);
    dbms_output.put_line(x_sum);
END;


--Question 3
--Every year, the company increases the price of all products in one category. 
--For example, the company wants to increase the price (list_price) of products 
--in category 1 by $5. Write a procedure named update_price_by_cat to update 
--the price of all products in a given category and the given amount to be added 
--to the current price if the price is greater than 0. The procedure shows the 
--number of updated rows if the update is successful.
--The procedure gets two parameters:
--� category_id IN NUMBER
--� amount NUMBER(9,2)
--To define the type of variables that store values of a table� column, you can 
--also write:
--vriable_name table_name.column_name%type;
--The above statement defines a variable of the same type as the type of the 
--table� column.
--category_id products.category_id%type;
--Or you need to see the table definition to find the type of the category_id 
--column. Make sure the type of your variable is compatible with the value that 
--is stored in your variable.
--To show the number of affected rows the update query, declare a variable 
--named rows_updated of type NUMBER and use the SQL variable 
--sql%rowcount to set your variable. Then, print its value in your stored 
--procedure.
--Rows_updated := sql%rowcount;
--SQL%ROWCOUNT stores the number of rows affected by an INSERT, UPDATE, 
--or DELETE.

CREATE OR REPLACE PROCEDURE update_price_by_cat(target_category_id IN NUMBER, amount NUMBER)
AS
    max_category PRODUCTS.CATEGORY_ID%type;
    rows_updated NUMBER;

BEGIN
    -- GET THE MAX CATEGORY NUMBER AND ASSIGN IT TO MAX_CATEGORY
    SELECT MAX(CATEGORY_ID)
    INTO max_category
    FROM PRODUCTS;

-- ASSERT
    IF (target_category_id <= 0 or target_category_id > max_category) THEN
        dbms_output.put_line('The category:' || target_category_id || ' does not exist...');
        RETURN;
    END IF;

-- INCREASE LIST_PRICE OF TARGET CATEGORY BY AMOUNT 
    UPDATE
        PRODUCTS
    SET LIST_PRICE = LIST_PRICE + amount
    WHERE CATEGORY_ID = target_category_id;

    rows_updated := SQL%ROWCOUNT;
    DBMS_OUTPUT.put_line('number of rows affected: ' || rows_updated);
EXCEPTION
    WHEN OTHERS
        THEN
            DBMS_OUTPUT.put_line('Error. Something went wrong...');
END;

BEGIN
    update_price_by_cat(5, 10);
    update_price_by_cat(4, 10);
    update_price_by_cat(3, 10);
    update_price_by_cat(2, 10);
    update_price_by_cat(1, 10);
END;


--QUESTION 4
--Every year, the company increase the price of products whose price is less 
--than the average price of all products by 1%. 
--
--(list_price * 1.01). Write a stored 
--procedure named update_price_under_avg. This procedure do not have any 
--parameters. 
--
--
--You need to find the average price of all products and store it into 
--a variable of the same type. 
--
--If the average price is less than or equal to $1000, 
--update products� price by 2% if the price of the product is less than the 
--calculated average. 
--
--If the average price is greater than $1000, update 
--products� price by 1% if the price of the product is less than the calculated 
--average. 
--
--
--The query displays an error message if any error occurs. Otherwise, it 
--displays the number of updated rows.


CREATE OR REPLACE PROCEDURE update_price_under_avg
AS
    average_price PRODUCTS.LIST_PRICE%type;
    rows_updated  NUMBER;

BEGIN
    -- GET THE AVERAGE PRICE FOR ALL ITEMS IN THE PRODUCTS TABLE COMBINED
    SELECT AVG(LIST_PRICE)
    INTO average_price
    FROM PRODUCTS;

    IF (average_price <= 1000) THEN
        UPDATE
            PRODUCTS
        SET LIST_PRICE = LIST_PRICE + (LIST_PRICE * (2 / 100))
        WHERE LIST_PRICE < average_price;
    END IF;

    IF (average_price > 1000) THEN
        UPDATE
            PRODUCTS
        SET LIST_PRICE = LIST_PRICE + (LIST_PRICE * (1 / 100))
        WHERE LIST_PRICE < average_price;
    END IF;

    rows_updated := SQL%ROWCOUNT;
    DBMS_OUTPUT.put_line('number of rows affected: ' || rows_updated);
EXCEPTION
    WHEN OTHERS
        THEN
            DBMS_OUTPUT.put_line('Error. Something went wrong...');
END;

BEGIN
    update_price_under_avg;
END;

--QUESTION 5
--The company needs a report that shows three category of products basedtheir prices. 
--The company needs to know if the product price is cheap, fair, orexpensive. 
--Let�s assume that? 
--If the list price is less thano (avg_price - min_price) / 2The product�s price is cheap.? 
--If the list price is greater thano (max_price - avg_price) / 2The product� price is expensive.? 
--If the list price is betweeno (avg_price - min_price) / 2o ando (max_price - avg_price) / 2o the end values includedThe product�s price is fair.
--Write a procedure named product_price_report to show the number of products in each price category:
--The following is a sample output of the procedure if no error occurs:Cheap: 10Fair: 50Expensive: 18The values in the above examples are just random values and may not matchthe real numbers in your result.
--The procedure has no parameter. 
--First, you need to find the average,minimum, and maximum prices (list_price) in your database and store theminto varibles avg_price, min_price, and max_price.
--You need more three varaibles to store the number of products in eachprice category:cheap_countfair_countexp_countMake sure you choose a proper type for each variable. 
--You may need todefine more variables based on your solution.

CREATE OR REPLACE PROCEDURE product_price_report
AS
    min_price      NUMBER;
    avg_price      NUMBER;
    max_price      NUMBER;
    cheap_item     NUMBER := 0;
    fair_item      NUMBER := 0;
    expensive_item NUMBER := 0;
    CURSOR product_cursor
        IS
        SELECT PRODUCT_ID,
               PRODUCT_NAME,
               DESCRIPTION,
               STANDARD_COST,
               LIST_PRICE,
               CATEGORY_ID
        FROM PRODUCTS;

BEGIN
    SELECT MIN(LIST_PRICE),
           AVG(LIST_PRICE),
           MAX(LIST_PRICE)

    INTO
        min_price,
        avg_price,
        max_price

    FROM PRODUCTS;

    FOR item in product_cursor
        LOOP
            IF (item.list_price < (avg_price - min_price) / 2) THEN
                cheap_item := cheap_item + 1;

            ELSIF (item.list_price > (max_price - avg_price) / 2) THEN
                expensive_item := expensive_item + 1;

            ELSIF (item.list_price >= ((avg_price - min_price) / 2) AND
                   item.list_price <= ((max_price - avg_price) / 2)) THEN
                fair_item := fair_item + 1;
            END IF;
        END LOOP;

    DBMS_OUTPUT.put_line('Cheap: ' || cheap_item || chr(10) || 'Fair: ' || fair_item || chr(10) || 'Expensive: ' ||
                         expensive_item);

EXCEPTION
    WHEN OTHERS
        THEN
            DBMS_OUTPUT.put_line('Error. Something went wrong...');
END;

BEGIN
    product_price_report;
END;