USE MARCIN_NIERUCHOMOSC;

GO

CREATE VIEW VIEW_GET_UUID
AS
SELECT NEWID() uuid
GO


CREATE FUNCTION getUUID() RETURNS varchar(255) AS
BEGIN
    DECLARE @UUID uniqueidentifier
    SELECT @UUID = uuid
    FROM VIEW_GET_UUID
    RETURN CONVERT(varchar(255), @UUID);
END

GO

CREATE FUNCTION FN_OBLICZ_RABAT(@FROM date, @TO date) RETURNS decimal(2, 2) AS
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
PRINT (dbo.FN_OBLICZ_RABAT(convert(datetime, '22.10.2016', 104), convert(datetime, '22.12.2017', 104)))

GO

-- CREATE FUNCTION FN_UTWORZ_RACHUNEK()