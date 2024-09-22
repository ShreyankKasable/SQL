# 511. Game Play Analysis I :- (1)
-- Write a solution to find the first login date for each player.
-- Return the result table in any order.
		SELECT player_id, MIN(event_date) AS first_login
		FROM Activity
		GROUP BY player_id;
        
        
# 550. Game Play Analysis IV :- (2)
-- Write a solution to report the fraction of players that logged in again on the day after the day they first logged in,
-- rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days
-- starting from their first login date, then divide that number by the total number of players.   
		WITH CTE AS (
			SELECT player_id, MIN(event_date) AS MIN_DATE
			FROM Activity
			GROUP BY player_id
		)
		SELECT ROUND((
					SELECT COUNT(*) 
					FROM Activity A
					LEFT JOIN CTE C ON A.player_id = C.player_id
					WHERE DATEDIFF(A.event_date, C.MIN_DATE) = 1
					)/(SELECT COUNT(DISTINCT player_id) FROM Activity), 2) AS fraction;    
                    
                    
# 577. Employee Bonus :- (3)
-- Write a solution to report the name and bonus amount of each employee with a bonus less than 1000.
-- Return the result table in any order.
		SELECT E.name, B.bonus FROM Employee E
		LEFT JOIN Bonus B ON E.empId = B.empId
		WHERE B.bonus < 1000 OR B.bonus IS NULL;       
        
        
# 586. Customer Placing the Largest Number of Orders :- (4)
-- Write a solution to find the customer_number for the customer who has placed the largest number of orders.
-- The test cases are generated so that exactly one customer will have placed more orders than any other customer. 
		SELECT customer_number 
		FROM Orders
		GROUP BY customer_number
		ORDER BY COUNT(customer_number) DESC LIMIT 1;
        
        
# 596. Classes More Than 5 Students :- (5)
-- Write a solution to find all the classes that have at least five students.
-- Return the result table in any order.
		SELECT class FROM Courses
		GROUP BY class
		HAVING COUNT(class) >= 5;

        
       