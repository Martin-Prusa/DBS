SELECT Z.id
FROM Zvirata AS Z JOIN Druhy AS D ON (D.id = Z.druh)
					JOIN Ma_rad AS M ON (M.druh = D.id)
                    JOIN Osetrovatele AS Ote ON (Ote.id = M.osetrovatel)
WHERE Ote.jmeno LIKE "Aaron Kropacek";