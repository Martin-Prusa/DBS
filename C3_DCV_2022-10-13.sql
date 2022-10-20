-- A1 - J

-- Jméno nejmladšího ošetřovatele? 'Mads HOLAS'
SELECT Ote.jmeno
FROM Osetrovatele AS Ote
ORDER BY Ote.narozen DESC
LIMIT 1;

-- Kolik váží dohromady všechny vodoměrky? '1435'
SELECT SUM(Z.vaha)
FROM Zvirata AS Z JOIN Druhy AS D ON (D.id = Z.druh)
WHERE D.nazev LIKE "vodomerka";

-- Kolik zvířat (kusů zvířat, ne druhů!) má rád Aaron Kropáček? 15
SELECT COUNT(Z.id)
FROM Zvirata AS Z JOIN Druhy AS D ON (D.id = Z.druh)
					JOIN Ma_rad AS M ON (M.druh = D.id)
                    JOIN Osetrovatele AS Ote ON (Ote.id = M.osetrovatel)
WHERE Ote.jmeno LIKE "Aaron Kropacek";
