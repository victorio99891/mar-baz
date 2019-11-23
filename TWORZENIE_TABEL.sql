-- CREATE DATABASE MARCIN_NIERUCHOMOSC;

-- GO

USE MARCIN_NIERUCHOMOSC;

GO

CREATE TABLE KLIENT_FIRMA
(
    ID_KLIENT_FIRMA   bigint primary key identity,
    UUID              varchar(255) unique not null,
    NAZWA             varchar(60)         not null,
    NIP               varchar(10) unique  not null,
    ADRES_ULICA_LOKAL varchar(100)        not null,
    KOD_POCZTOWY      varchar(5)          not null,
    MIESCOWOSC        varchar(50)         not null
);

GO

CREATE TABLE KLIENT_INDYWIDUALNY
(
    ID_KLIENT         bigint primary key identity,
    UUID              varchar(255) unique not null,
    IMIE              varchar(20)         not null,
    NAZWISKO          varchar(50)         not null,
    PESEL             varchar(11) unique  not null,
    ADRES_ULICA_LOKAL varchar(100)        not null,
    KOD_POCZTOWY      varchar(5)          not null,
    MIESCOWOSC        varchar(50)         not null,
);

GO

CREATE TABLE AGENT_NIERUCHOMOSCI
(
    ID_AGENT bigint primary key identity,
    UUID     varchar(255) unique not null,
    IMIE     varchar(20)         not null,
    NAZWISKO varchar(50)         not null,
)

GO

CREATE TABLE NIERUCHOMOSC
(
    ID_NIERUCHOMOSC   bigint primary key identity,
    UUID              varchar(255) unique not null,
    ID_AGENT          bigint              not null,
    NAZWA             varchar(100)        not null,
    RODZAJ            bigint              not null,
    ADRES_ULICA_LOKAL varchar(100)        not null,
    KOD_POCZTOWY      varchar(5)          not null,
    MIESCOWOSC        varchar(50)         not null,
    CENA_DOBA_NETTO   decimal(10, 2)      not null,
    CENA_DOBA_BRUTTO  decimal(10, 2),
    METRAZ            int                 not null,
    DOSTEPNA          bit default 0
)

GO

ALTER TABLE NIERUCHOMOSC
    ADD CONSTRAINT FK_NIERUCHOMOSC_AGENT_ID FOREIGN KEY (ID_AGENT) REFERENCES AGENT_NIERUCHOMOSCI (ID_AGENT);

GO

CREATE TABLE KATEGORIA_NIERUCHOMOSCI
(
    ID_KATEGORIA bigint primary key,
    UUID         varchar(255) unique not null,
    NAZWA        varchar(30)         not null,
)

GO

ALTER TABLE NIERUCHOMOSC
    ADD CONSTRAINT FK_NIERUCHOMOSC_RODZAJ FOREIGN KEY (RODZAJ) REFERENCES KATEGORIA_NIERUCHOMOSCI (ID_KATEGORIA);

GO

CREATE TABLE NAJEM_INDYWIDUALNY
(
    ID_NAJEM               bigint primary key identity,
    UUID                   varchar(255) unique not null,
    ID_KLIENT_INDYWIDUALNY bigint default null,
    DATA_OD                date                not null,
    DATA_DO                date                not null,
    ID_NIERUCHOMOSC        bigint,
    WIELKOSC_RABATU        decimal(2, 2),
    ID_RACHUNEK            bigint unique,
    ID_STATUS              bigint              not null
)

GO

CREATE TABLE NAJEM_FIRMA
(
    ID_NAJEM        bigint primary key identity,
    UUID            varchar(255) unique not null,
    ID_KLIENT_FIRMA bigint              not null,
    DATA_OD         date                not null,
    DATA_DO         date                not null,
    ID_NIERUCHOMOSC bigint              not null,
    WIELKOSC_RABATU decimal(2, 2),
    ID_FAKTURA      bigint unique,
    ID_STATUS       bigint              not null
)

GO

CREATE TABLE NAJEM_STATUS
(
    ID_STATUS bigint primary key,
    UUID      varchar(255) unique not null,
    NAZWA     varchar(20) unique  not null
)


GO

ALTER TABLE NAJEM_INDYWIDUALNY
    ADD CONSTRAINT FK_NAJEM_IND_STATUS_ID FOREIGN KEY (ID_STATUS) REFERENCES NAJEM_STATUS (ID_STATUS);

ALTER TABLE NAJEM_FIRMA
    ADD CONSTRAINT FK_NAJEM_FIRMA_STATUS_ID FOREIGN KEY (ID_STATUS) REFERENCES NAJEM_STATUS (ID_STATUS);


GO

CREATE TABLE FAKTURA
(
    ID_FAKTURA             bigint primary key identity,
    UUID                   char(255) unique not null,
    ID_NAJEM               bigint unique,
    CENA_NETTO_PO_RABACIE  decimal(30, 2),
    CENA_BRUTTO_PO_RABACIE decimal(30, 2),
    WARTOSC_RABATU_NETTO   decimal(30, 2),
    CZY_OPLACONA           bit default 0
)

GO

CREATE TABLE RACHUNEK
(
    ID_RACHUNEK            bigint primary key identity,
    UUID                   char(255) unique not null,
    ID_NAJEM               bigint unique,
    CENA_NETTO_PO_RABACIE  decimal(30, 2),
    CENA_BRUTTO_PO_RABACIE decimal(30, 2),
    WARTOSC_RABATU_NETTO   decimal(30, 2),
    CZY_OPLACONY           bit default 0
)

GO

ALTER TABLE NAJEM_FIRMA
    ADD CONSTRAINT FK_NAJEM_KLIENT_FIRMA_ID FOREIGN KEY (ID_KLIENT_FIRMA) REFERENCES KLIENT_FIRMA (ID_KLIENT_FIRMA);

ALTER TABLE NAJEM_INDYWIDUALNY
    ADD CONSTRAINT FK_NAJEM_KLIENT_IND_ID FOREIGN KEY (ID_KLIENT_INDYWIDUALNY) REFERENCES KLIENT_INDYWIDUALNY (ID_KLIENT);

ALTER TABLE NAJEM_FIRMA
    ADD CONSTRAINT FK_NAJEM_FIRM_NIERUCHOMOSC_ID FOREIGN KEY (ID_NIERUCHOMOSC) REFERENCES NIERUCHOMOSC (ID_NIERUCHOMOSC);

ALTER TABLE NAJEM_INDYWIDUALNY
    ADD CONSTRAINT FK_NAJEM_IND_NIERUCHOMOSC_ID FOREIGN KEY (ID_NIERUCHOMOSC) REFERENCES NIERUCHOMOSC (ID_NIERUCHOMOSC);

GO

ALTER TABLE NAJEM_FIRMA
    ADD CONSTRAINT FK_NAJEM_FIRMA_FAKTURA FOREIGN KEY (ID_FAKTURA) REFERENCES FAKTURA (ID_FAKTURA);

ALTER TABLE NAJEM_INDYWIDUALNY
    ADD CONSTRAINT FK_NAJEM_IND_RACHUNEK FOREIGN KEY (ID_RACHUNEK) REFERENCES RACHUNEK (ID_RACHUNEK);

GO

CREATE VIEW VIEW_GET_UUID
AS
SELECT NEWID() uuid
GO

GO

CREATE FUNCTION getUUID() RETURNS varchar(255) AS
BEGIN
    DECLARE @UUID uniqueidentifier
    SELECT @UUID = uuid
    FROM VIEW_GET_UUID
    RETURN CONVERT(varchar(255), @UUID);
END

GO






