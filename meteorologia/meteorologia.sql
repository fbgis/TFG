--Càrrega de les dades meteoroògiques
CREATE TABLE meteorologiaTemp (Data String, Hora String, Temperatura Float, HumitatRelativa int, DireccioVent int, VelocitatVent int, Irradiacio int, Insolacio int, Precipitacio Float)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH 'meteorologia.txt' INTO TABLE meteorologiaTemp;

--Generació de la clau principal
CREATE TABLE meteorologiaTemp1 AS SELECT concat(Data,'-',Hora) AS id, Temperatura, HumitatRelativa, DireccioVent, VelocitatVent, Irradiacio, Insolacio, Precipitacio
	FROM meteorologiaTemp;

CREATE TABLE meteorologiaTemp2 (id String, Temperatura Float, HumitatRelativa int, DireccioVent int, VelocitatVent int, Irradiacio int, Insolacio int, Precipitacio Float)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

--Eliminació dels casos amb valors nuls
INSERT OVERWRITE TABLE meteorologiaTemp2 
    SELECT * FROM meteorologiaTemp1 
    WHERE Temperatura IS NOT NULL AND 
    HumitatRelativa IS NOT NULL AND 
    DireccioVent IS NOT NULL AND 
    VelocitatVent IS NOT NULL AND
    Irradiacio IS NOT NULL AND
    Insolacio IS NOT NULL AND
    Precipitacio IS NOT NULL
;

--Eliminació dels casos duplicats
CREATE TABLE meteorologia AS
SELECT id,
  MAX(Temperatura) AS Temperatura,
  MAX(HumitatRelativa) AS HumitatRelativa,
  MAX(DireccioVent) AS DireccioVent,
  MAX(VelocitatVent) AS VelocitatVent,
  MAX(Irradiacio) AS Irradiacio,
  MAX(Insolacio) AS Insolacio,
  MAX(Precipitacio) AS Precipitacio 
FROM meteorologiaTemp2
GROUP BY id;

DROP TABLE meteorologiaTemp;
DROP TABLE meteorologiaTemp1;
DROP TABLE meteorologiaTemp2;

