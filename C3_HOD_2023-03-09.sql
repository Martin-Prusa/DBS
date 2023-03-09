-- ==== X ====
-- 1. Ošetřovatele, kteří ošetřují dvě (nebo více) zvířat se shodným datem narození
SELECT Ote.jmeno
FROM Osetrovatele AS Ote
WHERE Ote.id IN (SELECT DISTINCT Oje.osetrovatel AS osetrovatel
                 FROM Osetruje AS Oje
                          JOIN Zvirata AS Z ON Oje.zvire = Z.id
                 GROUP BY Z.narozen, Oje.osetrovatel
                 HAVING COUNT(Z.id) > 1);

-- 2. Nejplodnější den (den, kdy se narodilo nejvíce zvířat - chce se pouze datum!)

SELECT Z.narozen
FROM Zvirata AS Z
GROUP BY Z.narozen
HAVING COUNT(Z.id) = (SELECT COUNT(Z.id)
                      FROM Zvirata AS Z
                      GROUP BY Z.narozen
                      ORDER BY COUNT(Z.id) DESC
                      LIMIT 1);

-- 3. Nejstarší nemilované zvíře (chce se POUZE JMÉNO!)
SELECT Z.jmeno
FROM Zvirata AS Z LEFT JOIN Ma_rad AS M ON Z.druh = M.druh
WHERE M.id IS NULL
ORDER BY Z.narozen
LIMIT 1;