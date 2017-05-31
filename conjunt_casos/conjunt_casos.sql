--Unió de les taules amb les dades meteorològiques, d'inversió tèrmica, de trànsit i de contaminació
CREATE TABLE conjuntcasos AS SELECT m.id, m.Temperatura, m.HumitatRelativa, m.DireccioVent, m.VelocitatVent, m.Irradiacio, m.Insolacio, m.Precipitacio, i.Inversio, t.Intensitat, c.classe 
FROM meteorologia m JOIN inversio i ON (m.id=i.id) JOIN transit t ON (i.id=t.id) JOIN contaminacio c ON (t.id=c.id)
;


CREATE TABLE entrenament (id String, Temperatura Float, HumitatRelativa int, DireccioVent int, VelocitatVent int, Irradiacio int, Insolacio int, Precipitacio Float, Inversio Float, Intensitat int, classe int) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

--Creació del conjunt d'entrenament a partir d'un subconjunt aleatòri del 70% dels casos
INSERT OVERWRITE TABLE entrenament SELECT * FROM conjuntcasos SORT BY RAND() LIMIT 4250;

--Creació del conjunt de test a partir dels casos no utilitzats en el conjunt d'entrenament
CREATE TABLE test AS 
SELECT * 
FROM   conjuntcasos c 
WHERE  NOT EXISTS (
   SELECT 1           
   FROM   entrenament e
   WHERE  c.id = e.id
   );