-- Drop tables if they exist to start fresh
DROP TABLE IF EXISTS return_status2;
DROP TABLE IF EXISTS issued_status2;
DROP TABLE IF EXISTS books2;
DROP TABLE IF EXISTS members2;
DROP TABLE IF EXISTS employees2;
DROP TABLE IF EXISTS branch2;

-- Create Branch table
CREATE TABLE branch
(
    branch_id VARCHAR(10) PRIMARY KEY,
    manager_id VARCHAR(10),
    branch_address VARCHAR(50),
    contact_no VARCHAR(15)
);

-- Create Employee table
CREATE TABLE employees
(
    emp_id VARCHAR(10) PRIMARY KEY,
    emp_name VARCHAR(25),
    position VARCHAR(15),
    salary DECIMAL(10,2),
    branch_id VARCHAR(10) -- Data type corrected to match branch_id
);

-- Create Members table
CREATE TABLE members
(
    member_id VARCHAR(10) PRIMARY KEY,
    member_name VARCHAR(30),
    member_address VARCHAR(30),
    reg_date DATE
);

-- Create Books table
CREATE TABLE books
(
    isbn VARCHAR(50) PRIMARY KEY,
    book_title VARCHAR(80),
    category VARCHAR(30),
    rental_price DECIMAL(10,2),
    status VARCHAR(10),
    author VARCHAR(30),
    publisher VARCHAR(30)
);

-- Create IssueStatus table
CREATE TABLE issued_status
(
    issued_id VARCHAR(10) PRIMARY KEY,
    issued_member_id VARCHAR(10), -- Data type corrected to match member_id
    issued_book_name VARCHAR(80),
    issued_date DATE,
    issued_book_isbn VARCHAR(50),
    issued_emp_id VARCHAR(10)
);

-- Create ReturnStatus table
CREATE TABLE return_status
(
    return_id VARCHAR(10) PRIMARY KEY,
    issued_id VARCHAR(10), -- Data type corrected to match issued_id
    return_book_name VARCHAR(80),
    return_date DATE,
    return_book_isbn VARCHAR(50)
);

---
-- Add Foreign Keys
---

-- Foreign key for issued_status2 to members2
-- This links an issued book to a specific member
ALTER TABLE issued_status
ADD CONSTRAINT fk_members
FOREIGN KEY (issued_member_id)
REFERENCES members(member_id);

-- Foreign key for issued_status2 to books2
-- This links an issued book to a specific book using its ISBN
ALTER TABLE issued_status
ADD CONSTRAINT fk_books
FOREIGN KEY (issued_book_isbn)
REFERENCES books(isbn);

-- Foreign key for issued_status2 to employees2
-- This links an issued book to the employee who issued it
ALTER TABLE issued_status
ADD CONSTRAINT fk_employees
FOREIGN KEY (issued_emp_id)
REFERENCES employees(emp_id);

-- Foreign key for employees2 to branch2
-- This links an employee to their branch
ALTER TABLE employees
ADD CONSTRAINT fk_branch
FOREIGN KEY (branch_id)
REFERENCES branch(branch_id);


