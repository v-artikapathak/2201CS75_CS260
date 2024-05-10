-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 

-- 1. Create a procedure to calculate the average salary of employees in a given department.
DELIMITER //

CREATE PROCEDURE CalculateAvgSalaryByDepartment(IN dept_id INT)
BEGIN
    SELECT AVG(salary) AS avg_salary
    FROM employees
    WHERE department_id = dept_id;
END //

DELIMITER ;

-- 2. Write a procedure to update the salary of an employee by a specified percentage.
DELIMITER //

CREATE PROCEDURE UpdateEmployeeSalary(IN emp_id INT, IN percentage DECIMAL(5,2))
BEGIN
    UPDATE employees
    SET salary = salary * (1 + (percentage / 100))
    WHERE emp_id = emp_id;
END //

DELIMITER ;

-- 3. Create a procedure to list all employees in a given department.
DELIMITER //

CREATE PROCEDURE ListEmployeesInDepartment(IN dept_id INT)
BEGIN
    SELECT *
    FROM employees
    WHERE department_id = dept_id;
END //

DELIMITER ;

-- 4. Write a procedure to calculate the total budget allocated to a specific project.
DELIMITER //

CREATE PROCEDURE CalculateProjectBudget(IN proj_id INT)
BEGIN
    SELECT budget
    FROM projects
    WHERE project_id = proj_id;
END //

DELIMITER ;

-- 5. Create a procedure to find the employee with the highest salary in a given department.
DELIMITER //

CREATE PROCEDURE FindHighestPaidEmployeeInDepartment(IN dept_id INT)
BEGIN
    SELECT *
    FROM employees
    WHERE department_id = dept_id
    ORDER BY salary DESC
    LIMIT 1;
END //

DELIMITER ;

-- 6. Write a procedure to list all projects that are due to end within a specified number of days.
DELIMITER //

CREATE PROCEDURE ListProjectsDueInDays(IN num_days INT)
BEGIN
    SELECT *
    FROM projects
    WHERE DATEDIFF(end_date, CURDATE()) <= num_days;
END //

DELIMITER ;

-- 7. Create a procedure to calculate the total salary expenditure for a given department.
DELIMITER //

CREATE PROCEDURE CalculateDepartmentSalaryExpenditure(IN dept_id INT)
BEGIN
    SELECT SUM(salary) AS total_salary_expenditure
    FROM employees
    WHERE department_id = dept_id;
END //

DELIMITER ;

-- 8. Write a procedure to generate a report listing all employees along with their department and salary details.
DELIMITER //

CREATE PROCEDURE GenerateEmployeeReport()
BEGIN
    SELECT e.emp_id, e.first_name, e.last_name, d.department_name, e.salary
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id;
END //

DELIMITER ;

-- 9. Create a procedure to find the project with the highest budget.
DELIMITER //

CREATE PROCEDURE FindProjectWithHighestBudget()
BEGIN
    SELECT *
    FROM projects
    ORDER BY budget DESC
    LIMIT 1;
END //

DELIMITER ;

-- 10. Write a procedure to calculate the average salary of employees across all departments.
DELIMITER //

CREATE PROCEDURE CalculateOverallAvgSalary()
BEGIN
    SELECT AVG(salary) AS overall_avg_salary
    FROM employees;
END //

DELIMITER ;

-- 11. Create a procedure to assign a new manager to a department and update the manager_id in the departments table.
DELIMITER //

CREATE PROCEDURE AssignNewManagerToDepartment(IN dept_id INT, IN new_manager_id INT)
BEGIN
    UPDATE departments
    SET manager_id = new_manager_id
    WHERE department_id = dept_id;
END //

DELIMITER ;

-- 12. Write a procedure to calculate the remaining budget for a specific project.
DELIMITER //

CREATE PROCEDURE CalculateRemainingBudgetForProject(IN proj_id INT)
BEGIN
    SELECT budget - SUM(salary) AS remaining_budget
    FROM projects
    JOIN employees ON projects.project_id = proj_id;
END //

DELIMITER ;

-- 13. Create a procedure to generate a report of employees who joined the company in a specific year.
DELIMITER //

CREATE PROCEDURE GenerateEmployeeJoiningReport(IN join_year INT)
BEGIN
    SELECT *
    FROM employees
    WHERE YEAR(join_date) = join_year;
END //

DELIMITER ;

-- 14. Write a procedure to update the end date of a project based on its start date and duration.
DELIMITER //

CREATE PROCEDURE UpdateProjectEndDate(IN proj_id INT, IN duration INT)
BEGIN
    UPDATE projects
    SET end_date = DATE_ADD(start_date, INTERVAL duration MONTH)
    WHERE project_id = proj_id;
END //

DELIMITER ;

-- 15. Create a procedure to calculate the total number of employees in each department.
DELIMITER //

CREATE PROCEDURE CalculateTotalEmployeesPerDepartment()
BEGIN
    SELECT department_id, COUNT(emp_id) AS total_employees
    FROM employees
    GROUP BY department_id;
END //

DELIMITER ;
