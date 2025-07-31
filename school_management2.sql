- 🏫 School Management System
-- 👤 Author: Evans
-- 📅 Date: Week 8 Assignment
-- 📜 Description: Complete, normalized school management database system with proper constraints and relationships.

-- 🚫 Drop tables if they exist (for development/testing)
DROP TABLE IF EXISTS attendance, grades, enrollments, student_guardian, teacher_course, users, guardians, students, teachers, classrooms, courses, departments;

-- ==============================
-- 🔧 Departments Table
-- ==============================
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- ==============================
-- 👨‍🏫 Teachers Table
-- ==============================
CREATE TABLE teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- ==============================
-- 🧑‍🎓 Students Table
-- ==============================
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20)
);

-- ==============================
-- 🧑‍👩 Guardians Table
-- ==============================
CREATE TABLE guardians (
    guardian_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    relationship VARCHAR(50)
);

-- ==============================
-- 🔗 Student-Guardian (M-M)
-- ==============================
CREATE TABLE student_guardian (
    student_id INT,
    guardian_id INT,
    PRIMARY KEY (student_id, guardian_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (guardian_id) REFERENCES guardians(guardian_id)
);

-- ==============================
-- 🏫 Classrooms Table
-- ==============================
CREATE TABLE classrooms (
    classroom_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    capacity INT NOT NULL
);

-- ==============================
-- 📚 Courses Table
-- ==============================
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL UNIQUE,
    course_code VARCHAR(10) NOT NULL UNIQUE,
    department_id INT,
    classroom_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (classroom_id) REFERENCES classrooms(classroom_id)
);

-- ==============================
-- 🔗 Teacher-Course (M-M)
-- ==============================
CREATE TABLE teacher_course (
    teacher_id INT,
    course_id INT,
    PRIMARY KEY (teacher_id, course_id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- ==============================
-- 🧾 Enrollments (M-M between student & course)
-- ==============================
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    UNIQUE (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- ==============================
-- 📊 Grades Table (1-M)
-- ==============================
CREATE TABLE grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT NOT NULL,
    grade CHAR(2) CHECK (grade IN ('A', 'B', 'C', 'D', 'E', 'F', 'I')),
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);

-- ==============================
-- 📆 Attendance Table
-- ==============================
CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    status ENUM('Present', 'Absent', 'Excused') NOT NULL,
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);

-- ==============================
-- 🔐 Users Table (1-1 with Teachers/Students)
-- ==============================
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Teacher', 'Student') NOT NULL,
    teacher_id INT UNIQUE,
    student_id INT UNIQUE,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- ==============================
-- ✅ Sample Data (optional)
-- ==============================
-- INSERT INTO departments(name) VALUES ('Mathematics'), ('Science'), ('Languages');
-- INSERT INTO classrooms(name, capacity) VALUES ('A101', 40), ('B202', 30);



-- ==============================
-- 🔧 Departments
-- ==============================
INSERT INTO departments (name) VALUES
('Mathematics'),
('Science'),
('Languages'),
('History');

-- ==============================
-- 🏫 Classrooms
-- ==============================
INSERT INTO classrooms (name, capacity) VALUES
('A101', 40),
('B202', 30),
('C303', 35),
('D404', 25);

-- ==============================
-- 👨‍🏫 Teachers
-- ==============================
INSERT INTO teachers (first_name, last_name, email, phone, department_id) VALUES
('John', 'Doe', 'jdoe@school.edu', '1234567890', 1),
('Jane', 'Smith', 'jsmith@school.edu', '1234567891', 2),
('Albert', 'Newton', 'anewton@school.edu', '1234567892', 3),
('Mary', 'Johnson', 'mjohnson@school.edu', '1234567893', 4);

-- ==============================
-- 🧑‍🎓 Students
-- ==============================
INSERT INTO students (first_name, last_name, date_of_birth, gender, email, phone) VALUES
('Alice', 'Wong', '2007-05-14', 'Female', 'alice.wong@example.com', '5551111111'),
('Bob', 'Lee', '2006-11-22', 'Male', 'bob.lee@example.com', '5552222222'),
('Carla', 'Diaz', '2007-03-09', 'Female', 'carla.diaz@example.com', '5553333333'),
('David', 'Smith', '2005-08-18', 'Male', 'david.smith@example.com', '5554444444');

-- ==============================
-- 👨‍👩 Guardians
-- ==============================
INSERT INTO guardians (full_name, phone, relationship) VALUES
('Evelyn Wong', '5559991111', 'Mother'),
('Henry Lee', '5559992222', 'Father'),
('Maria Diaz', '5559993333', 'Mother'),
('Paul Smith', '5559994444', 'Father');

-- ==============================
-- 🔗 Student-Guardian Links
-- ==============================
INSERT INTO student_guardian (student_id, guardian_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- ==============================
-- 📚 Courses
-- ==============================
INSERT INTO courses (course_name, course_code, department_id, classroom_id) VALUES
('Algebra I', 'MATH101', 1, 1),
('Biology Basics', 'SCI201', 2, 2),
('English Grammar', 'LANG301', 3, 3),
('World History', 'HIST101', 4, 4);

-- ==============================
-- 🔗 Teacher-Course Assignments
-- ==============================
INSERT INTO teacher_course (teacher_id, course_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- ==============================
-- 🧾 Enrollments
-- ==============================
INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-09-01'),
(2, 2, '2024-09-01'),
(3, 3, '2024-09-01'),
(4, 4, '2024-09-01');

-- ==============================
-- 📊 Grades
-- ==============================
INSERT INTO grades (enrollment_id, grade) VALUES
(1, 'A'),
(2, 'B'),
(3, 'A'),
(4, 'C');

-- ==============================
-- 📆 Attendance
-- ==============================
INSERT INTO attendance (enrollment_id, attendance_date, status) VALUES
(1, '2024-10-01', 'Present'),
(2, '2024-10-01', 'Absent'),
(3, '2024-10-01', 'Excused'),
(4, '2024-10-01', 'Present');

-- ==============================
-- 🔐 Users
-- ==============================
INSERT INTO users (username, password_hash, role, teacher_id, student_id) VALUES
('teacher.john', 'hash123', 'Teacher', 1, NULL),
('teacher.jane', 'hash456', 'Teacher', 2, NULL),
('alice.w', 'hash789', 'Student', NULL, 1),
('bob.l', 'hashabc', 'Student', NULL, 2);


