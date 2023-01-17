-- 4912
SELECT COUNT(Oje.id)
FROM Osetruje AS Oje;

-- 121
SELECT COUNT(Z.id)
FROM Ma_Rad AS M JOIN Zvirata AS Z ON M.druh = Z.druh
				JOIN Osetruje AS Oje ON Oje.zvire = Z.id AND M.osetrovatel = Oje.osetrovatel;
                
-- 5033
SELECT COUNT(DISTINCT Oje2.id) + COUNT(DISTINCT Oje.id)
FROM Ma_Rad AS M JOIN Zvirata AS Z ON M.druh = Z.druh
				JOIN Osetruje AS Oje ON Oje.zvire = Z.id AND M.osetrovatel = Oje.osetrovatel
                JOIN Osetruje AS Oje2;
                
                SELECT COUNT(Oje.id)
FROM Osetrovatele AS Ote JOIN Osetruje AS Oje ON Ote.id = Oje.osetrovatel
						JOIN Ma_Rad AS M ON Ote.id = M.osetrovatel
                        JOIN Zvirata AS Z ON M.druh = Z.druh
                        JOIN Osetruje AS Oje2 ON Oje2.osetrovatel = Ote.id;