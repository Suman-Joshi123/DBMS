CREATE DATABASE student;
use student;
CREATE TABLE Student (
    s_id INT PRIMARY KEY,
    s_name VARCHAR(100) NOT NULL,
    s_age INT,
    s_email VARCHAR(100),
    s_phone_number VARCHAR(20)
);
CREATE TABLE course (
    c_id INT PRIMARY KEY,
    c_name VARCHAR(100) NOT NULL,
    credit_hr INT
);
CREATE TABLE enrollment (
    e_id INT PRIMARY KEY,
    c_id INT,
    s_id INT,
    FOREIGN KEY (c_id) REFERENCES course(c_id),
    FOREIGN KEY (s_id) REFERENCES Student(s_id)
);
INSERT INTO Student (s_id, s_name, s_age, s_email, s_phone_number) VALUES
(1, 'Alice Smith', 20, 'alice@example.com', '555-0101'),
(2, 'Bob Johnson', 22, 'bob@example.com', '555-0102'),
(3, 'Charlie Brown', 19, 'charlie@example.com', '555-0103'),
(4, 'Diana Prince', 21, 'diana@example.com', '555-0104'),
(5, 'Evan Wright', 23, 'evan@example.com', '555-0105');
INSERT INTO course (c_id, c_name, credit_hr) VALUES
(101, 'Introduction to Computer Science', 3),
(102, 'Data Structures', 4),
(103, 'Database Management Systems', 3),
(104, 'Web Development', 3),
(105, 'Artificial Intelligence', 4);
INSERT INTO enrollment (e_id, c_id, s_id) VALUES
(1001, 101, 1),
(1002, 103, 1),
(1003, 102, 2),
(1004, 104, 2),
(1005, 101, 3),
(1006, 105, 4),
(1007, 103, 5),
(1008, 105, 5),
(1009, 102, 1);
SELECT * FROM student;
SELECT s_name, s_email
FROM student;
SELECT * FROM course;
SELECT * FROM enrollment;