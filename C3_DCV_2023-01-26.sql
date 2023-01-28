-- ==== R ====
-- 1. Kteří ošetřovatelé nemají rádi vrabce? - 483
SELECT Ote.jmeno
FROM Osetrovatele AS Ote LEFT JOIN (Ma_Rad AS M 
						JOIN Druhy AS D ON D.id = M.druh AND D.nazev LIKE "vrabec") ON M.osetrovatel = Ote.id
WHERE M.id IS NULL;

SELECT Ote.jmeno
FROM Ma_Rad AS M JOIN Druhy AS D ON D.id = M.druh AND D.nazev LIKE "vrabec" 
				RIGHT JOIN Osetrovatele AS Ote ON M.osetrovatel = Ote.id
WHERE M.id IS NULL;

-- 2. Který ošetřovatel je nejvíce nenávistný? (Nemá rád nejvíce druhů) ?
SELECT Ote.jmeno
FROM Osetrovatele AS Ote LEFT JOIN Ma_Rad AS M ON M.osetrovatel = Ote.id
GROUP BY Ote.id
ORDER BY COUNT(M.id)
LIMIT 1;

-- 3. Kolik těžkých zvířat (váha přes 50) je krmeno méně než dvěma ošetřovateli? - 368
SELECT COUNT(Z.id) OVER() pocet
FROM Zvirata AS Z LEFT JOIN Osetruje AS Oje ON Oje.zvire = Z.id
WHERE Z.vaha > 50
GROUP BY Z.id
HAVING COUNT(Oje.id) < 2
LIMIT 1;