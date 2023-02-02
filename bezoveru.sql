SELECT COUNT(DISTINCT Z.id)
FROM Osetruje AS Oje JOIN Osetruje AS Oje2 ON Oje2.zvire = Oje.zvire AND Oje2.id != Oje.id
					RIGHT JOIN Zvirata AS Z ON Oje.zvire = Z.id
WHERE Oje.id IS NULL AND Z.vaha > 50;