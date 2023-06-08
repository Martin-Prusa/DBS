-- 1. Všechny ošetřovatele, kteří neošetřují žádného bobra současně s nutrií
-- Komentář: Najdu si ošetřovatele, kteří ošetřují bobra současně s nutrií, pak jen najdu ty, kteří v této tabulce nejsou.
-- kocka a pes 492, bobr a nutrie vsichni
SELECT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
WHERE Ote.id NOT IN
      (SELECT Ote.id
       FROM Osetrovatele Ote
                JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
                JOIN Zvirata Z ON Oje.zvire = Z.id
                JOIN Druhy D ON D.id = Z.druh
       WHERE D.nazev LIKE 'bobr'
          OR D.nazev LIKE 'nutrie'
       GROUP BY Ote.id
       HAVING COUNT(DISTINCT D.id) = 2);

-- 2. Všechny tukorády: Ošetřovatele, kteří mají rádi nadprůměrně těžké druhy
-- Komentář: Vypočítám váhový průměr druhů, najdu si druhy, které mají váhový průměr vyšší. Pak najdu ošetřovatele, kteří mají rádi některý z těchto druhů
-- 425
SELECT DISTINCT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
         JOIN Ma_rad M ON M.osetrovatel = Ote.id
WHERE M.druh IN (SELECT Z.druh
                 FROM Zvirata Z
                 GROUP BY Z.druh
                 HAVING AVG(Z.vaha) > (SELECT AVG(Prumery.prumer)
                                       FROM (SELECT AVG(Z.vaha) AS prumer
                                             FROM Zvirata Z
                                             GROUP BY Z.druh) AS Prumery));

-- 3. Všechny workoholiky: Ošetřovatele, kteří ošetřují alespoň 15 zvířat a každé jím ošetřované zvíře je jiného druhu
-- Komentář: Pokud počet zvířat je roven počtu unikátních druhů, je každé zvíře jiného druhu.
-- 16
SELECT Ote.id, Ote.jmeno, COUNT(Z.id) AS pocetZvirat, COUNT(DISTINCT Z.druh) AS pocetDruhu
FROM Osetrovatele Ote
         JOIN Osetruje Oje ON Ote.id = Oje.osetrovatel
         JOIN Zvirata Z ON Z.id = Oje.zvire
GROUP BY Ote.id
HAVING pocetDruhu = pocetZvirat
   AND pocetZvirat >= 15;

-- 4. Všechny hladomory: Ošetřovatele, kteří ošetřují pouze zvířata, která nedosahují váhového průměru svého druhu
-- Komentář: Zjistím ošetřovatele, kteří ošetřují váhově nadprůměrné zvíře. Pak vezmu ty, kteří v tomto seznamu nejsou a připojím ošetřuje, tím odstraním ty, kteří nikoho neošetřují.
-- 3
SELECT DISTINCT Ote.id, Ote.jmeno
FROM Osetrovatele Ote
         JOIN Osetruje Oje ON Oje.osetrovatel = Ote.id
WHERE Ote.id NOT IN (SELECT Oje.osetrovatel
                     FROM Zvirata Z
                              JOIN Osetruje Oje ON Oje.zvire = Z.id
                              JOIN (SELECT Z.druh, AVG(Z.vaha) AS prumer
                                    FROM Zvirata Z
                                    GROUP BY Z.druh) prumery ON prumery.druh = Z.druh
                     WHERE Z.vaha >= prumery.prumer);


-- 5. Dobře krmené druhy: Takové druhy, kde každé zvíře z daného druhu ošetřuje alespoň 5 ošetřovatelů
-- Komentář: Najdu si druh zvířat, která ošetřuje méně než 5 ošetřovatelů. Pak vypíšu ty druhy, které nejsou v této tabulce.
SELECT DISTINCT D.id, D.nazev
FROM Druhy D
JOIN Zvirata Z ON D.id = Z.druh
WHERE D.id NOT IN (SELECT Z.druh
                   FROM Zvirata Z
                            LEFT JOIN Osetruje Oje ON Z.id = Oje.zvire
                   GROUP BY Z.id
                   HAVING COUNT(Oje.id) < 5);

