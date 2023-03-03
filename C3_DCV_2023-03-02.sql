-- ==== W ==== ( Bonbónkové úkoly ) 
-- 1. (10% a bonbón) Vypište jméno váhově nejprůměrnějšího zvířete (zvíře, jehož váha se od průměrné váhy všech zvířat liší co nejméně)
-- Výsledkem by mělo být pouze jméno, nic víc

-- Průměř '74.4105'

-- Pouze 1
SELECT Z.jmeno
FROM Zvirata Z
JOIN (
	SELECT AVG(Z.vaha) vaha
	FROM Zvirata Z
) Prumer
ORDER BY ABS(Prumer.vaha - Z.vaha)
LIMIT 1;

-- Vsechny s vahou
SELECT Z.jmeno
FROM Zvirata Z
WHERE Z.vaha = (
	SELECT Z.vaha
	FROM Zvirata Z
	JOIN (
		SELECT AVG(Z.vaha) vaha
		FROM Zvirata Z
	) Prumer
	ORDER BY ABS(Prumer.vaha - Z.vaha)
	LIMIT 1
);