use zoo;

-- 2. Jméno a druh "prodatelných" zvířata (= nejstarší zvíře každého druhu, pokud bych prodejem daného zvířete nepřišel o posledního zástupce daného druhu)
SELECT Z.jmeno, D.nazev
FROM Zvirata AS Z JOIN Druhy AS D ON D.id = Z.druh
JOIN (
	SELECT Z.druh AS druh, COUNT(Z.id) AS pocetZvirat
	FROM Zvirata AS Z
	GROUP BY Z.druh
) AS pocty ON D.id = pocty.druh
WHERE pocty.pocetZvirat > 1 AND Z.id IN (
	SELECT Z.id
	FROM Zvirata AS Z
	JOIN (
		SELECT Z.druh AS druh, MIN(Z.narozen) AS narozen
		FROM Zvirata AS Z
		GROUP BY Z.druh
	) AS nejstarsiData ON Z.druh = nejstarsiData.druh AND Z.narozen = nejstarsiData.narozen
) GROUP BY D.id;



-- 2. Jméno a druh "prodatelných" zvířata (= nejstarší zvíře každého druhu, pokud bych prodejem daného zvířete nepřišel o posledního zástupce daného druhu)
SELECT Z.jmeno, D.nazev
FROM Zvirata AS Z
JOIN Druhy AS D ON Z.druh = D.id
JOIN (
	SELECT Z.druh AS druh, MAX(Z.id) AS nejstarsi
    FROM Zvirata AS Z
    LEFT JOIN Zvirata AS Z2 ON Z2.druh = Z.druh AND Z.narozen > Z2.narozen
    WHERE Z2.id IS NULL
    GROUP BY Z.druh
) AS nejstarsi ON Z.id = nejstarsi.nejstarsi
JOIN (
	SELECT Z.druh AS druh, COUNT(Z.id) AS pocetZvirat
	FROM Zvirata AS Z
	GROUP BY Z.druh
) AS pocty ON D.id = pocty.druh
WHERE pocty.pocetZvirat > 1;

