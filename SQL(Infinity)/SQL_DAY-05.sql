# 175. Combine Two Tables :- (1)

	SELECT P.firstName, P.lastName, A.city, A.state 
	FROM Person P
	LEFT JOIN Address A ON P.personId = A.personId;
    

# 176. Second Highest Salary :- (2)
--  Write a solution to find the second highest distinct salary from the Employee table.
--  If there is no second highest salary, return null (return None in Pandas).

# APPOACH 1 :-
		SELECT MAX(salary) AS SecondHighestSalary 
		FROM EMPLOYEE
		WHERE salary < (    
			SELECT MAX(salary) 
			FROM EMPLOYEE
			);
# APPROACH 2 :-
		WITH CTE AS (
			SELECT * ,
			DENSE_RANK() OVER(ORDER BY salary DESC) AS DR
			FROM EMPLOYEE
		)
		SELECT IFNULL(
			(SELECT salary 
			FROM CTE 
			WHERE DR = 2 LIMIT 1
			), NULL) AS SecondHighestSalary;
					

# 177. Nth Highest Salary :- (3)
-- Write a solution to find the nth highest salary from the Employee table.
-- If there is no nth highest salary, return null.

		CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
		BEGIN
		  RETURN (
				WITH CTE AS (
					SELECT *, 
					DENSE_RANK() OVER (ORDER BY salary DESC) AS DR
					FROM Employee
				)

				SELECT IFNULL(
					(SELECT salary
					FROM CTE 
					WHERE DR = N
					LIMIT 1),NULL) AS getNthHighestSalary
		  );
		END


# 178. Rank Scores :- (4)
-- Write a solution to find the rank of the scores. The ranking should be calculated according to the following rules:
-- The scores should be ranked from the highest to the lowest.
-- If there is a tie between two scores, both should have the same ranking.
-- After a tie, the next ranking number should be the next consecutive integer value. 
-- In other words, there should be no holes between ranks.

		SELECT score, 
		DENSE_RANK() OVER (ORDER BY score DESC) AS 'rank'
		FROM Scores;
        
        
# 180. Consecutive Numbers :- (5)
-- Find all numbers that appear at least three times consecutively.    

		WITH CTE AS (
			SELECT *, 
					LEAD(num, 1) OVER(ORDER BY id) AS NUM_1,
					LEAD(id, 1) OVER(ORDER BY id) AS ID_1,
					LEAD(NUM, 2) OVER(ORDER BY id) AS NUM_2,
					LEAD(id, 2) OVER(ORDER BY id) AS ID_2
			FROM Logs        
		)
		SELECT DISTINCT num AS ConsecutiveNums 
		FROM CTE
		WHERE num = NUM_1 AND num = NUM_2 AND ID_1 = id + 1 AND ID_2 = ID + 2;    
    