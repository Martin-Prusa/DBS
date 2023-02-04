-- ==== K3 - S ====
-- 1. Zvířata, která jsou krmena osobou, která je nemá ráda
SELECT DISTINCT Z.id, Z.jmeno -- 1822
FROM Zvirata AS Z JOIN Osetruje AS Oje ON Oje.zvire = Z.id
					LEFT JOIN Ma_Rad AS M ON M.osetrovatel = Oje.osetrovatel AND M.druh = Z.druh
WHERE M.id IS NULL;

-- 2. Neošetřovaná, a přesto milovaná zvířata
SELECT DISTINCT Z.id, Z.jmeno -- 163
FROM Zvirata AS Z JOIN Ma_Rad AS M ON M.druh = Z.druh
					LEFT JOIN Osetruje AS Oje ON Oje.zvire = Z.id
WHERE Oje.id IS NULL;

-- 3. * Neošetřovaná a současně nemilovaná zvířata ?
SELECT Z.id, Z.jmeno -- 6
FROM Zvirata AS Z LEFT JOIN Osetruje AS Oje ON Z.id = Oje.zvire
					LEFT JOIN Ma_Rad AS M ON M.druh = Z.druh
WHERE Oje.id IS NULL AND M.id IS NULL;