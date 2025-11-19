-- 1. Hämta alla böcker sorterade efter titel
-- 2. Hämta alla medlemmar som blev medlemmar under 2024
-- 3. Hämta alla böcker i kategorin "Fiction"
-- 4. Hämta alla aktiva lån (inte återlämnade)
-- 5. Hämta böcker med ISBN

SELECT * FROM books ORDER BY title;

SELECT *
FROM members
WHERE membership_date BETWEEN '2024-01-01' AND '2024-12-31';

SELECT * FROM books WHERE category = 'Fiction';
SELECT * FROM loans WHERE return_date IS NULL;
SELECT * FROM books WHERE isbn IS NOT NULL;

-- JOIN-queries (5 st):
-- 6. Visa alla lån med bokens titel och medlemmens namn
-- 7. Visa alla böcker en specifik medlem har lånat
-- 8. Visa alla medlemmar som har lånat böcker av en specifik författare
-- 9. Visa böcker som aldrig har lånats
-- 10. Visa medlemmar som inte har några aktiva lån

SELECT 
    m.first_name, 
    m.last_name, 
    b.title
FROM loans l 
JOIN members m ON l.member_id = m.id
JOIN books b ON l.book_id = b.id;

SELECT 
    m.first_name, 
    m.last_name, 
    b.title
FROM loans l 
JOIN members m ON l.member_id = m.id
JOIN books b ON l.book_id = b.id
WHERE m.id = 1;

SELECT 
    m.first_name, 
    m.last_name, 
    b.title,
    b.id
FROM loans l 
JOIN members m ON l.member_id = m.id
JOIN books b ON l.book_id = b.id
WHERE b.author = 'J.R.R. Tolkien';

SELECT * FROM books b
LEFT JOIN loans l ON b.id = l.book_id
WHERE l.book_id IS NULL;

SELECT * FROM members m
LEFT JOIN loans l ON m.id = l.member_id
WHERE l.member_id IS NULL;


-- Aggregering och analys (5 st):
-- 11. Räkna antal böcker per kategori
-- 12. Hitta de 5 mest populära böckerna (mest lånade)
-- 13. Visa medlemmar med flest antal lån
-- 14. Beräkna genomsnittligt antal dagar mellan lånedatum och återlämning
-- 15. Visa hur många böcker som är försenade (due_date passerat men inte återlämnade)

SELECT 
    category, 
    COUNT(*) AS antal_bocker
FROM 
    Books
GROUP BY category
ORDER BY antal_bocker DESC;

SELECT 
    b.title, 
    COUNT(l.id) AS antal_lan
FROM Loans l
JOIN Books b ON l.book_id = b.id
GROUP BY b.title
ORDER BY antal_lan DESC
LIMIT 5;

SELECT 
    m.name, 
    m.lats_name, 
    COUNT(l.id) AS antal_lan
FROM Loans l
JOIN Members m ON l.member_id = m.id
GROUP BY m.id
ORDER BY antal_lan DESC;

SELECT
    AVG(return_date - loan_date) AS genomsnittliga_lanedagar
FROM Loans
WHERE return_date IS NOT NULL;

SELECT
    COUNT(*) AS antal_forseenade
FROM Loans
WHERE return_date is NULL
    AND due_date < CURRENT_DATE;