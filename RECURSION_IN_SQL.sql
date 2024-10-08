-- 														RECURSION IN SQL

-- SYNTAX :-

WITH [RECURSIVE] CTE_NAME AS
	(
     SELECT query (Non Recursive query or the base query)
	 UNION [ALL]
     SELECT query (Recursive query using CTE_name [with a termination condition])
    )
SELECT * FROM CTE_name;

-- PRACTICE QUESTION :-
-- Q1) Display number from 1 to 10 without using any in built function :-
		
        WITH RECURSIVE 	NUMBERS AS
			(
			 SELECT 1 AS N
			 UNION
			 SELECT N + 1 
			 FROM NUMBERS WHERE N < 10
			)
        SELECT * FROM NUMBERS;    
        
    
select * from emp_details;     
-- Q2) Find the Hierarchy of employees under a given manager 'Asha' :-
	
    -- SOLUTION01 :-
    WITH RECURSIVE EMP_HIERARCHY AS 
		(SELECT ID, NAME, MANAGER_ID, DESIGNATION, 1 AS LVL
		 FROM EMP_DETAILS WHERE NAME = 'Asha'
		 UNION
		 SELECT E.ID, E.NAME, E.MANAGER_ID, E.DESIGNATION, H.LVL+1 AS LEVEL
		 FROM EMP_HIERARCHY H
		 JOIN EMP_DETAILS E ON H.ID = E.MANAGER_ID
		)
	SELECT * FROM EMP_HIERARCHY;    
    
    -- SOLUTION 02 :-
    WITH RECURSIVE EMP_HIERARCHY AS 
		(SELECT ID, NAME, MANAGER_ID, DESIGNATION, 1 AS LVL
		 FROM EMP_DETAILS WHERE NAME = 'Asha'
		 UNION
		 SELECT E.ID, E.NAME, E.MANAGER_ID, E.DESIGNATION, H.LVL+1 AS LEVEL
		 FROM EMP_HIERARCHY H
		 JOIN EMP_DETAILS E ON H.ID = E.MANAGER_ID
		)
	SELECT H2.ID AS EMP_ID, H2.NAME AS EMP_NAME, E2.NAME AS MANAGER_NAME, H2.LVL AS LEVEL
    FROM EMP_HIERARCHY H2
    JOIN EMP_DETAILS E2 ON E2.ID = H2.MANAGER_ID;  
    
-- Q3) Find the Hierarchy of managers for a given employee 'David' :- 
	
	 WITH RECURSIVE EMP_HIERARCHY AS 
		(SELECT ID, NAME, MANAGER_ID, DESIGNATION, 1 AS LVL
		 FROM EMP_DETAILS WHERE NAME = 'David'
		 UNION
		 SELECT E.ID, E.NAME, E.MANAGER_ID, E.DESIGNATION, H.LVL+1 AS LEVEL
		 FROM EMP_HIERARCHY H
		 JOIN EMP_DETAILS E ON H.MANAGER_ID = E.ID
		)
	SELECT H2.ID AS EMP_ID, H2.NAME AS EMP_NAME, E2.NAME AS MANAGER_NAME, H2.LVL AS LEVEL
    FROM EMP_HIERARCHY H2
    JOIN EMP_DETAILS E2 ON E2.ID = H2.MANAGER_ID;  
			
		
       
