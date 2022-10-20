-- Všechny dvojice ošetřovatel - zvíře, kde zvíře je těžší než věk ošetřovatele v letech
SELECT Z.jmeno, Ote.jmeno
FROM Zvirata AS Z JOIN Osetruje AS Oje ON Oje.zvire = Z.id
					JOIN Osetrovatele AS Ote ON Ote.id = Oje.osetrovatel
WHERE Z.vaha > TIMESTAMPDIFF(YEAR, Ote.narozen, NOW());