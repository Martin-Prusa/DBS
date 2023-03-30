-- 1. Všechny vrabce, kteří nejsou oštřováni žádným Janem
SELECT Z.id, Z.jmeno
FROM Zvirata Z JOIN Druhy D ON D.id = Z.druh
WHERE D.nazev LIKE 'vrabec' AND Z.id NOT IN (
    SELECT Oje.zvire
    FROM Osetrovatele Ote JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
    WHERE Ote.jmeno LIKE 'Jan %'
    );

-- 2. Všechny ošetřovatele, kteří ošetřují pouze tlustá zvířata (nad 100kg)
SELECT Ote.id
FROM Osetrovatele Ote JOIN Osetruje Oje ON Ote.id = Oje.osetrovatel
                        LEFT JOIN Zvirata Z ON Z.id = Oje.zvire AND Z.vaha < 100
GROUP BY Ote.id
HAVING COUNT(Z.id) = 0;