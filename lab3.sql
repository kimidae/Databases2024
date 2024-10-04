CREATE DATABASE lab3;

-- 2. Create table for Students
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50)
);

-- 3. Create table for Courses
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE,
    course_name VARCHAR(100),
    credits INT
);

-- 4. Create table for Registration (link between students and courses)
CREATE TABLE registration (
    registration_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    registration_date DATE,
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

-- 5. Insert sample data into students table
INSERT INTO students (first_name, last_name, date_of_birth, email, city) VALUES
('Alice', 'Johnson', '2001-05-14', 'alice.johnson@example.com', 'Almaty'),
('Bob', 'Smith', '2000-09-20', 'bob.smith@example.com', 'New York'),
('Cathy', 'Williams', '2002-01-10', 'cathy.williams@example.com', 'Almaty'),
('David', 'Brown', '1999-03-22', 'david.brown@example.com', 'Los Angeles');

-- 6. Insert sample data into courses table
INSERT INTO courses (course_code, course_name, credits) VALUES
('CS101', 'Introduction to Computer Science', 4),
('MATH201', 'Calculus I', 3),
('PHYS301', 'General Physics', 3),
('HIST101', 'World History', 2);

-- 7. Insert sample data into registration table
INSERT INTO registration (student_id, course_id, registration_date, grade) VALUES
(1, 1, '2023-09-01', NULL),  -- Alice registered for CS101
(2, 2, '2023-09-01', NULL),  -- Bob registered for MATH201
(3, 3, '2023-09-01', NULL),  -- Cathy registered for PHYS301
(4, 1, '2023-09-01', NULL),  -- David registered for CS101
(1, 4, '2023-09-01', NULL);  -- Alice registered for HIST101


-- 3 Select the last name of all students.
SELECT last_name FROM students;

--4 Select the last name of all students, without duplicates.
SELECT DISTINCT last_name FROM students;

--5 Select all data of students whose last name is "Johnson."
SELECT * FROM students WHERE last_name = 'Johnson';

--6 Select all data of students whose last name is "Johnson" or "Smith."
SELECT * FROM students WHERE last_name = 'Johnson' or last_name = 'Smith';

--7 Select all data of students who are registered in the "CS101" course.
SELECT * FROM students s
JOIN registration r on s.student_id = r.student_id
JOIN courses c on c.course_id = r.course_id
WHERE course_code = 'CS101';

--8 Select all data of students who are registered in the "MATH201" or "PHYS301" courses.
SELECT * FROM students s
JOIN registration r on s.student_id = r.student_id
JOIN courses c on c.course_id = r.course_id
WHERE course_code = 'MATH201' or course_code='PHYS301';

--9 Select the total number of credits for all courses.
SELECT SUM(credits) AS total_credits FROM courses;

--10 Select the number of students registered for each course. Show the course ID and the number of students. (Use the COUNT(*) operator for counting the number of students.)
SELECT c.course_id, COUNT(r.student_id) AS student_count
FROM courses c
JOIN registration r ON c.course_id = r.course_id
GROUP BY c.course_id;

--11 Select the course ID with more than 2 students registered.
SELECT c.course_id FROM courses c
JOIN registration r on c.course_id = r.course_id
GROUP BY c.course_id
HAVING COUNT(r.student_id)>2 ;

--12 Select the course name with the second-highest number of credits.
SELECT course_name
FROM courses
ORDER BY credits DESC
LIMIT 1 OFFSET 1;

--13 Select the first and last names of students registered in the course with the fewest credits.
SELECT s.first_name, s.last_name
FROM students s
JOIN registration r ON s.student_id = r.student_id
JOIN courses c ON r.course_id = c.course_id
WHERE c.credits = (SELECT MIN(credits) FROM courses);

--14 Select the first and last names of all students from Almaty
SELECT first_name, last_name FROM students WHERE city = 'Almaty';

--15 Select all courses with more than 3 credits, sorted by increasing credits and decreasing course ID
SELECT * FROM courses
WHERE credits > 3
ORDER BY credits ASC, course_id DESC;

--16 Decrease the number of credits for the course with the fewest credits by 1.
UPDATE courses
SET credits = credits - 1
WHERE course_id = (
    SELECT course_id
    FROM courses
    ORDER BY credits
    LIMIT 1
);

--17 Reassign all students from the "MATH201" course to the "CS101 course.
UPDATE registration
SET course_id = (SELECT course_id FROM courses WHERE course_code = 'CS101')
WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'MATH201');


--18 Delete from the table all students registered for the "CS101" course.
DELETE FROM registration
WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'CS101');

--19 Delete all students from the database.
DELETE FROM students;




