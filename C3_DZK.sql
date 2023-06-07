-- 1. Vypište jména ošetřovatelů, kteří ošetřují alespoň dvě zvířata od stejného druhu. -- 187
SELECT DISTINCT Ote.id, Ote.jmeno, COUNT(Z.id) pocet
FROM Osetrovatele Ote
         JOIN Osetruje Oje ON Ote.id = Oje.osetrovatel
         JOIN Zvirata Z ON Z.id = Oje.zvire
GROUP BY Ote.id, Z.druh
HAVING pocet >= 2;

-- 2. Vypište jména ošetřovatelů, kteří ošetřují alespoň dva druhy takové, že příslušný ošetřovatel
-- ošetřuje alespoň dvě zvířata takového druhu.
-- Pro lepší pochopení: Žádá se totéž co ve cvičení č. 1, akorát takových druhů musí ošetřovatel
-- ošetřovat více. -- 38
SELECT pocty.id, pocty.jmeno
FROM (SELECT Ote.id, Ote.jmeno, COUNT(Z.id) pocet
      FROM Osetrovatele Ote
               JOIN Osetruje Oje ON Ote.id = Oje.osetrovatel
               JOIN Zvirata Z ON Z.id = Oje.zvire
      GROUP BY Ote.id, Z.druh
      HAVING pocet >= 2) pocty
GROUP BY pocty.id
HAVING COUNT(pocty.jmeno) >= 2;

-- 3. Vypište takové ošetřovatele, kteří neošetřují žádné zvíře starší než on sám. -- 36
SELECT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
WHERE Ote.id NOT IN (SELECT DISTINCT Ote.id
                     FROM Osetrovatele Ote
                              JOIN Osetruje Oje ON Ote.id = Oje.osetrovatel
                              JOIN Zvirata Z ON Z.id = Oje.zvire
                     WHERE Z.narozen < Ote.narozen);

-- 4. Vypište zvířata, která nikdo neošetřuje. -- 171
SELECT Z.id, Z.jmeno
FROM Zvirata Z
         LEFT JOIN Osetruje Oje ON Oje.zvire = Z.id
WHERE Oje.id IS NULL;

-- 5. Vypište data, kdy se narodilo nějaké zvíře, ale žádný ošetřovatel. - 1928
SELECT zn.narozen
FROM (SELECT DISTINCT Z.narozen
      FROM Zvirata Z) zn
WHERE zn.narozen NOT IN (SELECT Ote.narozen
                         FROM Osetrovatele Ote);

-- 6. Pro každý druh vypište jméno nejtěžšího a nejlehčího zvířete
SELECT D.nazev, minimalni.jmeno AS nejlehci, maximalni.jmeno AS nejtezsi
FROM Druhy D
         JOIN (SELECT Z.druh, Z.jmeno
               FROM Zvirata Z
                        JOIN (SELECT Z.druh, MIN(Z.vaha) AS vaha
                              FROM Zvirata Z
                              GROUP BY Z.druh) AS minVaha ON minVaha.druh = Z.druh AND Z.vaha = minVaha.vaha) minimalni
              ON minimalni.druh = D.id
         JOIN (SELECT Z.druh, Z.jmeno
               FROM Zvirata Z
                        JOIN (SELECT Z.druh, MAX(Z.vaha) AS vaha
                              FROM Zvirata Z
                              GROUP BY Z.druh) AS maxVaha ON maxVaha.druh = Z.druh AND Z.vaha = maxVaha.vaha) maximalni
              ON maximalni.druh = D.id;



-- 7. Vypište všechna zvířata, která mají váhu nižší, než je průměrná váha druhu, ke kterému
-- náleží - 1020
SELECT Z.id, Z.jmeno
FROM Zvirata Z
         JOIN (SELECT Z.druh AS druh, AVG(Z.vaha) AS prumer
               FROM Zvirata Z
               GROUP BY Z.druh) prumery ON Z.druh = prumery.druh
WHERE Z.vaha < prumery.prumer;

-- 8. Ke každému ošetřovateli vypište nejmladší zvíře, které má rád a které je starší než on sám
SELECT Ote.id, Z.id
FROM Osetrovatele Ote
         JOIN Ma_rad M ON M.osetrovatel = Ote.id
         JOIN Zvirata Z ON Z.druh = M.druh
         JOIN (SELECT Ote.id o, MAX(Z.narozen) nar
               FROM Osetrovatele Ote
                        JOIN Ma_rad M ON M.osetrovatel = Ote.id
                        JOIN Zvirata Z ON Z.druh = M.druh
               WHERE Z.narozen < Ote.narozen
               GROUP BY Ote.id) maxNar ON maxNar.o = Ote.id AND Z.narozen = maxNar.nar;


-- 9. Vypište nejošetřovávanější zvíře. Pokud je takových zvířat více, zajímají nás všechna.
SELECT Z.id, COUNT(Oje.id) pocet
FROM Zvirata Z
         JOIN Osetruje Oje ON Oje.zvire = Z.id
GROUP BY Z.id
HAVING pocet = (SELECT COUNT(Oje.id) AS pocet
                FROM Zvirata Z
                         JOIN Osetruje Oje ON Oje.zvire = Z.id
                GROUP BY Z.id
                ORDER BY pocet DESC
                LIMIT 1);


-- 10. Ke každému ošetřovateli vypište nejmladší ze zvířat, které ošetřuje a které je starší než
-- příslušný ošetřovatel.
SELECT Ote.id, Z.id
FROM Osetrovatele Ote
         JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
         JOIN Zvirata Z ON Z.id = Oje.zvire
         JOIN (SELECT Ote.id o, MAX(Z.narozen) nar
               FROM Osetrovatele Ote
                        JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
                        JOIN Zvirata Z ON Z.id = Oje.zvire
               WHERE Z.narozen < Ote.narozen
               GROUP BY Ote.id) maxNar ON maxNar.o = Ote.id AND Z.narozen = maxNar.nar;

-- 11. Vypište všechny ošetřovatele, kteří ošetřují všechny zajíce.
-- Pokud by ošetřovatel měl rád i další zvířata jiných druhů, není to na škodu; podstatné je, že
-- má rád všechny zajíce.
SELECT Oje.osetrovatel AS oset, COUNT(Z.id) pocet
FROM Osetruje Oje
         JOIN Zvirata Z ON Oje.zvire = Z.id
         JOIN Druhy D ON Z.druh = D.id
WHERE D.nazev LIKE 'zajic'
GROUP BY Oje.osetrovatel
HAVING pocet = (SELECT COUNT(Z.id)
                FROM Zvirata Z
                         JOIN Druhy D ON D.id = Z.druh
                WHERE D.nazev LIKE 'zajic');

-- 12. Vypište ošetřovatele, který nemá rád žádné ze zvířat, které ošetřuje (zvířata, která
-- neošetřuje, rád mít může).
SELECT Ote.id
FROM Osetrovatele Ote
WHERE Ote.id NOT IN (SELECT DISTINCT Ote.id
                     FROM Osetrovatele Ote
                              JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
                              JOIN Ma_rad M ON M.osetrovatel = Ote.id
                              JOIN Zvirata Z ON Z.id = Oje.zvire AND Z.druh = M.druh);



-- 13. Vypište ošetřovatele, který má rád všechna zvířata, která ošetřuje (pokud má rád i nějaké
-- další, která neošetřuje, nevadí to).
SELECT Ote.id
FROM Osetrovatele Ote
         JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
WHERE Ote.id NOT IN (SELECT DISTINCT Ote.id
                     FROM Osetrovatele Ote
                              JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
                              JOIN Zvirata Z ON Oje.zvire = Z.id
                              LEFT JOIN Ma_rad M ON M.osetrovatel = Ote.id AND M.druh = Z.druh
                     WHERE M.id IS NULL);


-- 14. Vypište všechna zvířata, která nemá rád ošetřovatel Juhani Lorenc a jsou těžší než 100.
SELECT Z.id, Z.jmeno
FROM Zvirata Z
WHERE Z.id NOT IN (SELECT Z.id
                   FROM Zvirata Z
                            JOIN Ma_rad M ON M.druh = Z.druh
                            JOIN Osetrovatele Ote ON Ote.id = M.osetrovatel
                   WHERE Ote.jmeno LIKE 'Juhani Lorenc')
  AND Z.vaha > 100;

-- 15. Vypište všechna zvířata, která ošetřují pouze děti (tzn. všichni ošetřovatelé musí být ročník
-- 2005 a mladší).
-- Poznámka: Lidem narozeným v r. 2004 letos 18 bylo nebo teprve bude. Protože funkce pro
-- manipulaci s datem a časem nebyly letos probrány, ročník 2004 pro jednoduchost
-- zanedbáme a budeme osoby narozené v r. 2004 posuzovat všechny jako již dospělé.
SELECT Z.id, Z.jmeno
FROM Zvirata AS Z
         JOIN (SELECT Z.id, COUNT(Ote.id) AS pocet
               FROM Zvirata Z
                        JOIN Osetruje Oje ON Z.id = Oje.zvire
                        JOIN Osetrovatele Ote ON Ote.id = Oje.osetrovatel
               GROUP BY Z.id) AS nor ON nor.id = Z.id
         JOIN (SELECT Z.id, COUNT(Ote.id) AS deti
               FROM Zvirata Z
                        JOIN Osetruje Oje ON Z.id = Oje.zvire
                        JOIN Osetrovatele Ote ON Ote.id = Oje.osetrovatel
               WHERE Ote.narozen > '2004-12-31'
               GROUP BY Z.id)
    AS deti ON Z.id = deti.id
WHERE deti.deti = nor.pocet;

-- 16. Všechny milovníky starých zvířat (takové ošetřovatele, kteří jsou mladší než každé zvíře,
-- které mají rádi)
SELECT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
         JOIN (SELECT Ote.id, COUNT(Z.id) AS starsich
               FROM Osetrovatele Ote
                        JOIN Ma_rad M ON M.osetrovatel = Ote.id
                        JOIN Zvirata Z on M.druh = Z.druh
               WHERE Ote.narozen > Z.narozen
               GROUP BY Ote.id) AS st ON st.id = Ote.id
         JOIN (SELECT Ote.id, COUNT(Z.id) AS celkem
               FROM Osetrovatele Ote
                        JOIN Ma_rad M ON M.osetrovatel = Ote.id
                        JOIN Zvirata Z on M.druh = Z.druh
               GROUP BY Ote.id) AS vsech ON vsech.id = Ote.id
WHERE st.starsich = vsech.celkem;

-- 17. Všechna zvířata, která neošetřuje nikdo, jehož jméno obsahuje písmeno „X“
SELECT Z.id, Z.jmeno
FROM Zvirata Z
WHERE Z.id NOT IN (SELECT Z.id
                   FROM Zvirata Z
                            JOIN Osetruje Oje ON Oje.zvire = Z.id
                            JOIN Osetrovatele Ote ON Oje.osetrovatel = Ote.id
                   WHERE Ote.jmeno LIKE '%x%'
                      OR Ote.jmeno LIKE '%X%');

-- 18. Všechny přemnožené druhy ( = druhy, jejichž populace je větší, než průměrná populace
-- druhu)
SELECT D.id, D.nazev
FROM Druhy D
         JOIN Zvirata Z ON Z.druh = D.id
GROUP BY D.id
HAVING COUNT(Z.id) > (SELECT AVG(c.c)
                      FROM (SELECT COUNT(Z.id) as c
                            FROM Zvirata Z
                            GROUP BY Z.druh) AS c);

-- 19. Všechny ošetřovatele, kteří neošetřují staré holuby

-- 20. Všechna zvířata, která mají rádi pouze staří ošetřovatelé (narození v roce 1950 a starší)
SELECT Z.id, Z.jmeno
FROM Zvirata Z
JOIN Ma_rad M on Z.druh = M.druh
WHERE Z.id NOT IN (SELECT DISTINCT Z.id
                   FROM Zvirata Z
                            JOIN Ma_rad M on Z.druh = M.druh
                            JOIN Osetrovatele Ote ON Ote.id = M.osetrovatel
                   WHERE Ote.narozen >= '1951-01-01');


-- 21. “Prodatelná” zvířata
-- (nejmladší zvíře každého druhu, s výjimkou těch, kde by populace po prodeji klesla pod 10
-- jedinců)
SELECT MIN(Z.id)
FROM Zvirata Z
         JOIN (SELECT MAX(Z.narozen) AS nar, Z.druh, COUNT(Z.id) AS pocet
               FROM Zvirata Z
               GROUP BY Z.druh
               HAVING pocet > 10) maxNar ON Z.druh = maxNar.druh AND Z.narozen = maxNar.nar
GROUP BY Z.druh;

-- 22. Všechny ošetřovatele, kteří neošetřují žádné zvíře, které mají rádi
SELECT Ote.id
FROM Osetrovatele Ote
         JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
         LEFT JOIN (SELECT M.osetrovatel, Z.id zvire
                    FROM Ma_rad M
                             JOIN Zvirata Z on M.druh = Z.druh) mazvire
                   ON Oje.zvire = mazvire.zvire AND mazvire.osetrovatel = Oje.osetrovatel
GROUP BY Ote.id
HAVING COUNT(mazvire.osetrovatel) = 0;

SELECT Ote.id
FROM Osetrovatele Ote
         JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
         JOIN Zvirata Z ON Oje.zvire = Z.id
         LEFT JOIN Ma_rad M ON Z.druh = M.druh AND M.osetrovatel = Oje.osetrovatel
GROUP BY Ote.id
HAVING COUNT(M.osetrovatel) = 0;

-- 23. Všechny hladomory
-- Def: Hladomorem nazveme takového ošetřovatele, který ošetřuje alespoň jedno zvíře, které je nejlehčí
-- svého druhu
SELECT DISTINCT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
         JOIN Osetruje Oje ON Ote.id = Oje.osetrovatel
         JOIN (SELECT Z.id
               FROM Zvirata Z
                        JOIN (SELECT Z.druh, MIN(Z.vaha) AS vaha
                              FROM Zvirata Z
                              GROUP BY Z.druh) AS m ON Z.druh = m.druh AND Z.vaha = m.vaha) AS minV
              ON minV.id = Oje.zvire;

-- 24. Nadprůměrně těžké druhy
-- Vahou druhu chápeme váhový průměr všech jeho zvířat. Nadprůměrně těžké druhy jsou takové druhy,
-- jejichž váha je vyšší než průměr vah všech druhů. Druhy, které nemají žádné zvíře, do výpočtů
-- nezahrnujte.
SELECT D.id, D.nazev
FROM Druhy D
         JOIN (SELECT Z.druh, AVG(Z.vaha) AS vaha
               FROM Zvirata Z
               GROUP BY Z.druh) AS avgVahy ON avgVahy.druh = D.id
WHERE avgVahy.vaha > (SELECT AVG(prumerne.vaha)
                      FROM (SELECT Z.druh, AVG(Z.vaha) AS vaha
                            FROM Zvirata Z
                            GROUP BY Z.druh) prumerne);

-- 25. Všechny ošetřovatele, kteří ošetřují pouze pštrosy.
SELECT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
         JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
         JOIN Zvirata Z ON Z.id = Oje.zvire
         LEFT JOIN Druhy D ON D.id = Z.druh AND D.nazev NOT LIKE 'pstros'
GROUP BY Ote.id
HAVING COUNT(D.id) = 0;

-- 26. Vyhynulé druhy (nemají žádné zvíře)
SELECT D.nazev
FROM Druhy D
         LEFT JOIN Zvirata Z ON Z.druh = D.id
WHERE Z.id IS NULL;

-- 27. Všechna zvířata, která nemá nikdo rád
SELECT Z.id, Z.jmeno
FROM Zvirata Z
         LEFT JOIN Ma_rad M on Z.druh = M.druh
WHERE M.id IS NULL;

-- 28. Všechny ošetřovatele, kteří nikoho neošetřují
SELECT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
         LEFT JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
WHERE Oje.id IS NULL;

-- 29. Všechny kachny, které nemá nikdo rád
SELECT Z.id, Z.jmeno
FROM Zvirata Z
         JOIN Druhy D ON D.id = Z.druh
         LEFT JOIN Ma_rad M ON M.druh = Z.druh
WHERE M.id IS NULL
  AND D.nazev LIKE 'kacena';

-- 30. Všechny ošetřovatele, kteří neošetřují kachny
SELECT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
WHERE Ote.id NOT IN (SELECT Oje.osetrovatel
                     FROM Osetruje Oje
                              JOIN Zvirata Z ON Oje.zvire = Z.id
                              JOIN Druhy D ON D.id = Z.druh
                     WHERE D.nazev LIKE 'kacena');

-- 31. Všechny ošetřovatele, kteří neošetřují kachny ani husy
SELECT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
WHERE Ote.id NOT IN (SELECT Oje.osetrovatel
                     FROM Osetruje Oje
                              JOIN Zvirata Z ON Oje.zvire = Z.id
                              JOIN Druhy D ON D.id = Z.druh
                     WHERE D.nazev LIKE 'husa'
                        OR D.nazev LIKE 'kacena');

-- 32. Všechny ošetřovatele, kteří neošetřují těžké osly
SELECT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
WHERE Ote.id NOT IN (SELECT Oje.osetrovatel
                     FROM Osetruje Oje
                              JOIN Zvirata Z ON Oje.zvire = Z.id
                              JOIN Druhy D ON D.id = Z.druh
                     WHERE D.nazev LIKE 'osel'
                       AND Z.vaha > 100);

-- 33. Všechny těžké osly, které nikdo neošetřuje
SELECT Z.id, Z.jmeno
FROM Zvirata Z
         JOIN Druhy D ON D.id = Z.druh
         LEFT JOIN Osetruje Oje ON Oje.zvire = Z.id
WHERE Oje.id IS NULL
  AND Z.vaha > 100
  AND D.nazev LIKE 'osel';