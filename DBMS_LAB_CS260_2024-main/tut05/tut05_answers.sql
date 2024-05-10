-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 


-- 1. Write a relational algebra expression to select all employees from the 'Engineering' department.
π_first_name, last_name, salary(employees ⨝_{employees.department_id = departments.department_id}(employees ⨝_{departments.department_name = 'Engineering'} departments))

-- 2. Perform a projection to display only the first names and salaries of all employees.
π_first_name, salary(employees)

-- 3. Write a relational algebra expression to find employees who are managers.
π_first_name, last_name, salary(employees ⨝_{employees.emp_id = departments.manager_id} departments)

-- 4. Perform a selection to retrieve employees earning a salary greater than ?60000.
σ_{salary > 60000}(employees)

-- 5. Write a relational algebra expression to join employees with their respective departments.
employees ⨝_{employees.department_id = departments.department_id} departments

-- 6. Perform a Cartesian product between employees and projects.
employees × projects

-- 7. Write a relational algebra expression to find employees who are not managers.
π_first_name, last_name, salary(employees - (employees ⨝_{employees.emp_id = departments.manager_id} departments))

-- 8. Perform a natural join between departments and projects.
departments ⨝ projects

-- 9. Write a relational algebra expression to project the department names and locations from departments table.
π_department_name, location(departments)

-- 10. Perform a selection to retrieve projects with budgets greater than ?100000.
σ_{budget > 100000}(projects)

-- 11. Write a relational algebra expression to find employees who are managers in the 'Sales' department.
π_first_name, last_name, salary(employees ⨝_{employees.emp_id = departments.manager_id AND departments.department_name = 'Sales'} departments)

-- 12. Perform a union operation between two sets of employees from the 'Engineering' and 'Finance' departments.
π_first_name, last_name, salary(employees ⨝_{employees.department_id = departments.department_id} σ_{department_name = 'Engineering'}(departments)) ∪ π_first_name, last_name, salary(employees ⨝_{employees.department_id = departments.department_id} σ_{department_name = 'Finance'}(departments))

-- 13. Write a relational algebra expression to find employees who are not assigned to any projects.
π_first_name, last_name, salary(employees - (employees ⨝_{employees.emp_id = projects.project_id} projects))

-- 14. Perform a join operation to display employees along with their project assignments.
employees ⨝_{employees.emp_id = projects.project_id} projects

-- 15. Write a relational algebra expression to find employees whose salaries are not within the range ?50000 to ?70000.
π_first_name, last_name, salary(employees - σ_{salary >= 50000 AND salary <= 70000}(employees)
