# **Library Management System (SQL Project)**

## 1.Project Overview
This project demonstrate a Library Management System built using My SQL Workbench. It simulates the fundamental operations of a library: managing books, librarians, users (members), and tracking which members borrow which books.
The database handles:
- Book storage and librarian responsibility
- Membership details
- Issuance and return tracking of books
- Cost and quantity analytics

Image[https://github.com/vj220803/Library_SQL/blob/main/Library%20Management%20System%20(SQL%20Project).png]

---

## 2.Database Schema

The database `LIBRARY` contains four interrelated tables:

### 1. `librarian`

| Column     | Type        | Description         |
| ---------- | ----------- | ------------------- |
| l\_id      | INT (PK)    | Librarian ID        |
| l\_name    | VARCHAR(20) | Librarian Name      |
| experience | VARCHAR(20) | Years of Experience |

### 2. `books`

| Column     | Type         | Description                   |
| ---------- | ------------ | ----------------------------- |
| book\_id   | INT (PK)     | Book ID                       |
| book\_name | VARCHAR(50)  | Name of the book              |
| author     | VARCHAR(20)  | Author's name                 |
| category   | VARCHAR(20)  | Book category (Fiction, etc.) |
| quantity   | INT          | Number of copies              |
| cost       | DECIMAL(6,2) | Price per copy                |
| l\_id      | INT (FK)     | Managed by librarian (l\_id)  |

### 3. `person`

| Column           | Type                         | Description          |
| ---------------- | ---------------------------- | -------------------- |
| p\_id            | INT (PK)                     | Person ID            |
| p\_name          | VARCHAR(20)                  | Person's Name        |
| gender           | ENUM('M','F')                | Gender               |
| phone\_no        | VARCHAR(10)                  | Contact number       |
| book\_interest   | VARCHAR(20)                  | Preferred book genre |
| membership\_type | ENUM('Monthly','Annual',...) | Membership plan      |

### 4. `person_books`

| Column       | Type   | Description                |
| ------------ | ------ | -------------------------- |
| p\_id        | INT FK | Person who issued the book |
| book\_id     | INT FK | Book that was issued       |
| issue\_date  | DATE   | Date of issue              |
| return\_date | DATE   | Expected return date       |

---

## 3.Relationships

```
[librarian] 1 ─────< manages >───── M [books]
[person]    1 ─────< issues  >───── M [person_books] M ─────> 1 [books]
```
1. Librarian → Books
- One librarian manages many books
- So: 1 → N from LIBRARIAN to BOOKS

2. Books → Person_Books (Issue Records)
- One book can be issued many times
- So: 1 → N from BOOKS to PERSON_BOOKS

3. Person → Person_Books
- One person can issue many books
- So: 1 → N from PERSON to PERSON_BOOKS

---

## 4.Query List & Explanation

| No  | Query Description                                     |
| --- | ----------------------------------------------------- |
| Q1  | Students who issued book with lowest quantity         |
| Q2  | Average cost of books                                 |
| Q3  | Count of monthly members who issued books             |
| Q4  | Most issued book                                      |
| Q5  | List of books and the responsible librarian           |
| Q6  | Members who haven't issued any book                   |
| Q7  | Count of books by each category                       |
| Q8  | Count of members by book interest                     |
| Q9  | Total cost of books issued per person                 |
| Q10 | Overdue books based on current date                   |
| Q11 | Librarian who manages the most books                  |
| Q12 | Total quantity and value of books grouped by category |
| Q13 | Books that have never been issued                     |

---

## Author

**Vijayan Naidu**
M.Sc. Data Science @ Fergusson College
SQL Project

---
