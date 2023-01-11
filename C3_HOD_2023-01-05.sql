-- ============================================================ P =================================================
-- 1. Kolik druhů nikdo nemá rád? - 5
SELECT COUNT(D.nazev) 
FROM Druhy AS D LEFT JOIN Ma_Rad AS M ON M.druh = D.id
WHERE M.id IS NULL;

-- 2. Kteří ošetřovatelé ošetřují více zvířat stejného druhu? - 177
SELECT DISTINCT Ote.id, Ote.jmeno
FROM Osetrovatele AS Ote JOIN Osetruje AS Oje ON Oje.osetrovatel = Ote.id
						JOIN Zvirata AS Z ON Oje.zvire = Z.id
                        JOIN Osetruje AS Oje2 ON Oje2.osetrovatel = Ote.id
                        JOIN Zvirata AS Z2 ON Oje2.zvire = Z2.id
WHERE Z.druh = Z2.druh AND Z.id != Z2.id;

-- 3. Kteří ošetřovatelé ošetřují více zvířat se stejnou vahou? - 138
SELECT DISTINCT Ote.id, Ote.jmeno
FROM Osetrovatele AS Ote JOIN Osetruje AS Oje ON Oje.osetrovatel = Ote.id
						JOIN Zvirata AS Z ON Oje.zvire = Z.id
                        JOIN Osetruje AS Oje2 ON Oje2.osetrovatel = Ote.id
                        JOIN Zvirata AS Z2 ON Oje2.zvire = Z2.id
WHERE Z.vaha = Z2.vaha AND Z.id != Z2.id;

-- 4. * Vypište celkový počet "denních chodů" za předpokladu, že každý ošetřovatel nakrmí každého ze svých svěřenců 1x denně a má-li jej navíc rád, pak 2x denně?
-- 4912
SELECT COUNT(Oje.id)
FROM Osetrovatele AS Ote JOIN Osetruje AS Oje ON Ote.id = Oje.osetrovatel
						JOIN Ma_Rad AS M ON Ote.id = M.osetrovatel
                        JOIN Zvirata AS Z ON M.druh = Z.druh
                        JOIN Osetruje AS Oje2 ON Oje2.osetrovatel = Ote.id;
                        
-- ================================================================= Q ================================================================
-- 1. Které druhy mají průměrnou váhu přes 50? - 104
SELECT D.nazev
FROM Druhy AS D JOIN Zvirata AS Z ON D.id = Z.druh
GROUP BY D.id
HAVING AVG(Z.vaha) > 50;

-- 2. Kdo je ošetřovatelem největšího počtu andulek? - SEVCIK / LANGR
SELECT Ote.jmeno
FROM Osetrovatele AS Ote JOIN Osetruje AS Oje ON Oje.osetrovatel = Ote.id
						JOIN Zvirata AS Z ON Oje.zvire = Z.id
                        JOIN Druhy AS D ON Z.druh = D.id
WHERE D.nazev LIKE "andulka"
GROUP BY Ote.id
ORDER BY COUNT(Z.id) DESC
LIMIT 1;

-- 3. Vypište celkový počet "denních chodů" za předpokladu, že každý ošetřovatel nakrmí každého ze svých svěřenců 2x denně - 9824
SELECT COUNT(Oje.id) * 2
FROM Osetruje AS Oje;


-- ========================================================== R ========================================================
-- 1. Kteří ošetřovatelé nemají rádi vrabce?
SELECT Ote.jmeno
FROM Osetrovatele AS Ote LEFT JOIN Ma_Rad AS M ON M.osetrovatel = Ote.id
						LEFT JOIN Druhy AS D ON D.id = M.druh AND !D.nazev LIKE "vrabec"
WHERE !(Ote.id IN (SELECT OteX.id
FROM Osetrovatele AS OteX JOIN Ma_Rad AS MX ON MX.osetrovatel = OteX.id
						JOIN Druhy AS DX ON DX.id = MX.druh
WHERE DX.nazev LIKE "vrabec"))
GROUP BY Ote.id;


						