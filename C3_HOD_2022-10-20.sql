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