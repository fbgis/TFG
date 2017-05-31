--Càrrega de les dades tractades d'un arxiu mensual a la taula temporal
INSERT INTO TABLE TransitTemp SELECT * FROM taula3;

DROP TABLE taula3;

