--Suma dels valors d'intensitat dels tres sensors
CREATE TABLE taula4  AS SELECT id, SUM(Intensitat) AS Intensitat
FROM TransitTemp
GROUP BY id;

DROP TABLE TransitTemp;

CREATE TABLE transit (id String, Intensitat int)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

--Eliminació dels valors nuls
INSERT OVERWRITE TABLE transit
   SELECT * FROM taula4 
   WHERE Intensitat IS NOT NULL;

DROP TABLE taula4;

