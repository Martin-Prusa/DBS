-- ==== X ====
-- 1. Ošetřovatele, kteří ošetřují dvě (nebo více) zvířat se shodným datem narození
SELECT DISTINCT Ote.jmeno
FROM Osetruje AS Oje JOIN Zvirata AS Z ON Oje.zvire = Z.id
JOIN Osetrovatele AS Ote ON Ote.id = Oje.osetrovatel
GROUP BY Z.narozen, Oje.osetrovatel
HAVING COUNT(Z.id) > 1;

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
FROM Zvirata AS Z
         LEFT JOIN Ma_rad AS M ON Z.druh = M.druh
WHERE M.id IS NULL
ORDER BY Z.narozen
LIMIT 1;

-- ==== Y ====
-- 1. Pro každého ošetřovatele vypište nejstarší zvíře, které daný ošetřovatel NEošetřuje
-- 2. Pro každého ošetřovatele vypište počet zvířat, které daný ošetřovatel neošetřuje, ale má je rád
-- 3. Data, v nichž se narodila pouze zvířata (tedy nějaké zvíře, ale žádný ošetřovatel)