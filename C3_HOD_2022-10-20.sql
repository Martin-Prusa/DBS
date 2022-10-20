-- A1 - K
-- Kteří ošetřovatelé mají rádi alespoň jedno zvíře, které ošetřují?
SELECT distinct Ote.jmeno
FROM Osetrovatele AS Ote JOIN Osetruje AS Oje ON Oje.osetrovatel = Ote.id
						JOIN Zvirata AS Z ON Oje.zvire = Z.id
                        JOIN Druhy AS D ON D.id = Z.druh
                        JOIN Ma_rad AS M ON M.druh = D.id AND M.osetrovatel = Ote.id;
                        
-- Kteří ošetřovatelé s láskou krmí šneky?
SELECT distinct Ote.jmeno
FROM Osetrovatele AS Ote JOIN Osetruje AS Oje ON Oje.osetrovatel = Ote.id
						JOIN Zvirata AS Z ON Oje.zvire = Z.id
                        JOIN Druhy AS D ON D.id = Z.druh
                        JOIN Ma_rad AS M ON M.druh = D.id AND M.osetrovatel = Ote.id
WHERE D.nazev LIKE "snek";

-- * Která zvířata jsou s láskou krmena stejným ošetřovatelem, jako vrabec Falco?
SELECT Ote.jmeno
FROM Zvirata AS Z JOIN Druhy AS D ON D.id = Z.druh
					JOIN Ma_rad AS M ON M.druh = D.id
                    JOIN Osetrovatele AS Ote ON Ote.id = M.osetrovatel
                    JOIN Osetruje AS Oje ON Oje.zvire = Z.id AND Oje.osetrovatel = Ote.id
GROUP BY Ote.id
HAVING COUNT(Z.jmeno)  > 1;

SELECT Z.jmeno
FROM Zvirata AS Z JOIN Druhy AS D ON D.id = Z.druh
					JOIN Ma_rad AS M ON M.druh = D.id
                    JOIN Osetrovatele AS Ote ON Ote.id = M.osetrovatel
                    JOIN Osetruje AS Oje ON Oje.zvire = Z.id AND Oje.osetrovatel = Ote.id
WHERE Ote.id = (
	SELECT Ote2.id
    FROM Zvirata AS Z2 JOIN Druhy AS D2 ON D2.id = Z2.druh
					JOIN Ma_rad AS M2 ON M2.druh = D2.id
                    JOIN Osetrovatele AS Ote2 ON Ote2.id = M2.osetrovatel
                    JOIN Osetruje AS Oje2 ON Oje2.zvire = Z2.id AND Oje2.osetrovatel = Ote2.id
	WHERE Z2.jmeno LIKE "Falco" AND D2.nazev LIKE "vrabec"
    LIMIT 1
);