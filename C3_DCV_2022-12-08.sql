-- 1. Zvířata, která nemá nikdo rád 76
SELECT Z.jmeno
FROM Zvirata AS Z LEFT JOIN Ma_Rad AS M ON M.druh = Z.druh
WHERE ISNULL(M.id);

-- 2. Ošetřovatelé, kteří nemají nikoho rádi 39
SELECT Ote.jmeno
FROM Osetrovatele AS Ote LEFT JOIN Ma_Rad AS M ON M.osetrovatel = Ote.id
WHERE ISNULL(M.id);

-- 3. Nenávistní lenoši (ošetřovatelé, kteří nemají nikoho rádi a navíc nikoho neošetřují).
-- Note: Nevím, jestli tam nějaký takový je. Pokud ne, vytvořte si nového ošetřovatele (třeba "Lenoch Nenávistný"). Ten určitě nebude nikoho ošetřovat, ani nemá nikoho rád.
-- Protože 3. je trochu za hranou toho, co jsme dělali, tak za 100% splněný úkol se považuje, když budete mít dvě správně kterékoliv dva (ale doporučuju zkusit i trojku).
SELECT Ote.jmeno, Ote.id
FROM Osetrovatele AS Ote LEFT JOIN Osetruje AS Oje ON Oje.osetrovatel = Ote.id
						LEFT JOIN Ma_Rad AS M ON M.osetrovatel = Ote.id
WHERE ISNULL(M.id) AND ISNULL(Oje.id);