-- ==== Y ====
-- 1. Pro každého ošetřovatele vypište nejstarší zvíře, které daný ošetřovatel NEošetřuje

SELECT Ote.id, Z.jmeno
FROM Osetrovatele Ote
         JOIN (SELECT Ote.id, MIN(Z.narozen) AS narozen
               FROM Osetrovatele Ote
                        JOIN Zvirata Z
                        LEFT JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id AND Oje.zvire = Z.id
               WHERE Oje.id IS NULL
               GROUP BY Ote.id) AS OseVekNeo ON OseVekNeo.id = Ote.id
         JOIN Zvirata Z ON (OseVekNeo.narozen = Z.narozen)
         LEFT JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id AND Oje.zvire = Z.id
WHERE Oje.id IS NULL;