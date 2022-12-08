-- 1. Zjistěte, který ošetřovatel je nejlepší krmič prasat (ošetřuje nejtěžší prase). Pokud by takových bylo více, vypište libovolného z nich. 
SELECT Ote.jmeno
FROM Osetrovatele AS Ote JOIN Osetruje AS Oje ON Oje.osetrovatel = Ote.id
						JOIN Zvirata AS Z ON Oje.zvire = Z.id
                        JOIN Druhy AS D ON D.id = Z.druh
WHERE D.nazev LIKE "prase"
ORDER BY Z.vaha DESC
LIMIT 1;

-- 2. Zjistěte, který ošetřovatel ošetřuje nejvíce prasat
SELECT Ote.jmeno
FROM Osetrovatele AS Ote JOIN Osetruje AS Oje ON Oje.osetrovatel = Ote.id
						JOIN Zvirata AS Z ON Z.id = Oje.zvire
						JOIN Druhy AS D ON Z.druh = D.id
WHERE D.nazev LIKE "prase"
GROUP BY Ote.id
ORDER BY COUNT(Z.id) DESC
LIMIT 1;

-- 3. Vypiste, kolik osetrovatelu osetruje jednotliva prasata
SELECT Z.jmeno, COUNT(Ote.id)
FROM Osetrovatele AS Ote JOIN Osetruje AS Oje ON Oje.osetrovatel = Ote.id
						JOIN Zvirata AS Z ON Z.id = Oje.zvire
                        JOIN Druhy AS D ON Z.druh = D.id
WHERE D.nazev LIKE "prase"
GROUP BY Z.id;
 
-- 4. Kolik prasat nedosauje jatecni vahu (87,5 kg)
SELECT COUNT(Z.id)
FROM Zvirata AS Z JOIN Druhy AS D ON Z.druh = D.id
WHERE D.nazev LIKE "prase" AND Z.vaha < 87.5;

-- 5. Kteri milovnici prasat maji radi take kravy
SELECT Ote.jmeno
FROM Osetrovatele AS Ote JOIN Ma_Rad AS M ON Ote.id = M.osetrovatel
						JOIN Druhy AS D ON D.id = M.druh
                        JOIN Ma_Rad AS M2 ON M2.osetrovatel = Ote.id
                        JOIN Druhy AS D2 ON M2.druh = D2.id
WHERE D.nazev LIKE "prase" AND D2.nazev LIKE "krava";