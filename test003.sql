-- 1. Najděte takové ošetřovatele, kteří mají rádi alespoň 3 zvířata
SELECT Ote.jmeno
FROM Osetrovatele AS Ote JOIN Ma_Rad AS M ON M.osetrovatel = Ote.id
						JOIN Zvirata AS Z ON Z.druh = M.druh
GROUP BY Ote.id
HAVING COUNT(Z.id) >= 3;

-- 2. Zjistěte, kteří ošetřovatelé jsou mladší než každé zvíře, které mají rádi.
SELECT Ote.jmeno, Ote.narozen
FROM Osetrovatele AS Ote JOIN Ma_Rad AS M ON M.osetrovatel = Ote.id
						JOIN Zvirata AS Z ON Z.druh = M.druh
GROUP BY Ote.id
HAVING MAX(Z.narozen) < Ote.narozen;

-- 3. Vypište, který druh má nejvyšší celkovou váhu ( = součet vah zvířat daného druhu je co nejvyšší)
SELECT D.nazev , SUM(Z.vaha)
FROM Druhy AS D JOIN Zvirata AS Z ON Z.druh = D.id
GROUP BY D.id
ORDER BY SUM(Z.vaha) DESC
LIMIT 1;