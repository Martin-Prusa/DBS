-- Z3 G

-- Kdo ošetřuje nejtěžšího pavouka? - Jaroslav LOUDA
SELECT O.jmeno
FROM Osetrovatele AS O JOIN Osetruje AS I ON O.id = I.osetrovatel
					JOIN Zvirata AS Z ON Z.id = I.zvire
                    JOIN Druhy AS D ON Z.druh = D.id
WHERE D.nazev LIKE "pavouk"
ORDER BY Z.vaha DESC
LIMIT 1;

-- Jména všech těžkých zvířat, které ošetřují lidé narození v roce 1950  ("těžké" je přes 50) - 21
SELECT Z.jmeno
FROM Zvirata AS Z JOIN Osetruje AS I ON Z.id = I.zvire
				JOIN Osetrovatele AS O ON (O.id = I.osetrovatel)
WHERE Z.vaha > 50 AND O.narozen LIKE "1950-%";

-- Jména všech lidí, kteří mají rádi škvory - 0 (6pes)
SELECT O.jmeno
FROM Osetrovatele AS O JOIN Ma_rad AS M ON M.osetrovatel = O.id
                    JOIN Druhy AS D ON (M.druh = D.id)
WHERE D.nazev LIKE "skvor" COLLATE utf8mb4_general_ci;
