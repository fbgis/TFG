CREATE TABLE contaminacioTemp (Organisme String, Estacio String, Mesura String, Constituent String, Unitats String, Data String, Valor Float)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

--Càrrega de les dades de contaminació
LOAD DATA LOCAL INPATH 'contaminacio.txt' INTO TABLE contaminacioTemp;

--Projeccó de la taula inicial per a reduir els camps utilitzats
CREATE TABLE contaminacioTemp1 AS SELECT Data, Valor
	FROM contaminacioTemp;

CREATE TABLE contaminacioTemp2 (id String, Valor Float)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

--Eliminació dels casos amb valors nuls
INSERT OVERWRITE TABLE contaminacioTemp2
    SELECT * FROM contaminacioTemp1 
    WHERE Valor IS NOT NULL;

CREATE TABLE contaminacioTemp3 AS 
SELECT 
    regexp_replace(id, ' ', '-') AS id,
    Valor
FROM contaminacioTemp2;

CREATE TABLE contaminacio(id String ,Valor Float) clustered by (id) into 2 buckets stored as orc TBLPROPERTIES('transactional'='true');

INSERT INTO TABLE contaminacio SELECT * FROM contaminacioTemp3;

--Afegir la classe a la taula contaminació
ALTER TABLE contaminacio ADD COLUMNS (classe int);

--Càlcul de la classe
UPDATE contaminacio SET classe=1 WHERE Valor BETWEEN 0 AND 50.00;
UPDATE contaminacio SET classe=2 WHERE Valor BETWEEN 50.01 AND 100.00;
UPDATE contaminacio SET classe=3 WHERE Valor BETWEEN 100.01 AND 200.00; 
--UPDATE contaminacio SET classe=4 WHERE Valor BETWEEN 200.01 AND 400.00;
--UPDATE contaminacio SET classe=5 WHERE Valor>400.01; 

DROP TABLE contaminacioTemp;
DROP TABLE contaminacioTemp1;
DROP TABLE contaminacioTemp2;
DROP TABLE contaminacioTemp3;


