CREATE DATABASE OFFICE;

USE OFFICE;

CREATE TABLE Employee(
	emp_id VARCHAR(20) PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    salary INT,
    dept_id VARCHAR(20),
    manager_id VARCHAR(20)
);

INSERT INTO Employee
VALUES	('E1', 'Rahul', 15000, 'D1','M1'),
		('E2', 'Manoj', 15000, 'D1','M1'),
        ('E3', 'James', 55000, 'D2','M2'),
        ('E4', 'Michael', 25000, 'D2','M2'),
        ('E5', 'Ali', 20000, 'D10','M3'),
        ('E6', 'Robin', 35000, 'D10','M3');
        
CREATE TABLE Department(
	dept_id VARCHAR(20) PRIMARY KEY,
    dept_name VARCHAR(50)
);

INSERT INTO Department
VALUES 	('D1', 'IT'),
		('D2', 'HIR'),
        ('D3', 'Finance'),
        ('D4', 'Admin');
        

CREATE TABLE Manager(
	manager_id VARCHAR(20) PRIMARY KEY,
    manager_name VARCHAR(50),
    dept_id varchar(20)
    );        

INSERT INTO Manager
VALUES 	('M1', 'Prem', 'D3'),
		('M2', 'Shivpath', 'D4'),
		('M3', 'Nick', 'D1'),
		('M4', 'Cory', 'D1');
        
CREATE TABLE Projects(
			project_id 	VARCHAR(20),
            project_name VARCHAR(100),
            team_member_id VARCHAR(20)
            );

INSERT INTO Projects
VALUES  ('P1', 'Data Migration', 'E1'),
		('P1', 'Data Migration', 'E2'),
		('P1', 'Data Migration', 'M3'), 
		('P2', 'ETL Tool', 'E1'),
		('P2', 'ETL Tool', 'M4');           
      
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM MANAGER;
SELECT * FROM PROJECTS;        

-- FETCH THE EMPLOYEE NAME AND THE DEPARTMENT NAME THEY BELOONG TO.

	-- INNER JOIN :-
		SELECT EMP.emp_name, DEP.dept_name FROM EMPLOYEE EMP
		JOIN DEPARTMENT DEP ON DEP.dept_id = EMP.dept_id; 
        
        
-- FETCH  ALL THE EMPLOYEE NAME AND THE DEPARTMENT NAME THEY BELOONG TO.
	-- LEFT OUTER JOIN :- (INNER JOIN + EXTRA INSTANCE OF LEFT TABLE
		SELECT EMP.emp_name, DEP.dept_name FROM EMPLOYEE EMP
		LEFT JOIN DEPARTMENT DEP ON DEP.dept_id = EMP.dept_id; 
        
        
    -- RIGHT OUTER JOIN :- (INNER JOIN + EXTRA INSTANCE OF RIGHT TABLE
		SELECT EMP.emp_name, DEP.dept_name FROM EMPLOYEE EMP
		RIGHT JOIN DEPARTMENT DEP ON DEP.dept_id = EMP.dept_id;    
        
        
-- FETCH DETAILS OF ALL EMP, THEIR MANAGER, THEIR DEPRTMENT, AND THE PROJECTS THEY WORK ON.

SELECT * FROM EMPLOYEE;     
SELECT * FROM PROJECTS;   

SELECT Emp.emp_name, Dep.dept_name, Mag.manager_name, Proj.project_name
FROM EMPLOYEE Emp
LEFT JOIN DEPARTMENT Dep ON Emp.dept_id = Dep.dept_id
LEFT JOIN MANAGER Mag ON Emp.manager_id = Mag.manager_id
LEFT JOIN PROJECTS Proj ON Emp.emp_id = Proj.team_member_id;	

/*
-- FULL JOIN :-
				INNER JOIN 
					+ ALL REMAINING RECORDS FROM LEFT TABLE
                    + ALL REMAINING RECORDS FROM RIGHT TABLE
*/
	SELECT E.emp_name, D.dept_name
	FROM EMPLOYEE E
	LEFT JOIN DEPARTMENT D ON D.dept_id = E.dept_id
	UNION
	SELECT E.emp_name, D.dept_name
	FROM EMPLOYEE E
	RIGHT JOIN DEPARTMENT D ON D.dept_id = E.dept_id;


-- CROSS JOIN:- CROSS JOIN RETURN CARTESION PRODUCT.
--				len(cross join) = len(left table) * len(right table)
SELECT E.emp_name, D.dept_name
FROM EMPLOYEE E 
CROSS JOIN DEPARTMENT D;

CREATE TABLE COMPANY(
	company_id VARCHAR(10) PRIMARY KEY,
    company_name VARCHAR(50),
    location VARCHAR(20)	
);
INSERT INTO COMPANY
VALUES ('C001', 'TtechTFQ Solutions', 'Kuala Lumpur');

SELECT * FROM COMPANY;

-- Write a query to fetch the employee name and thier corresponding department name.
-- Also make sure to display the company name and the company location corresponding to each employee

SELECT EMP.emp_name, DEP.dept_name, C.company_name, C.location
FROM EMPLOYEE EMP
JOIN DEPARTMENT DEP ON DEP.dept_id = EMP.dept_id
CROSS JOIN COMPANY C;
-- we can use cross join when we don't have any similar coloumn but we still wants to compare two or more table.

/*
-- NATURAL JOIN :- - Natural join is type of join which is similar to inner join but in natural join the sql will decide which column
                     we can use to join tables
                   - Natural join is not that recommanded because it has multiple drawback
                   - eg: suppose in one one column in both table which have same name but the data they rrepresent may not same in this 
				     situation natual join fail.
*/ 

SELECT EMP.emp_name, DEP.dept_name
FROM EMPLOYEE EMP
NATURAL JOIN DEPARTMENT DEP ;

CREATE TABLE FAMILY
(
	member_id VARCHAR(10),
    name VARCHAR(50),
    age INT,
    parent_id VARCHAR(10)
);
INSERT INTO family
VALUES	('F1','David', 4, 'F5'),
		('F2','Carol', 10, 'F5'),
		('F3','Michael', 12, 'F5'),
		('F4','Johnson', 36 , "  "),
		('F5','Maryam', 40, 'F6'),
		('F6','Stewart', 70 , "  "),
		('F7','Rohan', 6, 'F4'),
		('F8','Asha', 8, 'F4');
        
-- SELF JOIN:- In self join we use same table to perform join operation
-- write a queury to fetch the child name and their age correspnding to their parent name and parent age

SELECT CHILD.NAME AS CHILD_NAME, CHILD.AGE AS CHILD_AGE,
	   PARENT.NAME AS PARENT_NAME, PARENT.AGE AS PARENT_AGE
FROM FAMILY AS CHILD
JOIN FAMILY AS PARENT ON CHILD.parent_id = PARENT.member_id   		