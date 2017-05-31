--Creació de la taula temporal
CREATE TABLE TransitTemp (id String, Intensitat int)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;



