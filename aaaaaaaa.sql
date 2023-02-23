SELECT Z.druh, MIN(Z.narozen)
FROM Zvirata AS Z
GROUP BY Z.druh;

SELECT Z.id
FROM Zvirata AS Z
JOIN (
	SELECT Z.druh AS druh, MIN(Z.narozen) AS narozen
	FROM Zvirata AS Z
	GROUP BY Z.druh
) AS nejstarsiData ON Z.druh = nejstarsiData.druh AND Z.narozen = nejstarsiData.narozen;

SELECT M.druh
FROM Ma_Rad AS M JOIN Osetrovatele AS Ote ON Ote.id = M.osetrovatel
WHERE Ote.jmeno LIKE "Luke JANSA";