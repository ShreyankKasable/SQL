#                                         SQL WITH CLAUSE

USE BANK_DB;
SELECT * FROM EMPLOYEES_TAB;

-- QUESTION 01 :- Fetch employee who earn more than average salary of all employees
	-- approach 01:-
		SELECT * 
		FROM EMPLOYEES_TAB EMP
		JOIN (SELECT AVG(SALARY) AVG_SAL FROM EMPLOYEES_TAB) AVG_SALARY ON AVG_SALARY.AVG_SAL < EMP.SALARY;

	-- approach 02:-
		WITH AVERAGE_SALARY (AVG_SAL) AS (SELECT CAST(AVG(SALARY) AS SIGNED) FROM EMPLOYEES_TAB)
		SELECT * 
		FROM EMPLOYEES_TAB EMP, AVERAGE_SALARY A
		WHERE EMP.SALARY > A.AVG_SAL;


USE OFFICE;
SELECT * FROM SALES;
-- QUESTION 02 :- Find stores who's sales where better than the average sales across all stores
--                1. Total sales per each store
-- 				  2. Find the average sales with respect all the stores
-- APPROACH 1:- (without WITH CLAUSE)
	-- 1. Total sales per each store:-
		SELECT STORE_NAME, SUM(PRICE) AS TOTAL_SALES
        FROM SALES
        GROUP BY STORE_NAME;
        
	-- 2. Find the average sales with respect all the stores
		SELECT AVG(TOTAL_SALES) 
        AS AVERAGE_SALES
        FROM (SELECT STORE_NAME, SUM(PRICE) AS TOTAL_SALES
			  FROM SALES
        GROUP BY STORE_NAME) AS STORE_SALES;
	-- 3. Find stores who's sales where better than the average sales across all stores :-
        SELECT *
        FROM (SELECT STORE_NAME, SUM(PRICE) AS TOTAL_SALES
			  FROM SALES
			  GROUP BY STORE_NAME) AS TS
        JOIN  (SELECT AVG(TOTAL_SALES) 
			  AS AVERAGE_SALES
              FROM (SELECT STORE_NAME, SUM(PRICE)  
				    AS TOTAL_SALES
                    FROM SALES
                    GROUP BY STORE_NAME) AS STORE_SALES
			   ) AS AVG_SALES
         ON  AVG_SALES.AVERAGE_SALES < TS.TOTAL_SALES;
# as over here we are repeating the same subquery multiple time so if we use with clause then we can reduce the redudancy of query

WITH TOTAL_SALES (STORE_ID, TOTAL_SALES) AS 
		(SELECT S.STORE_ID, SUM(PRICE) AS TOTAL_SALES
		 FROM SALES S
		 GROUP BY S.STORE_ID),
      AVERAGE_SALES (AVG_SALES_FOR_ALL_STORES) AS 
		(SELECT AVG(TOTAL_SALES) AS AVG_SALES_FOR_ALL_STORES
		 FROM TOTAL_SALES)
SELECT *
FROM TOTAL_SALES TS
JOIN AVERAGE_SALES AV
ON AV.AVG_SALES_FOR_ALL_STORES < TS.TOTAL_SALES


      

