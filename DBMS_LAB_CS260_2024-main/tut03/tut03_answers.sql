-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 

-- 1. Write a query to display the first name and last name of all students.
SELECT first_name, last_name FROM students;

-- 2. List all course names along with their credit hours.
SELECT course_name, credit_hours FROM courses;

-- 3. Display the first name, last name, and email of all instructors.
SELECT first_name, last_name, email FROM instructors;

-- 4. Show the course names and grades of all students.
SELECT courses.course_name, enrollments.grade 
FROM courses 
JOIN enrollments ON courses.course_id = enrollments.course_id;

-- 5. List the first name, last name, and city of all students.
SELECT first_name, last_name, city FROM students;

-- 6. Display the course names and instructor names for all courses.
SELECT courses.course_name, CONCAT(instructors.first_name, ' ', instructors.last_name) AS instructor_name 
FROM courses 
JOIN instructors ON courses.instructor_id = instructors.instructor_id;

-- 7. Show the first name, last name, and age of all students.
SELECT first_name, last_name, age FROM students;

-- 8. List the course names and enrollment dates of all students.
SELECT courses.course_name, enrollments.enrollment_date 
FROM courses 
JOIN enrollments ON courses.course_id = enrollments.course_id;

-- 9. Display the instructor names and email addresses for all instructors.
SELECT first_name, last_name, email FROM instructors;

-- 10. Show the course names and credit hours for all courses.
SELECT course_name, credit_hours FROM courses;

-- 11. List the first name, last name, and email of the instructor for 'Mathematics' course.
SELECT instructors.first_name, instructors.last_name, instructors.email 
FROM instructors 
JOIN courses ON instructors.instructor_id = courses.instructor_id 
WHERE courses.course_name = 'Mathematics';

-- 12. Display the course names and grades for all students with a grade of 'A'.
SELECT courses.course_name, enrollments.grade 
FROM courses 
JOIN enrollments ON courses.course_id = enrollments.course_id 
WHERE enrollments.grade = 'A';

-- 13. Show the first name, last name, and state of students enrolled in 'Computer Science' course.
SELECT students.first_name, students.last_name, students.state 
FROM students 
JOIN enrollments ON students.student_id = enrollments.student_id 
JOIN courses ON enrollments.course_id = courses.course_id 
WHERE courses.course_name = 'Computer Science';

-- 14. List the course names and enrollment dates for all students with a grade of 'B+'.
SELECT courses.course_name, enrollments.enrollment_date 
FROM courses 
JOIN enrollments ON courses.course_id = enrollments.course_id 
WHERE enrollments.grade = 'B+';

-- 15. Display the instructor names and email addresses for instructors teaching courses with more than 3 credit hours.
SELECT instructors.first_name, instructors.last_name, instructors.email 
FROM instructors 
JOIN courses ON instructors.instructor_id = courses.instructor_id 
WHERE courses.credit_hours > 3;
