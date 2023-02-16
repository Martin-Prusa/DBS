select z.jmeno, d.nazev
from zvirata as z join druhy as d on(d.id = z.druh)
                  join osetruje as oje on(z.id = oje.zvire)
where oje.osetrovatel = (select otel.id from osetrovatele as otel order by otel.narozen asc limit 1);

SELECT Z.jmeno, D.nazev
FROM Zvirata AS Z JOIN Druhy AS D ON D.id = Z.druh
				JOIN Osetruje AS Oje ON Oje.zvire = Z.id
WHERE Oje.osetrovatel = (
	SELECT Ote.id
    FROM Osetrovatele AS Ote
    WHERE Ote.narozen = (SELECT MIN(Ote.narozen) FROM Osetrovatele Ote)
    LIMIT 1
);