-- a) Vypište všechny Josefy, kteří neošetřují koně ani psa
SELECT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
         LEFT JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
         LEFT JOIN Zvirata Z ON Oje.zvire = Z.id
         LEFT JOIN Druhy D ON Z.druh = D.id AND (D.nazev LIKE 'kun' OR D.nazev LIKE 'pes')
WHERE Ote.jmeno LIKE 'Josef %'
GROUP BY Ote.id
HAVING COUNT(D.id) = 0;

-- b) Vypište všechny druhy, které nemá rád žádný Josef
SELECT D.id, D.nazev
FROM Druhy D
WHERE D.id NOT IN (SELECT DISTINCT D.id
                   FROM Druhy AS D
                            JOIN Ma_rad M ON M.druh = D.id
                            JOIN Osetrovatele Ote ON Ote.id = M.osetrovatel
                   WHERE Ote.jmeno LIKE 'Josef %');

-- *c) Vypište všechny ošetřovatelé, kteří ošetřují všechny slepice
SELECT OteSlepic.id, OteSlepic.jmeno
FROM (SELECT Ote.id AS id, Ote.jmeno AS jmeno, COUNT(Z.id) AS pocet
      FROM Osetrovatele Ote
               JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
               JOIN Zvirata Z ON Z.id = Oje.zvire
               JOIN Druhy D ON D.id = Z.druh
      WHERE D.nazev LIKE 'slepice'
      GROUP BY Ote.id) OteSlepic
WHERE OteSlepic.pocet = (SELECT COUNT(Z.id)
                         FROM Zvirata Z
                                  JOIN Druhy D ON D.id = Z.druh
                         WHERE D.nazev LIKE 'slepice');