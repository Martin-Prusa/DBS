SELECT Z.jmeno
FROM Zvirata AS Z JOIN Osetruje AS Oje ON Oje.zvire = Z.id
					JOIN Osetrovatele AS Ote ON Ote.id = Oje.osetrovatel
GROUP BY Z.id
HAVING Z.narozen > MIN(Ote.narozen) AND Z.narozen < MAX(Ote.narozen);