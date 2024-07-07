#							SQL SUBQUERY
# SQL SUBQUERY :- A subquery is a query nested inside another query in SQL. 
             --   It is used to perform operations that require multiple steps or complex data retrieval.
USE SCHOOL_DETAIL;
SELECT * FROM STAFF_SALARY;

-- QUESTION:- Find the employees who's salary is more than the average salary earned by all employees
/*
1) Find the avg Salary
2) Filter the employees based on the above result
*/
-- APPROACH-01:-
SELECT AVG(SALARY) FROM STAFF_SALARY; -- 8062.5
SELECT COUNT(*) FROM STAFF_SALARY; -- 24
SELECT COUNT(*) FROM STAFF_SALARY WHERE SALARY > 8062.5; -- 9/24

-- APPROACH-02 :-
SELECT COUNT(*)  -- 9
FROM STAFF_SALARY 
WHERE SALARY > (SELECT AVG(SALARY) FROM STAFF_SALARY); 

/*
	TYPES OF SQL QUERY:- 
					1. SCALAR SUBQUERY
                    2. MULTIPLE ROW SUBQUERY
                    3. CORRELATED SUBQUERY
*/

-- SCALAR SUBQUERY :- RETURNS SINGLE VALUE	
SELECT *
FROM STAFF_SALARY STF
JOIN (SELECT AVG(SALARY) SALARY FROM STAFF_SALARY) AVG_SALARY ON STF.SALARY > AVG_SALARY.SALARY;
# when we perform join operation on scalar subquery then sql treat scalary subquery(single value) as another table and perform join 
# using these tahble so as a result it will produce new columns which represent the data of subquery.   

-- MULTIPLE ROW SUBQUERY :- 
						-- 1. SUBQUERY WHICH RETURNS MULTIPLE COLUMN AND MULTIPLE ROW.
                        -- 2. SUBQUERY WHICH RETURNS ONLY 1 COLUMN AND MULTIPLE ROW.

-- 1. SUBQUERY WHICH RETURNS MULTIPLE COLUMN AND MULTIPLE ROW.                        
-- QUESTION:- Find the employees who earn the highest salary in each department:-
USE FIRST;
SELECT * FROM EMPLOYEES_DETAIL;                  

-- GENERATING MAXIMUM SALARY FROM EACH EMPLOYEE :-
SELECT DEPARTMENT_ID, MAX(SALARY) AS EMPLOYEE_MAX_SALARY 
FROM EMPLOYEES_DETAIL 
GROUP BY DEPARTMENT_ID 
ORDER BY EMPLOYEE_MAX_SALARY DESC;

-- FINAL RESULT :-
SELECT DEPARTMENT_ID, FIRST_NAME, LAST_NAME, SALARY 
FROM EMPLOYEES_DETAIL
WHERE (DEPARTMENT_ID, SALARY) IN (
			SELECT DEPARTMENT_ID, MAX(SALARY) AS EMPLOYEE_MAX_SALARY 
			FROM EMPLOYEES_DETAIL 
			GROUP BY DEPARTMENT_ID 
			)
ORDER BY SALARY DESC; 
                                                      
                                                      
-- 2. SUBQUERY WHICH RETURNS ONLY 1 COLUMN AND MULTIPLE ROW.
-- QUESTION :- Find department who do not have any employees
	USE OFFICE;
	SELECT * FROM DEPARTMENT;   
	SELECT * FROM EMPLOYEE;

-- SUBQUERY
SELECT DISTINCT DEPT_ID FROM EMPLOYEE;
-- FINAL RESULT
SELECT * 
FROM DEPARTMENT 
WHERE DEPT_ID NOT IN (SELECT DISTINCT DEPT_ID FROM EMPLOYEE); 



-- CORRELATED SUBQUERY :- A subquery which is related to the outer query

-- QUESTION 1:- Find the Employees in each department who earn more than the average salary in that respective department

USE FIRST;
SELECT * FROM EMPLOYEES_DETAIL;       

SELECT * FROM EMPLOYEES_DETAIL E1
WHERE SALARY > (
				SELECT AVG(SALARY) 
                FROM EMPLOYEES_DETAIL E2 
                WHERE E1.DEPARTMENT_ID = E2.DEPARTMENT_ID
                );           
		
-- QUESTION 2:- Find department who do not have any employees
	USE OFFICE;
	SELECT * FROM DEPARTMENT;   
	SELECT * FROM EMPLOYEE;        
    
SELECT * 
FROM DEPARTMENT D
WHERE NOT EXISTS(SELECT * FROM EMPLOYEE emp WHERE Emp.dept_id = D.dept_id);
# its work like a for loop in for loop 


-- NESTED SUBQUERY :- Subquery inside a subquery

-- QUESTION :- Find stores who's sales where better than the average sales accross all stores 
--      1. Find the total sales of each store
--      2. Find avg sales for all store
--      3. compare 1. 2

SELECT * FROM SALES; 
-- 1. Find the total sales of each store
SELECT STORE_NAME, AVG(PRICE)  
FROM SALES 
GROUP BY STORE_NAME;

SELECT STORE_NAME, SUM(PRICE)  
FROM SALES 
GROUP BY STORE_NAME;

-- Find avg price for all store
SELECT AVG(PRICE) FROM SALES;

-- 2. Find Avg sales for all store
SELECT AVG(TOTAL_SALES)
FROM (SELECT STORE_NAME, SUM(PRICE) AS TOTAL_SALES
	  FROM SALES 
      GROUP BY STORE_NAME) AS STORE_SALES; 
SELECT AVG(TOTAL_SALES);
      
      
-- FINAL RESULT :-
-- APPROACH 01:-
SELECT * 
FROM (SELECT STORE_NAME, SUM(PRICE) AS TOTAL_SALES
	  FROM SALES 
      GROUP BY STORE_NAME) SALES
JOIN (SELECT AVG(TOTAL_SALES) AS SALE
FROM (SELECT STORE_NAME, SUM(PRICE) AS TOTAL_SALES
	  FROM SALES
      GROUP BY STORE_NAME)X)AS AVG_SALES
ON SALES.TOTAL_SALES > AVG_SALES.SALE;


# As in this query we are repeating same subquery multiple time so we can achive the same result with using WITH clause

-- APPROACH 02:- 

WITH SALES
AS (SELECT STORE_NAME, SUM(PRICE) AS TOTAL_SALES
	FROM SALES 
	GROUP BY STORE_NAME)
SELECT * 
FROM SALES
JOIN (SELECT AVG(TOTAL_SALES) AS SALE
FROM SALES X) AVG_SALES
ON SALES.TOTAL_SALES > AVG_SALES.SALE;    -- using WITH clause we store whole subquery in varaible SALES


--                                DIFFERENT SQL CLAUSE WHERE SUBQUERY IS ALLOWED
/*
1. SELECT 
2. FROM
3. WHERE
4. HAVING
*/

-- USING A SUBQUERY IN SELECT CLAUSE :-
-- QUESTION :- Fetch all employee and add remarks to those employees whe earn more tha the average salary

select * from employee;

# APPROACH 01 :-  USING SUBQUERY IN SELECT CLAUSE:-
SELECT *
, (CASE WHEN SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE)
			THEN 'Higher then Average'    
       ELSE NULL
  END) AS REMARK
FROM EMPLOYEE;  
      
# APPROACH 02 :- USING SUBQUERY 

SELECT *
, (CASE WHEN SALARY > AVG_SALARY.SAL
			THEN 'Higher then Average'    
       ELSE NULL
  END) AS REMARK
FROM EMPLOYEE
CROSS JOIN (SELECT AVG(SALARY) SAL FROM EMPLOYEE) AVG_SALARY;      
      

-- HAVING :-

SELECT STORE_NAME, SUM(PRICE)
FROM SALES  
GROUP BY STORE_NAME     
HAVING SUM(PRICE) > (SELECT AVG(PRICE) FROM SALES);
                                               
--                                                
-- SQL QUERY :-
-- 	1. INSERT
--     2. UPDATE
--     3. DELETE
--     
-- INSERT :-
-- QUESTION :- Insert data to employee history table. make sure not insert duplicate records

CREATE TABLE EMPLOYEE_HISTORY
(
	EMP_ID INTEGER PRIMARY KEY,
    EMP_NAME VARCHAR(50),
    DEPT_NAME VARCHAR(50),
    SALARY INTEGER
);   
ALTER TABLE  EMPLOYEE_HISTORY ADD DEPT_ID VARCHAR(5);
ALTER TABLE EMPLOYEE_HISTORY MODIFY COLUMN EMP_ID VARCHAR(10);  


SELECT * FROM EMPLOYEE_HISTORY;      
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

INSERT INTO EMPLOYEE_HISTORY
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_NAME, E.SALARY, D.DEPT_ID
FROM EMPLOYEE E
JOIN DEPARTMENT D ON D.DEPT_ID = E.DEPT_ID
WHERE NOT EXISTS (SELECT 1 FROM EMPLOYEE_HISTORY EH WHERE EH.EMP_ID = E.EMP_ID);


-- UPDATE :-
SELECT * FROM EMPLOYEE;
-- QUESTION :- GET THE SALARY HIKE TO EMPLOYEE BY 10% WITH THE MAXIMUM SALARY FROM THERE BELONGING DEPARTMENT
UPDATE EMPLOYEE E 
SET SALARY = (SELECT MAX(SALARY) + (MAX(SALARY) *0.1)
			 FROM EMPLOYEE_HISTORY EH
             WHERE EH.DEPT_ID = E.DEPT_ID);
             
-- DELETE :-             
-- QUESTION :- DELETE ALL DEPARTMENT WHO DO NOT HAVE ANY EMPLOYEE

DELETE FROM DEPARTMENT
WHERE DEPT_NAME IN (SELECT DEPT_NAME
					FROM DEPARTMENT D
                    WHERE NOT EXISTS (SELECT 1 
									  FROM EMPLOYEE E
                                      WHERE E.DEPT_ID = D.DEPT_ID)
					);
 

 
