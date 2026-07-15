CREATE DATABASE info;
use info;
--Database Setup
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    email VARCHAR(100),
    phone_number VARCHAR(20)
);
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credit_hour INT
);
CREATE TABLE enrollment (
    enrollment_id INT PRIMARY KEY,
    course_id INT,
    student_id INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);
--Data Insertion
INSERT INTO Students (student_id, name, age, email, phone_number) VALUES
(1, 'Alice Smith', 20, 'alice@example.com', '555-0101'),
(2, 'Bob Johnson', 22, 'bob@example.com', '555-0102'),
(3, 'Charlie Brown', 19, 'charlie@example.com', '555-0103'),
(4, 'Diana Prince', 21, 'diana@example.com', '555-0104'),
(5, 'Evan Wright', 23, 'evan@example.com', '555-0105');
INSERT INTO courses (course_id, name, credit_hour) VALUES
(101, 'Introduction to Computer Science', 3),
(102, 'Data Structures', 4),
(103, 'Database Management Systems', 3),
(104, 'Web Development', 3),
(105, 'Artificial Intelligence', 4);
INSERT INTO enrollment (enrollment_id, course_id, student_id) VALUES
(1001, 101, 1),
(1002, 103, 1),
(1003, 102, 2),
(1004, 104, 2),
(1005, 101, 3),
(1006, 105, 4),
(1007, 103, 5),
(1008, 105, 5),
(1009, 102, 1);
--Selections
SELECT * FROM students;
SELECT name,email
FROM students;
SELECT * FROM students
WHERE age>20;
SELECT name 
FROM students where name LIKE 'A%';
SELECT * FROM courses
WHERE name like '%Science%';
SELECT * FROM students
ORDER BY age DESC;
SELECT * FROM students
WHERE phone_number='555-0103';
--Alter
ALTER Table students
ADD COLUMN address VARCHAR(255);
UPDATE Students SET address = 'Kathmandu' WHERE student_id = 1;
UPDATE Students SET address = 'Pokhara' WHERE student_id = 2;
UPDATE Students SET address = 'Lalitpur' WHERE student_id = 3;
UPDATE Students SET address = 'Bhaktapur' WHERE student_id = 4;
UPDATE Students SET address = 'Biratnagar' WHERE student_id = 5;
ALTER Table students
ADD COLUMN is_active BOOLEAN DEFAULT true;
ALTER Table students
MODIFY COLUMN phone_number VARCHAR(50);
ALTER Table courses
RENAME COLUMN name to course_name;
ALTER Table students
DROP COLUMN age;
ALTER Table courses
ADD constraint chk_credit_hour
check(credit_hour>=1);
--Update
UPDATE students
SET phone_number='555-9999'
WHERE student_id=1;
ALTER Table students
ADD COLUMN age INT;
UPDATE Students SET age = 20 WHERE student_id = 1;
UPDATE Students SET age = 22 WHERE student_id = 2;
UPDATE Students SET age = 19 WHERE student_id = 3;
UPDATE Students SET age = 21 WHERE student_id = 4;
UPDATE Students SET age = 23 WHERE student_id = 5;
UPDATE students
SET age=23, email='bob.j@newemail.com'
WHERE student_id=2;
UPDATE courses
SET credit_hour=credit_hour+1
WHERE credit_hour=3;
UPDATE students
SET email=LOWER(email);
UPDATE courses
SET credit_hour=5
WHERE course_id=(
    SELECT course_id
    FROM(
        SELECT course_id, course_name
        FROM courses
    )AS temp 
    WHERE course_name='Data Structures'
);
--Delete
--DELETE FROM students
--WHERE name='Evan Wright';
--student_id = 5 (Evan) is being used in the enrollment table.
--If we delete Evan from Students, what should I do with these enrollment records that still say student_id = 5
--Those rows would point to a student who no longer exists.
DELETE FROM enrollment
WHERE student_id=5;
DELETE FROM students
WHERE name='Evan Wright';
--A foreign key prevents you from deleting a parent row (Students) while child rows (enrollment) still refer to it. 
--You must delete the child rows first.
DELETE FROM courses
WHERE credit_hour<3;
DELETE FROM enrollment
WHERE student_id=3;
DELETE FROM students
WHERE student_id=3;
--Since the enrollment table has a foreign key to the Students table, you must delete Charlie's enrollment records first, then delete Charlie from Students.
DELETE FROM enrollment;
--Aggregate Functions
SELECT COUNT(*) AS total_students
FROM students;
SELECT AVG(age) AS average_age
FROM students;
SELECT MAX(credit_hour) AS maximum_credit_hour
FROM courses;
SELECT MIN(age) AS youngest_age
FROM students;
SELECT SUM(credit_hour) AS total_credit_hours
FROM courses;
--Grouping Data
INSERT INTO enrollment (enrollment_id, course_id, student_id)
VALUES (1001, 101, 1);
INSERT INTO enrollment (enrollment_id, course_id, student_id)
VALUES (1002, 103, 1);
INSERT INTO enrollment (enrollment_id, course_id, student_id)
VALUES (1003, 102, 2);
INSERT INTO enrollment (enrollment_id, course_id, student_id)
VALUES (1004, 104, 2);
INSERT INTO enrollment (enrollment_id, course_id, student_id)
VALUES (1006, 105, 4);
INSERT INTO enrollment (enrollment_id, course_id, student_id)
VALUES (1009, 102, 1);
SELECT course_id, COUNT(student_id) AS total_students
FROM enrollment
GROUP BY course_id;
SELECT student_id, COUNT(course_id) AS enrollment_count
FROM enrollment
GROUP BY student_id;
INSERT INTO enrollment (enrollment_id, course_id, student_id)
VALUES (1010, 101, 2);
SELECT course_id, COUNT(student_id) AS total_students
FROM enrollment
GROUP BY course_id
HAVING COUNT(student_id) > 2;
SELECT student_id, COUNT(course_id) AS total_courses
FROM enrollment
GROUP BY student_id
HAVING COUNT(course_id) = 2;
--Table Relations and Joins
SELECT s.name, e.course_id
FROM students s
INNER JOIN enrollment e
ON s.student_id = e.student_id;
SELECT s.name AS student_name,
c.name AS course_name
FROM students s
JOIN enrollment e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_id = c.course_id;
SELECT c.course_id,
c.name AS course_name,
COUNT(e.student_id) AS total_students
FROM courses c
LEFT JOIN enrollment e
ON c.course_id = e.course_id
GROUP BY c.course_id, c.name;
SELECT s.name
FROM students s
INNER JOIN enrollment e
ON s.student_id = e.student_id
INNER JOIN courses c
ON e.course_id = c.course_id
WHERE c.name = 'Database Management Systems';
INSERT INTO students
(student_id, name, age, email, phone_number)
VALUES
(6, 'Ram Sharma', 20, 'ram@example.com', '555-0106');
SELECT s.student_id,
s.name
FROM students s
LEFT JOIN enrollment e
ON s.student_id = e.student_id
WHERE e.student_id IS NULL;
SELECT s.name,
SUM(c.credit_hour) AS total_credit_hours
FROM students s
INNER JOIN enrollment e
ON s.student_id = e.student_id
INNER JOIN courses c
ON e.course_id = c.course_id
GROUP BY s.student_id, s.name;
--Subqueries and Advanced Logic
SELECT s.name
FROM students s
JOIN enrollment e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_id = c.course_id
WHERE c.credit_hour = (
    SELECT MAX(credit_hour)
    FROM courses
);
SELECT c.name,
COUNT(e.student_id) AS enrollment_count
FROM courses c
JOIN enrollment e
ON c.course_id = e.course_id
GROUP BY c.course_id, c.name
HAVING COUNT(e.student_id) >
(
    SELECT AVG(student_count)
    FROM
    (
        SELECT COUNT(student_id) AS student_count
        FROM enrollment
        GROUP BY course_id
    ) AS avg_enrollment
);
SELECT name, age
FROM students
WHERE age >
(
    SELECT AVG(age)
    FROM students
);
--Stored Procedures and DML
SELECT c.name
FROM courses c
JOIN enrollment e
ON c.course_id = e.course_id
WHERE e.student_id = 1;
CREATE PROCEDURE EnrollStudent(
    IN p_student_id INT,
    IN p_course_id INT
)
BEGIN
    INSERT INTO enrollment
    VALUES (1011, p_course_id, p_student_id);
END;
UPDATE courses
SET credit_hour = credit_hour + 1
WHERE name = 'Web Development';