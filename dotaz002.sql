SELECT distinct Ote.jmeno, Ote.id, Ote2.jmeno, Ote2.id
FROM Osetrovatele AS Ote JOIN Osetrovatele AS Ote2
WHERE Ote.jmeno LIKE Ote2.jmeno AND Ote.id != Ote2.id