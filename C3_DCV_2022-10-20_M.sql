-- A2 - M
-- Jaká je průměrná váha vrabce? - 57.1739
SELECT AVG(Z.vaha)
FROM Zvirata AS Z JOIN Druhy AS D ON D.id = Z.druh
WHERE D.nazev LIKE "vrabec";

-- Kdo je nejvytíženějším chovatelem? (ošetřuje nejvíce zvířat) - Lucas MATYS
SELECT Ote.jmeno
FROM Zvirata AS Z JOIN Osetruje AS Oje ON Oje.zvire = Z.id
					JOIN Osetrovatele AS Ote ON Ote.id = Oje.osetrovatel
GROUP BY Ote.id
ORDER BY COUNT(Z.id) DESC
LIMIT 1;

-- Kolik různých druhů ošetřují jednotliví ošetřovatelé?
SELECT Ote.jmeno, COUNT(DISTINCT D.id)
FROM Osetrovatele AS Ote JOIN Osetruje AS Oje ON Oje.osetrovatel = Ote.id
						JOIN Zvirata AS Z ON Oje.zvire = Z.id
                        JOIN Druhy AS D ON Z.druh = D.id
GROUP BY Ote.id;
