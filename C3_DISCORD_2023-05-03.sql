-- \| 1. Všechny těžké druhy, které nemá rád nikdo starý
-- (těžký druh je takový, který má průměrnou váhu přes 50, starý je ten, kdo se narodil 1980 a dříve) -- 4 (25, 31, 65, 96)
SELECT Z.druh
FROM Zvirata Z
WHERE Z.druh NOT IN (SELECT DISTINCT D.id
                     FROM Druhy D
                              JOIN Ma_rad M ON M.druh = D.id
                              JOIN Osetrovatele Ote ON Ote.id = M.osetrovatel
                     WHERE Ote.narozen < '1981-01-01')
GROUP BY Z.druh
HAVING AVG(Z.vaha) > 50;

-- 2. Všechny staré ošetřovatele, kteří ošetřují pouze těžké druhy. - 335
SELECT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
         JOIN (SELECT Ote.id AS ote, COUNT(Oje.id) AS pocet
               FROM Osetrovatele Ote
                        JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
               WHERE Ote.narozen < '1981-01-01'
               GROUP BY Ote.id) AS stariCelkem ON stariCelkem.ote = Ote.id
         JOIN (SELECT Ote.id AS ote, COUNT(Z.id) AS pocet
               FROM Osetrovatele Ote
                        JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
                        JOIN Zvirata Z ON Z.id = Oje.zvire
               WHERE Z.druh IN (SELECT Z.druh
                                FROM Zvirata Z
                                GROUP BY Z.druh
                                HAVING AVG(Z.vaha) > 50)
               GROUP BY Ote.id) AS tezkych ON tezkych.ote = Ote.id
WHERE tezkych.pocet = stariCelkem.pocet;

-- 3. Všechny ošetřovatele, kteří mají rádi „nejkrmenější“ zvíře (tzn. zvíře, které krmi nejvíce ošetřovatelů)
-- 10 (5, 19, 210, 238, 287, 419, 423, 450, 485, 499)
SELECT DISTINCT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
         JOIN Ma_rad M ON M.osetrovatel = Ote.id
WHERE M.druh IN (SELECT Z.druh
                 FROM Zvirata Z
                          JOIN Osetruje Oje ON Oje.zvire = Z.id
                 GROUP BY Z.id
                 HAVING COUNT(Oje.id) = (SELECT COUNT(Oje.id)
                                         FROM Zvirata Z
                                                  JOIN Osetruje Oje ON Oje.zvire = Z.id
                                         GROUP BY Z.id
                                         ORDER BY COUNT(Oje.id) DESC
                                         LIMIT 1));

-- 4. Fitness trenér: Vypište ošetřovatele, kteří ošetřují alespoň jedno nejlehčí zvíře z některého druhu, který má daný ošetřovatel rád.
-- 10 - (43, 88, 103, 110, 211, 218, 236, 299, 424, 495)
SELECT M.osetrovatel
FROM Zvirata Z
         JOIN (SELECT Z.druh AS druh, MIN(Z.vaha) AS vaha
               FROM Zvirata Z
               GROUP BY Z.druh) nejlehci ON nejlehci.druh = Z.druh AND Z.vaha = nejlehci.vaha
JOIN Ma_rad M ON Z.druh = M.druh
JOIN Osetruje Oje ON Oje.zvire = Z.id AND M.osetrovatel = Oje.osetrovatel;