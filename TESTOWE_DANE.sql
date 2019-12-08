-- TESTOWE DODANIE NAJEM_INDYWIDUALNY
INSERT INTO NAJEM_INDYWIDUALNY(UUID, ID_KLIENT_INDYWIDUALNY, DATA_OD, DATA_DO, ID_NIERUCHOMOSC, WIELKOSC_RABATU,
                               ID_RACHUNEK)
VALUES (dbo.getUUID(), 1, convert(datetime, '24.12.2019', 104), convert(datetime, '29.12.2019', 104), 1, null, null);

GO

INSERT INTO NAJEM_INDYWIDUALNY(UUID, ID_KLIENT_INDYWIDUALNY, DATA_OD, DATA_DO, ID_NIERUCHOMOSC, WIELKOSC_RABATU,
                               ID_RACHUNEK)
VALUES (dbo.getUUID(), 2, convert(datetime, '24.12.2019', 104), convert(datetime, '29.12.2019', 104), 3, null, null);

GO

INSERT INTO NAJEM_INDYWIDUALNY(UUID, ID_KLIENT_INDYWIDUALNY, DATA_OD, DATA_DO, ID_NIERUCHOMOSC, WIELKOSC_RABATU,
                               ID_RACHUNEK)
VALUES (dbo.getUUID(), 1, convert(datetime, '30.11.2019', 104), convert(datetime, '31.12.2020', 104), 2, null, null);

GO

-- TESTOWE DODANIE NAJEM_FIRMA
INSERT INTO NAJEM_FIRMA(UUID, ID_KLIENT_FIRMA, DATA_OD, DATA_DO, ID_NIERUCHOMOSC, WIELKOSC_RABATU,
                        ID_FAKTURA)
VALUES (dbo.getUUID(), 1, convert(datetime, '30.12.2019', 104), convert(datetime, '31.12.2020', 104), 1, null, null);

GO
-- TESTOWE DODANIE NAJEM_FIRMA
INSERT INTO NAJEM_FIRMA(UUID, ID_KLIENT_FIRMA, DATA_OD, DATA_DO, ID_NIERUCHOMOSC, WIELKOSC_RABATU,
                        ID_FAKTURA)
VALUES (dbo.getUUID(), 2, convert(datetime, '26.12.2019', 104), convert(datetime, '31.12.2020', 104), 4, null, null);

GO

-- TESTY TRIGGERA
UPDATE RACHUNEK
SET CZY_OPLACONY = 1
WHERE ID_NAJEM = 1;

UPDATE RACHUNEK
SET CZY_OPLACONY = 1
WHERE ID_NAJEM = 3;

GO

-- TEST TRIGGERA
UPDATE FAKTURA
SET CZY_OPLACONA = 1
WHERE ID_NAJEM = 1;