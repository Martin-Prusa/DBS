use zoo;

-- 1. Vypište jména ošetřovatelů, kteří ošetřují alespoň dvě zvířata od stejného druhu.
SELECT Ote.jmeno
FROM Osetrovatele AS Ote JOIN Osetruje AS Oje ON Oje.osetrovatel = Ote.id
						JOIN Zvirata AS Z ON Oje.zvire = Z.id
GROUP BY Ote.id
HAVING COUNT(DISTINCT Z.druh) != COUNT(Z.id);

-- 2. Pro ošetřovatele Juhani Lorence vypište nejmladší ze zvířat, které ošetřuje a které je starší než příslušný ošetřovatel
SELECT Z.id, Z.jmeno, Z.narozen, Ote.narozen
FROM Zvirata AS Z JOIN Osetruje AS Oje ON Oje.zvire = Z.id
					JOIN Osetrovatele AS Ote ON Oje.osetrovatel = Ote.id
WHERE Ote.jmeno LIKE "Juhani Lorence" AND Z.narozen < Ote.narozen
ORDER BY Z.narozen DESC
LIMIT 1;

-- 3. Kolik různých druhů ošetřuje ošetřovatel Rasmus Nejedlý?
SELECT COUNT(DISTINCT Z.druh)
FROM Zvirata AS Z JOIN Osetruje AS Oje ON Oje.zvire = Z.id
					JOIN Osetrovatele AS Ote ON Ote.id = Oje.osetrovatel
WHERE Ote.jmeno LIKE "Rasmus Nejedlý";