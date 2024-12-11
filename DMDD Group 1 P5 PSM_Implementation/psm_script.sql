----------------------------------------------------------------------------------------------------------------------
--PSM
----------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------
--Stored Procedures
----------------------------------------------------------------------------------------------------------------------
/*
--1.
-- Stored Procedure to Update Athlete's Treatment Progress
CREATE PROCEDURE sp_UpdateTreatmentProgress
    @TreatmentID INT,          
    @InjuryID INT,             
    @NewProgress VARCHAR(50),   
    @ProgressNotes TEXT,       
    @IsCompleted BIT,          
    @UpdatedByProviderID INT,   
    @UpdateSuccess BIT OUTPUT   
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validate required parameters
    IF @NewProgress NOT IN ('Initial', 'Improving', 'Stable', 'Advanced')
    BEGIN
        RAISERROR ('Invalid progress status. Must be: Initial, Improving, Stable, or Advanced', 16, 1);
        RETURN;
    END

    IF @ProgressNotes IS NULL OR DATALENGTH(@ProgressNotes) = 0
    BEGIN
        RAISERROR ('Progress notes are required', 16, 1);
        RETURN;
    END

    PRINT '=== Input Parameter Requirements ==='
    PRINT '1. Treatment ID: Must be valid Treatment ID'
    PRINT '2. Injury ID: Must be valid Injury ID'
    PRINT '3. Progress Status: Must be [Initial/Improving/Stable/Advanced]'
    PRINT '4. Progress Notes: Required - Enter detailed observations'
    PRINT '5. Is Completed: Enter 1=Complete, 0=Ongoing'
    PRINT '6. Provider ID: Must be valid Provider ID'
    PRINT '=================================='

    BEGIN TRY
        BEGIN TRANSACTION;
            -- Update treatment progress
            UPDATE Treatment_Injury
            SET InjuryTreatmentProgress = @NewProgress,
                InjuryTreatmentNotes = @ProgressNotes,
                Outcome = CASE 
                    WHEN @IsCompleted = 1 THEN 'Completed'
                    ELSE 'In Progress'
                END
            WHERE Treatment_ID = @TreatmentID 
            AND Injury_ID = @InjuryID;
            
            PRINT 'Treatment progress updated to: ' + @NewProgress;

            -- Update treatment record using CONVERT for text concatenation
            UPDATE Treatment
            SET Notes = CONVERT(TEXT, 
                              CASE 
                                  WHEN Notes IS NULL THEN ''
                                  ELSE CONVERT(VARCHAR(MAX), Notes) + CHAR(13) + CHAR(10)
                              END + 
                              'Updated on ' + CONVERT(VARCHAR, GETDATE()) + ': ' + 
                              CONVERT(VARCHAR(MAX), @ProgressNotes))
            WHERE Treatment_ID = @TreatmentID;
            
            PRINT 'Treatment notes appended with new progress information';

            -- Update injury status if completed
            IF @IsCompleted = 1
            BEGIN
                UPDATE Injury
                SET Recovery_Status = 'Recovered'
                WHERE Injury_ID = @InjuryID;
                
                PRINT 'Injury status marked as Recovered';
            END

            SET @UpdateSuccess = 1;
            
        COMMIT TRANSACTION;

        -- Print Summary of Changes
        PRINT '=== Treatment Update Summary ==='
        PRINT 'Treatment ID: ' + CAST(@TreatmentID AS VARCHAR)
        PRINT 'Injury ID: ' + CAST(@InjuryID AS VARCHAR)
        PRINT 'New Progress Status: ' + @NewProgress
        PRINT 'Updated By Provider: ' + CAST(@UpdatedByProviderID AS VARCHAR)
        PRINT 'Treatment Status: ' + CASE @IsCompleted 
                                      WHEN 1 THEN 'Completed'
                                      ELSE 'In Progress' END
        PRINT 'Update Timestamp: ' + CONVERT(VARCHAR, GETDATE())
        PRINT 'Update Status: SUCCESS'
        PRINT '=============================='

    END TRY
    BEGIN CATCH
        SET @UpdateSuccess = 0;
        ROLLBACK TRANSACTION;
        PRINT 'ERROR DETAILS:'
        PRINT 'Error Message: ' + ERROR_MESSAGE()
        PRINT 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR)
        PRINT 'Update Status: FAILED'
        RAISERROR ('Error occurred during treatment update', 16, 1);
    END CATCH;
END;

-- Query to run the Stored Procedure

--check tables before update
select * from Treatment_Injury;
select * from Treatment;
select * from Injury;

DECLARE @Success BIT;
EXEC sp_UpdateTreatmentProgress 
    @TreatmentID = 6,
    @InjuryID = 6,
    @NewProgress = 'Initial',
    @ProgressNotes = 'Patient showing good improvement in mobility, will need more care',
    @IsCompleted = 0,
    @UpdatedByProviderID = 4,
    @UpdateSuccess = @Success OUTPUT;

SELECT @Success as UpdateStatus;


-- check tables after updation
SELECT * FROM Treatment_Injury WHERE Treatment_ID = 6 AND Injury_ID = 6;
SELECT * FROM Treatment WHERE Treatment_ID = 6;
SELECT * FROM Injury WHERE Injury_ID = 6;

*/
----------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------
/*
--2.
-- Stored Procedure to Update Athlete Clearance
CREATE PROCEDURE sp_UpdateAthleteClearance
   @AthleteID INT,           -- Input: Enter Athlete ID number
   @HealthProviderID INT,     -- Input: Enter Healthcare Provider ID number 
   @ClearanceStatus VARCHAR(50), -- Input: Enter 'Cleared', 'Not Cleared', or 'Conditional'
   @Notes TEXT,              -- Input: Enter any notes about the clearance
   @RequiresFollowUp BIT,    -- Input: Enter 1 for Yes, 0 for No
   @NextEvalDate DATE = NULL, -- Input: Enter next evaluation date if follow-up required (YYYY-MM-DD)
   @ClearanceID INT OUTPUT   -- Output: Will return the new Clearance ID
AS
BEGIN
   -- Print input parameter requirements
   PRINT 'Required Inputs:'
   PRINT '---------------'
   PRINT '1. Athlete ID: Must be valid ID from Athlete table'
   PRINT '2. Healthcare Provider ID: Must be valid ID from HealthProvider table'  
   PRINT '3. Clearance Status: Must be "Cleared", "Not Cleared", or "Conditional"'
   PRINT '4. Notes: Enter relevant clearance notes'
   PRINT '5. Requires Follow-up: Enter 1 for Yes, 0 for No'
   PRINT '6. Next Evaluation Date: Required if Follow-up is Yes (Format: YYYY-MM-DD)'

   BEGIN TRY
       BEGIN TRANSACTION;
           -- Insert new clearance record
           INSERT INTO Clearance (AthleteID, HealthProviderID, ClearanceDate, ClearanceStatus, ClearanceNotes)
           VALUES (@AthleteID, @HealthProviderID, GETDATE(), @ClearanceStatus, @Notes);

           SET @ClearanceID = SCOPE_IDENTITY();
           PRINT 'New Clearance record created with ID: ' + CAST(@ClearanceID AS VARCHAR);

           -- Insert into AthleteClearance
           INSERT INTO AthleteClearance (AthleteID, ClearanceID, ClearanceType)
           VALUES (@AthleteID, @ClearanceID,
                  CASE @ClearanceStatus
                      WHEN 'Cleared' THEN 'Full Clearance'
                      WHEN 'Not Cleared' THEN 'Medical Hold'
                      ELSE 'Conditional Clearance'
                  END);
           PRINT 'Athlete Clearance record added for Athlete ID: ' + CAST(@AthleteID AS VARCHAR);

           -- Insert follow-up if required
           IF @RequiresFollowUp = 1
           BEGIN
               IF @NextEvalDate IS NULL
                   THROW 50001, 'Next evaluation date is required when follow-up is needed', 1;
               
               INSERT INTO Follow_Up (AthleteID, ClearanceID, Follow_UpRequired, Next_Eval_Date)
               VALUES (@AthleteID, @ClearanceID, 1, @NextEvalDate);
               PRINT 'Follow-up scheduled for: ' + CAST(@NextEvalDate AS VARCHAR);
           END
           ELSE
           BEGIN
               PRINT 'No follow-up required for this clearance';
           END

       COMMIT TRANSACTION;
       PRINT '-----------------------------'
       PRINT 'Clearance update completed successfully'
       PRINT 'New Clearance ID: ' + CAST(@ClearanceID AS VARCHAR)
       PRINT 'Status: ' + @ClearanceStatus
       PRINT 'Follow-up Required: ' + CASE @RequiresFollowUp WHEN 1 THEN 'Yes' ELSE 'No' END
   END TRY
   BEGIN CATCH
       ROLLBACK TRANSACTION;
       PRINT 'Error occurred: ' + ERROR_MESSAGE();
       THROW;
   END CATCH;
END;

--Query to run the stored Procedure - Update Athlete Clearance
select * from Follow_Up

DECLARE @OutputClearanceID INT;

EXEC sp_UpdateAthleteClearance
   @AthleteID = 2,                  -- Existing Athlete ID
   @HealthProviderID = 2,           -- Existing Health Provider ID
   @ClearanceStatus = 'Cleared',    -- Status
   @Notes = 'Annual physical clearance for basketball season',
   @RequiresFollowUp = 1,           -- Yes, requires follow-up
   @NextEvalDate = '2024-04-16',    -- Next evaluation date
   @ClearanceID = @OutputClearanceID OUTPUT;

-- Print the output ClearanceID
SELECT @OutputClearanceID as NewClearanceID;

select * from Follow_Up
*/
----------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------
/*
--3.
-- Stored Procedure to Manage Follow Up Scheduling
CREATE PROCEDURE sp_ManageFollowUpScheduling
    @AthleteID INT,
    @ClearanceID INT,
    @NewEvalDate DATE,
    @UpdateReason VARCHAR(255),
    @HealthProviderID INT,
    @IsUrgent BIT = 0,
    @SchedulingSuccess BIT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Input Validation Prints
    PRINT 'Input Parameters:';
    PRINT 'AthleteID: ' + ISNULL(CONVERT(VARCHAR(10), @AthleteID), 'NULL') + 
           ' (Required: Unique Identifier for the Athlete)';
    PRINT 'ClearanceID: ' + ISNULL(CONVERT(VARCHAR(10), @ClearanceID), 'NULL') + 
           ' (Required: Unique Identifier for Medical Clearance)';
    PRINT 'NewEvalDate: ' + ISNULL(CONVERT(VARCHAR(10), @NewEvalDate, 120), 'NULL') + 
           ' (Required: Future Date for Next Medical Evaluation)';
    PRINT 'UpdateReason: ' + ISNULL(@UpdateReason, 'NULL') + 
           ' (Required: Description for Follow-up Scheduling)';
    PRINT 'HealthProviderID: ' + ISNULL(CONVERT(VARCHAR(10), @HealthProviderID), 'NULL') + 
           ' (Required: Identifier for Health Provider)';
    PRINT 'IsUrgent: ' + ISNULL(CONVERT(VARCHAR(1), @IsUrgent), 'NULL') + 
           ' (Optional: Indicates Urgency of Follow-up, Default: 0)';

    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    BEGIN TRY
        BEGIN TRANSACTION;
            -- Update or insert follow-up record
            IF EXISTS (SELECT 1 FROM Follow_Up WHERE AthleteID = @AthleteID AND ClearanceID = @ClearanceID)
            BEGIN
                UPDATE Follow_Up
                SET Next_Eval_Date = @NewEvalDate,
                    Follow_UpRequired = 1
                WHERE AthleteID = @AthleteID 
                AND ClearanceID = @ClearanceID;
            END
            ELSE
            BEGIN
                INSERT INTO Follow_Up (AthleteID, ClearanceID, Follow_UpRequired, Next_Eval_Date)
                VALUES (@AthleteID, @ClearanceID, 1, @NewEvalDate);
            END

            -- Update clearance notes using CAST
            UPDATE Clearance
            SET ClearanceNotes = CAST(
                CAST(ClearanceNotes AS VARCHAR(MAX)) + 
                CHAR(13) + CHAR(10) + 
                'Follow-up scheduled for ' + CONVERT(VARCHAR(10), @NewEvalDate) + 
                CASE WHEN @IsUrgent = 1 THEN ' (URGENT)' ELSE '' END +
                ': ' + @UpdateReason 
            AS TEXT)
            WHERE ClearanceID = @ClearanceID;

            SET @SchedulingSuccess = 1;

            -- Output Result Print
            PRINT 'Output Parameter:';
            PRINT 'SchedulingSuccess: ' + CONVERT(VARCHAR(1), @SchedulingSuccess) + 
                   ' (1 = Successful Follow-up Scheduling, 0 = Scheduling Failed)';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        SET @SchedulingSuccess = 0;
        
        -- Capture error information
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        ROLLBACK TRANSACTION;

        -- Raise the error
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;


--Query to run the Stored Procedure Manage Follow Up Scheduling
SELECT * FROM Follow_Up;
SELECT * FROM Clearance;

DECLARE @AthleteID INT = 8,  -- Actual Athlete ID from Athletes table
        @ClearanceID INT = 8,  -- Actual Clearance ID from Clearance table
        @NewEvalDate DATE = '2024-12-31',  -- Future evaluation date
        @UpdateReason VARCHAR(255) = 'Routine follow-up evaluation',
        @HealthProviderID INT = 1,  -- Actual Health Provider ID
        @IsUrgent BIT = 0,  -- 0 for non-urgent, 1 for urgent
        @SchedulingSuccess BIT;

EXEC sp_ManageFollowUpScheduling 
    @AthleteID,
    @ClearanceID,
    @NewEvalDate,
    @UpdateReason,
    @HealthProviderID,
    @IsUrgent,
    @SchedulingSuccess OUTPUT;

-- Display the result
SELECT @SchedulingSuccess AS SchedulingSuccess;

SELECT * FROM Follow_Up WHERE ClearanceID = 8;
SELECT ClearanceNotes FROM Clearance WHERE ClearanceID = 8;

*/
----------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------
/*
-- 4.
-- Stored Procedure Manage Prescriptions Changes 
CREATE PROCEDURE sp_ManagePrescriptionChanges
   @PrescriptionID INT,
   @NewDosage VARCHAR(50) = NULL,
   @NewFrequency VARCHAR(50) = NULL, 
   @ExtendDays INT = NULL,
   @DiscontinueEarly BIT = 0,
   @ChangeNotes TEXT,
   @HealthProviderID INT,
   @ChangeSuccess BIT OUTPUT
AS
BEGIN
   SET NOCOUNT ON;

   PRINT '=== Required Inputs ==='
   PRINT '@PrescriptionID: Enter prescription identifier number'
   PRINT '@ChangeNotes: Enter notes explaining prescription changes'
   PRINT '@HealthProviderID: Enter healthcare provider''s ID number'
   PRINT ''
   PRINT '=== Optional Inputs ==='
   PRINT '@NewDosage: Enter new dosage (e.g. ''500mg'')'
   PRINT '@NewFrequency: Enter new frequency (e.g. ''Twice daily'')'
   PRINT '@ExtendDays: Enter number of days to extend prescription'
   PRINT '@DiscontinueEarly: Enter 1 to end prescription today, 0 to maintain current end date'
   PRINT '@ChangeSuccess: Returns 1 if successful, 0 if failed'
   PRINT ''

   BEGIN TRY
       BEGIN TRANSACTION;
           DECLARE @CurrentEndDate DATE;
           
           SELECT @CurrentEndDate = EndDate 
           FROM Drug_Prescription 
           WHERE Prescription_ID = @PrescriptionID;

           UPDATE Drug_Prescription
           SET Dosage = ISNULL(@NewDosage, Dosage),
               Frequency = ISNULL(@NewFrequency, Frequency),
               EndDate = CASE 
                   WHEN @DiscontinueEarly = 1 THEN GETDATE()
                   WHEN @ExtendDays IS NOT NULL THEN DATEADD(DAY, @ExtendDays, @CurrentEndDate)
                   ELSE EndDate
               END,
               Prescription_Notes = CAST(
                   (SELECT ISNULL(CAST(Prescription_Notes AS VARCHAR(MAX)), '') + 
                   CHAR(13) + CHAR(10) + 
                   'Modified on ' + CONVERT(VARCHAR, GETDATE()) + ': ' + 
                   CAST(@ChangeNotes AS VARCHAR(MAX))
                   FROM Drug_Prescription 
                   WHERE Prescription_ID = @PrescriptionID) AS TEXT)
           WHERE Prescription_ID = @PrescriptionID
           AND HealthProvider_ID = @HealthProviderID;

           PRINT '=== Changes Summary ==='
           PRINT 'Prescription ID: ' + CAST(@PrescriptionID AS VARCHAR(10))
           IF @NewDosage IS NOT NULL PRINT 'New Dosage: ' + @NewDosage
           IF @NewFrequency IS NOT NULL PRINT 'New Frequency: ' + @NewFrequency
           IF @ExtendDays IS NOT NULL PRINT 'Extended by: ' + CAST(@ExtendDays AS VARCHAR(5)) + ' days'
           IF @DiscontinueEarly = 1 PRINT 'Prescription discontinued early'
           
           SET @ChangeSuccess = 1;
       COMMIT TRANSACTION;
   END TRY
   BEGIN CATCH
       SET @ChangeSuccess = 0;
       ROLLBACK TRANSACTION;
       THROW;
   END CATCH;
END;
*/
/*
--Query to run the stored procedure - manage prescriptions changes
-- Check existing prescriptions
SELECT Prescription_ID, HealthProvider_ID, Dosage, Frequency, EndDate
FROM Drug_Prescription;

-- Execute example:
DECLARE @Success BIT;
EXEC sp_ManagePrescriptionChanges 
   @PrescriptionID = 7,
   @NewDosage = '100mg', 
   @NewFrequency = '4 times a day, daily',
   @ExtendDays = 30,
   @DiscontinueEarly = 0,
   @ChangeNotes = 'Updated dosage and extended prescription',
   @HealthProviderID = 7,
   @ChangeSuccess = @Success OUTPUT;

-- Check if successful
SELECT @Success AS 'Change Successful';

SELECT * FROM Drug_Prescription 
WHERE Prescription_ID = 7 ;

SELECT * FROM Drug_Prescription;
*/
----------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------
-- USER DEFINED FUNCTIONS
----------------------------------------------------------------------------------------------------------------------/*


----------------------------------------------------------------------------------------------------------------------
/*
--1.
-- UDF - Get Latest Health Report

CREATE FUNCTION dbo.GetLatestHealthReport(@AthleteID INT)
RETURNS TABLE
AS
RETURN (
    SELECT TOP 1 VitalSigns, HealthNotes, ReportDate
    FROM Health_Report
    WHERE AthleteID = @AthleteID
    ORDER BY ReportDate DESC
)


--Query to run the UDF - Get Latest Health Report
SELECT 
    a.AthleteID,
    a.Ath_Name,
    report.VitalSigns,
    report.HealthNotes,
    report.ReportDate
FROM 
    Athlete a
CROSS APPLY 
    dbo.GetLatestHealthReport(a.AthleteID) AS report;

*/
----------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------
/*
--2.
-- UDF - Check Athlete Clearance 
CREATE FUNCTION dbo.IsAthleteClearedForPlay(@AthleteID INT)
RETURNS BIT
AS
BEGIN
    RETURN CASE 
        WHEN EXISTS (
            SELECT 1 
            FROM Clearance 
            WHERE AthleteID = @AthleteID 
            AND CAST(ClearanceStatus AS VARCHAR(MAX)) = 'Cleared'
        ) THEN 1
        ELSE 0
    END
END



-- Query for running the UDF - Check Athlete Clearance 
-- Show only cleared athletes
SELECT 
    a.AthleteID,
    a.Ath_Name,
    a.Ath_SportTeam,
    c.ClearanceDate
FROM Athlete a
LEFT JOIN Clearance c ON a.AthleteID = c.AthleteID
WHERE dbo.IsAthleteClearedForPlay(a.AthleteID) = 1
ORDER BY a.AthleteID;

-- Show only non-cleared athletes
SELECT 
    a.AthleteID,
    a.Ath_Name,
    a.Ath_SportTeam,
    c.ClearanceDate
FROM Athlete a
LEFT JOIN Clearance c ON a.AthleteID = c.AthleteID
WHERE dbo.IsAthleteClearedForPlay(a.AthleteID) = 0
ORDER BY a.AthleteID;


-- More detailed view including clearance details
SELECT 
    a.AthleteID,
    a.Ath_Name,
    a.Ath_SportTeam,
    CASE 
        WHEN dbo.IsAthleteClearedForPlay(a.AthleteID) = 1 THEN 'Cleared'
        ELSE 'Not Cleared'
    END AS ClearanceStatus,
    c.ClearanceDate,
    c.ClearanceNotes
FROM Athlete a
LEFT JOIN Clearance c ON a.AthleteID = c.AthleteID
ORDER BY a.AthleteID;

*/
----------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------
/*
--3.
-- UDF - Calculate BMI
CREATE FUNCTION CalculateBMI (@Weight FLOAT, @Height FLOAT)
RETURNS FLOAT
AS
BEGIN
    RETURN (@Weight / POWER(@Height * 0.0254, 2));
END;
*/



/*
--Query to run UDF - Calculate BMI

-- Declare a variable to hold the input for AthleteID
DECLARE @AthleteID INT;

-- Set the value of AthleteID (this is where you can input the desired AthleteID)
SET @AthleteID = 1;  -- Replace 1 with the actual AthleteID you want to use

DECLARE @AthleteName NVARCHAR(100);
DECLARE @Weight FLOAT;
DECLARE @Height FLOAT;
DECLARE @BMI FLOAT;

-- Retrieve athlete's details for the given AthleteID
SELECT 
    @AthleteName = a.Ath_Name,
    @Weight = a.Ath_Weight,
    @Height = a.Ath_Height,
    @BMI = dbo.CalculateBMI(a.Ath_Weight, a.Ath_Height)
FROM 
    Athlete a
WHERE 
    a.AthleteID = @AthleteID;

-- Check if the athlete exists, and if so, print their details as a message
IF @AthleteName IS NOT NULL
BEGIN
    PRINT 'Athlete Name: ' + @AthleteName + 
          ', Weight: ' + CAST(@Weight AS NVARCHAR(10)) + ' kg' + 
          ', Height: ' + CAST(@Height AS NVARCHAR(10)) + ' meters' + 
          ', BMI: ' + CAST(@BMI AS NVARCHAR(10));
END
ELSE
BEGIN
    PRINT 'No athlete found with the specified AthleteID: ' + CAST(@AthleteID AS NVARCHAR(10));
END
*/
----------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------
/*
-- 4.
-- UDF - Calculate Age 
CREATE FUNCTION dbo.CalculateAthleteAge(@DOB DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @DOB, GETDATE()) - 
           CASE 
               WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR 
                    (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE()))
               THEN 1 
               ELSE 0 
           END
END
*/

/*
--Query to run UDF - Calculate Age


--Result in a table
--Find athletes in different age 

SELECT 
    CASE 
        WHEN dbo.CalculateAthleteAge(Ath_DOB) < 20 THEN 'Under 20'
        WHEN dbo.CalculateAthleteAge(Ath_DOB) BETWEEN 20 AND 25 THEN '20-25'
        WHEN dbo.CalculateAthleteAge(Ath_DOB) BETWEEN 26 AND 30 THEN '26-30'
        ELSE 'Over 30'
    END AS AgeGroup,
    COUNT(*) AS AthleteCount,
    STRING_AGG(Ath_Name, ', ') AS Athletes,
    STRING_AGG(Ath_SportTeam, ', ') AS Sports
FROM Athlete
GROUP BY 
    CASE 
        WHEN dbo.CalculateAthleteAge(Ath_DOB) < 20 THEN 'Under 20'
        WHEN dbo.CalculateAthleteAge(Ath_DOB) BETWEEN 20 AND 25 THEN '20-25'
        WHEN dbo.CalculateAthleteAge(Ath_DOB) BETWEEN 26 AND 30 THEN '26-30'
        ELSE 'Over 30'
    END
ORDER BY AgeGroup;

--for groups

DECLARE @AgeGroup VARCHAR(20)
DECLARE @Count INT
DECLARE @Athletes VARCHAR(MAX)
DECLARE @Sports VARCHAR(MAX)

DECLARE age_cursor CURSOR FOR
SELECT 
    CASE 
        WHEN dbo.CalculateAthleteAge(Ath_DOB) < 20 THEN 'Under 20'
        WHEN dbo.CalculateAthleteAge(Ath_DOB) BETWEEN 20 AND 25 THEN '20-25'
        WHEN dbo.CalculateAthleteAge(Ath_DOB) BETWEEN 26 AND 30 THEN '26-30'
        ELSE 'Over 30'
    END AS AgeGroup,
    COUNT(*) AS AthleteCount,
    STRING_AGG(Ath_Name, ', ') AS Athletes,
    STRING_AGG(Ath_SportTeam, ', ') AS Sports
FROM Athlete
GROUP BY 
    CASE 
        WHEN dbo.CalculateAthleteAge(Ath_DOB) < 20 THEN 'Under 20'
        WHEN dbo.CalculateAthleteAge(Ath_DOB) BETWEEN 20 AND 25 THEN '20-25'
        WHEN dbo.CalculateAthleteAge(Ath_DOB) BETWEEN 26 AND 30 THEN '26-30'
        ELSE 'Over 30'
    END;

OPEN age_cursor;

FETCH NEXT FROM age_cursor INTO @AgeGroup, @Count, @Athletes, @Sports;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT '----------------------------------------';
    PRINT 'Age Group: ' + @AgeGroup;
    PRINT 'Count: ' + CAST(@Count AS VARCHAR);
    PRINT 'Athletes: ' + @Athletes;
    PRINT 'Sports: ' + @Sports;
    
    FETCH NEXT FROM age_cursor INTO @AgeGroup, @Count, @Athletes, @Sports;
END

CLOSE age_cursor;
DEALLOCATE age_cursor;

*/
----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------
/*
--5.
-- UDF - Get CLean Address
CREATE FUNCTION FormatAddress (
    @Street NVARCHAR(100), 
    @Apt NVARCHAR(10), 
    @City NVARCHAR(50), 
    @State NVARCHAR(2), 
    @Zip NVARCHAR(10)
)
RETURNS NVARCHAR(200)
AS
BEGIN
    RETURN CONCAT(
        @Street, 
        ISNULL(CONCAT(', Apt ', @Apt), ''), 
        ', ', 
        @City, ', ', 
        @State, ' ', 
        @Zip
    );
END;
*/
/*
--Query to run UDF - Get Clean Address
SELECT 
    AthleteID, 
    dbo.FormatAddress(Ath_Add_Street, Ath_Add_Apt, Ath_Add_City, Ath_Add_State, Ath_Add_Zip) AS FormattedAddress
FROM 
    Athlete
WHERE 
    AthleteID = 1; 
*/

----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
/*
--6.
-- UDF - Get Athlete Details
CREATE FUNCTION GetAthleteDetails (@AthleteID INT)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    RETURN (
        SELECT CONCAT(
            Ath_Name, ', ', 
            Ath_Gender, ', DOB: ', 
            FORMAT(Ath_DOB, 'yyyy-MM-dd'), ', Address: ', 
            dbo.FormatAddress(Ath_Add_Street, Ath_Add_Apt, Ath_Add_City, Ath_Add_State, Ath_Add_Zip)
        )
        FROM Athlete
        WHERE AthleteID = @AthleteID
    );
END;
*/
/*
--Query1 to run UDF - Get Athlete Details 
SELECT dbo.GetAthleteDetails(1) AS AthleteDetails;

DECLARE @AthleteDetails NVARCHAR(MAX);

-- Get the athlete details
SET @AthleteDetails = dbo.GetAthleteDetails(1);  -- Replace 1 with the desired AthleteID

-- Print the result as a message
PRINT @AthleteDetails;
*/
/*
--Query2 to run UDF - Get Athlete Details 
--For multiple Athletes

DECLARE @AthleteID INT;
DECLARE @AthleteDetails NVARCHAR(MAX);

-- Declare a cursor to fetch AthleteID from Athlete table
DECLARE athlete_cursor CURSOR FOR
SELECT AthleteID
FROM Athlete;

-- Open the cursor
OPEN athlete_cursor;

-- Fetch the first row
FETCH NEXT FROM athlete_cursor INTO @AthleteID;

-- Loop through all rows
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Get athlete details for the current AthleteID
    SET @AthleteDetails = dbo.GetAthleteDetails(@AthleteID);
    
    -- Print the athlete details as a message
    PRINT 'Athlete ID: ' + CAST(@AthleteID AS VARCHAR) + ' - ' + @AthleteDetails;

    -- Fetch the next row
    FETCH NEXT FROM athlete_cursor INTO @AthleteID;
END;

-- Close and deallocate the cursor
CLOSE athlete_cursor;
DEALLOCATE athlete_cursor;

*/
-----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------
/*
--7.
--UDF - Check for Follow Up
CREATE FUNCTION dbo.NeedsFollowUp(@AthleteID INT)
RETURNS BIT
AS
BEGIN
    RETURN CASE 
        WHEN EXISTS (
            SELECT 1 
            FROM Follow_Up 
            WHERE AthleteID = @AthleteID 
            AND Follow_UpRequired = 1
            AND Next_Eval_Date >= GETDATE()
        ) THEN 1
        ELSE 0
    END
END
*/

/*
--Query to run UDF - Check For Follow Up
SELECT 
    AthleteID,
    CASE 
        WHEN dbo.NeedsFollowUp(AthleteID) = 1 THEN 'Follow-up Needed'
        ELSE 'Follow-up Not Needed'
    END AS FollowUpStatus
FROM 
    Athlete
WHERE 
    AthleteID = 1;
*/
-----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------
--VIEWS
-----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------

--View 1: Athlete Injury Report
--This view provides a report on athletes, their injuries, and the physician details.
/*
CREATE VIEW AthleteInjuryReport AS
SELECT 
    a.Ath_Name,
    a.Ath_SportTeam,
    i.Injury_Type,
    i.Injury_Date,
    i.Severity,
    i.TreatmentPlan,
    i.Recovery_Status,
    hp.HP_Name AS Physician,
    hp.HP_ContactInfo AS PhysicianContact
FROM 
    Athlete a
JOIN 
    Injury i ON a.AthleteID = i.Athlete_ID  
JOIN 
    HealthProvider hp ON i.Athlete_ID = hp.HealthProviderID;
*/
--Select * from AthleteInjuryReport;

-----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------
--View 2: Athlete Treatment History
--This view shows the treatment history for athletes, including details about injuries, treatments, and outcomes.
/*
CREATE VIEW AthleteTreatmentHistory AS
SELECT 
    a.Ath_Name,
    a.Ath_SportTeam,
    i.Injury_Type,
    t.TreatmentType,
    t.TreatmentAddedDate,
    t.Notes AS TreatmentNotes,
    ti.InjuryTreatmentProgress,
    ti.Outcome AS TreatmentOutcome
FROM 
    Athlete a
JOIN 
    Injury i ON a.AthleteID = i.Athlete_ID  -- Corrected column name to AthleteID
JOIN 
    Treatment_Injury ti ON i.Injury_ID = ti.Injury_ID
JOIN 
    Treatment t ON ti.Treatment_ID = t.Treatment_ID;
*/
--Select * from AthleteTreatmentHistory;

-----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------
--View 3:Athlete's Most Frequent Injury Type
--This view identifies the most frequent injury type for each athlete, which can be helpful for understanding recurring issues.
/*
CREATE VIEW AthleteMostFrequentInjury AS
SELECT 
    a.AthleteID,
    a.Ath_Name,
    i.Injury_Type,
    COUNT(i.Injury_ID) AS InjuryCount
FROM 
    Athlete a
JOIN 
    Injury i ON a.AthleteID = i.Athlete_ID
GROUP BY 
    a.AthleteID, a.Ath_Name, i.Injury_Type;
*/
/*
SELECT * 
FROM AthleteMostFrequentInjury
ORDER BY InjuryCount DESC;
*/

-----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------
--View 4: Clearance Status and Health Provider Association
--This view links athletes’ clearance statuses with the health provider who issued the clearance.
/*
CREATE VIEW AthleteClearanceHealthProvider AS
SELECT 
    a.AthleteID,
    a.Ath_Name,
    c.ClearanceDate,
    c.ClearanceStatus,
    c.ClearanceNotes,
    hp.HP_Name AS HealthProviderName
FROM 
    Athlete a
JOIN 
    Clearance c ON a.AthleteID = c.AthleteID
JOIN 
    HealthProvider hp ON c.HealthProviderID = hp.HealthProviderID;
*/
--Select * from AthleteClearanceHealthProvider;

-----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------
--View 5: Injury Recovery and Follow-up Requirements
--This view tracks recovery status of athletes and whether a follow-up is required for their injuries.
/*
CREATE VIEW AthleteInjuryRecoveryFollowUp AS
SELECT 
    a.AthleteID,
    a.Ath_Name,
    i.Injury_Type,
    i.Injury_Date,
    i.Recovery_Status,
    f.Follow_UpRequired,
    f.Next_Eval_Date
FROM 
    Athlete a
JOIN 
    Injury i ON a.AthleteID = i.Athlete_ID
LEFT JOIN 
    Follow_Up f ON a.AthleteID = f.AthleteID AND i.Injury_ID = f.ClearanceID;
*/
--Select * from AthleteInjuryRecoveryFollowUp;

-----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------
--View 6: Drug Prescriptions by Health Provider
--This view tracks drug prescriptions for athletes, showing which health providers prescribed the medications.
/*
CREATE VIEW DrugPrescriptionsByHealthProvider AS
SELECT 
    dp.Prescription_ID,
    dp.Athlete_ID,
    dp.DrugName,
    dp.Dosage,
    dp.Frequency,
    dp.StartDate,
    dp.EndDate,
    hp.HP_Name AS HealthProviderName
FROM 
    Drug_Prescription dp
JOIN 
    HealthProvider hp ON dp.HealthProvider_ID = hp.HealthProviderID;
	*/

--Select * from DrugPrescriptionsByHealthProvider;
-----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------
--DML TRIGGERS
-----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------
--Trigger 1: Log Updates to Injury Recovery Status
--This trigger logs changes to the Recovery_Status in the Injury table.
/*
CREATE TABLE InjuryAuditLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    InjuryID INT,
    Athlete_ID INT,
    Old_Recovery_Status NVARCHAR(50),
    New_Recovery_Status NVARCHAR(50),
    UpdateDate DATETIME DEFAULT GETDATE()
);
*/
/*
CREATE TRIGGER trg_LogInjuryUpdates
ON Injury
AFTER UPDATE
AS
BEGIN
    INSERT INTO InjuryAuditLog (InjuryID, Athlete_ID, Old_Recovery_Status, New_Recovery_Status, UpdateDate)
    SELECT 
        d.Injury_ID,
        d.Athlete_ID,
        d.Recovery_Status AS OldRecoveryStatus,
        i.Recovery_Status AS NewRecoveryStatus,
        GETDATE()
    FROM Deleted d
    JOIN Inserted i ON d.Injury_ID = i.Injury_ID
    WHERE d.Recovery_Status <> i.Recovery_Status;
END;
*/

/*
UPDATE Injury
SET Recovery_Status = 'Recovered'
WHERE Injury_ID = 1;

SELECT 
    LogID,
    InjuryID,
    Athlete_ID,
    Old_Recovery_Status,
    New_Recovery_Status,
    UpdateDate
FROM InjuryAuditLog
ORDER BY UpdateDate DESC;

select * from Athlete;
*/
-----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------
--Trigger 2: Log Athlete Clearance Approvals
--This trigger logs new clearances when an athlete is marked as Cleared in the Clearance table.
/*
CREATE TABLE ClearanceLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    AthleteID INT,
    ClearanceDate DATE,
    ClearanceStatus NVARCHAR(50),
    LogDate DATETIME DEFAULT GETDATE()
);


  -- Change `ClearanceStatus` to `nvarchar(max)`
ALTER TABLE Clearance
ALTER COLUMN ClearanceStatus NVARCHAR(MAX);

-- Change `ClearanceNotes` to `nvarchar(max)`
ALTER TABLE Clearance
ALTER COLUMN ClearanceNotes NVARCHAR(MAX);

*/
/*
CREATE TRIGGER trg_LogClearance
ON Clearance
AFTER INSERT
AS
BEGIN
    INSERT INTO ClearanceLog (AthleteID, ClearanceDate, ClearanceStatus, LogDate)
    SELECT 
        i.AthleteID,
        i.ClearanceDate,
        CAST(i.ClearanceStatus AS VARCHAR(MAX)),  -- Cast text to varchar(max)
        GETDATE()
    FROM Inserted i
    WHERE i.ClearanceStatus = 'Cleared';
END;
*/

/*
INSERT INTO Clearance (AthleteID, ClearanceDate, ClearanceStatus)
VALUES (1, '2024-11-20', 'Cleared');
SELECT * FROM sys.triggers WHERE name = 'trg_LogClearance';
*/
-----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------
--Trigger 3: Log Prescription Updations 
--This triggers logs in changes in the drug prescription

/*
CREATE TABLE PrescriptionAuditLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    PrescriptionID INT,
    AthleteID INT,
    HealthProviderID INT,
    Old_Dosage NVARCHAR(50),
    New_Dosage NVARCHAR(50),
    Old_Frequency NVARCHAR(50),
    New_Frequency NVARCHAR(50),
    Old_Notes NVARCHAR(255),
    New_Notes NVARCHAR(255),
    ChangeDate DATETIME DEFAULT GETDATE()
);

-- Alter the column type from text to nvarchar(max)
ALTER TABLE Drug_Prescription
ALTER COLUMN Prescription_Notes NVARCHAR(MAX);
*/
/*
CREATE TRIGGER trg_LogPrescriptionChanges
ON Drug_Prescription
AFTER UPDATE
AS
BEGIN
    INSERT INTO PrescriptionAuditLog (
        PrescriptionID,
        AthleteID,
        HealthProviderID,
        Old_Dosage,
        New_Dosage,
        Old_Frequency,
        New_Frequency,
        Old_Notes,
        New_Notes,
        ChangeDate
    )
    SELECT 
        d.Prescription_ID,
        d.Athlete_ID,
        d.HealthProvider_ID,
        d.Dosage AS Old_Dosage,
        i.Dosage AS New_Dosage,
        d.Frequency AS Old_Frequency,
        i.Frequency AS New_Frequency,
        d.Prescription_Notes AS Old_Notes,
        i.Prescription_Notes AS New_Notes,
        GETDATE() AS ChangeDate
    FROM Deleted d
    JOIN Inserted i ON d.Prescription_ID = i.Prescription_ID
    WHERE 
        d.Dosage <> i.Dosage OR 
        d.Frequency <> i.Frequency OR 
        d.Prescription_Notes <> i.Prescription_Notes;
END;
*/
/*
INSERT INTO Drug_Prescription (Athlete_ID, HealthProvider_ID, Dosage, Frequency, DrugName, StartDate, EndDate, Prescription_Notes)
VALUES (1, 1, '500mg', 'Twice daily', 'Ibuprofen', '2024-01-01', '2024-01-15', 'Take with food');
UPDATE Drug_Prescription

SET Dosage = '400mg', Frequency = 'Three times daily', Prescription_Notes = 'Take after meals'
WHERE Prescription_ID = 1;

SELECT * FROM PrescriptionAuditLog;
*/
-----------------------------------------------------------------------------------------------------------------------







