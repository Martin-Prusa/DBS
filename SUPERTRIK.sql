SELECT Z1.jmeno
FROM Zvirata AS Z1 LEFT JOIN Zvirata AS Z2 ON (Z1.vaha < Z2.vaha)
WHERE Z2.id IS NULL;