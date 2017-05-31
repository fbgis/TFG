--Càrrega de les dades d'inversió tèrmica
CREATE TABLE estacioAlta (Data String, Hora String, Temperatura Float)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

CREATE TABLE estacioBaixa (Data String, Hora String, Temperatura Float)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH 'Aixas.txt' INTO TABLE estacioAlta;
LOAD DATA LOCAL INPATH 'BordaVidal.txt' INTO TABLE estacioBaixa;

--Creació de la clau principal
CREATE TABLE estacioAltaID AS SELECT concat(Data,'-',Hora) AS id, Temperatura
	FROM estacioAlta;

CREATE TABLE estacioBaixaID AS SELECT concat(Data,'-',Hora) AS id, Temperatura
	FROM estacioBaixa;

--Càlcul dels valors d'inversió tèrmica
CREATE TABLE inversioTemp AS SELECT a.id, (a.Temperatura-b.Temperatura) AS Inversio
FROM estacioAltaID a JOIN estacioBaixaID b 
ON (a.id = b.id);

CREATE TABLE inversio (id String, Inversio Float)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

--Eliminació dels valors nuls
INSERT OVERWRITE TABLE inversio 
    SELECT * FROM inversioTemp 
    WHERE Inversio IS NOT NULL;

DROP TABLE estacioAlta;
DROP TABLE estacioBaixa;
DROP TABLE estacioAltaID;
DROP TABLE estacioBaixaID;
DROP TABLE inversioTemp;