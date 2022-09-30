-- Řazení
SELECT Z.jmeno 
FROM Zvirata AS Z
WHERE Z.vaha < 50
ORDER BY Z.vaha DESC, Z.jmeno ASC; -- Podle prvniho, kdyz jsou stejne tak podle druheho

-- Chci jmeno i druh
SELECT Z.jmeno, D.nazev
FROM Zvirata AS Z JOIN Druhy AS D ON (Z.druh = D.id);

-- Jména všech slonů
SELECT Z.jmeno
FROM Zvirata AS Z JOIN Druhy AS D ON (Z.druh = D.id)
WHERE D.nazev LIKE "krava";

-- Všechny druhy mající zástupce mezi Juliemi
SELECT D.nazev, Z.jmeno
FROM Druhy AS D JOIN Zvirata AS Z ON (Z.druh = D.id)
WHERE Z.jmeno LIKE "Julie";

-- Datum narození netopýra "Sisi"
SELECT Z.narozen
FROM Zvirata AS Z JOIN Druhy AS D ON (D.id = Z.druh AND D.nazev LIKE "netopyr" AND Z.jmeno LIKE "Sisi");

-- Pět nejlehčích zvířat
SELECT Z.jmeno
FROM Zvirata AS Z
ORDER BY Z.vaha
LIMIT 5;

-- Nejtěžšího králíka
SELECT Z.vaha, Z.jmeno
FROM Zvirata as Z JOIN Druhy AS D ON (Z.druh = D.id)
WHERE D.nazev LIKE "kralik"
ORDER BY Z.vaha DESC
LIMIT 1;

-- * Nejstaršího kráva
SELECT Z.narozen, Z.jmeno
FROM Zvirata AS Z JOIN Druhy as D ON (Z.druh = D.id AND D.nazev LIKE "krava")
ORDER BY Z.narozen ASC
LIMIT 1;
