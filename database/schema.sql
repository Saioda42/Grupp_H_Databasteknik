DROP TABLE IF EXISTS books CASCADE;
DROP TABLE IF EXISTS members CASCADE;
DROP TABLE IF EXISTS loans CASCADE;

CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    publication_year INTEGER,
    category VARCHAR(100),
    total_copies INTEGER DEFAULT 1 CHECK (total_copies >= 0),
    available_copies INTEGER DEFAULT 1 CHECK (available_copies >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE members (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    membership_date DATE DEFAULT CURRENT_DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE loans (
    id SERIAL PRIMARY KEY,
    book_id INTEGER NOT NULL REFERENCES books(id) ON DELETE CASCADE,
    member_id INTEGER NOT NULL REFERENCES members(id) ON DELETE CASCADE,
    loan_date DATE DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL CHECK (due_date > loan_date),
    return_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_loans_book_id ON loans (book_id);
CREATE INDEX idx_loans_member_id ON loans (member_id);
CREATE INDEX idx_books_category ON books (category);
CREATE INDEX idx_books_title ON books (title);
CREATE INDEX idx_members_membership_date ON members (membership_date);