-- ==== U ====
-- Poznámka k "potřebným sloupcům": Chce se po vás skutečně jen výsledek s danými sloupci. Pokud potřebujete nějaké navíc, budete je muset nějak schovat. 

-- 1. Jména nejlehčích zvířat (Všechna zvířata, která váží stejně jako nejlehčí) - 18
SELECT Z.jmeno
FROM Zvirata Z
WHERE Z.vaha = (SELECT MIN(Z.vaha) FROM Zvirata Z);

-- 2. Která zvířata (jméno a druh) ošetřuje nejstarší ošetřovatel? - 12
-- Pokud jsou nejstarsi 2, funguje
SELECT Z.jmeno, D.nazev
FROM Zvirata AS Z JOIN Druhy AS D ON D.id = Z.druh
				JOIN Osetruje AS Oje ON Oje.zvire = Z.id
WHERE Oje.osetrovatel IN (
	SELECT Ote.id
    FROM Osetrovatele AS Ote
    WHERE Ote.narozen = (SELECT MIN(Ote.narozen) FROM Osetrovatele Ote)
);

-- Pokud jsou nejstarsi 2 nefunguje
SELECT Z.jmeno, D.nazev
FROM Zvirata AS Z JOIN Druhy AS D ON D.id = Z.druh
				JOIN Osetruje AS Oje ON Oje.zvire = Z.id
WHERE Oje.osetrovatel = (
	SELECT Ote.id
    FROM Osetrovatele AS Ote
    ORDER BY Ote.narozen
    LIMIT 1
);

-- 3. Jméno nejlehčího zvířete s více než jedním ošetřovatelem - Albina
SELECT Z.jmeno
FROM Zvirata Z
WHERE Z.id IN (
	SELECT Z.id
    FROM Zvirata Z JOIN Osetruje Oje ON Oje.zvire = Z.id
    GROUP BY Z.id
    HAVING COUNT(Oje.id) > 1
)
ORDER BY Z.vaha
LIMIT 1;