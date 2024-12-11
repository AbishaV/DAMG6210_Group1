
USE master;
GO

-- Kill all connections to the SIMS database
ALTER DATABASE SIMS 
SET SINGLE_USER 
WITH ROLLBACK IMMEDIATE;
GO

DROP DATABASE IF EXISTS SIMS;
GO

CREATE DATABASE SIMS;
GO
USE SIMS;
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Drop existing tables if they exist


DROP TABLE IF EXISTS AthleteClearance;
DROP TABLE IF EXISTS Follow_Up;
DROP TABLE IF EXISTS Treatment_Injury;
DROP TABLE IF EXISTS HealthProvider_Treatment;
DROP TABLE IF EXISTS Drug_Prescription;
DROP TABLE IF EXISTS Health_Report;
DROP TABLE IF EXISTS Athelete_SportsPersonnel;
DROP TABLE IF EXISTS Athlete_Physician;
DROP TABLE IF EXISTS Coach_Physician;
DROP TABLE IF EXISTS Athletic_Trainer;

-- Second Layer
DROP TABLE IF EXISTS Injury;
DROP TABLE IF EXISTS Treatment;
DROP TABLE IF EXISTS Clearance;
DROP TABLE IF EXISTS Physician;
DROP TABLE IF EXISTS Physiotherapist;
DROP TABLE IF EXISTS Coach;
DROP TABLE IF EXISTS SportsPersonnel;

-- Final Layer (Parent Tables)
DROP TABLE IF EXISTS HealthProvider;
DROP TABLE IF EXISTS Athlete;


----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create Athlete table
CREATE TABLE Athlete (
    AthleteID INT IDENTITY(1,1) PRIMARY KEY,
    Ath_Name VARCHAR(100) NOT NULL,
    Ath_DOB DATE NOT NULL,
    Ath_Gender CHAR(1) CHECK (Ath_Gender IN ('M', 'F')),
    Ath_Weight DECIMAL(5, 2),
    Ath_Height DECIMAL(5, 2),
    Ath_Add_Street VARCHAR(255),
    Ath_Add_Apt VARCHAR(150),
    Ath_Add_City VARCHAR(100),
    Ath_Add_State CHAR(2),
    Ath_Add_Zip VARCHAR(10),
    Ath_Add_ContactInfo VARCHAR(10),
    Ath_SportTeam VARCHAR(100)
);

-- Create HealthProvider table
CREATE TABLE HealthProvider (
    HealthProviderID INT IDENTITY(1,1) PRIMARY KEY,
    HP_Name VARCHAR(100) NOT NULL,
    HP_Add_Street VARCHAR(255),
    HP_Add_Apt VARCHAR(150),
    HP_Add_City VARCHAR(100),
    HP_Add_State CHAR(2),
    HP_Add_Zip VARCHAR(10),
    HP_ContactInfo VARCHAR(100),
    HP_Availability VARCHAR(100),
    HP_Notes TEXT
);

-- Create Clearance table
CREATE TABLE Clearance (
    ClearanceID INT IDENTITY(1,1) PRIMARY KEY,
    AthleteID INT NOT NULL,
    HealthProviderID INT NOT NULL,
    ClearanceDate DATE NOT NULL,
    ClearanceStatus TEXT,
    ClearanceNotes TEXT,
    CONSTRAINT FK_Clearance_Athlete FOREIGN KEY (AthleteID) REFERENCES Athlete(AthleteID),
    CONSTRAINT FK_Clearance_HealthProvider FOREIGN KEY (HealthProviderID) REFERENCES HealthProvider(HealthProviderID)
);

-- Create AthleteClearance table
CREATE TABLE AthleteClearance (
    AthleteID INT NOT NULL,
    ClearanceID INT NOT NULL,
    ClearanceType VARCHAR(50),
    CONSTRAINT PK_AthleteClearance PRIMARY KEY (AthleteID, ClearanceID),
    CONSTRAINT FK_AthleteClearance_Athlete FOREIGN KEY (AthleteID) REFERENCES Athlete(AthleteID),
    CONSTRAINT FK_AthleteClearance_Clearance FOREIGN KEY (ClearanceID) REFERENCES Clearance(ClearanceID)
);

-- Create Follow_Up table
CREATE TABLE Follow_Up (
    AthleteID INT,
    ClearanceID INT,
    Follow_UpRequired BIT NOT NULL DEFAULT 0,
    Next_Eval_Date DATE,
    PRIMARY KEY (AthleteID, ClearanceID),
    CONSTRAINT FK_FollowUp_Athlete FOREIGN KEY (AthleteID) REFERENCES Athlete(AthleteID),
    CONSTRAINT FK_FollowUp_Clearance FOREIGN KEY (ClearanceID) REFERENCES Clearance(ClearanceID)
);

-- Create Athlete_Physician table
CREATE TABLE Athlete_Physician (
    HealthProviderID INT NOT NULL,
    AthleteID INT NOT NULL,
    [Description] TEXT,
    CONSTRAINT FK_Athlete_Physician_Athlete FOREIGN KEY (AthleteID) REFERENCES Athlete(AthleteID),
    CONSTRAINT FK_Athlete_Physician_HealthProvider FOREIGN KEY (HealthProviderID) REFERENCES HealthProvider(HealthProviderID)
);

-- Create Physician table
CREATE TABLE Physician (
   HealthProviderID INT NOT NULL UNIQUE,
   Ph_Specialty VARCHAR(100),
   Ph_Certification TEXT,
   Prev_Experience DECIMAL CHECK (Prev_Experience >= 0),
   CONSTRAINT FK_Physician_HP FOREIGN KEY (HealthProviderID) REFERENCES HealthProvider(HealthProviderID)
);

-- Create Coach table
CREATE TABLE Coach (
   CoachStaffID INT IDENTITY(1,1) PRIMARY KEY,
   Achievements VARCHAR(100),
   Years_of_Experience INT CHECK (Years_of_Experience >= 0),
   Coaching_Specialty VARCHAR(100),
   Performance TEXT
);

-- Create Coach_Physician table
CREATE TABLE Coach_Physician (
   CoachStaffID INT IDENTITY(1,1) PRIMARY KEY,
   HealthProviderID INT NOT NULL,
   CommunicationDate DATE NOT NULL,
   SubjectDescription TEXT,
   CONSTRAINT FK_Coach_Physician_HealthProvider FOREIGN KEY (HealthProviderID) REFERENCES HealthProvider(HealthProviderID),
   CONSTRAINT FK_Coach_Physician_Coach FOREIGN KEY (CoachStaffID) REFERENCES Coach(CoachStaffID)
);

-- Create Physiotherapist table
CREATE TABLE Physiotherapist (
   HealthProvider_ID INT NOT NULL UNIQUE,
   Pt_Speciality TEXT,
   Treatment_Method TEXT DEFAULT 'No treatment details provided',
   CONSTRAINT FK_Physiotherapist_HP FOREIGN KEY (HealthProvider_ID) REFERENCES HealthProvider(HealthProviderID)
);

-- Create Athletic_Trainer table
CREATE TABLE Athletic_Trainer (
   StaffID INT NOT NULL,
   AthTrainer_Speciality TEXT,
   EmergencyTraining BIT DEFAULT 0 CHECK (EmergencyTraining IN (0, 1)),
   Technical_Certification BIT DEFAULT 0 CHECK (Technical_Certification IN (0, 1)),
   CONSTRAINT FK_Athletic_Trainer_Staff FOREIGN KEY (StaffID) REFERENCES Coach_Physician(CoachStaffID)
);

-- Create SportsPersonnel table
CREATE TABLE SportsPersonnel (
   StaffID INT NOT NULL,
   StaffTeam INT IDENTITY(1,1) PRIMARY KEY,
   StaffName VARCHAR(100),
   StaffContactDetails VARCHAR(255),
   StaffAdd_Street VARCHAR(255),
   StaffAdd_City VARCHAR(100),
   StaffAdd_Apt VARCHAR(100),
   StaffAdd_State CHAR(2),
   StaffAdd_Zip VARCHAR(10),
   [Role] VARCHAR(50),
   Prescription_Notes TEXT
);

-- Create Athlete_SportsPersonnel table
CREATE TABLE Athelete_SportsPersonnel (
   CoachStaffID INT NOT NULL PRIMARY KEY,
   AthleteID INT NOT NULL,
   Exercise_Regime TEXT,
   CONSTRAINT FK_SportsPersonnel_Athlete FOREIGN KEY (AthleteID) REFERENCES Athlete(AthleteID),
   CONSTRAINT FK_SportsPersonnel_Staff FOREIGN KEY (CoachStaffID) REFERENCES Coach(CoachStaffID)
);

-- Create Drug_Prescription table
CREATE TABLE Drug_Prescription (
   Prescription_ID INT IDENTITY(1,1) PRIMARY KEY,
   Athlete_ID INT NOT NULL,
   HealthProvider_ID INT NOT NULL,
   Dosage VARCHAR(50),
   Frequency VARCHAR(50),
   DrugName VARCHAR(100),
   StartDate DATE NOT NULL,
   EndDate DATE,
   Prescription_Notes TEXT,
   CONSTRAINT FK_DrugPrescription_Athlete FOREIGN KEY (Athlete_ID) REFERENCES Athlete(AthleteID),
   CONSTRAINT FK_DrugPrescription_HealthProvider FOREIGN KEY (HealthProvider_ID) REFERENCES HealthProvider(HealthProviderID)
);

-- Create Treatment table
CREATE TABLE Treatment (
   Treatment_ID INT IDENTITY(1,1) PRIMARY KEY,
   TreatmentAddedDate DATE NOT NULL,
   TreatmentType VARCHAR(100),
   Notes TEXT
);

-- Create Injury table
CREATE TABLE Injury (
   Injury_ID INT IDENTITY(1,1) PRIMARY KEY,
   Athlete_ID INT NOT NULL,
   Injury_Type VARCHAR(100),
   Injury_Date DATE NOT NULL CHECK (Injury_Date <= GETDATE()),
   Severity VARCHAR(50),
   TreatmentPlan TEXT,
   Recovery_Status VARCHAR(50),
   CONSTRAINT FK_Injury_Athlete FOREIGN KEY (Athlete_ID) REFERENCES Athlete(AthleteID)
);

-- Create Treatment_Injury table
CREATE TABLE Treatment_Injury (
     Treatment_ID INT NOT NULL,
     Injury_ID INT NOT NULL,
     Prescription_ID INT NOT NULL UNIQUE,
     InjuryTreatmentProgress TEXT,
     Outcome TEXT,
     InjuryTreatmentNotes TEXT,
     PRIMARY KEY (Treatment_ID, Injury_ID),
     CONSTRAINT FK_TreatmentInjury_Treatment FOREIGN KEY (Treatment_ID) REFERENCES Treatment(Treatment_ID),
     CONSTRAINT FK_TreatmentInjury_Injury FOREIGN KEY (Injury_ID) REFERENCES Injury(Injury_ID),
     CONSTRAINT FK_TreatmentInjury_Prescription FOREIGN KEY (Prescription_ID) REFERENCES Drug_Prescription(Prescription_ID)
);

-- Create Health_Report table
CREATE TABLE Health_Report (
     ReportID INT IDENTITY(1,1) PRIMARY KEY,
     AthleteID INT NOT NULL UNIQUE,
     ReportDate DATE NOT NULL CHECK (ReportDate <= GETDATE()),
     VitalSigns VARCHAR(MAX) CHECK (LEN(RTRIM(LTRIM(ISNULL(VitalSigns, '')))) > 0),
     HealthNotes VARCHAR(MAX) DEFAULT 'No notes available',
     CONSTRAINT FK_HealthReport_Athlete FOREIGN KEY (AthleteID) REFERENCES Athlete(AthleteID)
);

-- Create HealthProvider_Treatment table
CREATE TABLE HealthProvider_Treatment (
     HealthProviderID INT NOT NULL,
     TreatmentID INT NOT NULL UNIQUE,
     TreatmentDetails TEXT DEFAULT 'No treatment details provided',
     Duration DECIMAL CHECK (Duration >= 0),
     CONSTRAINT FK_HealthProvider_Treatment_HP UNIQUE (HealthProviderID),
     CONSTRAINT FK_HealthProvider_Treatment_Treatment FOREIGN KEY (TreatmentID) REFERENCES Treatment(Treatment_ID)
);

----------------------------------------------------------------------------------------------------------------------------------------------------------------