# SQL Joins

## Notes before we start:

#### Dash
There's an OSX desktop app called Dash which is great for keeping an offline copy of documentation you know you might use.  It is different from GA's Dash.

Unless you buy it, it will occasionally make you wait 10 seconds.

[http://kapeli.com](http://kapeli.com)

## Agenda
1. Relationships and Joins
1. A Library Schema
1. INNER JOIN
1. LEFT, RIGHT, and FULL OUTER JOIN
1. GROUP BY

## Relationships and Joins
In your first SQL lesson you learned how to CREATE TABLE and DROP TABLE, and how to do the four basic SQL operations: SELECT, INSERT, UPDATE, and DELETE.  With these features, we have what is essentially a spreadsheet, a spreadsheet which enforces constraints on the type of data in each column via the schema.  It's as if Excel could handle a million rows, but had no way of expressing the relationship between the items in one spreadsheet and another.

Postgres and other SQL databases are __relational__.  They are designed for storing and viewing data that is interrelated.  To do this, one table has a __foreign key__ to another table.  If rows are related, one column in each row will have the same value.  Usually, a column in one row will contain the primary key of another row.

Here's an example we'll come:

```
CREATE DATABASE employees_example;
\c employees_example

CREATE TABLE employees (
	id SERIAL PRIMARY KEY,
	name varchar(300) NOT NULL,
	manager_id integer
);
```

This gives us a table of employees, and each employee must have a name, and can have a manager (also an employee).

Let's talk about a library catalog system which contains the catalogs of a whole system of libraries.  In general, if you would do something in Ruby by having an array, make a new table for it in SQL.

## A Library Schema

In our system there are many libraries, so we will have a library table.  There are also many books, so we will have a books table.  Each book can have many copies in the system, so we will have a table which represents a copy of a book.  The libraries have many users, who can have a book checked out, and employees who work at a particular library.  Let's start by working out the library, books, and book-copy tables.

```
CREATE DATABASE all_libraries;
\c all_libraries

CREATE TABLE libraries (
	id SERIAL PRIMARY KEY,
	name varchar(255),
	address text
);

CREATE TABLE books (
	id SERIAL PRIMARY KEY,
	isbn varchar(13) UNIQUE,
	title varchar(255),
	author text
);

CREATE TABLE book_copies (
	id SERIAL PRIMARY KEY,
	book_id integer,
	library_id integer
);
```

## INNER JOIN

Now that we have our library, if we have a book in the books table, how can we get a list of all the copies of it that exist?  How can we see what libraries those copies are in?  We use joins.  We'll start with the INNER JOIN.

In the abstract, all joins between tables A and B begin by taking the full set of rows in table A and the full set of rows in table B and imagining that we have a table C which is the cartesian product of the rows of A and the rows of B.  That is, for each row a=(value_from_a, value_from_a, ...) in A and each row in row b=(value_from_b, value_from_b, ...), there's a row in the cartesian product (value_from_a, value_from_a, ..., value_from_b, value_from_b).  Then this table is filtered by the join condition.

To join, we add a JOIN like INNER JOIN to the FROM clause of our SQL SELECT statement.  We say which table we are joining, then ON, then the condition on which we are joining.

```
SELECT * FROM books
	INNER JOIN libraries
	  ON true;
```

This gives us the unfiltered join table.  There is a row for every possible combination of a book and a library.  How do we just match the book with the book_copy that corresponds to it?

```
SELECT * FROM books AS b
  INNER JOIN book_copies AS bc
   ON bc.book_id=b.id;
```

Now for each book, we want a list of the libraries it is in. 

```
SELECT b.name, l.name FROM books AS b
  INNER JOIN book_copies AS bc
   ON bc.book_id=b.id 
  INNER JOIN libraries AS l
   ON bc.library_id=l.id
  WHERE books.id=1;
```

You can join on anything.  We can select rows `FROM books INNER JOIN libraries` where the id of the book is equal to the id of the library, although that would be meaningless.

Remember our employees table?  Employees have a manager_id, but there is no managers table.  Managers are also employees, so to get employees with their managers, we can join the employees table to itself:

```
SELECT e_left.name, e_right.name FROM employees AS e_left
  INNER JOIN employees AS e_right
    ON e_left.manager_id=e_right.id;
```

As you can see, this does not give rows for employees that do not have managers.  Let's talk about how to get the employees that don't have managers, or books that don't have any copies in the library when we do our join.

## LEFT, RIGHT, and FULL OUTER JOIN
For an OUTER JOIN, we go through the same process as an INNER JOIN.  There is a filtered cartesian product of tables A and B.  Then, for a LEFT OUTER JOIN, any rows in A that don't correspond to any row in B are added to the result, with the columns from B filled with NULLs.  For the employees-employees join, this gives a row for each employee that doesn't have a manager, with the employee's details on the left and an empty space for the manager on the right.

```
SELECT e_left.name, e_right.name FROM employees AS e_left
  LEFT OUTER JOIN employees AS e_right
    ON e_left.manager_id=e_right.id;
```

Here is how to get all the books including books which have no copies:
```
SELECT b.name, l.name FROM books AS b
  LEFT OUTER JOIN book_copies AS bc
   ON bc.book_id=b.id 
  LEFT OUTER JOIN libraries AS l
   ON bc.library_id=l.id;
```

A RIGHT OUTER JOIN is almost the same as a LEFT OUTER JOIN.  Any rows in B which don't correspond to any row in A are added to the result, with the columns from B filled with NULLs.  The query below will give the employee-manager list with another row for each employee who does not manage any employees.

```
SELECT e_left.name, e_right.name FROM employees AS e_left
  RIGHT OUTER JOIN employees AS e_right
    ON e_left.manager_id=e_right.id;
```

A FULL OUTER JOIN gives both sides.  A row is added for each unmatched row in A and for each unmatched row in B.

```
SELECT e_left.name, e_right.name FROM employees AS e_left
  FULL OUTER JOIN employees AS e_right
    ON e_left.manager_id=e_right.id;
```

## GROUP BY
Suppose for each employee, we want the number of employees they manage, or for each library, we want the number of distinct books they stock.  We need to use GROUP BY.

```
SELECT COUNT(e.id) AS reports_count, m.id, m.name 
  FROM employees AS e 
  INNER JOIN employees AS m 
    ON e.manager_id=m.id 
  GROUP BY e.manager_id, m.id, m.name;
```

This builds the join table from employees to employees, then aggregates the rows which have the same e.manager_id, m.id, and m.name.  Then it selects the number of rows aggregated and the id and name of the manager. 

