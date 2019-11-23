USE MARCIN_NIERUCHOMOSC;

INSERT INTO KLIENT_INDYWIDUALNY (UUID, IMIE, NAZWISKO, PESEL, ADRES_ULICA_LOKAL, KOD_POCZTOWY, MIESCOWOSC)
VALUES (dbo.getUUID(), 'Andrzej', 'Kowalski', '92011287321', 'Madalińskiego 9/12', '01123',
        'Warszawa'),
       (dbo.getUUID(), 'Anna', 'Siemaszko', '95052199021', 'Czerwonego Kapturka 15b', '01454',
        'Łomianki');


INSERT INTO AGENT_NIERUCHOMOSCI (UUID, IMIE, NAZWISKO)
VALUES (dbo.getUUID(), 'Bożydar', 'Sięmięczko');

INSERT INTO KATEGORIA_NIERUCHOMOSCI (UUID, NAZWA)
VALUES (dbo.getUUID(), 'POWIERZCHNIA_BIUROWA');

INSERT INTO NIERUCHOMOSC (UUID, NAZWA, RODZAJ, ADRES_ULICA_LOKAL, KOD_POCZTOWY, MIESCOWOSC, CENA_DOBA_NETTO,
                          CENA_DOBA_BRUTTO, METRAZ)
VALUES (dbo.getUUID(), 'Q22 - Piętro 28', 1, 'Aleja Jana Pawła 22', '01146', 'Warszawa', 249.99, null, 120);

GO

CREATE TRIGGER TR_CHECK_DATES
    ON NAJEM
    INSTEAD OF INSERT
    AS
BEGIN
    DECLARE @FROM date;
    DECLARE @TO date;
    DECLARE @NIERUCH bigint;
    SELECT @FROM = inserted.DATA_OD, @TO = inserted.DATA_DO, @NIERUCH = inserted.ID_NIERUCHOMOSC FROM inserted;
    IF (@TO < @FROM)
        BEGIN
            RAISERROR ('Wrong dates!',17,1);
        END
    ELSE
        IF EXISTS(SELECT *
                  FROM NAJEM
                  WHERE NAJEM.ID_NIERUCHOMOSC = @NIERUCH
                    AND NAJEM.DATA_OD >= @FROM
                    AND NAJEM.DATA_DO <= @TO)
            BEGIN
                RAISERROR ('This property is currently booked!',17,1);
            END
        ELSE
            BEGIN
                INSERT INTO NAJEM (UUID, ID_AGENT, DATA_OD, DATA_DO, ID_KLIENT_INDYWIDUALNY, ID_KLIENT_FIRMA,
                                   ID_NIERUCHOMOSC,
                                   WIELKOSC_RABATU, ARCHIWUM)
                SELECT inserted.UUID,
                       inserted.ID_AGENT,
                       inserted.DATA_OD,
                       inserted.DATA_DO,
                       inserted.ID_KLIENT_INDYWIDUALNY,
                       inserted.ID_KLIENT_FIRMA,
                       inserted.ID_NIERUCHOMOSC,
                       inserted.WIELKOSC_RABATU,
                       inserted.ARCHIWUM
                FROM inserted;
            END
END

GO


INSERT INTO NAJEM(UUID, ID_AGENT, DATA_OD, DATA_DO, ID_KLIENT_INDYWIDUALNY, ID_KLIENT_FIRMA, ID_NIERUCHOMOSC,
                  WIELKOSC_RABATU, ARCHIWUM)
VALUES (dbo.getUUID(), 1, convert(datetime, '23.10.2016', 104), convert(datetime, '23.10.2016', 104), 1, null, 1, null,
        0);

GO

INSERT INTO NAJEM(UUID, ID_AGENT, DATA_OD, DATA_DO, ID_KLIENT_INDYWIDUALNY, ID_KLIENT_FIRMA, ID_NIERUCHOMOSC,
                  WIELKOSC_RABATU, ARCHIWUM)
VALUES (dbo.getUUID(), 1, convert(datetime, '13.10.2016', 104), convert(datetime, '22.10.2016', 104), 1, null, 1, null,
        0);