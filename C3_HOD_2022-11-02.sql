-- A2 - N
-- Které druhy mají pouze těžká zvířata (zvířata vážící přes 50)
SELECT D.nazev 
FROM Druhy AS D JOIN Zvirata AS Z ON (Z.druh = D.id)
GROUP BY D.id
HAVING MIN(Z.vaha) > 50;

-- Který druh má nejvyšší váhový průměr?
SELECT D.nazev
FROM Druhy AS D JOIN Zvirata AS Z ON Z.druh = D.id
GROUP BY D.id
ORDER BY AVG(Z.vaha) DESC
LIMIT 1;

-- Kolik zvířat s láskou ošetřují jednotliví ošetřovatelé?
SELECT Ote.jmeno, COUNT(Z.id)
FROM Zvirata AS Z JOIN Osetruje AS Oje ON (Oje.zvire = Z.id)
				JOIN Osetrovatele AS Ote ON (Ote.id = Oje.osetrovatel)
                JOIN Ma_rad AS M ON (M.druh = Z.druh AND M.osetrovatel = Ote.id)
GROUP BY Ote.id;

-- ------------------------------------------------------------------------------
SELECT COUNT(DISTINCT D.id)
FROM Druhy AS D JOIN Zvirata AS Z ON (D.id = Z.druh)
WHERE Z.vaha <= 50;

-- A2 - O
-- Kolik váží dohromady všechny osetrovane andulky?
SELECT SUM(Z.vaha)
FROM Zvirata AS Z JOIN Druhy AS D ON(Z.druh = D.id)
					JOIN Osetruje AS Oje ON (Oje.zvire = Z.id)
WHERE D.nazev LIKE "andulka";

-- Průměrná váha 20ti letých zvířat
SELECT AVG(Z.vaha)
FROM Zvirata AS Z
WHERE TIMESTAMPDIFF(YEAR, Z.narozen, CURDATE()) = 20