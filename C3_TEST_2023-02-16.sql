-- ===== Test ======
-- 1) Zvirata, ktera maji nejvice sourozencu - 32
SELECT Z.jmeno
FROM Zvirata AS Z
WHERE Z.druh IN (
		SELECT Z.druh AS idDruhu
        FROM Zvirata AS Z
        GROUP BY Z.druh
        HAVING COUNT(Z.id) = (SELECT COUNT(Z.id) AS pocet
			FROM Zvirata AS Z
			GROUP BY Z.druh
			ORDER BY pocet DESC
			LIMIT 1)
);

-- 2) Zvirata, ktera jsou tezsi nez prumer jejich druhu - 973
SELECT Z.jmeno
FROM Zvirata AS Z JOIN (
	SELECT Z.druh AS idDruhu, AVG(Z.vaha) AS pv
	FROM Zvirata AS Z
    GROUP BY Z.druh
	) AS vahy ON Z.druh = vahy.idDruhu
WHERE Z.vaha > vahy.pv;

-- 3) Druhový průměr, váhový průměr druhů - 69.44927857
SELECT AVG(vahy.V)
FROM (
	SELECT AVG(Z.vaha) AS V
    FROM Zvirata AS Z
    GROUP BY Z.druh
) AS vahy;