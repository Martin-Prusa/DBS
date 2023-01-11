select distinct otel.id, otel.jmeno
from osetrovatele as otel join osetruje as oje on(otel.id = oje.osetrovatel)
                          join zvirata as z on(z.id = oje.zvire)
Group by z.druh, otel.id
HAVING COUNT(z.id) >= 2

AND otel.id NOT IN 

-- Kteří ošetřovatelé ošetřují více zvířat stejného druhu?
(SELECT DISTINCT Ote.id
FROM Osetrovatele AS Ote JOIN Osetruje AS Oje ON Oje.osetrovatel = Ote.id
						JOIN Zvirata AS Z ON Oje.zvire = Z.id
                        JOIN Osetruje AS Oje2 ON Oje2.osetrovatel = Ote.id
                        JOIN Zvirata AS Z2 ON Oje2.zvire = Z2.id
WHERE Z.druh = Z2.druh AND Z.id != Z2.id);
