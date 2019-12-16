USE MARCIN_NIERUCHOMOSC;

GO

-- GENERUJE UNIKALNY IDENTYFIKATOR DLA KAŻDEGO OBIEKTU W SYSTEMIE UUID - Universally Unique Identifier
-- KORZYSTA Z WIDOKU VIEW_GET_UUID
CREATE FUNCTION getUUID() RETURNS varchar(255) AS
BEGIN
    DECLARE @UUID uniqueidentifier
    SELECT @UUID = uuid
    FROM VIEW_GET_UUID
    RETURN CONVERT(varchar(255), @UUID);
END

GO

DECLARE @SAMPLE_UUID varchar(255);
SET @SAMPLE_UUID = dbo.getUUID();
PRINT (@SAMPLE_UUID);

GO

-- WYZNACZA PROCENT RABATU PRZYSLUGUJACEGO ZA WYNAJEM
-- <= 1 miesiaca - 0%
-- >1 do <=3 miesiace - 5%
-- >3 do <=12 miesiecy - 10%
CREATE FUNCTION FN_ILE_PROCENT_RABATU(@FROM date, @TO date) RETURNS decimal(2, 2) AS
BEGIN
    IF (DATEDIFF(month, @FROM, @TO) <= 1)
        BEGIN
            RETURN 0.00
        END
    IF (DATEDIFF(month, @FROM, @TO) <= 3)
        BEGIN
            RETURN 0.05
        END
    IF (DATEDIFF(month, @FROM, @TO) > 3 AND DATEDIFF(month, @FROM, @TO) <= 12)
        BEGIN
            RETURN 0.10
        END
    IF (DATEDIFF(month, @FROM, @TO) > 12)
        BEGIN
            RETURN 0.15
        END
    RETURN 0.00;
END

GO
-- TEST FUNKCJI RABAT
PRINT (dbo.FN_ILE_PROCENT_RABATU(convert(datetime, '22.10.2016', 104), convert(datetime, '22.12.2017', 104)))

GO

-- FUNKCJA ODPOWIEDZIALNA ZA OBLICZENIE CENY WYNAJMU NETTO - ZASTOSOWANA DO WYNAJEM_INDYWIUDALNY JAK I WYNAJEM_FIRMA NA POTRZEBY RACHUNKU/FAKTURY
CREATE FUNCTION FN_POLICZ_NETTO(@ILE_DNI int, @CENA_DOBA decimal(30, 2)) RETURNS decimal(30, 2) AS
BEGIN
    -- NIE MOŻE BYC 0 DNI - MINUMUM 1 DOBA
    IF (@ILE_DNI = 0)
        BEGIN
            SET @ILE_DNI = 1;
        END
    DECLARE @NETTO decimal(30, 2);
    SET @NETTO = ((@ILE_DNI * @CENA_DOBA));
    RETURN @NETTO;
END

GO

DECLARE @SAMPLE_NETTO decimal(7, 2);
SET @SAMPLE_NETTO = dbo.FN_POLICZ_NETTO(5, 100);
PRINT (@SAMPLE_NETTO);

GO

-- FUNKCJA ODPOWIEDZIALNA ZA OBLICZENIE CENY WYNAJMU BRUTTO - ZASTOSOWANA DO WYNAJEM_INDYWIUDALNY JAK I WYNAJEM_FIRMA NA POTRZEBY RACHUNKU/FAKTURY
CREATE FUNCTION FN_POLICZ_BRUTTO(@NETTO decimal(30, 2)) RETURNS decimal(30, 2) AS
BEGIN
    DECLARE @BRUTTO decimal(30, 2);
    SET @BRUTTO = @NETTO * 1.23;
    RETURN @BRUTTO;
END

GO

DECLARE @SAMPLE_BRUTTO decimal(7, 2);
SET @SAMPLE_BRUTTO = dbo.FN_POLICZ_BRUTTO(500.00);
PRINT (@SAMPLE_BRUTTO);

GO

-- FUNKCJA ODPOWIEDZIALNA ZA OBLICZENIE WARTOSCI RABATU (OD CENY BRUTTO) - ZASTOSOWANA DO WYNAJEM_INDYWIUDALNY JAK I WYNAJEM_FIRMA NA POTRZEBY RACHUNKU/FAKTURY
-- RABAT ODEJMOWANY JEST OD CENNY BRUTTO
CREATE FUNCTION FN_POLICZ_RABAT(@BRUTTO decimal(30, 2), @RABAT decimal(2, 2)) RETURNS decimal(30, 2) AS
BEGIN
    RETURN @BRUTTO * @RABAT;
END

GO

DECLARE @SAMPLE_RABAT decimal(7, 2);
SET @SAMPLE_RABAT = dbo.FN_POLICZ_RABAT(500.00, 0.54);
PRINT (@SAMPLE_RABAT);

GO

-- TEST KALKULACJI CENY
DECLARE @NETTO decimal(30, 2);
DECLARE @BRUTTO decimal(30, 2);
DECLARE @RABAT decimal(30, 2);

SELECT @NETTO = dbo.FN_POLICZ_NETTO(1, 105.00);
SELECT @NETTO AS NETTO;
SELECT @BRUTTO = dbo.FN_POLICZ_BRUTTO(@NETTO);
SELECT @BRUTTO AS BRUTTO;
SELECT @RABAT = dbo.FN_POLICZ_RABAT(@BRUTTO, 0.13);
SELECT @RABAT AS RABAT;



GO

-- FUNCKJA SPRAWDZAJACA CZY DODAWANY TERMIN NAJMU DLA KONKRETNEJ NIERUCHOMOSCI (TABELA: NAJEM_INDTWIDUALNY) JUZ ISTNIEJE
CREATE FUNCTION FN_SPRAWDZ_CZY_WYNAJEM_INDYWIDUALNY_ISTNIEJE(@ID_NIERUCH bigint, @DATA_OD date, @DATA_DO date) RETURNS bit AS
BEGIN
    IF EXISTS(SELECT *
              FROM NAJEM_INDYWIDUALNY
              WHERE NAJEM_INDYWIDUALNY.ID_NIERUCHOMOSC = @ID_NIERUCH
                AND NAJEM_INDYWIDUALNY.DATA_OD >= @DATA_OD
                AND NAJEM_INDYWIDUALNY.DATA_DO <= @DATA_DO)
        BEGIN
            -- NAJEM ISTNIEJE - NIE MOŻNA WYPOZYCZYC DWA RAZY TEJ SAMEJ NIERUCHOMOSCI W TYM SAMYM TERMINIE
            RETURN 1;
        END
    ELSE
        BEGIN
            -- MOŻNA WYPOŻYCZYĆ
            RETURN 0;
        END
    RETURN 0;
END

GO

DECLARE @CZY_MOZNA bit;
SET @CZY_MOZNA = dbo.FN_SPRAWDZ_CZY_WYNAJEM_INDYWIDUALNY_ISTNIEJE(1, CONVERT(date, '20.12.2019', 104),
                                                                  CONVERT(date, '25.12.2019', 104));
SELECT @CZY_MOZNA;

GO

-- FUNCKJA SPRAWDZAJACA CZY DODAWANY TERMIN NAJMU DLA KONKRETNEJ NIERUCHOMOSCI (TABELA: NAJEM_FIRMA) JUZ ISTNIEJE
CREATE FUNCTION FN_SPRAWDZ_CZY_WYNAJEM_FRIMA_ISTNIEJE(@ID_NIERUCH bigint, @DATA_OD date, @DATA_DO date) RETURNS bit AS
BEGIN
    IF EXISTS(SELECT *
              FROM NAJEM_FIRMA
              WHERE NAJEM_FIRMA.ID_NIERUCHOMOSC = @ID_NIERUCH
                AND NAJEM_FIRMA.DATA_OD >= @DATA_OD
                AND NAJEM_FIRMA.DATA_DO <= @DATA_DO)
        BEGIN
            RETURN 1;
        END
    ELSE
        BEGIN
            RETURN 0;
        END
    RETURN 0;
END

GO

-- FUNKCJA TABELARNA
CREATE FUNCTION FN_ZWROC_TABELE_WYNAJEM_INDYWIDUALNY_JOIN_RACHUNEK_BY_NAJEM_ID(@NAJEM_ID bigint)
    RETURNS TABLE AS
        RETURN
            (
                SELECT NI.ID_NAJEM, NI.ID_STATUS, R.CZY_OPLACONY
                FROM NAJEM_INDYWIDUALNY AS NI
                         JOIN RACHUNEK R on NI.ID_RACHUNEK = R.ID_RACHUNEK
                WHERE NI.ID_NAJEM = @NAJEM_ID
            )

GO

-- TEST
SELECT *
FROM dbo.FN_ZWROC_TABELE_WYNAJEM_INDYWIDUALNY_JOIN_RACHUNEK_BY_NAJEM_ID(1);

GO

-- FUNKCJA TABELARNA
CREATE FUNCTION FN_ZWROC_TABELE_WYNAJEM_FIRMA_JOIN_FAKTURA_BY_NAJEM_ID(@NAJEM_ID bigint)
    RETURNS TABLE AS
        RETURN
            (
                SELECT NF.ID_NAJEM, NF.ID_STATUS, F.CZY_OPLACONA
                FROM NAJEM_FIRMA AS NF
                         JOIN FAKTURA F on NF.ID_FAKTURA = F.ID_FAKTURA
                WHERE NF.ID_NAJEM = @NAJEM_ID
            )

GO
-- TEST
SELECT *
FROM dbo.FN_ZWROC_TABELE_WYNAJEM_FIRMA_JOIN_FAKTURA_BY_NAJEM_ID(1);