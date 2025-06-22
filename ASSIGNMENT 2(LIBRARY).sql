DROP database LIBRARY;
CREATE database LIBRARY;
use LIBRARY;

DROP TABLE IF EXISTS librarian;
CREATE TABLE librarian (
  l_id INT AUTO_INCREMENT PRIMARY KEY,
  l_name VARCHAR(20),
  experience VARCHAR(20)
);
DESC librarian;

INSERT INTO librarian (l_id,l_name, experience) 
VALUES
(20,'Prashant', '5 years'),
(21,'china', '3 years'),
(22,'satyam', '7 years'),
(23,'palak', '2 years'),
(24,'vicky', '10 years');

SELECT * FROM librarian;

#Creating and populating books table
DROP TABLE IF EXISTS books;
CREATE TABLE books (
  book_id INT AUTO_INCREMENT PRIMARY KEY,
  book_name VARCHAR(50),
  author VARCHAR(20),
  category VARCHAR(20),
  quantity INT,
  l_id INT,
  FOREIGN KEY (l_id) REFERENCES librarian(l_id)
);
DESC books;

INSERT INTO books (book_id,book_name, author, category, quantity, l_id) 
VALUES
(1,'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 5, 20),
(2,'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 3, 21),
(3,'1984', 'George Orwell', 'Dystopian', 4, 22),
(4,'The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 6, 23),
(5,'Moby Dick', 'Herman Melville', 'Classic', 2, 24);
/*('War and Peace', 'Leo Tolstoy', 'Historical', 1, 25),
('Pride and Prejudice', 'Jane Austen', 'Romance', 3, 2),
('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 4, 3),
('The Alchemist', 'Paulo Coelho', 'Adventure', 5, 4),
('Brave New World', 'Aldous Huxley', 'Dystopian', 2, 5);*/

SELECT * FROM books;

#Adding cost column to books table
ALTER TABLE books ADD COLUMN cost DECIMAL(6,2);

# Updating cost values in books table
UPDATE books SET cost = 15.99 WHERE book_id = 1;
UPDATE books SET cost = 20.50 WHERE book_id = 2;
UPDATE books SET cost = 25.75 WHERE book_id = 3;
UPDATE books SET cost = 30.00 WHERE book_id = 4;
UPDATE books SET cost = 35.25 WHERE book_id = 5;
/*UPDATE books SET cost = 40.75 WHERE book_id = 6;
UPDATE books SET cost = 45.00 WHERE book_id = 7;
UPDATE books SET cost = 50.50 WHERE book_id = 8;
UPDATE books SET cost = 55.99 WHERE book_id = 9;
UPDATE books SET cost = 60.00 WHERE book_id = 10;*/

# Creating and populating person table
DROP TABLE IF EXISTS person;
CREATE TABLE person (
  p_id INT AUTO_INCREMENT PRIMARY KEY,
  p_name VARCHAR(20),
  gender CHAR(1),
  phone_no VARCHAR(10),
  book_interest VARCHAR(20),
  membership_type VARCHAR(20)
);
DESC person;

INSERT INTO person (p_id,p_name, gender, phone_no, book_interest, membership_type) 
VALUES
(50,'san', 'M', '1234567890', 'Fiction', 'Annual'),
(51,'mina', 'F', '0987654321', 'Non-Fiction', 'Monthly'),
(52,'sana', 'F', '2345678901', 'Science', 'Annual'),
(53,'mingi', 'M', '3456789012', 'Mystery', 'Lifetime'),
(54,'momo', 'F', '4567890123', 'Fantasy', 'Monthly');


SELECT * FROM person;

# Creating and populating person_books table
DROP TABLE IF EXISTS person_books;
CREATE TABLE person_books (
  p_id INT,
  book_id INT,
  issue_date DATE,
  return_date DATE,
  FOREIGN KEY (p_id) REFERENCES person(p_id),
  FOREIGN KEY (book_id) REFERENCES books(book_id)
);
DESC person_books;

INSERT INTO person_books (p_id, book_id, issue_date, return_date) 
VALUES
(50, 1, '2023-09-01', '2023-09-15'),
(51, 2, '2023-09-02', '2023-09-16'),
(52, 3, '2023-09-03', '2023-09-17'),
(53, 4, '2023-09-04', '2023-09-18'),
(54, 5, '2023-09-05', '2023-09-19');


SELECT * FROM person_books;

# Q1: Finding student names who issued the book with the lowest quantity
SELECT DISTINCT person.p_name AS Student_Name, books.book_name AS Book_Name
FROM person 
JOIN person_books ON person.p_id = person_books.p_id
JOIN books ON person_books.book_id = books.book_id
WHERE books.quantity = (SELECT MIN(quantity) FROM books);


# Q2: Calculating the average cost of books
SELECT AVG(cost) AS Average_Cost
FROM books;


# Q3: Counting the number of students with monthly membership who issued books
SELECT COUNT(DISTINCT person_books.p_id) AS total_students
FROM person_books 
JOIN person ON person_books.p_id = person.p_id
WHERE person.membership_type = 'Monthly';


# Q4. Which is the book issued maximum times by students.
SELECT b.book_name, COUNT(pb.book_id) AS issue_count
FROM person_books pb
JOIN books b ON pb.book_id = b.book_id
GROUP BY pb.book_id
ORDER BY issue_count DESC
LIMIT 1;


# Q5. List the names of all books along with the name of the librarian responsible.
SELECT b.book_name, l.l_name AS librarian
FROM books b
JOIN librarian l ON b.l_id = l.l_id;


# Q6. Find members who have not issued any books.
SELECT p.p_name
FROM person p
LEFT JOIN person_books pb ON p.p_id = pb.p_id
WHERE pb.p_id IS NULL;

# Q7. Count how many books fall under each category.
SELECT category, COUNT(*) AS total_books
FROM books
GROUP BY category;


# Q8. Display book interest and the number of members interested in each.
SELECT book_interest, COUNT(*) AS total_members
FROM person
GROUP BY book_interest;


# Q9. Show total cost of books issued by each person.
SELECT p.p_name, SUM(b.cost) AS total_cost
FROM person p
JOIN person_books pb ON p.p_id = pb.p_id
JOIN books b ON pb.book_id = b.book_id
GROUP BY p.p_name;


# Q10. List all overdue books (assuming today is '2023-09-20')
SELECT p.p_name, b.book_name, pb.return_date
FROM person p
JOIN person_books pb ON p.p_id = pb.p_id
JOIN books b ON pb.book_id = b.book_id
WHERE pb.return_date < '2023-09-20';


# Q11. Find the librarian who manages the most books.
SELECT l.l_name, COUNT(b.book_id) AS book_count
FROM librarian l
JOIN books b ON l.l_id = b.l_id
GROUP BY l.l_id
ORDER BY book_count DESC
LIMIT 1;


# Q12. Calculate the total quantity and value (cost × quantity) of books per category.
SELECT category, 
       SUM(quantity) AS total_quantity,
       SUM(quantity * cost) AS total_value
FROM books
GROUP BY category;


# Q13. List all books not yet issued to anyone.
SELECT b.book_name
FROM books b
LEFT JOIN person_books pb ON b.book_id = pb.book_id
WHERE pb.book_id IS NULL;

