-- ==== X ====
-- 1. Ošetřovatele, kteří ošetřují dvě (nebo více) zvířat se shodným datem narození
SELECT DISTINCT Ote.jmeno
FROM Osetruje AS Oje
         JOIN Zvirata AS Z ON Oje.zvire = Z.id
         JOIN Osetrovatele AS Ote ON Ote.id = Oje.osetrovatel
GROUP BY Z.narozen, Oje.osetrovatel
HAVING COUNT(Z.id) > 1;

-- 2. Nejplodnější den (den, kdy se narodilo nejvíce zvířat - chce se pouze datum!)

SELECT Z.narozen
FROM Zvirata AS Z
GROUP BY Z.narozen
HAVING COUNT(Z.id) = (SELECT COUNT(Z.id)
                      FROM Zvirata AS Z
                      GROUP BY Z.narozen
                      ORDER BY COUNT(Z.id) DESC
                      LIMIT 1);

-- 3. Nejstarší nemilované zvíře (chce se POUZE JMÉNO!)
SELECT Z.jmeno
FROM Zvirata AS Z
         LEFT JOIN Ma_rad AS M ON Z.druh = M.druh
WHERE M.id IS NULL
ORDER BY Z.narozen
LIMIT 1;

-- ==== Y ====
-- 1. Pro každého ošetřovatele vypište nejstarší zvíře, které daný ošetřovatel NEošetřuje
SELECT *
FROM Osetrovatele AS Ote
         LEFT JOIN Zvirata AS Z ON true
WHERE Z.id NOT IN (SELECT Oje2.zvire
                   FROM Osetruje AS Oje2
                   WHERE Oje2.osetrovatel = Ote.id);



-- 2. Pro každého ošetřovatele vypište počet zvířat, které daný ošetřovatel neošetřuje, ale má je rád
-- NEZKONTROLOVANO
SELECT Ote.id, COUNT(Z.id)
FROM Osetrovatele AS Ote
         JOIN Ma_rad AS M ON M.osetrovatel = Ote.id
         JOIN Zvirata Z on M.druh = Z.druh
         LEFT JOIN Osetruje AS Oje ON Oje.osetrovatel = Ote.id AND Z.id = Oje.zvire
WHERE Oje.id IS NULL
GROUP BY Ote.id;

-- 3. Data, v nichž se narodila pouze zvířata (tedy nějaké zvíře, ale žádný ošetřovatel)

-- ==== Z ==== ( Bonbónkové úkoly )
-- 1. Vypište nejplodnější den v týdnu (tzn. den v týdnu: Pondělí, úterý..., kdy se narodilo nejvíce zvířat). Nezáleží na tom, jakým jazykem nebo jestli to bude zkratka
-- pouze 1
SELECT DAYNAME(Z.narozen) AS den
FROM Zvirata AS Z
GROUP BY den
ORDER BY COUNT(Z.id) DESC
LIMIT 1;

-- pokud by se narodilo stejne zvirat ve vice dnech
SELECT DAYNAME(Z.narozen) AS den
FROM Zvirata AS Z
GROUP BY den
HAVING COUNT(Z.id) = (SELECT COUNT(Z.id) as pocet
                      FROM Zvirata AS Z
                      GROUP BY DAYNAME(Z.narozen)
                      ORDER BY pocet DESC
                      LIMIT 1);
