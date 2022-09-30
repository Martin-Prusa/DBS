SELECT z.jmeno, z.vaha
FROM Zvirata AS z;

SELECT z.jmeno, z.vaha
FROM Zvirata AS z
WHERE z.vaha < 50;

SELECT z.jmeno
FROM Zvirata AS z
WHERE z.jmeno LIKE "A%";

SELECT z.jmeno
FROM Zvirata AS z
WHERE z.jmeno LIKE "% %";

SELECT z.jmeno
FROM Zvirata AS z
WHERE z.vaha < 50 AND z.jmeno LIKE "%A";