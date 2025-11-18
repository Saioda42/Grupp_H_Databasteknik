INSERT INTO Books (title, author, isbn, published_year, category, totoral_copies, available_copies)
VALUES
('The Pragmatic Programmer', 'Andrew Hunt & David Thomas', '9780201616224', 1999, 'Software Development', 5, 3),
('Clean Code', 'Robert C. Martin', '9780132350884', 2008, 'Software Engineering', 7, 7),
('Gödel, Escher, Bach', 'Douglas Hofstadter', '9780465026562', 1979, 'Science / Philosophy', 3, 2),
('Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', '9780062316097', 2011, 'History', 6, 4),
('Thinking, Fast and Slow', 'Daniel Kahneman', '9780374533557', 2011, 'Psychology', 4, 1),
('The Hobbit', 'J.R.R. Tolkien', '9780547928227', 1937, 'Fantasy', 10, 8),
('1984', 'George Orwell', '9780451524935', 1949, 'Dystopian', 8, 5),
('To Kill a Mockingbird', 'Harper Lee', '9780061120084', 1960, 'Classic Literature', 5, 2),
('The Catcher in the Rye', 'J.D. Salinger', '9780316769488', 1951, 'Classic Literature', 4, 4),
('Brave New World', 'Aldous Huxley', '9780060850524', 1932, 'Dystopian', 6, 3),
('Crime and Punishment', 'Fyodor Dostoevsky', '9780140449136', 1866, 'Classic Literature', 5, 5),
('Moby-Dick', 'Herman Melville', '9781503280786', 1851, 'Adventure', 4, 3),
('A Game of Thrones', 'George R.R. Martin', '9780553573404', 1996, 'Fantasy', 12, 6),
('The Name of the Wind', 'Patrick Rothfuss', '9780756404741', 2007, 'Fantasy', 7, 5),
('The Alchemist', 'Paulo Coelho', '9780062315007', 1988, 'Fiction', 9, 9);


INSERT INTO Members (name, lats_name, email, phone, membership_date)
VALUES
('Anna', 'Johansson', 'anna.johansson@example.com', '0701234567', '2024-02-10'),
('Erik', 'Svensson', 'erik.svensson@example.com', '0709876543', '2023-11-22'),
('Maria', 'Nilsson', 'maria.nilsson@example.com', '0725566789', '2024-01-15'),
('Jonas', 'Larsson', 'jonas.larsson@example.com', '0763344556', '2023-12-05'),
('Sara', 'Andersson', 'sara.andersson@example.com', '0738899001', '2024-03-01'),
('Oskar', 'Lindberg', 'oskar.lindberg@example.com', '0706655443', '2023-10-18'),
('Lina', 'Bergström', 'lina.bergstrom@example.com', '0727788990', '2024-02-28'),
('Daniel', 'Holm', 'daniel.holm@example.com', '0761122334', '2023-09-30'),
('Elin', 'Ekström', 'elin.ekstrom@example.com', '0704433221', '2024-01-05'),
('Victor', 'Lundgren', 'victor.lundgren@example.com', '0735544332', '2023-12-20');


INSERT INTO Loans (book_id, member_id, loan_date, due_date, return_date)
VALUES
(1, 3, '2024-01-05', '2024-01-19', '2024-01-18'),
(2, 1, '2024-01-10', '2024-01-24', '2024-01-23'),
(3, 5, '2024-02-01', '2024-02-15', '2024-02-14'),
(4, 7, '2024-02-12', '2024-02-26', '2024-02-25'),
(5, 2, '2024-03-03', '2024-03-17', '2024-03-16'),
(6, 6, '2024-03-10', '2024-03-24', '2024-03-22'),
(7, 4, '2024-03-15', '2024-03-29', '2024-03-28'),
(8, 9, '2024-04-01', '2024-04-15', '2024-04-14'),
(9, 8, '2024-04-08', '2024-04-22', '2024-04-21'),
(10, 10, '2024-04-20', '2024-05-04', '2024-05-02'),

(11, 3, '2024-10-01', '2024-10-15', NULL),
(12, 1, '2024-10-05', '2024-10-19', NULL),
(13, 6, '2024-10-10', '2024-10-24', NULL),
(14, 2, '2024-10-12', '2024-10-26', NULL),
(15, 4, '2024-10-15', '2024-10-29', NULL),
(3, 7, '2024-10-18', '2024-11-01', NULL),
(8, 5, '2024-10-20', '2024-11-03', NULL),
(12, 9, '2024-10-22', '2024-11-05', NULL),
(14, 8, '2024-10-25', '2024-11-08', NULL),
(6, 10, '2024-10-28', '2024-11-11', NULL);