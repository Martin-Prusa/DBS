-- 1. Všechny ošetřovatele, kteří neošetřují současně slepici a lasičku (tzn. nemusí ošetřovat nic z toho, ale pokud ano, nesmí ošetřovat zvířata z obou druhů současně).


-- 2. Všechny nadprůměrné druhy ( = takové druhy, jejichž váhový průměr je vyšší, než průměr váhových průměrů všech druhů). -> 57
SELECT D.id, D.nazev, prumery.prumernaVaha
FROM Druhy D
         JOIN (SELECT Z.druh druh, AVG(Z.vaha) prumernaVaha
               FROM Zvirata Z
               GROUP BY Z.druh) prumery ON D.id = prumery.druh
WHERE prumery.prumernaVaha > (SELECT AVG(Z.vaha)
                              FROM Zvirata Z);


-- 3. Všechny ošetřovatele, kteří ošetřují nejstarší zvíře z (jakéhokoliv) druhu -> 221
SELECT DISTINCT Ote.id, Ote.jmeno
FROM Zvirata Z
         JOIN (SELECT Z.druh druh, MIN(Z.narozen) narozen
               FROM Zvirata Z
               GROUP BY Z.druh) minNarozen ON minNarozen.druh = Z.druh AND minNarozen.narozen = Z.narozen
         JOIN Osetruje Oje ON Oje.zvire = Z.id
         JOIN Osetrovatele Ote ON Ote.id = Oje.osetrovatel;