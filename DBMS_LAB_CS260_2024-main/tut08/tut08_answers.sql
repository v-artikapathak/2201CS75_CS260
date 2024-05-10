-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 

-- 1. Create a trigger that automatically increases the salary by 10% for employees whose salary is below ?60000 when a new record is inserted into the employees table.
DELIMITER //

CREATE TRIGGER IncreaseSalaryBelowThreshold
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 60000 THEN
        SET NEW.salary = NEW.salary * 1.10;
    END IF;
END //

DELIMITER ;

-- 2. Create a trigger that prevents deleting records from the departments table if there are employees assigned to that department.
DELIMITER //

CREATE TRIGGER PreventDeleteFromDepartments
BEFORE DELETE ON departments
FOR EACH ROW
BEGIN
    DECLARE emp_count INT;
    SELECT COUNT(*) INTO emp_count FROM employees WHERE department_id = OLD.department_id;
    IF emp_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete department with assigned employees';
    END IF;
END //

DELIMITER ;

-- 3. Write a trigger that logs the details of any salary updates (old salary, new salary, employee name, and date) into a separate audit table.
DELIMITER //

CREATE TRIGGER SalaryUpdateAudit
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO salary_audit (emp_id, old_salary, new_salary, update_date)
    VALUES (OLD.emp_id, OLD.salary, NEW.salary, CURDATE());
END //

DELIMITER ;

-- 4. Create a trigger that automatically assigns a department to an employee based on their salary range (e.g., salary <= ?60000 -> department_id = 3).
DELIMITER //

CREATE TRIGGER AssignDepartmentBasedOnSalary
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary <= 60000 THEN
        SET NEW.department_id = 3;
    -- Add more conditions and assignments as needed
    END IF;
END //

DELIMITER ;

-- 5. Write a trigger that updates the salary of the manager (highest-paid employee) in each department whenever a new employee is hired in that department.
DELIMITER //

CREATE TRIGGER UpdateManagerSalaryOnNewHire
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    UPDATE employees e
    JOIN (SELECT department_id, MAX(salary) AS max_salary FROM employees GROUP BY department_id) m
    ON e.department_id = m.department_id
    SET e.salary = NEW.salary
    WHERE e.salary = m.max_salary;
END //

DELIMITER ;

-- 6. Create a trigger that prevents updating the department_id of an employee if they have worked on projects.
DELIMITER //

CREATE TRIGGER PreventDepartmentIdUpdate
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    DECLARE proj_count INT;
    SELECT COUNT(*) INTO proj_count FROM works_on WHERE emp_id = OLD.emp_id;
    IF proj_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update department ID for employees with assigned projects';
    END IF;
END //

DELIMITER ;

-- 7. Write a trigger that calculates and updates the average salary for each department whenever a salary change occurs.
DELIMITER //

CREATE TRIGGER UpdateAverageSalaryOnSalaryChange
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    UPDATE departments d
    JOIN (
        SELECT department_id, AVG(salary) AS avg_salary FROM employees GROUP BY department_id
    ) a ON d.department_id = a.department_id
    SET d.avg_salary = a.avg_salary;
END //

DELIMITER ;

-- 8. Create a trigger that automatically deletes all records from the works_on table for an employee when that employee is deleted from the employees table.
DELIMITER //

CREATE TRIGGER DeleteWorksOnRecordsOnEmployeeDelete
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    DELETE FROM works_on WHERE emp_id = OLD.emp_id;
END //

DELIMITER ;

-- 9. Write a trigger that prevents inserting a new employee if their salary is less than the minimum salary set for their department.
DELIMITER //

CREATE TRIGGER PreventSalaryBelowMinimum
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    DECLARE min_salary DECIMAL(10,2);
    SELECT MIN_SALARY INTO min_salary FROM departments WHERE department_id = NEW.department_id;
    IF NEW.salary < min_salary THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee salary below minimum for department';
    END IF;
END //

DELIMITER ;

-- 10. Create a trigger that automatically updates the total salary budget for a department whenever an employee's salary is updated.
DELIMITER //

CREATE TRIGGER UpdateDepartmentSalaryBudget
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    UPDATE departments d
    JOIN (
        SELECT department_id, SUM(salary) AS total_salary FROM employees GROUP BY department_id
    ) s ON d.department_id = s.department_id
    SET d.total_salary_budget = s.total_salary;
END //

DELIMITER ;

-- 11. Write a trigger that sends an email notification to HR whenever a new employee is hired.
DELIMITER //

CREATE TRIGGER NotifyHROnNewEmployeeHire
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    -- Your code to send email notification to HR goes here
END //

DELIMITER ;

-- 12. Create a trigger that prevents inserting a new department if the location is not specified.
DELIMITER //

CREATE TRIGGER PreventDepartmentInsertWithoutLocation
BEFORE INSERT ON departments
FOR EACH ROW
BEGIN
    IF NEW.location IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Location must be specified for a new department';
    END IF;
END //

DELIMITER ;

-- 13. Write a trigger that updates the department_name in the employees table when the corresponding department_name is updated in the departments table.
DELIMITER //

CREATE TRIGGER UpdateDepartmentNameInEmployees
AFTER UPDATE ON departments
FOR EACH ROW
BEGIN
    UPDATE employees
    SET department_name = NEW.department_name
    WHERE department_id = NEW.department_id;
END //

DELIMITER ;

-- 14. Create a trigger that logs all insert, update, and delete operations on the employees table into a separate audit table.
DELIMITER //

CREATE TRIGGER EmployeeOperationsAudit
AFTER INSERT, UPDATE, DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (operation_type, emp_id, first_name, last_name, salary, department_id, operation_date)
    VALUES (IFNULL(NEW.emp_id, OLD.emp_id), IFNULL(NEW.first_name, OLD.first_name), IFNULL(NEW.last_name, OLD.last_name), IFNULL(NEW.salary, OLD.salary), IFNULL(NEW.department_id, OLD.department_id), NOW());
END //

DELIMITER ;

-- 15. Write a trigger that automatically generates an employee ID using a sequence whenever a new employee is inserted.
DELIMITER //

CREATE TRIGGER GenerateEmployeeID
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    DECLARE next_id INT;
    SELECT MAX(emp_id) + 1 INTO next_id FROM employees;
    SET NEW.emp_id = next_id;
END //

DELIMITER ;
