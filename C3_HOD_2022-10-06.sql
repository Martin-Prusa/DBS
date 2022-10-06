-- Z3 - H

-- Nejtěžší zvíře, které má rád ošetřovatel Luke JANSA
SELECT Z.jmeno
FROM Druhy AS D JOIN Ma_Rad AS M ON (M.druh = D.id)
					JOIN Osetrovatele AS Ote ON (Ote.id = M.osetrovatel)
                    JOIN Zvirata AS Z ON (D.id = Z.druh)
WHERE Ote.jmeno LIKE "Luke JANSA"
ORDER BY Z.vaha DESC
LIMIT 1;

-- Druhy všech lehkých zvířat, která ošetřují Emilové
SELECT DISTINCT D.nazev
FROM Druhy AS D JOIN Zvirata AS Z ON (Z.druh = D.id)
				JOIN Osetruje AS Oje ON (Oje.zvire = Z.id)
                JOIN Osetrovatele AS Ote ON (Ote.id = Oje.osetrovatel)
WHERE Ote.jmeno LIKE "Emil %" AND Z.vaha < 50 ;

-- Druh nejtěžšího zvířete, které ošetřuje nejstarší ošetřovatel
SELECT D.nazev, Ote.jmeno
FROM Druhy AS D JOIN Zvirata AS Z ON Z.druh = D.id
				JOIN Osetruje AS Oje ON Oje.zvire = Z.id
                JOIN Osetrovatele AS Ote ON Oje.osetrovatel = Ote.id
ORDER BY Ote.narozen, Z.vaha DESC
LIMIT 1;
