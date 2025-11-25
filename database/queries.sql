-- 1. Hämta alla böcker sorterade efter titel
SELECT * FROM books ORDER BY title;

-- 2. Hämta alla medlemmar som blev medlemmar under 2024
SELECT *
FROM members
WHERE membership_date BETWEEN '2024-01-01' AND '2024-12-31';

-- 3. Hämta alla böcker i kategorin "Fiction"
SELECT * FROM books WHERE category = 'Fiction';

-- 4. Hämta alla aktiva lån (inte återlämnade)
SELECT * FROM loans WHERE return_date IS NULL;

-- 5. Hämta böcker med ISBN
SELECT * FROM books WHERE isbn IS NOT NULL;

-- JOIN-queries (5 st):
-- 6. Visa alla lån med bokens titel och medlemmens namn
SELECT 
    m.first_name, 
    m.last_name, 
    b.title
FROM loans l 
JOIN members m ON l.member_id = m.id
JOIN books b ON l.book_id = b.id;

-- 7. Visa alla böcker en specifik medlem har lånat
SELECT 
    m.first_name, 
    m.last_name, 
    b.title
FROM loans l 
JOIN members m ON l.member_id = m.id
JOIN books b ON l.book_id = b.id
WHERE m.id = 1;

-- 8. Visa alla medlemmar som har lånat böcker av en specifik författare
SELECT 
    m.first_name, 
    m.last_name, 
    b.title,
    b.id
FROM loans l 
JOIN members m ON l.member_id = m.id
JOIN books b ON l.book_id = b.id
WHERE b.author = 'J.R.R. Tolkien';

-- 9. Visa böcker som aldrig har lånats
SELECT * FROM books b
LEFT JOIN loans l ON b.id = l.book_id
WHERE l.book_id IS NULL;

-- 10. Visa medlemmar som inte har några aktiva lån
SELECT * FROM members m
LEFT JOIN loans l 
    ON m.id = l.member_id
    AND l.return_date IS NULL
WHERE l.id IS NULL;

-- Aggregering och analys (5 st):
-- 11. Räkna antal böcker per kategori
SELECT 
    category, 
    COUNT(*) AS antal_bocker
FROM 
    books
GROUP BY category
ORDER BY antal_bocker DESC;

-- 12. Hitta de 5 mest populära böckerna (mest lånade)
SELECT 
    b.title, 
    COUNT(l.id) AS antal_lan
FROM loans l
JOIN books b ON l.book_id = b.id
GROUP BY b.title
ORDER BY antal_lan DESC
LIMIT 5;

-- 13. Visa medlemmar med flest antal lån
SELECT 
    m.first_name, 
    m.last_name, 
    COUNT(l.id) AS antal_lan
FROM loans l
JOIN members m ON l.member_id = m.id
GROUP BY m.id, m.first_name, m.last_name
HAVING COUNT(l.id) >= 2
ORDER BY antal_lan DESC;

-- 14. Beräkna genomsnittligt antal dagar mellan lånedatum och återlämning
SELECT
    AVG(return_date - loan_date) AS genomsnittliga_lanedagar
FROM loans
WHERE return_date IS NOT NULL;

-- 15. Visa hur många böcker som är försenade (due_date passerat men inte återlämnade)
SELECT
    COUNT(*) AS antal_forseenade
FROM loans
WHERE return_date is NULL
    AND due_date < CURRENT_DATE;