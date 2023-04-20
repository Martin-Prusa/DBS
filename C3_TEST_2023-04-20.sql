-- Test 20.4.2023
-- 1) Všechny ošetřovatele , kteří neošetřují zvířata, která začínají na P, B a jsou tlustá ---> 332

SELECT Ote.id, Ote.jmeno
FROM Osetrovatele AS Ote
WHERE Ote.id NOT IN (SELECT Ote.id
                     FROM Osetrovatele AS Ote
                              JOIN Osetruje AS Oje ON Oje.osetrovatel = Ote.id
                              JOIN Zvirata AS Z ON Oje.zvire = Z.id
                     WHERE (Z.jmeno LIKE 'P%' OR Z.jmeno LIKE 'B%')
                       AND Z.vaha > 100);


-- 2) Zvířata, která nemá rád nikdo stařší než r.n. 2000 ---> 76
SELECT Z.id, Z.jmeno
FROM Zvirata AS Z
WHERE Z.id NOT IN (SELECT Z.id
                   FROM Zvirata AS Z
                            JOIN Ma_rad AS M on Z.druh = M.druh
                            JOIN Osetrovatele AS Ote ON Ote.id = M.osetrovatel
                   WHERE Ote.narozen < '2000-01-01');



