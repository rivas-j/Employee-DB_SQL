-- Create a new table of employees that are retirement age and their titles
SELECT employees.emp_no,
	employees.first_name,
	employees.last_name,
	titles.title,
	titles.from_date,
	titles.to_date
INTO retirement_titles
FROM employees
JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;

--  Retrieve the number of employees by their most recent job title who are about to retire and add them to a new table
SELECT count(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count(title) DESC;

SELECT * FROM retiring_titles;

---------------------------------------------------------------------------------------------------------------------------

-- Create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program

SELECT DISTINCT ON (employees.emp_no) employees.emp_no,
	employees.first_name,
	employees.last_name,
	employees.birth_date,
	dept_emp.from_date,
	dept_emp.to_date,
	titles.title
	
INTO mentorship_eligibility
FROM employees
JOIN dept_emp
ON (employees.emp_no = dept_emp.emp_no)
JOIN titles
ON (employees.emp_no= titles.emp_no)
WHERE (dept_emp.to_date = '9999-01-01') AND (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

Select * FROM mentorship_eligibility;