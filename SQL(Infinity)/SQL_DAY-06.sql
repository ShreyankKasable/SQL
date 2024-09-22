# 184. Department Highest Salary :- (1)
-- Write a solution to find employees who have the highest salary in each of the departments.
-- Return the result table in any order
		WITH CTE AS(
			SELECT *, 
			DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) AS DR
			FROM Employee
		)
		SELECT D.name as Department, C.name as Employee, C.salary as Salary
		FROM CTE C
		JOIN Department D ON C.departmentId = D.id
		WHERE DR = 1;
        

# 185. Department Top Three Salaries :- (2)
-- A company's executives are interested in seeing who earns the most money in each of the company's departments.
-- A high earner in a department is an employee who has a salary in the top three unique salaries for that department.
-- Write a solution to find the employees who are high earners in each of the departments.
-- Return the result table in any order.        
		WITH CTE AS(
			SELECT *, 
			DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) AS DR
			FROM Employee
		)
		SELECT D.name AS Department, C.name AS Employee, C.salary 
		FROM CTE C
		JOIN Department D ON C.departmentId = D.id
		WHERE DR=1 OR DR=2 OR DR=3;
        
        
# 181. Employees Earning More Than Their Managers :- (3)       
-- Write a solution to find the employees who earn more than their managers.
-- Return the result table in any order.
		SELECT EMP_1.name AS Employee 
		FROM Employee EMP_1
		LEFT JOIN Employee EMP_2 ON EMP_1.managerId = EMP_2.id
		WHERE EMP_1.salary > EMP_2.salary;
        
 
# 182. Duplicate Emails :- (4)
-- Write a solution to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.
-- Return the result table in any order.
		SELECT DISTINCT P1.email FROM Person P1
		JOIN Person P2 ON P1.email = P2.email
		WHERE P1.email = P2.email AND P1.id != P2.id;


# 197. Rising Temperature :- (5)
-- Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).
-- Return the result table in any order.
		SELECT W2.id FROM Weather W1
		JOIN Weather W2 ON DATEDIFF(W2.recordDate, W1.recordDate) = 1
		WHERE W2.temperature > W1.temperature;

