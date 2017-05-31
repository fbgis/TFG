CREATE TABLE taula0 (Data String, Hora String, Velocitat int, Ocupacio int, Intensitat int, Noclassificats int, VehiclesHora int, Apunts int, ApuntsValids int, Error String)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

SET arxiu=${hiveconf:flag2}.txt;

--Càrrega de les dades d'un dels arixus mensuals del sensor
LOAD DATA LOCAL INPATH '${hiveconf:arxiu}' INTO TABLE taula0;

--Generació de la calu principal
CREATE TABLE taula2 AS SELECT concat(Data,'-',concat(substr(Hora, 0, 2),':00')) AS id, Intensitat
	FROM taula0;

--Conversió dels registrs per minuts a registres horaris
CREATE table taula3  AS SELECT id, SUM(Intensitat) AS Intensitat
FROM taula2
GROUP BY id;

DROP TABLE taula0;
DROP TABLE taula2;




