-- 1) Vyhynulé druhy ( nemají žádná zvířata) - praopice
SELECT D.nazev
FROM Druhy AS D LEFT JOIN Zvirata AS Z ON D.id = Z.druh
GROUP BY D.id
HAVING COUNT(Z.id) = 0;

-- 2) Lehké druhy ( každé zvíře daného druhu je lehčí než 50) - amur, praopice
SELECT D.nazev
FROM Druhy AS D LEFT JOIN Zvirata AS Z ON D.id = Z.druh
GROUP BY D.id
HAVING MAX(Z.vaha) <  50 OR COUNT(Z.id) = 0;

SELECT D.nazev
FROM Druhy AS D LEFT JOIN Zvirata AS Z ON D.id = Z.druh AND Z.vaha > 50
GROUP BY D.id
HAVING COUNT(Z.id) = 0;

-- 3) No-X druhy ( žádné zvíře z daného druhu nemá ve jménu písmeno "x") - 83
SELECT D.nazev, D.id
FROM Druhy AS D LEFT JOIN Zvirata AS Z ON Z.druh = D.id AND Z.jmeno LIKE "%x%"
GROUP BY D.id
HAVING COUNT(Z.id) = 0;

-- 4) Líní důchodci ( ošetřovatelé r. nar 1955 a starší, kteří neošetřují žádné zvíře) - 3
SELECT Ote.jmeno, Ote.narozen
FROM Osetrovatele AS Ote LEFT JOIN Osetruje AS Oje ON Ote.id = Oje.osetrovatel
GROUP BY Ote.id
HAVING COUNT(Oje.id) = 0 AND Ote.narozen < "1955-12-31";

-- 5) Líní bručouni ( ošetřovatelé, kteří neošetřují žádné zvíře a současně nemají žádné zvíře rádi) - 4
SELECT Ote.jmeno, Ote.id
FROM Osetrovatele AS Ote LEFT JOIN Osetruje AS OJE ON Ote.id = Oje.osetrovatel
						LEFT JOIN Ma_Rad AS M ON Ote.id = M.osetrovatel
WHERE Oje.id IS NULL AND M.id IS NULL;
