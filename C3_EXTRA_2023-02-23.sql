-- Vypište, kterých zvířat se narodilo v jednotlivé roky nejvíce.
-- Očekávaným výpisem jsou dva sloupce – v jednom všechny roky, kdy se narodilo alespoň jedno zvíře, ve druhém pak druh, jejichž zástupců se v daném roce narodilo nejvíce. Pokud budete mít navíc vypsány nějaké kontrolní sloupce, nevadí.
-- ---------------
-- rok    |  druh
-- ---------------
-- 1941   | lev
-- 1964   | papoušek

SELECT narozeni.rok, D.nazev
FROM (
	SELECT narozeni2.rok AS rok, MAX(pocet) AS maxPocet
	FROM (
		SELECT YEAR(Z.narozen) AS rok, Z.druh AS druh, COUNT(Z.id) as pocet
		FROM Zvirata AS Z
		GROUP BY YEAR(Z.narozen), Z.druh
	) AS narozeni2
GROUP BY narozeni2.rok
) AS maximalni 
JOIN (
	SELECT YEAR(Z.narozen) AS rok, Z.druh AS druh, COUNT(Z.id) as pocet
	FROM Zvirata AS Z
	GROUP BY YEAR(Z.narozen), Z.druh
) AS narozeni ON (narozeni.rok = maximalni.rok AND narozeni.pocet = maximalni.maxPocet)
JOIN Druhy AS D ON narozeni.druh = D.id
ORDER BY narozeni.rok;



-- =============================Postup==============================


-- Rok / druh / pocet
SELECT YEAR(Z.narozen) AS rok, Z.druh AS druh, COUNT(Z.id) as pocet
FROM Zvirata AS Z
GROUP BY YEAR(Z.narozen), Z.druh;

-- Rok / maximalni druh
SELECT narozeni2.rok AS rok, MAX(pocet) AS maxPocet
FROM (
	SELECT YEAR(Z.narozen) AS rok, Z.druh AS druh, COUNT(Z.id) as pocet
	FROM Zvirata AS Z
	GROUP BY YEAR(Z.narozen), Z.druh
) AS narozeni2
GROUP BY narozeni2.rok;