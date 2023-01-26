-- Zvirata, ktre neosetruje Juhani
SELECT Z.jmeno
FROM Osetrovatele AS Ote JOIN Osetruje AS Oje ON Oje.osetrovatel = Ote.id AND Ote.jmeno LIKE "Juhani %"
RIGHT JOIN Zvirata AS Z ON Z.id = Oje.id
WHERE Oje.id IS NULL;

-- =

SELECT Z.jmeno
FROM Zvirata AS Z LEFT JOIN
(Osetrovatele AS Ote JOIN Osetruje AS Oje ON Oje.osetrovatel = Ote.id AND Ote.jmeno LIKE "Juhani %")
ON Z.id = Oje.id
WHERE Oje.id IS NULL;

-- Osetrovatele neosetrujici kone - 457

SELECT Ote.jmeno
FROM Osetrovatele AS Ote LEFT JOIN (Osetruje AS Oje 
						JOIN Zvirata AS Z ON Z.id = Oje.zvire
                        JOIN Druhy AS D ON Z.druh = D.id AND D.nazev LIKE "kun") ON Oje.osetrovatel = Ote.id
WHERE Oje.id IS NULL;