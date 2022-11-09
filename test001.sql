-- 1. Napište dotaz, jehož výsledkem bude počet lehkých (= váha pod 50) pštrosů - 1
SELECT COUNT(Z.id)
FROM Zvirata AS Z JOIN Druhy AS D ON (Z.druh = D.id)
WHERE D.nazev LIKE "pstros" AND Z.vaha < 50;

-- 2. Napište dotaz, jehož výsledkem bude váha (nikoliv jméno) nejtěžšího zvířete z každého druhu - OK
SELECT D.nazev, MAX(Z.vaha)
FROM Zvirata AS Z JOIN Druhy AS D ON D.id = Z.druh
GROUP BY D.id;

-- 3. Napište dotaz, jehož výsledkem budou všechna zvířata, která ošetřuje alespoň 5 ošetřovatelů - OK
SELECT DISTINCT(Z.id), Z.jmeno
FROM Zvirata AS Z JOIN Osetruje AS Oje ON Oje.zvire = Z.id
GROUP BY Z.id
HAVING COUNT(Oje.id) >= 5;

-- 4. Napište dotaz, jehož výsledkem budou všichni ošetřovatelé ošetřující těžké zvíře a jejichž jméno nebo příjmení začíná na „A“  - 53
SELECT DISTINCT Ote.jmeno
FROM Osetrovatele AS Ote JOIN Osetruje AS Oje ON Oje.osetrovatel = Ote.id
						JOIN Zvirata AS Z ON Z.id = Oje.zvire
WHERE Z.vaha >= 50 AND (Ote.jmeno LIKE "A%" OR Ote.jmeno LIKE "% A%");

-- 5. Napište dotaz, jehož výsledkem bude seznam všech zvířat, které má rád někdo, kdo je současně ošetřuje. - 8 min - 121
SELECT DISTINCT Z.id, Z.jmeno
FROM Zvirata AS Z JOIN Ma_rad AS M ON M.druh = Z.druh
				JOIN Osetruje AS Oje ON M.osetrovatel = Oje.osetrovatel AND Z.id = Oje.zvire;

-- Bonus: Napište dotaz, jehož výsledkem bude druh, který má největší váhovou variabilitu (má největší rozdíl mezi vahou nejlehčího a nejtěžšího zvířete daného druhu) - 9 min
SELECT D.nazev
FROM Druhy AS D JOIN Zvirata AS Z ON Z.druh = D.id
GROUP BY D.id
ORDER BY MAX(Z.vaha) - MIN(Z.vaha) DESC
LIMIT 1;
