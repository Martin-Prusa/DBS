-- A2 D
-- Jména těžkých vlků ("těžké" znamená 50 nebo více) - Vlci se v databázi nenecházejí, hledám psy
SELECT Z.jmeno
FROM Zvirata AS Z JOIN Druhy AS D ON (D.id = Z.druh)
WHERE D.nazev LIKE "pes" AND Z.vaha >= 50;

-- Jméno nejtěžšího z lehkých pavouků ("lehké" znamená méně než 50)
SELECT Z.jmeno
FROM Zvirata AS Z JOIN Druhy AS D ON (D.id = Z.druh)
WHERE D.nazev LIKE "pavouk" AND Z.vaha < 50
ORDER BY Z.vaha DESC
LIMIT 1;

-- Jména všech zvířat začínajících na "A" nebo "B" (jmeno)
SELECT Z.jmeno
FROM Zvirata AS Z
WHERE Z.jmeno LIKE "A%" OR Z.jmeno LIKE "B%";

-- Jména všech zvířat začínajících na "A" nebo "B" (druh)
SELECT Z.jmeno
FROM Zvirata AS Z JOIN Druhy AS D ON (D.id = Z.druh)
WHERE D.nazev LIKE "A%" OR D.nazev LIKE "B%";