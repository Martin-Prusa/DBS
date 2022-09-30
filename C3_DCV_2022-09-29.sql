-- Z3 G

-- Kdo ošetřuje nejtěžšího pavouka? - Jaroslav LOUDA
SELECT O.jmeno
FROM Osetrovatele AS O JOIN Osetruje AS I
					JOIN Zvirata AS Z
                    JOIN Druhy AS D ON (Z.druh = D.id AND O.id = I.osetrovatel AND Z.id = I.zvire)
WHERE D.nazev LIKE "pavouk"
ORDER BY Z.vaha DESC
LIMIT 1;

-- Jména všech těžkých zvířat, které ošetřují lidé narození v roce 1950  ("těžké" je přes 50) - 21
SELECT Z.jmeno
FROM Zvirata AS Z JOIN Osetruje AS I
				JOIN Osetrovatele AS O ON (O.id = I.osetrovatel AND Z.id = I.zvire)
WHERE Z.vaha > 50 AND O.narozen LIKE "1950%";

-- Jména všech lidí, kteří mají rádi škvory - 0 (6pes)
SELECT O.jmeno
FROM Osetrovatele AS O JOIN Ma_rad AS M
                    JOIN Druhy AS D ON (M.osetrovatel = O.id AND M.druh = D.id)
WHERE D.nazev LIKE "skvor";
