-- -------------------------------------------------------- Z2 - E --------------------------------------------------------

-- Název druhu třetí nejstarší Julie
SELECT D.nazev
FROM Druhy AS D JOIN Zvirata AS Z ON (Z.druh = D.id)
WHERE Z.jmeno LIKE "Julie"
ORDER BY Z.narozen ASC
LIMIT 1
OFFSET 2;

-- LIMIT 2, 1

-- Název druhu nejtěžšího zvířete narozeného v lednu 2003
SELECT D.nazev
FROM Zvirata AS Z JOIN Druhy AS D ON (Z.druh = D.id)
WHERE Z.narozen >= "2003-01-01" AND Z.narozen < "2003-02-01"
ORDER BY Z.vaha DESC
LIMIT 1;

-- * Jména středně těžkých zvířat začínajících na "C" nebo končících na "a". (Středně těžké znamená "vážící mezi 50 a 100")
SELECT Z.jmeno
FROM Zvirata AS Z
WHERE Z.vaha > 50 AND Z.vaha < 100 AND (Z.jmeno LIKE "C%" OR Z.jmeno LIKE "%a");


-- -------------------------------------------------------- Z2 - F ----------------------------------------------------

-- Všechny druhy zvířat, které váží stejně, jako nejtěžší zvíře
SELECT D.nazev
FROM Druhy AS D JOIN Zvirata AS Z ON (D.id = Z.druh)
WHERE Z.vaha = (SELECT MAX(Z1.vaha) FROM Zvirata AS Z1);