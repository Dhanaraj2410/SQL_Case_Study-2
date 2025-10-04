create database case2

use case2

CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');

select * from LOCATION


  CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);


INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

select * from department

	   CREATE TABLE JOB (
  Job_ID INT PRIMARY KEY,
  Designation VARCHAR(50)
);

CREATE TABLE JOB
(JOB_ID INT PRIMARY KEY,
DESIGNATION VARCHAR(20))

INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')

select * from job

CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,LAST_NAME VARCHAR(20),FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),JOB_ID INT FOREIGN KEY REFERENCES JOB(JOB_ID),
MANAGER_ID INT,HIRE_DATE DATE,SALARY INT,COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)

select * from employee

--Simple Queries:
-- 1. List all the employee details.
SELECT * FROM Employee;

-- 2. List all the department details.
SELECT * FROM Department;

-- 3. List all job details.
SELECT * FROM Job;

-- 4. List all the locations.
SELECT * FROM Location;

-- 5. List First Name, Last Name, Salary, Commission for all employees.
SELECT First_Name, Last_Name, Salary, Comm FROM Employee;

-- 6. List Employee ID, Last Name, Department ID with aliases.
SELECT Employee_Id AS "ID of the Employee",
       Last_Name AS "Name of the Employee",
       Department_Id AS "Dep_id"
FROM Employee;

-- 7. List out the annual salary of the employees with their names only. 
SELECT First_Name, Last_Name, (Salary * 12) AS Annual_Salary
FROM Employee;

--WHERE Condition: 

-- 1. List the details about "Smith". 
SELECT * FROM Employee WHERE Last_Name = 'Smith';

-- 2. List out the employees who are working in department 20.
SELECT * FROM Employee WHERE Department_Id = 20;

-- 3. List out the employees who are earning salary between 2000 and 3000.
SELECT * FROM Employee WHERE Salary BETWEEN 2000 AND 3000;

-- 4. List out the employees who are working in department 10 or 20. 
SELECT * FROM Employee WHERE Department_Id IN (10, 20);

-- 5. Find out the employees who are not working in department 10 or 30. 
SELECT * FROM Employee WHERE Department_Id NOT IN (10, 30);

-- 6. List out the employees whose name starts with 'L'.
SELECT * FROM Employee WHERE First_Name LIKE 'L%';

-- 7. List out the employees whose name starts with 'L' and ends with 'E'.
SELECT * FROM Employee WHERE First_Name LIKE 'L%E';

-- 8. List out the employees whose name length is 4 and start with 'J'. 
SELECT * FROM Employee
WHERE LEN(First_Name) = 4 AND First_Name LIKE 'J%';


/*9.List out the employees who are working in department 30 and draw the 
salaries more than 2500.*/
SELECT * FROM Employee
WHERE Department_Id = 30 AND Salary > 2500;

-- 10. List out the employees who are not receiving commission. 
SELECT * FROM Employee WHERE Comm IS NULL OR Comm = 0;

-- ORDER BY Clause: 

-- 1. List out the Employee ID and Last Name in ascending order based on the Employee ID. 
SELECT Employee_Id, Last_Name FROM Employee ORDER BY Employee_Id ASC;

-- 2. List out the Employee ID and Name in descending order based on salary. 
SELECT Employee_Id, First_Name, Last_Name, Salary
FROM Employee ORDER BY Salary DESC;

-- 3. List out the employee details according to their Last Name in ascending-order.
SELECT * FROM Employee ORDER BY Last_Name ASC;

/* 4. List out the employee details according to their Last Name in ascending 
order and then Department ID in descending order. */
SELECT * FROM Employee ORDER BY Last_Name ASC, Department_Id DESC;

-- GROUP BY and HAVING Clause: 

/*1. List out the department wise maximum salary, minimum salary and 
average salary of the employees. */
SELECT Department_Id, MAX(Salary), MIN(Salary), AVG(Salary)FROM Employee
GROUP BY Department_Id;

-- 2. List out the job wise maximum salary, minimum salary and average salary of the employees. 
SELECT Job_Id, MAX(Salary), MIN(Salary), AVG(Salary)FROM Employee
GROUP BY Job_Id;

-- 3. List out the number of employees who joined each month in ascending order. 
SELECT DATENAME(MONTH, Hire_Date) AS Month, COUNT(*) AS Total_Employees FROM Employee
GROUP BY DATENAME(MONTH, Hire_Date), MONTH(Hire_Date)
ORDER BY MONTH(Hire_Date);

/*4. List out the number of employees for each month and year in 
ascending order based on the year and month. */
SELECT FORMAT(Hire_Date, 'yyyy-MM') AS YearMonth, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY FORMAT(Hire_Date, 'yyyy-MM')
ORDER BY YearMonth;


-- 5. List out the Department ID having at least four employees. 
SELECT Department_Id, COUNT(*) FROM Employee
GROUP BY Department_Id
HAVING COUNT(*) >= 4;

-- 6. How many employees joined in February month. .
SELECT COUNT(*) FROM Employee
WHERE MONTH(Hire_Date) = '02';

-- 7. How many employees joined in May or June month. 
SELECT COUNT(*) FROM Employee
WHERE MONTH(Hire_Date) IN ('05','06');

-- 8. How many employees joined in 1985? 
SELECT COUNT(*) FROM Employee
WHERE YEAR(Hire_Date) = 1985;


-- 9. How many employees joined each month in 1985? 
SELECT DATENAME(MONTH, Hire_Date) AS Month, COUNT(*) AS Total_Employees FROM Employee
WHERE YEAR(Hire_Date) = 1985
GROUP BY DATENAME(MONTH, Hire_Date), MONTH(Hire_Date)
ORDER BY MONTH(Hire_Date);


-- 10. How many employees were joined in April 1985? 
SELECT COUNT(*) FROM Employee
WHERE YEAR(Hire_Date) = 1985 AND MONTH(Hire_Date) = 4;


/*11. Which is the Department ID having greater than or equal to 3 employees 
joining in April 1985? */
SELECT Department_Id, COUNT(*) AS Total_Employees FROM Employee
WHERE YEAR(Hire_Date) = 1985 AND MONTH(Hire_Date) = 4
GROUP BY Department_Id HAVING COUNT(*) >= 3;

-- Joins: 

-- 1. List out employees with their department names. 
SELECT e.First_Name, e.Last_Name, d.Name AS Department
FROM Employee e
JOIN Department d ON e.Department_Id = d.Department_Id;

--2. Display employees with their designations. 
SELECT e.First_Name, e.Last_Name, j.Designation
FROM Employee e
JOIN Job j ON e.Job_Id = j.Job_Id;

--3. Display the employees with their department names and city.
SELECT e.First_Name, e.Last_Name, d.Name AS Department, l.City
FROM Employee e
JOIN Department d ON e.Department_Id = d.Department_Id
JOIN Location l ON d.Location_Id = l.Location_Id;

--4. How many employees are working in different departments? Display with department names. 
SELECT d.Name, COUNT(*)
FROM Employee e
JOIN Department d ON e.Department_Id = d.Department_Id
GROUP BY d.Name;

-- 5. How many employees are working in the sales department? 
SELECT COUNT(*) FROM Employee e
JOIN Department d ON e.Department_Id = d.Department_Id
WHERE d.Name = 'Sales';

/* 6.  Which is the department having greater than or equal to 3
employees and display the department names in ascending order. sc.*/
SELECT d.Name, COUNT(*) FROM Employee e
JOIN Department d ON e.Department_Id = d.Department_Id
GROUP BY d.Name
HAVING COUNT(*) >= 3
ORDER BY d.Name ASC;

-- 7. How many employees are working in 'Dallas'? 
SELECT COUNT(*) FROM Employee e
JOIN Department d ON e.Department_Id = d.Department_Id
JOIN Location l ON d.Location_Id = l.Location_Id
WHERE l.City = 'Dallas';

-- 8. Display all employees in sales or operation departments. 
SELECT e.First_Name, e.Last_Name, d.Name FROM Employee e
JOIN Department d ON e.Department_Id = d.Department_Id
WHERE d.Name IN ('Sales','Operations');

-- CONDITIONAL STATEMENT 

/* 1. Display the employee details with salary grades. Use conditional statement to 
create a grade column.*/

SELECT First_Name, Last_Name, Salary,
CASE
  WHEN Salary < 1000 THEN 'Grade C'
  WHEN Salary BETWEEN 1000 AND 3000 THEN 'Grade B'
  ELSE 'Grade A'
END AS Salary_Grade
FROM Employee;

/*2. List out the number of employees grade wise. Use conditional statement to 
create a grade column. */
SELECT
CASE
  WHEN Salary < 1000 THEN 'Grade C'
  WHEN Salary BETWEEN 1000 AND 3000 THEN 'Grade B'
  ELSE 'Grade A'
END AS Salary_Grade,
COUNT(*)
FROM Employee
GROUP BY
CASE
  WHEN Salary < 1000 THEN 'Grade C'
  WHEN Salary BETWEEN 1000 AND 3000 THEN 'Grade B'
  ELSE 'Grade A'
END;

/* 3. Display the employee salary grades and the number of employees between 
2000 to 5000 range of salary. */
SELECT
CASE
  WHEN Salary < 1000 THEN 'Grade C'
  WHEN Salary BETWEEN 1000 AND 3000 THEN 'Grade B'
  ELSE 'Grade A'
END AS Salary_Grade,
COUNT(*)
FROM Employee
WHERE Salary BETWEEN 2000 AND 5000
GROUP BY
CASE
  WHEN Salary < 1000 THEN 'Grade C'
  WHEN Salary BETWEEN 1000 AND 3000 THEN 'Grade B'
  ELSE 'Grade A'
END;

-- Subqueries: 

-- 1. Display the employees list who got the maximum salary. 
SELECT * FROM Employee
WHERE Salary = (SELECT MAX(Salary) FROM Employee);

-- 2.Display the employees who are working in the sales department. 
SELECT * FROM Employee
WHERE Department_Id = (SELECT Department_Id FROM Department WHERE Name='Sales');

-- 3. Display the employees who are working as 'Clerk'. 
SELECT * FROM Employee
WHERE Job_Id = (SELECT Job_Id FROM Job WHERE Designation='Clerk');

-- 4. Display the list of employees who are living in 'Boston'. 
SELECT * FROM Employee
WHERE Department_Id IN (
   SELECT Department_Id FROM Department
   WHERE Location_Id = (SELECT Location_Id FROM Location WHERE City='Boston')
);

--5. Find out the number of employees working in the sales department. 
SELECT COUNT(*) FROM Employee
WHERE Department_Id = (SELECT Department_Id FROM Department WHERE Name='Sales');

-- 6. Update the salaries of employees who are working as clerks on the basis of 10%. 
UPDATE Employee
SET Salary = Salary * 1.10
WHERE Job_Id = (SELECT Job_Id FROM Job WHERE Designation='Clerk');

-- 7. Display the second highest salary drawing employee details. 
SELECT * FROM Employee
WHERE Salary = (
   SELECT MAX(Salary) FROM Employee
   WHERE Salary < (SELECT MAX(Salary) FROM Employee)
);

-- 8.List out the employees who earn more than every employee in department 30.
SELECT * FROM Employee
WHERE Salary > ALL (SELECT Salary FROM Employee WHERE Department_Id=30);

-- 9.Find out which department has no employees.
SELECT * FROM Department
WHERE Department_Id NOT IN (SELECT DISTINCT Department_Id FROM Employee);

-- 10.  Find out the employees who earn greater than the average salary for their department. 
SELECT * FROM Employee e
WHERE Salary > (SELECT AVG(Salary) FROM Employee
WHERE Department_Id = e.Department_Id);
