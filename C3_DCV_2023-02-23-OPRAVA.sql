-- Oprava ==V2==

-- ==== V ====
-- 1. Ke každému ošetřovateli vypište jméno nejtěžšího zvířete, které ošetřuje
SELECT DISTINCT Ote.jmeno, Z.jmeno
FROM Osetrovatele AS Ote JOIN Osetruje AS Oje ON Oje.osetrovatel = Ote.id
JOIN Zvirata AS Z ON Z.id = Oje.zvire 
JOIN (
	SELECT Ote.id AS osetrovatel, MAX(Z.vaha) AS maxVaha
	FROM Osetrovatele AS Ote JOIN Osetruje AS Oje ON Oje.osetrovatel = Ote.id
	JOIN Zvirata AS Z ON Z.id = Oje.zvire
	GROUP BY Ote.id
) AS maxVahy ON Ote.id = maxVahy.osetrovatel AND Z.vaha = maxVahy.maxVaha;
                        

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


-- 3. * Vypište ošetřovatele, s nimiž si má Luke JANSA o čem popovídat (= mají rádi společně rádi alespoň jeden druh)
SELECT DISTINCT Ote.id, Ote.jmeno
FROM Osetrovatele AS Ote 
JOIN Ma_Rad AS M ON M.osetrovatel = Ote.id
WHERE Ote.jmeno NOT LIKE "Luke JANSA" AND M.druh IN (
	SELECT M.druh
	FROM Ma_Rad AS M JOIN Osetrovatele AS Ote ON Ote.id = M.osetrovatel
	WHERE Ote.jmeno LIKE "Luke JANSA"
)