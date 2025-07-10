CREATE TABLE "users" (
  "id" integer PRIMARY KEY,
  "username" varchar,
  "role" varchar,
  "created_at" timestamp
);

CREATE TABLE "roles" (
  "id" varchar PRIMARY KEY,
  "can_order" bool
);

CREATE TABLE "addresses" (
  "id" integer PRIMARY KEY,
  "user_id" integer,
  "street" varchar,
  "city" varchar,
  "country" varchar,
  "postal_code" varchar
);

CREATE TABLE "books" (
  "id" integer PRIMARY KEY,
  "title" varchar,
  "publish_year" varchar,
  "exemplar" varchar
);

CREATE TABLE "authors" (
  "id" integer PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "book_authors" (
  "book_id" integer,
  "author_id" integer,
  PRIMARY KEY ("book_id", "author_id")
);


CREATE TABLE "exemplars" (
  "exemplar" varchar PRIMARY KEY,
  "author_id" integer
);

CREATE TABLE "orders" (
  "id" integer PRIMARY KEY,
  "user_id" integer,
  "address_id" integer
);

CREATE TABLE "order_items" (
  "id" integer PRIMARY KEY,
  "order_id" integer,
  "user_id" integer,
  "book_id" integer
);

ALTER TABLE "users" ADD FOREIGN KEY ("role") REFERENCES "roles" ("id");

ALTER TABLE "addresses" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "book_authors" ADD FOREIGN KEY ("book_id") REFERENCES "books" ("id");

ALTER TABLE "book_authors" ADD FOREIGN KEY ("author_id") REFERENCES "authors" ("id");

ALTER TABLE "books" ADD FOREIGN KEY ("exemplar") REFERENCES "exemplars" ("exemplar");

ALTER TABLE "exemplars" ADD FOREIGN KEY ("author_id") REFERENCES "authors" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("id") REFERENCES "orders" ("user_id");

ALTER TABLE "addresses" ADD FOREIGN KEY ("id") REFERENCES "orders" ("address_id");

ALTER TABLE "order_items" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("id");

ALTER TABLE "order_items" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "books" ADD FOREIGN KEY ("id") REFERENCES "order_items" ("book_id");

INSERT INTO roles (id, can_order) VALUES
('admin', FALSE),
('customer', TRUE);

INSERT INTO users (id, username, role, created_at) VALUES
(1, 'admin1', 'admin', '2024-08-05 12:00:00'),
(2, 'admin2', 'admin', '2024-08-05 12:00:00'),
(3, 'John', 'customer', '2024-08-05 12:00:00'),
(4, 'Jane', 'customer', '2024-08-05 12:00:00');

INSERT INTO addresses (id, user_id, street, city, country, postal_code) VALUES
(1, 3, 'Piac Utca 69', 'Debrecen', 'HU', '4024'),
(2, 4, 'Karoly Mihaly utca 6', 'Budapest', 'HU', '1033')

INSERT INTO orders (id, user_id, address_id) VALUES
(1, 3, 1),
(2, 4, 2);

INSERT INTO order_items (id, order_id, user_id, book_id) VALUES
(1, 1, 3, 1),
(2, 2, 4, 2);

INSERT INTO authors (id, name) VALUES
(1, 'James Patterson'),
(2, 'John Vinci'),
(3, 'Adam Sadler'),
(4, 'Thomas Baker');

INSERT INTO exemplars (exemplar, author_id) VALUES
('Exemplar1', 1),
('Exemplar2', 2),
('Exemplar3', 3),
('Exemplar4', 4);

-- Scenario 1: A book with one author and no exemplars
INSERT INTO books (id, title, publish_year, exemplar) VALUES
(1, 'Book of Life', '2024', NULL);

--Book is owned by James Patterson
INSERT INTO book_authors (book_id, author_id) VALUES
(1, 1);

-- Scenario 2: A book with more than one author and no exemplars
INSERT INTO books (id, title, publish_year, exemplar) VALUES
(2, 'Book of Death', '2023', NULL);

--book is owned by James Patterson and John Vinci
INSERT INTO book_authors (book_id, author_id) VALUES
(2, 1),
(2, 2);

-- Scenario 3: A book with one author and one exemplar
INSERT INTO books (id, title, publish_year, exemplar) VALUES
(3, 'Book of Regret', '2022', 'Exemplar1');

--book has one exemplar and is written by James Patterson
INSERT INTO book_authors (book_id, author_id) VALUES
(3, 1);

-- Scenario 4: A book with more than one author and one exemplar
INSERT INTO books (id, title, publish_year, exemplar) VALUES
(4, 'Book of Interest', '2021', 'Exemplar2');

--book is written by Adam Sadler and Thomas Baker and has one exemplar
INSERT INTO book_authors (book_id, author_id) VALUES
(4, 3),
(4, 4);

-- Scenario 5: A book with one author and more than one exemplar
INSERT INTO books (id, title, publish_year, exemplar) VALUES
(5, 'Book of Science', '2020', 'Exemplar3');

--book is owned by Adam Sadler and has one exemplar
INSERT INTO book_authors (book_id, author_id) VALUES
(5, 3);

-- Scenario 6: A book with two exemplars, one written by one author 
INSERT INTO books (id, title, publish_year, exemplar) VALUES
(6, 'Book of Programming', '2019', 'Exemplar4');

--book is written by Thomas Baker and has one exemplar
INSERT INTO book_authors (book_id, author_id) VALUES
(6, 4);

-- Scenario 7: Book in scenario 6 by many authors in a different publish year
INSERT INTO books (id, title, publish_year, exemplar) VALUES
(7, 'Book of Programming', '2020', 'Exemplar4');

--this version is written by many authors in a different publish year with a different exemplar
INSERT INTO book_authors (book_id, author_id) VALUES
(7, 1),
(7, 2),
(7, 3);

--some example commands

--list all books
SELECT * from books;

--list books with title and publish year
SELECT title, publish_year FROM books;

--list books with the year later than 2020
SELECT * FROM books WHERE publish_year > '2020';

--list books with the title containing programming
SELECT * FROM books WHERE title LIKE '%Programming%';

--list books with specific titles
SELECT * FROM books WHERE title IN ('Book of Life', 'Book of Science');

--list books that were published in years between 2019 and 2022
SELECT * FROM books WHERE publish_year BETWEEN '2019' AND '2022';

--list books with no exemplars
SELECT * FROM books WHERE exemplar IS NULL;

--list books where the title is not programming
SELECT * FROM books WHERE title NOT LIKE '%Programming%';

--list books where the title has the word regret and the publish year is 2022
SELECT * FROM books WHERE publish_year = '2022' AND title LIKE '%Regret%';

--list books written by a specific author
SELECT * FROM books WHERE id IN (SELECT book_id FROM book_authors WHERE author_id = 1);

--list the latest years book
SELECT * FROM books WHERE publish_year = (SELECT MAX(publish_year) FROM books);

--list books with the years in a descending manner
SELECT * FROM books ORDER BY publish_year DESC;

--using a union to get books in 2022 and the second condition is to look for where the title has the word programming
SELECT title FROM books WHERE publish_year = '2022'
UNION
SELECT title FROM books WHERE title LIKE '%Programming%';

--using an inner join list books with titles and matching authors for those specific books
SELECT b.title, a.name
FROM books b
INNER JOIN book_authors ba ON b.id = ba.book_id
INNER JOIN authors a ON ba.author_id = a.id;

--using an inner join and condition list books with title and respective authors for books written past 2020
SELECT b.title, a.name
FROM books b
INNER JOIN book_authors ba ON b.id = ba.book_id
INNER JOIN authors a ON ba.author_id = a.id
WHERE b.publish_year > '2020';

--using a left join, list books with their respective authors
SELECT b.title, a.name
FROM books b
LEFT JOIN book_authors ba ON b.id = ba.book_id
LEFT JOIN authors a ON ba.author_id = a.id;

--using a right join, list books with their respective authors
SELECT b.title, a.name
FROM authors a
RIGHT JOIN book_authors ba ON a.id = ba.author_id
RIGHT JOIN books b ON ba.book_id = b.id;

--using numeric functions list the length of a books title
SELECT id, title, publish_year, LENGTH(title) AS title_length
FROM books;

--using string functions, make the title appear as uppercase or lower case
SELECT id, UPPER(title) AS uppercase_title, LOWER(title) AS lowercase_title
FROM books;

--using an aggregate function count the number of books with the same publish year and the count should be greater than 1
SELECT publish_year, COUNT(*) AS book_count
FROM books
GROUP BY publish_year
HAVING COUNT(*) > 1;

--using an aggregate function count the average length of how many id's are in the books table
SELECT AVG(id) AS average_id FROM books;

--using an aggregate function, get the latest publish year of all the books we have
SELECT MAX(publish_year) AS latest_year FROM books;
