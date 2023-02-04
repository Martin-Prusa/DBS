-- 117 -> 1883
SELECT COUNT(DISTINCT Z.id)
FROM Zvirata AS Z JOIN Osetruje AS Oje ON Oje.zvire = Z.id
					JOIN Ma_Rad AS M ON M.druh = Z.druh AND M.osetrovatel = Oje.osetrovatel;
                    
SELECT DISTINCT Z.id, Z.jmeno -- 169 -> 1714
FROM Zvirata AS Z LEFT JOIN Osetruje AS Oje ON Oje.zvire = Z.id
WHERE Oje.id IS NULL;

SELECT DISTINCT Z.id, Z.jmeno -- 1714
FROM Zvirata AS Z JOIN Osetruje AS Oje ON Oje.zvire = Z.id
WHERE Z.id NOT IN (
				SELECT DISTINCT Z.id
				FROM Zvirata AS Z JOIN Osetruje AS Oje ON Oje.zvire = Z.id
									JOIN Ma_Rad AS M ON M.druh = Z.druh AND M.osetrovatel = Oje.osetrovatel
				);

SELECT DISTINCT Z.id, Z.jmeno
FROM Zvirata AS Z JOIN Osetruje AS Oje ON Oje.zvire = Z.id
					LEFT JOIN Ma_Rad AS M ON M.osetrovatel = Oje.osetrovatel AND M.druh = Z.druh
WHERE M.id IS NULL AND Z.id NOT IN

(SELECT DISTINCT Z.id -- 1714
FROM Zvirata AS Z JOIN Osetruje AS Oje ON Oje.zvire = Z.id
WHERE Z.id NOT IN (
				SELECT DISTINCT Z.id
				FROM Zvirata AS Z JOIN Osetruje AS Oje ON Oje.zvire = Z.id
									JOIN Ma_Rad AS M ON M.druh = Z.druh AND M.osetrovatel = Oje.osetrovatel
				));