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
-- náleží

-- 8. Ke každému ošetřovateli vypište nejmladší zvíře, které má rád a které je starší než on sám

-- 9. Vypište nejošetřovávanější zvíře. Pokud je takových zvířat více, zajímají nás všechna.

-- 10. Ke každému ošetřovateli vypište nejmladší ze zvířat, které ošetřuje a které je starší než
-- příslušný ošetřovatel.

-- 11. Vypište všechny ošetřovatele, kteří ošetřují všechny zajíce.
-- Pokud by ošetřovatel měl rád i další zvířata jiných druhů, není to na škodu; podstatné je, že
-- má rád všechny zajíce.

-- 12. Vypište ošetřovatele, který nemá rád žádné ze zvířat, které ošetřuje (zvířata, která
-- neošetřuje, rád mít může).

-- 13. Vypište ošetřovatele, který má rád všechna zvířata, která ošetřuje (pokud má rád i nějaké
-- další, která neošetřuje, nevadí to).

-- 14. Vypište všechna zvířata, která nemá rád ošetřovatel Juhani Lorenc a jsou těžší než 100.

-- 15. Vypište všechna zvířata, která ošetřují pouze děti (tzn. všichni ošetřovatelé musí být ročník
-- 2005 a mladší).
-- Poznámka: Lidem narozeným v r. 2004 letos 18 bylo nebo teprve bude. Protože funkce pro
-- manipulaci s datem a časem nebyly letos probrány, ročník 2004 pro jednoduchost
-- zanedbáme a budeme osoby narozené v r. 2004 posuzovat všechny jako již dospělé.

-- 16. Všechny milovníky starých zvířat (takové ošetřovatele, kteří jsou mladší než každé zvíře,
-- které mají rádi)

-- 17. Všechna zvířata, která neošetřuje nikdo, jehož jméno obsahuje písmeno „X“

-- 18. Všechny přemnožené druhy ( = druhy, jejichž populace je větší, než průměrná populace
-- druhu)

-- 19. Všechny ošetřovatele, kteří neošetřují staré holuby

-- 20. Všechna zvířata, která mají rádi pouze staří ošetřovatelé (narození v roce 1950 a starší)

-- 21. “Prodatelná” zvířata
-- (nejmladší zvíře každého druhu, s výjimkou těch, kde by populace po prodeji klesla pod 10
-- jedinců)

-- 22. Všechny ošetřovatele, kteří neošetřují žádné zvíře, které mají rádi

-- 23. Všechny hladomory
-- Def: Hladomorem nazveme takového ošetřovatele, který ošetřuje alespoň jedno zvíře, které je nejlehčí
-- svého druhu

-- 24. Nadprůměrně těžké druhy
-- Vahou druhu chápeme váhový průměr všech jeho zvířat. Nadprůměrně těžké druhy jsou takové druhy,
-- jejichž váha je vyšší než průměr vah všech druhů. Druhy, které nemají žádné zvíře, do výpočtů
-- nezahrnujte.

-- 25. Všechny ošetřovatele, kteří ošetřují pouze pštrosy.

-- 26. Vyhynulé druhy (nemají žádné zvíře)

-- 27. Všechna zvířata, která nemá nikdo rád

-- 28. Všechny ošetřovatele, kteří nikoho neošetřují

-- 29. Všechny kachny, které nemá nikdo rád

-- 30. Všechny ošetřovatele, kteří neošetřují kachny

-- 31. Všechny ošetřovatele, kteří neošetřují kachny ani husy

-- 32. Všechny ošetřovatele, kteří neošetřují těžké osly

-- 33. Všechny těžké osly, které nikdo neošetřuje