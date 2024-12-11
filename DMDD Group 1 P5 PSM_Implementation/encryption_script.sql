ALTER TABLE Athlete
ADD EncryptedContactInfo VARBINARY(256);
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'SIMSGroup1DAMG6200';
GO
CREATE CERTIFICATE AthleteCert
WITH SUBJECT = 'Athlete Data Encryption';
GO
CREATE SYMMETRIC KEY AthleteSymmetricKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE AthleteCert;
GO
-- Open the symmetric key
OPEN SYMMETRIC KEY AthleteSymmetricKey
DECRYPTION BY CERTIFICATE AthleteCert;
GO

-- Encrypt the data
UPDATE Athlete
SET EncryptedContactInfo = EncryptByKey(
    Key_GUID('AthleteSymmetricKey'),
    CAST(Ath_Add_ContactInfo AS NVARCHAR(10))
);
GO

-- Close the symmetric key
CLOSE SYMMETRIC KEY AthleteSymmetricKey;
GO

SELECT * FROM Athlete;

-- Open the symmetric key
OPEN SYMMETRIC KEY AthleteSymmetricKey
DECRYPTION BY CERTIFICATE AthleteCert;
GO

-- Query decrypted data
SELECT Ath_Name, 
       CAST(DecryptByKey(EncryptedContactInfo) AS NVARCHAR(10)) AS DecryptedContactInfo
FROM Athlete;
GO

-- Close the symmetric key
CLOSE SYMMETRIC KEY AthleteSymmetricKey;
GO




