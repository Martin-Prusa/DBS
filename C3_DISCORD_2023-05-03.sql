-- \| 1. Všechny těžké druhy, které nemá rád nikdo starý
-- (těžký druh je takový, který má průměrnou váhu přes 50, starý je ten, kdo se narodil 1980 a dříve)
SELECT Z.druh
FROM Zvirata Z
WHERE Z.druh NOT IN (SELECT DISTINCT D.id
                     FROM Druhy D
                              JOIN Ma_rad M ON M.druh = D.id
                              JOIN Osetrovatele Ote ON Ote.id = M.osetrovatel
                     WHERE Ote.narozen < '1981-01-01')
GROUP BY Z.druh
HAVING AVG(Z.vaha) > 50;

-- 2. Všechny staré ošetřovatele, kteří ošetřují pouze těžké druhy.

-- 3. Všechny ošetřovatele, kteří mají rádi „nejkrmenější“ zvíře (tzn. zvíře, které krmi nejvíce ošetřovatelů)

-- 4. Fitness trenér: Vypište ošetřovatele, kteří ošetřují alespoň jedno nejlehčí zvíře z některého druhu, který má daný ošetřovatel rád.
