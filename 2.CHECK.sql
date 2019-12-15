USE MARCIN_NIERUCHOMOSC;

---------------------------------------------   6A ----------------------------------------------

GO

-- sprawdza czy data wypozyczenia dla KLIENTA INDYWIDUALNEGO OD jest pozniej niż dzis lub ta sama co dzis
ALTER TABLE NAJEM_INDYWIDUALNY
    ADD CONSTRAINT CHECK_IND_DATA_OD CHECK (DATA_OD >= GETDATE());

GO

-- psrawdza czy data wypozyczenia dla KLIENTA FIRMY jest w przyszlości (cos jak to wyzej)
ALTER TABLE NAJEM_FIRMA
    ADD CONSTRAINT CHECK_FIRMA_DATA_OD CHECK (DATA_OD >= GETDATE());

GO

-- sprawdza czy dlugosc PESEl to dokładnie 11 znaków
ALTER TABLE KLIENT_INDYWIDUALNY
    ADD CONSTRAINT CHECK_PESEL CHECK (LEN(PESEL) = 11);

GO

-- sprawdza czy NIP to dokladnie 10 znakow
ALTER TABLE KLIENT_FIRMA
    ADD CONSTRAINT CHECK_NIP CHECK (LEN(NIP) = 10);

GO

-- sprawdza czy kod pocztowy to dokladnie 6 znakow -> przyjeta forma: 11-234
ALTER TABLE KLIENT_FIRMA
    ADD CONSTRAINT CHECK_FIRMA_KOD_POCZTOWY CHECK (LEN(KOD_POCZTOWY) = 6);

GO

-- to samo co wyżej tylko na tabeli KLIENT_INDYWIDUALNY
ALTER TABLE KLIENT_INDYWIDUALNY
    ADD CONSTRAINT CHECK_IND_KOD_POCZTOWY CHECK (LEN(KOD_POCZTOWY) = 6);

GO

-- to samo tylko kod pocztowy nieruchomosci
ALTER TABLE NIERUCHOMOSC
    ADD CONSTRAINT CHECK_NIERUCHOMOSC_KOD_POCZTOWY CHECK (LEN(KOD_POCZTOWY) = 6);

GO


---------------------------------------------   6A ----------------------------------------------