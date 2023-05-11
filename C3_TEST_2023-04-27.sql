-- TEST 2023-04-27
-- 1. Všechny ošetřovatele, kteří ošetřují pouze pštrosy nebo tučňáky - X
SELECT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
         JOIN (SELECT Ote.id AS ote, COUNT(Oje.id) as pocet
               FROM Osetrovatele Ote
                        JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
               GROUP BY Ote.id) AS celkem ON celkem.ote = Ote.id
         JOIN (SELECT Ote.id AS ote, COUNT(Z.id) as pocet
               FROM Osetrovatele Ote
                        JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
                        JOIN Zvirata Z ON Z.id = Oje.zvire
                        JOIN Druhy D ON D.id = Z.druh
               WHERE D.nazev LIKE 'pstros'
                  OR D.nazev LIKE 'tucnak'
               GROUP BY Ote.id) AS vybranych ON Ote.id = vybranych.ote
WHERE vybranych.pocet = celkem.pocet;

-- 2. Toulavé kočky (takové kočky, které nikdo neošetřuje) -> 3 - X
SELECT Z.id, Z.jmeno
FROM Zvirata Z
         JOIN Druhy D ON Z.druh = D.id
WHERE D.nazev LIKE 'kocka'
  AND Z.id NOT IN (SELECT DISTINCT Z.id
                   FROM Zvirata Z
                            JOIN Druhy D ON Z.druh = D.id
                            JOIN Osetruje Oje ON Z.id = Oje.zvire
                   WHERE D.nazev LIKE 'kocka');

-- 3. Nejošetřovanější druh (průměrný počet ošetřovatelů zvířat daného druhu je nejvyšší) - X
SELECT D.nazev, pocty.druh, AVG(pocty.pocet) AS prumer
FROM Druhy D
JOIN (SELECT Z.druh AS druh, COUNT(Oje.id) AS pocet
      FROM Zvirata Z
               LEFT JOIN Osetruje Oje ON Oje.zvire = Z.id
      GROUP BY Z.id) AS pocty ON D.id = pocty.druh
GROUP BY pocty.druh
ORDER BY prumer DESC
LIMIT 1;

-- 4. Pránické druhy (takový druh, kde žádné zvíře daného druhu nikdo neošetřuje, ale nejméně 3 zvířata jsou težší než 100). - X
SELECT D.id, D.nazev
FROM Druhy D
         JOIN (SELECT Z.druh AS druh, COUNT(Z.id) AS pocet
               FROM Zvirata Z
               WHERE Z.vaha > 100
               GROUP BY Z.druh) AS pocty ON D.id = pocty.druh
WHERE pocty.pocet >= 3
  AND D.id NOT IN (SELECT DISTINCT Z.druh
                   FROM Zvirata Z
                            JOIN Osetruje Oje ON Z.id = Oje.zvire);

-- 5. Ošetřovatele-specialisty (ošetřovatele, kteří ošetřují alespoň 10 zvířat a všechna jím ošetřovaná zvířata jsou  nejvýše dvou různých druhů) - X
SELECT Ote.jmeno, pocetDruhu.ote
FROM Osetrovatele Ote
         JOIN (SELECT Ote.id AS ote, COUNT(DISTINCT Z.druh) AS pocet
               FROM Osetrovatele Ote
                        JOIN Osetruje Oje ON Ote.id = Oje.osetrovatel
                        JOIN Zvirata Z ON Z.id = Oje.zvire
               GROUP BY Ote.id) AS pocetDruhu ON Ote.id = pocetDruhu.ote
         JOIN (SELECT Ote.id AS ote, COUNT(Oje.id) AS pocet
               FROM Osetrovatele Ote
                        JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
               GROUP BY Ote.id) AS pocetZvirat ON pocetZvirat.ote = pocetDruhu.ote
WHERE pocetDruhu.pocet <= 2
  AND pocetZvirat.pocet >= 10;