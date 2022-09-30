-- Z1 - A
-- Všechny zvířecí druhy
SELECT d.nazev
FROM Druhy as d;

-- Všechna lehká zvířata (= lehčí než 50)
SELECT z.jmeno
FROM Zvirata AS z
WHERE z.vaha < 50;

-- Jména zvířat začínající na "A"
SELECT z.jmeno
FROM Zvirata AS z
WHERE z.jmeno LIKE "A%";

-- Zvířata seřazená podle abecedy
SELECT z.jmeno
FROM Zvirata AS z
ORDER BY z.jmeno;