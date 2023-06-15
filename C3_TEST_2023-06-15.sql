-- 1. Všechny ošetřovatele, kteří ošetřují koně jen tehdy, kteří ošetřují-li současně krávu
-- 469
SELECT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
WHERE Ote.id IN (SELECT Ote.id
                 FROM Osetrovatele Ote
                          JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
                          JOIN Zvirata Z ON Oje.zvire = Z.id
                          JOIN Druhy D ON D.id = Z.druh
                 WHERE D.nazev LIKE 'kun'
                    OR D.nazev LIKE 'krava'
                 GROUP BY Ote.id
                 HAVING COUNT(DISTINCT D.id) = 2)
   OR Ote.id NOT IN (SELECT DISTINCT Oje.osetrovatel
                     FROM Osetruje Oje
                              JOIN Zvirata Z ON Oje.zvire = Z.id
                              JOIN Druhy D ON D.id = Z.druh
                     WHERE D.nazev LIKE 'kun');

-- 2. Všechny malochovatele: Ošetřovatele, kteří ošetřují pouze druhy, které mají méně než 5 zvířat
-- Komentář: Najdu si druhy, které mají více než 5 zvířat. Pak si najdu ošetřovatele, kteří tyto druhy ošetřují. Pak ošetřovatele, kteří nejsou z tohoto seznamu
-- nikdo, musím přidat
SELECT DISTINCT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
         JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
WHERE Ote.id NOT IN (SELECT Oje.osetrovatel
                     FROM Osetruje Oje
                              JOIN Zvirata Z ON Z.id = Oje.zvire
                     WHERE Z.druh IN (SELECT Z.druh
                                      FROM Zvirata Z
                                      GROUP BY Z.druh
                                      HAVING COUNT(Z.id) >= 5));

-- 3. Všechny zvířata z podprůměrně početných druhů
-- 704
SELECT Z.id, Z.jmeno
FROM Zvirata Z
WHERE Z.druh IN (SELECT Z.druh
                 FROM Zvirata Z
                 GROUP BY Z.druh
                 HAVING COUNT(Z.id) < (SELECT AVG(prumery.prumer)
                                       FROM (SELECT COUNT(Z.id) AS prumer
                                             FROM Druhy D
                                                      LEFT JOIN Zvirata Z ON D.id = Z.druh
                                             GROUP BY D.id) AS prumery));


-- 4. Všechny ošetřovatele, kteří mají rádi jen vyhynulé druhy ( = druhy bez zvířat)
-- nikdo, vytvořil jsem
SELECT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
         JOIN Ma_rad M ON M.osetrovatel = Ote.id
WHERE Ote.id NOT IN (SELECT M.osetrovatel
                     FROM Ma_rad AS M
                     WHERE M.druh IN (SELECT DISTINCT Z.druh
                                      FROM Zvirata Z));

-- 5. Všechny překrmovače: Ošetřovatele, kteří ošetřují pouze zvířata, která jsou nejtěžší ze svého druhu.
-- nikdo, musim pridat
SELECT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
         JOIN (SELECT Oje.osetrovatel, COUNT(Oje.id) AS pocet
               FROM Osetruje Oje
               GROUP BY Oje.osetrovatel) AS celkem ON celkem.osetrovatel = Ote.id
         JOIN (SELECT DISTINCT Oje.osetrovatel, COUNT(DISTINCT Z.id) AS pocet
               FROM Zvirata Z
                        JOIN Osetruje Oje ON Oje.zvire = Z.id
                        JOIN (SELECT MAX(Z.vaha) AS maxVaha, Z.druh
                              FROM Zvirata Z
                              GROUP BY Z.druh) AS maximalni
                             ON maximalni.maxVaha = Z.vaha AND maximalni.druh = Z.druh
               GROUP BY Oje.osetrovatel) AS nejtezsich ON nejtezsich.osetrovatel = Ote.id
WHERE nejtezsich.pocet = celkem.pocet;

-- 4
SELECT DISTINCT Ote.id
FROM Osetrovatele Ote
         JOIN Ma_rad AS M ON Ote.id = M.osetrovatel
         LEFT JOIN Zvirata Z on M.druh = Z.druh
WHERE Z.id IS NULL
  AND Ote.id NOT IN (SELECT Ote.id
                     FROM Osetrovatele Ote
                              JOIN Ma_rad AS M ON Ote.id = M.osetrovatel
                              JOIN Zvirata Z on M.druh = Z.druh);
-- 5
SELECT DISTINCT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
         JOIN Osetruje Oje ON Ote.id = Oje.osetrovatel
WHERE Ote.id NOT IN (SELECT Oje.osetrovatel
                     FROM Osetruje Oje
                     WHERE Oje.zvire IN (SELECT Z.id
                                         FROM Zvirata Z
                                         WHERE Z.id NOT IN (SELECT Z.id
                                                            FROM Zvirata Z
                                                                     JOIN (SELECT MAX(Z.vaha) AS maxVaha, Z.druh
                                                                           FROM Zvirata Z
                                                                           GROUP BY Z.druh) AS maximalni
                                                                          ON maximalni.maxVaha = Z.vaha AND maximalni.druh = Z.druh)));
