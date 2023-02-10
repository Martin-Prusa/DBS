use zoo;
-- ==== K3 - S ====
-- 1. Zvířata, která jsou krmena osobou, která je nemá ráda - 178
SELECT Z.id AS id
FROM Osetruje AS Oje JOIN Ma_Rad AS M ON M.osetrovatel = Oje.osetrovatel
					JOIN Zvirata AS Z ON M.druh = Z.druh AND Oje.zvire = Z.id;

-- 2. Neošetřovaná, a přesto milovaná zvířata
SELECT DISTINCT Z.id, Z.jmeno
FROM Zvirata Z JOIN Ma_Rad M ON M.druh = Z.druh
WHERE Z.id NOT IN (SELECT Oje.zvire FROM Osetruje AS Oje);

-- 3. * Neošetřovaná a současně nemilovaná zvířata ?
SELECT DISTINCT Z.id, Z.jmeno
FROM Zvirata Z
WHERE Z.id NOT IN (SELECT Oje.zvire FROM Osetruje AS Oje) 
		AND Z.id NOT IN (SELECT Z.id FROM Ma_Rad M JOIN Zvirata Z ON Z.druh = M.druh)
        
-- zkřízit meče
