-- vsechny druhy pocet zvirat
SELECT D.nazev, COUNT(Z.id)
FROM Druhy AS D LEFT JOIN Zvirata AS Z ON (D.id = Z.druh)
GROUP BY D.id;

-- Lenosi, osetrovatele kteri nikoho neosetruji
SELECT Ote.jmeno 
FROM Osetrovatele AS Ote LEFT JOIN Osetruje AS Oje ON (Ote.id = Oje.osetrovatel)
GROUP BY Ote.id
HAVING COUNT(Oje.id) = 0;