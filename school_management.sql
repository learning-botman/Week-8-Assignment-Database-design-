-- 🏫 School Management System
-- 👤 Author: Evans
-- 📅 Date: Week 8 Assignment
-- 📜 Description: Full SQL script with database creation, user, and schema

-- ==============================
-- 🏛️ Create Database
-- ==============================
CREATE DATABASE IF NOT EXISTS school_management;
USE school_management;

-- ==============================
-- 👤 Create User (if not exists)
-- ==============================
CREATE USER IF NOT EXISTS 'evans'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Evans@2025!';
GRANT ALL PRIVILEGES ON school_management.* TO 'evans'@'localhost';
FLUSH PRIVILEGES;

-- ==============================
-- 🚫 Drop Tables (clean start)
-- ==============================
-- 🧾 Enrollments Table
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
-- 📊 Grades Table
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
-- 🔐 Users Table
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
-- ✅ Optional Sample Data
-- ==============================
-- INSERT INTO departments(name) VALUES ('Mathematics'), ('Science'), ('Languages');
-- INSERT INTO classrooms(name, capacity) VALUES ('A101', 40), ('B202', 30);

