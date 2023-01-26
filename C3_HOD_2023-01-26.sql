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