USE MARCIN_NIERUCHOMOSC;

GO

-- PRZYKŁADOWE DANE

INSERT INTO KLIENT_INDYWIDUALNY (UUID, IMIE, NAZWISKO, PESEL, ADRES_ULICA_LOKAL, KOD_POCZTOWY, MIESCOWOSC)
VALUES (dbo.getUUID(), 'Andrzej', 'Kowalski', '92011287321', 'Madalińskiego 9/12', '01-123',
        'Warszawa'),
       (dbo.getUUID(), 'Anna', 'Siemaszko', '95052199021', 'Czerwonego Kapturka 15b', '01-454',
        'Łomianki');

INSERT INTO KLIENT_FIRMA (UUID, NAZWA, NIP, ADRES_ULICA_LOKAL, KOD_POCZTOWY, MIESCOWOSC)
VALUES (dbo.getUUID(), 'SoftWare Inc.', '1234567890', 'Wiktoriańska 15 lok 100', '04-178',
        'Warszawa'),
       (dbo.getUUID(), 'MEBLOPOL SPÓŁKA JAWNA', '0987654321', 'Niedołajdy 21 p. 2', '51-754',
        'Kraków');

GO

INSERT INTO AGENT_NIERUCHOMOSCI (UUID, IMIE, NAZWISKO, NUMER_TELEFONU)
VALUES (dbo.getUUID(), 'Bożydar', 'Sięmięczko', '730480123'),
       (dbo.getUUID(), 'Krystyna', 'Kowlaska', '678232123'),
       (dbo.getUUID(), 'Anna', 'Wolska', '788233444'),
       (dbo.getUUID(), 'Karol', 'Woźniak', '876876123');

GO

INSERT INTO NIERUCHOMOSC (UUID, ID_AGENT, NAZWA, RODZAJ, ADRES_ULICA_LOKAL, KOD_POCZTOWY, MIESCOWOSC, CENA_DOBA_NETTO,
                          METRAZ)
VALUES (dbo.getUUID(), 1, 'Q22 - Piętro 28', 502, 'Aleja Jana Pawła 22', '01-146', 'Warszawa', 549.99, 120),
       (dbo.getUUID(), 2, 'Cracow Spire Full Floor', 502, 'Wawelska 1', '01-146', 'Kraków', 999.99, 430),
       (dbo.getUUID(), 3, 'Lokal - Studio', 503, 'Wolska 22', '03-146', 'Warszawa', 249.99, 90),
       (dbo.getUUID(), 2, 'Mieszkanie 3-pokojowe', 501, 'Rudnickiego 5/12', '04-146', 'Kraków', 150.00, 90),
       (dbo.getUUID(), 4, 'Mieszkanie 1-pokojowe', 501, 'Madalińskiego 5/133', '07-146', 'Warszawa', 99.99, 48),
       (dbo.getUUID(), 2, 'Mieszkanie 2-pokojowe', 501, 'Chrobrego 12/1', '01-146', 'Warszawa', 120.00, 60);

GO

