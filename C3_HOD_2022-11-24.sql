-- Vypište seznam zvířat, která ošetřuje někdo, kdo je starší i někdo, kdo je mladší.
SELECT DISTINCT Z.id, Z.jmeno
FROM Zvirata AS Z JOIN Osetruje AS Oje ON Oje.zvire = Z.id
					JOIN Osetrovatele AS Ote ON Ote.id = Oje.osetrovatel
                    JOIN Osetruje AS Oje2 ON Z.id = Oje2.zvire
                    JOIN Osetrovatele AS Ote2 ON Ote2.id = Oje2.osetrovatel
WHERE Z.narozen > Ote.narozen AND Z.narozen < Ote2.narozen;