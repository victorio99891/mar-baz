USE MARCIN_NIERUCHOMOSC;

GO

-- PROCEDURA PO KTOREJ WYWOLANIU WYKONYWANIE SKRYPTU JEST ZATRZYMYWANE I POBIERANY JEST BLAD I JEGO SZCZEGOLY
CREATE PROCEDURE FN_ERROR_HANDLER
AS
SELECT ERROR_NUMBER()    AS ErrorNumber
     , ERROR_SEVERITY()  AS ErrorSeverity
     , ERROR_STATE()     AS ErrorState
     , ERROR_PROCEDURE() AS ErrorProcedure
     , ERROR_LINE()      AS ErrorLine
     , ERROR_MESSAGE()   AS ErrorMessage;
GO

-- TEST

begin try
    IF (1 < 2)
        BEGIN
            RAISERROR ('Tutaj jest informacja o bledzie!',16,1);
        END
end try
begin catch
    EXEC FN_ERROR_HANDLER
end catch
