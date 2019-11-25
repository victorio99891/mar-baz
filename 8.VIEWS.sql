USE MARCIN_NIERUCHOMOSC;

GO

-- WIDOK NIERUCHOMOSC W KATEGORII MIESZKANIE + SZCZEGÓLY AGENTA PRZYPISANEGO DO NIERUCHOMOSCI
CREATE VIEW VIEW_MIESZKANIA_I_AGENT AS
(
SELECT ID_NIERUCHOMOSC,
       AN.IMIE                        AS IMIE_AGENT,
       AN.NAZWISKO                    AS NAZWISKO_AGENT,
       AN.NUMER_TELEFONU,
       NIERUCHOMOSC.NAZWA             AS NIERUCHOMOSC,
       KN.NAZWA                       AS KATEGORIA,
       NIERUCHOMOSC.ADRES_ULICA_LOKAL AS ADRES,
       MIESCOWOSC,
       METRAZ,
       CENA_DOBA_NETTO
FROM NIERUCHOMOSC
         JOIN AGENT_NIERUCHOMOSCI AN on NIERUCHOMOSC.ID_AGENT = AN.ID_AGENT
         JOIN KATEGORIA_NIERUCHOMOSCI KN on NIERUCHOMOSC.RODZAJ = KN.ID_KATEGORIA
WHERE KN.NAZWA = 'MIESZKANIE'
    )

GO

SELECT *
FROM VIEW_MIESZKANIA_I_AGENT;

GO

-- WIDOK NIERUCHOMOSC W KATEGORII POWIERZCHNIA_BIUROWA + SZCZEGÓLY AGENTA PRZYPISANEGO DO NIERUCHOMOSCI
CREATE VIEW VIEW_POWIERZCHNIA_BIUROWA_I_AGENT AS
(
SELECT ID_NIERUCHOMOSC,
       AN.IMIE                        AS IMIE_AGENT,
       AN.NAZWISKO                    AS NAZWISKO_AGENT,
       AN.NUMER_TELEFONU,
       NIERUCHOMOSC.NAZWA             AS NIERUCHOMOSC,
       KN.NAZWA                       AS KATEGORIA,
       NIERUCHOMOSC.ADRES_ULICA_LOKAL AS ADRES,
       MIESCOWOSC,
       METRAZ,
       CENA_DOBA_NETTO
FROM NIERUCHOMOSC
         JOIN AGENT_NIERUCHOMOSCI AN on NIERUCHOMOSC.ID_AGENT = AN.ID_AGENT
         JOIN KATEGORIA_NIERUCHOMOSCI KN on NIERUCHOMOSC.RODZAJ = KN.ID_KATEGORIA
WHERE KN.NAZWA = 'POWIERZCHNIA_BIUROWA'
    )

GO

SELECT *
FROM VIEW_POWIERZCHNIA_BIUROWA_I_AGENT;

GO

-- WIDOK NIERUCHOMOSC W KATEGORII LOKAL_UZYTKOWY + SZCZEGÓLY AGENTA PRZYPISANEGO DO NIERUCHOMOSCI
CREATE VIEW VIEW_LOKAL_UZYTKOWY_I_AGENT AS
(
SELECT ID_NIERUCHOMOSC,
       AN.IMIE                        AS IMIE_AGENT,
       AN.NAZWISKO                    AS NAZWISKO_AGENT,
       AN.NUMER_TELEFONU,
       N.NAZWA             AS NIERUCHOMOSC,
       KN.NAZWA                       AS KATEGORIA,
       N.ADRES_ULICA_LOKAL AS ADRES,
       MIESCOWOSC,
       METRAZ,
       CENA_DOBA_NETTO
FROM NIERUCHOMOSC AS N
         JOIN AGENT_NIERUCHOMOSCI AN on N.ID_AGENT = AN.ID_AGENT
         JOIN KATEGORIA_NIERUCHOMOSCI KN on N.RODZAJ = KN.ID_KATEGORIA
WHERE KN.NAZWA = 'LOKAL_UŻYTKOWY'
    )

GO

SELECT *
FROM VIEW_LOKAL_UZYTKOWY_I_AGENT;


-- WIDOK PRZYCHÓD ZA NAJEM INDYWIDUALNY W ROKU 2019 W ZALEZNOSCI OD NAZWY NIERUCHOMOSCI

-- SELECT N.NAZWA,
--        SUM(R.CENA_NETTO)  AS            DOCHOD_NETTO,
--        SUM(R.CENA_BRUTTO) AS            DOCHOD_BRUTTO,
--        SUM(R.WARTOSC_BRUTTO_PO_RABACIE) DOCHOD_FAKTYCZNY_RABAT
-- FROM NAJEM_INDYWIDUALNY AS NI
--          JOIN NIERUCHOMOSC N on NI.ID_NIERUCHOMOSC = N.ID_NIERUCHOMOSC
--          JOIN RACHUNEK R on NI.ID_RACHUNEK = R.ID_RACHUNEK
--          JOIN KATEGORIA_NIERUCHOMOSCI KN on N.RODZAJ = KN.ID_KATEGORIA
-- WHERE R.CZY_OPLACONY = 1
--   AND NI.DATA_OD >= '2019'
--   AND NI.DATA_DO < '2020'
-- GROUP BY N.NAZWA;

