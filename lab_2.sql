CREATE
    DATABASE lab2;
CREATE TABLE employees
(
    employee_id   SERIAL PRIMARY KEY,
    first_name    VARCHAR(60),
    last_name     VARCHAR(60),
    department_id INTEGER,
    salary        INTEGER
);

INSERT INTO employees (first_name, last_name, department_id, salary)
VALUES ('Ivan', 'Ivanov', 025648, 500000);


INSERT INTO employees (first_name, last_name)
VALUES ('Vasiliy', 'Vasilievich');

INSERT INTO employees (first_name, last_name, department_id, salary)
VALUES ('Egor', 'Egorovich', NULL, 500000);

INSERT INTO employees (first_name, last_name, department_id, salary)
VALUES ('FName1', 'LName1', NULL, 150000),
       ('FName2', 'LName2', NULL, 135000),
       ('FName3', 'LName3', 54682, 100000),
       ('FName4', 'LName4', 68765, 100),
       ('FName5', 'LName5', NULL, 60000);

ALTER TABLE employees
    ALTER COLUMN first_name SET DEFAULT 'John';

INSERT INTO employees (last_name, department_id, salary)
VALUES ('Johnovich', NULL, 500000);

INSERT INTO employees default
VALUES;

CREATE TABLE employees_archive (LIKE employees INCLUDING ALL);
SELECT * FROM employees_archive;

INSERT INTO employees_archive (employee_id, first_name, last_name, department_id, salary)
SELECT employee_id, first_name, last_name, department_id, salary FROM employees;

UPDATE employees
SET department_id = 1 WHERE department_id is NULL;

UPDATE employees
SET salary = salary * 1.15 WHERE department_id=1;

DELETE FROM employees
WHERE salary<50000;

DELETE FROM employees_archive
WHERE employee_id IN (SELECT employee_id FROM employees)
RETURNING *;

DELETE FROM employees RETURNING *;
































UPDATE employees
SET salary = salary * 1.15 WHERE department_id = 1;
SELECT (first_name, last_name, salary) FROM employees
