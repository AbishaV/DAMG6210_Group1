--Create index on Atlete Name
CREATE NONCLUSTERED INDEX idx_AthleteName
ON Athlete (Ath_Name);

SELECT name, type_desc
FROM sys.indexes
WHERE object_id = OBJECT_ID('Athlete')
  AND name = 'idx_AthleteName';

CREATE NONCLUSTERED INDEX idx_InjuryType
ON Injury (Injury_Type);

SELECT name, type_desc
FROM sys.indexes
WHERE object_id = OBJECT_ID('Injury')
  AND name = 'idx_InjuryType';

--Create index for the clearance 
CREATE NONCLUSTERED INDEX idx_ClearanceStatus
ON Clearance (ClearanceStatus);

SELECT name, type_desc
FROM sys.indexes
WHERE object_id = OBJECT_ID('Clearance')
  AND name = 'idx_ClearanceStatus';

CREATE NONCLUSTERED INDEX idx_DrugName
ON Drug_Prescription (DrugName);

SELECT name, type_desc
FROM sys.indexes
WHERE object_id = OBJECT_ID('Drug_Prescription')
  AND name = 'idx_DrugName';





