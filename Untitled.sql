use zoo;

SELECT D.nazev
From Druhy AS D JOIN Zvirata AS Z ON Z.druh = D.id
GROUP BY Z.druh
HAVING D.nazev LIKE "jezek";
