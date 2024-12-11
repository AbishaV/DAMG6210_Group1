-- Basic Tables First
-- Athlete table
INSERT INTO Athlete (Ath_Name, Ath_DOB, Ath_Gender, Ath_Weight, Ath_Height, Ath_Add_Street, Ath_Add_Apt, Ath_Add_City, Ath_Add_State, Ath_Add_Zip, Ath_Add_ContactInfo, Ath_SportTeam)
VALUES 
('John Smith', '2000-05-15', 'M', 180.5, 72.5, '123 Main St', '4B', 'Boston', 'MA', '02108', '6175550123', 'Basketball'),
('Emma Johnson', '1999-08-22', 'F', 145.0, 65.0, '456 Oak Ave', '2A', 'Cambridge', 'MA', '02139', '6175550124', 'Soccer'),
('Michael Brown', '2001-03-10', 'M', 175.0, 70.0, '789 Pine St', NULL, 'Somerville', 'MA', '02144', '6175550125', 'Football'),
('Sarah Davis', '2002-01-30', 'F', 135.5, 63.5, '321 Elm St', '5C', 'Boston', 'MA', '02116', '6175550126', 'Volleyball'),
('James Wilson', '2000-11-05', 'M', 190.0, 75.0, '654 Maple Dr', NULL, 'Cambridge', 'MA', '02138', '6175550127', 'Basketball'),
('Emily Taylor', '2001-07-18', 'F', 140.0, 64.0, '987 Cedar Ln', '3D', 'Somerville', 'MA', '02145', '6175550128', 'Soccer'),
('David Martinez', '1999-12-25', 'M', 170.0, 69.0, '147 Birch Rd', NULL, 'Boston', 'MA', '02115', '6175550129', 'Football'),
('Lisa Anderson', '2002-04-08', 'F', 142.5, 65.5, '258 Spruce St', '1A', 'Cambridge', 'MA', '02140', '6175550130', 'Volleyball'),
('Robert Thomas', '2000-09-14', 'M', 185.0, 73.0, '369 Oak St', '6B', 'Somerville', 'MA', '02143', '6175550131', 'Basketball'),
('Jessica White', '2001-06-20', 'F', 138.0, 64.5, '741 Pine Ave', NULL, 'Boston', 'MA', '02109', '6175550132', 'Soccer');

-- HealthProvider table
INSERT INTO HealthProvider (HP_Name, HP_Add_Street, HP_Add_Apt, HP_Add_City, HP_Add_State, HP_Add_Zip, HP_ContactInfo, HP_Availability, HP_Notes)
VALUES
('Dr. William Brown', '100 Medical Way', '301', 'Boston', 'MA', '02108', '6175551000', 'Mon-Fri 9AM-5PM', 'Team physician'),
('Dr. Sarah Johnson', '200 Health St', NULL, 'Cambridge', 'MA', '02139', '6175551001', 'Mon-Wed 8AM-6PM', 'Sports medicine specialist'),
('Dr. Robert Lee', '300 Care Ave', '205', 'Somerville', 'MA', '02144', '6175551002', 'Tue-Sat 10AM-7PM', 'Orthopedic specialist'),
('Dr. Maria Garcia', '400 Wellness Rd', NULL, 'Boston', 'MA', '02116', '6175551003', 'Mon-Thu 9AM-4PM', 'Physical therapy expert'),
('Dr. James Wilson', '500 Recovery Ln', '102', 'Cambridge', 'MA', '02138', '6175551004', 'Wed-Sun 8AM-5PM', 'Sports rehabilitation'),
('Dr. Emily Chen', '600 Health Ave', NULL, 'Somerville', 'MA', '02145', '6175551005', 'Mon-Fri 7AM-3PM', 'Athletic trainer'),
('Dr. Michael Davis', '700 Medical St', '405', 'Boston', 'MA', '02115', '6175551006', 'Tue-Sat 11AM-8PM', 'Nutritionist'),
('Dr. Lisa Thompson', '800 Care Way', NULL, 'Cambridge', 'MA', '02140', '6175551007', 'Mon-Thu 10AM-6PM', 'Psychology specialist'),
('Dr. David Martinez', '900 Wellness Ave', '301', 'Somerville', 'MA', '02143', '6175551008', 'Wed-Sun 9AM-5PM', 'Rehabilitation expert'),
('Dr. Jennifer White', '1000 Recovery Rd', NULL, 'Boston', 'MA', '02109', '6175551009', 'Mon-Fri 8AM-4PM', 'General sports medicine');

-- Physician table
INSERT INTO Physician (HealthProviderID, Ph_Specialty, Ph_Certification, Prev_Experience)
VALUES
(1, 'Sports Medicine', 'Board Certified in Sports Medicine', 15.5),
(2, 'Orthopedics', 'Board Certified in Orthopedic Surgery', 12.0),
(3, 'Physical Therapy', 'DPT, Sports Certified Specialist', 10.5),
(4, 'Rehabilitation', 'Board Certified in PM&R', 8.0),
(5, 'Sports Psychology', 'Licensed Clinical Psychologist', 14.0),
(6, 'Nutrition', 'Certified Sports Nutritionist', 7.5),
(7, 'Emergency Medicine', 'Board Certified in Emergency Medicine', 11.0),
(8, 'Family Medicine', 'Board Certified in Family Medicine', 9.5),
(9, 'Internal Medicine', 'Board Certified in Internal Medicine', 13.0),
(10, 'Pediatrics', 'Board Certified in Pediatric Sports Medicine', 6.5);

-- Coach table with all entries including later additions
INSERT INTO Coach (Achievements, Years_of_Experience, Coaching_Specialty, Performance)
VALUES
('State Championship 2023', 15, 'Basketball', 'Excellence in player development'),
('Regional Coach of the Year 2022', 10, 'Soccer', 'Strong tactical approach'),
('National Team Experience', 20, 'Football', 'Defensive specialist'),
('Olympic Team Assistant 2020', 12, 'Volleyball', 'Team building expert'),
('Multiple Conference Titles', 8, 'Basketball', 'Offensive strategist'),
('Youth Development Award', 14, 'Soccer', 'Player progression focus'),
('Professional League Experience', 18, 'Football', 'Special teams expert'),
('College Championship 2021', 11, 'Volleyball', 'Technical skills development'),
('International Coaching License', 16, 'Basketball', 'Mental preparation specialist'),
('Player Development Certificate', 9, 'Soccer', 'Youth coaching expert'),
-- Additional coaches
('Olympic Training Certification', 12, 'Basketball Strength and Conditioning', 'Expertise in injury prevention'),
('Regional Performance Award', 8, 'Basketball Skills Development', 'Specialized in shooting mechanics'),
('Advanced Training License', 10, 'Basketball Movement Specialist', 'Focus on footwork and agility'),
('International Coaching License', 15, 'Soccer Fitness Development', 'Elite conditioning expertise'),
('Youth Development Excellence', 9, 'Soccer Technical Skills', 'Individual skill enhancement'),
('Professional Training Certificate', 11, 'Soccer Speed Development', 'Sprint and agility focus'),
('National Team Experience', 14, 'Football Conditioning', 'Strength and power development'),
('Performance Enhancement Cert', 7, 'Football Skills Training', 'Position-specific training'),
('Injury Prevention Specialist', 13, 'Football Rehabilitation', 'Return to play protocols'),
('National Championship Experience', 10, 'Volleyball Performance', 'Jump training specialist'),
('Elite Training Certification', 8, 'Volleyball Skills', 'Technical development focus'),
('Sports Science Degree', 11, 'Volleyball Conditioning', 'Athletic performance expert');

-- All Injury records including later additions
INSERT INTO Injury (Athlete_ID, Injury_Type, Injury_Date, Severity, TreatmentPlan, Recovery_Status)
VALUES
-- Initial injuries
(1, 'Sprained Ankle', '2024-01-15', 'Moderate', 'RICE protocol and physical therapy', 'In Progress'),
(2, 'Knee Strain', '2024-02-01', 'Mild', 'Rest and strengthening exercises', 'Recovered'),
(3, 'Shoulder Dislocation', '2024-01-20', 'Severe', 'Surgery and rehabilitation', 'In Progress'),
(4, 'Muscle Pull', '2024-02-10', 'Mild', 'Physical therapy and stretching', 'Recovered'),
(5, 'Concussion', '2024-01-25', 'Moderate', 'Rest and gradual return protocol', 'In Progress'),
(6, 'Shin Splints', '2024-02-05', 'Mild', 'Rest and ice therapy', 'Recovered'),
(7, 'ACL Tear', '2024-01-30', 'Severe', 'Surgery and extensive rehabilitation', 'In Progress'),
(8, 'Tennis Elbow', '2024-02-15', 'Moderate', 'Physical therapy and anti-inflammatory', 'In Progress'),
(9, 'Back Strain', '2024-01-10', 'Mild', 'Physical therapy and core strengthening', 'Recovered'),
(10, 'Wrist Sprain', '2024-02-20', 'Moderate', 'Immobilization and gradual rehabilitation', 'In Progress'),
-- Additional injuries
(2, 'ACL Tear', '2024-01-05', 'Severe', 'Surgery and 9-month rehabilitation program', 'In Progress'),
(5, 'ACL Tear', '2024-01-12', 'Severe', 'Conservative treatment with PT', 'In Progress'),
(8, 'ACL Tear', '2023-12-15', 'Severe', 'Post-surgical rehabilitation', 'In Progress'),
(3, 'Sprained Ankle', '2024-02-05', 'Mild', 'RICE protocol and ankle strengthening', 'Recovered'),
(6, 'Sprained Ankle', '2024-02-10', 'Moderate', 'Physical therapy and balance training', 'In Progress'),
(9, 'Sprained Ankle', '2024-01-28', 'Severe', 'Immobilization followed by PT', 'In Progress'),
(4, 'Knee Strain', '2024-02-08', 'Moderate', 'Physical therapy and knee stabilization exercises', 'In Progress'),
(7, 'Knee Strain', '2024-01-25', 'Mild', 'Rest and guided strengthening program', 'Recovered'),
(10, 'Knee Strain', '2024-02-15', 'Severe', 'Intensive rehabilitation protocol', 'In Progress'),
(1, 'Hamstring Strain', '2024-02-01', 'Moderate', 'Progressive stretching and strengthening', 'In Progress'),
(5, 'Hamstring Strain', '2024-01-20', 'Mild', 'Active recovery and PT', 'Recovered'),
(8, 'Hamstring Strain', '2024-02-12', 'Severe', 'Extended rest and careful rehabilitation', 'In Progress');

-- Treatment table with all entries
INSERT INTO Treatment (TreatmentAddedDate, TreatmentType, Notes)
VALUES
('2024-01-16', 'Physical Therapy', 'Ankle strengthening exercises'),
('2024-02-02', 'Rehabilitation', 'Knee flexibility training'),
('2024-01-21', 'Surgery', 'Arthroscopic shoulder surgery'),
('2024-02-11', 'Massage Therapy', 'Deep tissue massage for muscle strain'),
('2024-01-26', 'Rest Protocol', 'Concussion recovery protocol'),
('2024-02-06', 'Ice Therapy', 'Regular ice application'),
('2024-01-31', 'Surgery', 'ACL reconstruction'),
('2024-02-16', 'Physical Therapy', 'Tennis elbow exercises'),
('2024-01-11', 'Chiropractic', 'Back adjustment and therapy'),
('2024-02-21', 'Splinting', 'Wrist immobilization and exercises'),
('2024-02-20', 'Strength Training', 'Progressive resistance training for ACL recovery'),
('2024-02-16', 'Balance Training', 'Proprioception exercises for ACL stability'),
('2024-02-17', 'Agility Training', 'Sport-specific movement patterns for ACL'),
('2024-02-18', 'Cognitive Training', 'Memory and concentration exercises');

-- Rest of the tables follow similar pattern, each containing all entries including later additions
-- Drug_Prescription with all entries
-- Complete Drug_Prescription table inserts
INSERT INTO Drug_Prescription (Athlete_ID, HealthProvider_ID, Dosage, Frequency, DrugName, StartDate, EndDate, Prescription_Notes)
VALUES
-- Initial prescriptions
(1, 1, '500mg', 'Twice daily', 'Ibuprofen', '2024-01-15', '2024-01-30', 'Take with food'),
(2, 2, '250mg', 'Once daily', 'Naproxen', '2024-02-01', '2024-02-15', 'Take in the morning'),
(3, 3, '750mg', 'Three times daily', 'Acetaminophen', '2024-01-20', '2024-02-03', 'Pain management'),
(4, 4, '50mg', 'Once daily', 'Diclofenac', '2024-02-10', '2024-02-24', 'Apply topically'),
(5, 5, '100mg', 'Twice daily', 'Aspirin', '2024-01-25', '2024-02-08', 'Take after meals'),
(6, 6, '400mg', 'Three times daily', 'Ibuprofen', '2024-02-05', '2024-02-19', 'For inflammation'),
(7, 7, '1000mg', 'Twice daily', 'Acetaminophen', '2024-01-30', '2024-02-13', 'Post-surgery pain'),
(8, 8, '500mg', 'Once daily', 'Naproxen', '2024-02-15', '2024-03-01', 'For joint pain'),
(9, 9, '75mg', 'Twice daily', 'Diclofenac', '2024-01-10', '2024-01-24', 'With physical therapy'),
(10, 10, '600mg', 'Three times daily', 'Ibuprofen', '2024-02-20', '2024-03-05', 'For acute pain'),
-- Additional Ibuprofen prescriptions
(2, 3, '600mg', 'Three times daily', 'Ibuprofen', '2024-01-18', '2024-02-01', 'For acute inflammation'),
(4, 1, '400mg', 'Four times daily', 'Ibuprofen', '2024-02-05', '2024-02-19', 'Take with meals only'),
(7, 5, '800mg', 'Twice daily', 'Ibuprofen', '2024-01-25', '2024-02-08', 'For severe pain management'),
(9, 2, '400mg', 'Three times daily', 'Ibuprofen', '2024-02-10', '2024-02-24', 'Only as needed for pain'),
-- Additional Naproxen prescriptions
(1, 4, '500mg', 'Twice daily', 'Naproxen', '2024-01-20', '2024-02-03', 'For chronic inflammation'),
(5, 6, '250mg', 'Twice daily', 'Naproxen', '2024-02-01', '2024-02-15', 'Morning and evening doses'),
(8, 3, '375mg', 'Twice daily', 'Naproxen', '2024-01-28', '2024-02-11', 'With food only'),
(10, 7, '500mg', 'Once daily', 'Naproxen', '2024-02-08', '2024-02-22', 'Extended release formula'),
-- Additional Acetaminophen prescriptions
(3, 8, '500mg', 'Four times daily', 'Acetaminophen', '2024-01-15', '2024-01-29', 'Not to exceed 4000mg daily'),
(6, 9, '650mg', 'Three times daily', 'Acetaminophen', '2024-02-01', '2024-02-15', 'For pain management'),
(9, 10, '500mg', 'As needed', 'Acetaminophen', '2024-01-25', '2024-02-08', 'Maximum 6 tablets daily'),
(2, 5, '1000mg', 'Twice daily', 'Acetaminophen', '2024-02-10', '2024-02-24', 'Extended release tablets'),
-- Additional Diclofenac prescriptions
(5, 2, '75mg', 'Twice daily', 'Diclofenac', '2024-01-22', '2024-02-05', 'Oral tablets'),
(7, 4, '100mg', 'Daily', 'Diclofenac', '2024-02-03', '2024-02-17', 'Apply to affected area'),
(10, 1, '50mg', 'Three times daily', 'Diclofenac', '2024-01-30', '2024-02-13', 'Take with food'),
(3, 6, '75mg', 'Twice daily', 'Diclofenac', '2024-02-08', '2024-02-22', 'For joint pain'),
-- Meloxicam prescriptions
(1, 7, '15mg', 'Once daily', 'Meloxicam', '2024-01-20', '2024-02-03', 'Take in the morning'),
(4, 8, '7.5mg', 'Once daily', 'Meloxicam', '2024-02-05', '2024-02-19', 'With breakfast'),
(8, 10, '15mg', 'Once daily', 'Meloxicam', '2024-01-28', '2024-02-11', 'For chronic pain'),
(6, 3, '7.5mg', 'Once daily', 'Meloxicam', '2024-02-15', '2024-03-01', 'Monitor kidney function');

-- Complete Clearance table inserts
INSERT INTO Clearance (AthleteID, HealthProviderID, ClearanceDate, ClearanceStatus, ClearanceNotes)
VALUES
-- Initial clearances
(1, 1, '2024-02-01', 'Cleared', 'Full participation allowed'),
(2, 2, '2024-02-15', 'Partially Cleared', 'Limited contact drills only'),
(3, 3, '2024-01-25', 'Not Cleared', 'Requires further evaluation'),
(4, 4, '2024-02-20', 'Cleared', 'No restrictions'),
(5, 5, '2024-02-10', 'Conditionally Cleared', 'Must wear protective gear'),
(6, 6, '2024-02-05', 'Cleared', 'Regular monitoring recommended'),
(7, 7, '2024-01-30', 'Not Cleared', 'Post-surgery recovery period'),
(8, 8, '2024-02-25', 'Partially Cleared', 'Non-contact activities only'),
(9, 9, '2024-02-12', 'Cleared', 'Full return to play'),
(10, 10, '2024-02-28', 'Conditionally Cleared', 'Gradual return to activity'),

-- ACL Recovery progression clearances
(7, 2, '2024-02-15', 'Not Cleared', 'Initial post-surgery evaluation'),
(7, 3, '2024-03-01', 'Partially Cleared', 'Cleared for rehabilitation exercises only'),
(7, 1, '2024-03-15', 'Conditionally Cleared', 'Light training permitted under supervision'),

-- Concussion Protocol clearances
(5, 3, '2024-02-05', 'Not Cleared', 'Initial concussion assessment'),
(5, 8, '2024-02-20', 'Partially Cleared', 'Cleared for non-contact activities'),
(5, 2, '2024-03-05', 'Conditionally Cleared', 'Gradual return to play protocol initiated'),

-- Ankle Sprain progression
(1, 4, '2024-02-10', 'Partially Cleared', 'Limited mobility exercises allowed'),
(1, 6, '2024-02-25', 'Conditionally Cleared', 'Can participate in specific drills'),
(1, 2, '2024-03-10', 'Cleared', 'Full return to activity approved'),

-- Shoulder Rehabilitation progression
(3, 5, '2024-02-01', 'Not Cleared', 'Post-injury evaluation'),
(3, 7, '2024-02-15', 'Partially Cleared', 'Rehabilitation exercises only'),
(3, 9, '2024-03-01', 'Conditionally Cleared', 'Modified training allowed'),

-- Knee Injury progression
(2, 8, '2024-02-05', 'Not Cleared', 'Initial assessment'),
(2, 10, '2024-02-20', 'Partially Cleared', 'Strength training permitted'),
(2, 4, '2024-03-05', 'Cleared', 'Full clearance granted'),

-- Additional monitoring clearances
(4, 5, '2024-03-01', 'Conditionally Cleared', 'Monthly monitoring required'),
(4, 6, '2024-03-15', 'Partially Cleared', 'Progress evaluation needed'),
(6, 7, '2024-03-05', 'Conditionally Cleared', 'Bi-weekly check required'),
(6, 8, '2024-03-20', 'Partially Cleared', 'Continued monitoring needed'),
(8, 9, '2024-03-10', 'Conditionally Cleared', 'Regular assessment needed'),
(9, 10, '2024-03-12', 'Partially Cleared', 'Follow-up evaluation required'),
(10, 1, '2024-03-08', 'Conditionally Cleared', 'Progressive monitoring needed');

-- AthleteClearance table
INSERT INTO AthleteClearance (AthleteID, ClearanceID, ClearanceType)
VALUES
(1, 1, 'Annual Physical'),
(2, 2, 'Injury Return'),
(3, 3, 'Post-Injury Assessment'),
(4, 4, 'Regular Check-up'),
(5, 5, 'Concussion Protocol'),
(6, 6, 'Mid-Season Evaluation'),
(7, 7, 'Post-Surgery'),
(8, 8, 'Injury Follow-up'),
(9, 9, 'Return to Play'),
(10, 10, 'Rehabilitation Clearance'),
-- Additional clearance types for ACL Recovery progression
(7, 11, 'Post-Surgery Initial'),
(7, 12, 'Rehabilitation Clearance'),
(7, 13, 'Activity Modification'),
-- Additional clearance types for Concussion Protocol progression
(5, 14, 'Concussion Evaluation'),
(5, 15, 'Activity Progression'),
(5, 16, 'Return Protocol'),
-- Additional clearance types for Ankle Sprain progression
(1, 17, 'Mobility Assessment'),
(1, 18, 'Drill Participation'),
(1, 19, 'Full Activity'),
-- Additional clearance types for Shoulder Rehabilitation progression
(3, 20, 'Initial Assessment'),
(3, 21, 'Rehab Progression'),
(3, 22, 'Modified Activity'),
-- Additional clearance types for Knee Injury progression
(2, 23, 'Initial Evaluation'),
(2, 24, 'Strength Training'),
(2, 25, 'Return to Play');

INSERT INTO Follow_Up (AthleteID, ClearanceID, Follow_UpRequired, Next_Eval_Date)
VALUES
-- Initial follow-ups (using first 10 clearances)
(1, 1, 0, NULL),
(2, 2, 1, '2024-03-15'),
(3, 3, 1, '2024-02-25'),
(4, 4, 0, NULL),
(5, 5, 1, '2024-03-10'),
(6, 6, 0, NULL),
(7, 7, 1, '2024-03-30'),
(8, 8, 1, '2024-03-25'),
(9, 9, 0, NULL),
(10, 10, 1, '2024-03-28');
INSERT INTO Follow_Up (AthleteID, ClearanceID, Follow_UpRequired, Next_Eval_Date)
VALUES
-- ACL Recovery follow-ups (using clearances 11-13)
(7, 11, 1, '2024-03-01'),
(7, 12, 1, '2024-03-15'),
(7, 13, 1, '2024-04-01');
INSERT INTO Follow_Up (AthleteID, ClearanceID, Follow_UpRequired, Next_Eval_Date)
VALUES
-- Concussion Protocol follow-ups (using clearances 14-16)
(5, 14, 1, '2024-02-20'),
(5, 15, 1, '2024-03-05'),
(5, 16, 1, '2024-03-20');
INSERT INTO Follow_Up (AthleteID, ClearanceID, Follow_UpRequired, Next_Eval_Date)
VALUES
-- Ankle Sprain follow-ups (using clearances 17-19)
(1, 17, 1, '2024-02-25'),
(1, 18, 1, '2024-03-10'),
(1, 19, 0, NULL);
INSERT INTO Follow_Up (AthleteID, ClearanceID, Follow_UpRequired, Next_Eval_Date)
VALUES
-- Shoulder Rehabilitation follow-ups (using clearances 20-22)
(3, 20, 1, '2024-02-15'),
(3, 21, 1, '2024-03-01'),
(3, 22, 1, '2024-03-15');
INSERT INTO Follow_Up (AthleteID, ClearanceID, Follow_UpRequired, Next_Eval_Date)
VALUES
-- Knee Injury follow-ups (using clearances 23-25)
(2, 23, 1, '2024-02-20'),
(2, 24, 1, '2024-03-05'),
(2, 25, 0, NULL);



-- Complete Coach table inserts
INSERT INTO Coach (Achievements, Years_of_Experience, Coaching_Specialty, Performance)
VALUES
-- Initial coaches
('State Championship 2023', 15, 'Basketball', 'Excellence in player development'),
('Regional Coach of the Year 2022', 10, 'Soccer', 'Strong tactical approach'),
('National Team Experience', 20, 'Football', 'Defensive specialist'),
('Olympic Team Assistant 2020', 12, 'Volleyball', 'Team building expert'),
('Multiple Conference Titles', 8, 'Basketball', 'Offensive strategist'),
('Youth Development Award', 14, 'Soccer', 'Player progression focus'),
('Professional League Experience', 18, 'Football', 'Special teams expert'),
('College Championship 2021', 11, 'Volleyball', 'Technical skills development'),
('International Coaching License', 16, 'Basketball', 'Mental preparation specialist'),
('Player Development Certificate', 9, 'Soccer', 'Youth coaching expert'),

-- Basketball specialized coaches
('Olympic Training Certification', 12, 'Basketball Strength and Conditioning', 'Expertise in injury prevention'),
('Regional Performance Award', 8, 'Basketball Skills Development', 'Specialized in shooting mechanics'),
('Advanced Training License', 10, 'Basketball Movement Specialist', 'Focus on footwork and agility'),
('International Performance License', 13, 'Basketball Conditioning', 'Elite athlete development'),
('Coaching Excellence Award', 15, 'Basketball Defense', 'Defensive strategy expert'),

-- Soccer specialized coaches
('International Coaching License', 15, 'Soccer Fitness Development', 'Elite conditioning expertise'),
('Youth Development Excellence', 9, 'Soccer Technical Skills', 'Individual skill enhancement'),
('Professional Training Certificate', 11, 'Soccer Speed Development', 'Sprint and agility focus'),
('UEFA A License', 14, 'Soccer Strategy', 'Advanced tactical planning'),
('Academy Director Experience', 16, 'Soccer Youth Development', 'Talent pipeline management'),

-- Football specialized coaches
('National Team Experience', 14, 'Football Conditioning', 'Strength and power development'),
('Performance Enhancement Cert', 7, 'Football Skills Training', 'Position-specific training'),
('Injury Prevention Specialist', 13, 'Football Rehabilitation', 'Return to play protocols'),
('Professional Playing Experience', 12, 'Football Strategy', 'Game planning specialist'),
('Strength Training Certification', 10, 'Football Performance', 'Athletic development'),

-- Volleyball specialized coaches
('National Championship Experience', 10, 'Volleyball Performance', 'Jump training specialist'),
('Elite Training Certification', 8, 'Volleyball Skills', 'Technical development focus'),
('Sports Science Degree', 11, 'Volleyball Conditioning', 'Athletic performance expert'),
('Olympic Development Program', 15, 'Volleyball Strategy', 'Advanced play design'),
('Performance Analytics Cert', 9, 'Volleyball Team Development', 'Data-driven coaching approach');

-- Complete Coach_Physician table inserts
INSERT INTO Coach_Physician (HealthProviderID, CommunicationDate, SubjectDescription)
VALUES
-- Initial communications
(1, '2024-02-01', 'Player injury status update'),
(2, '2024-02-15', 'Return to play protocol discussion'),
(3, '2024-01-25', 'Team health assessment'),
(4, '2024-02-20', 'Injury prevention strategies'),
(5, '2024-02-10', 'Mental health considerations'),
(6, '2024-02-05', 'Nutrition planning'),
(7, '2024-01-30', 'Recovery protocol review'),
(8, '2024-02-25', 'Performance enhancement discussion'),
(9, '2024-02-12', 'Rehabilitation progress'),
(10, '2024-02-28', 'Season preparation planning'),

-- Additional communications for ACL injuries
(1, '2024-02-02', 'ACL recovery protocol review'),
(3, '2024-02-16', 'Post-surgery rehabilitation plan'),
(5, '2024-02-03', 'Pain management strategies'),

-- Additional communications for concussion management
(2, '2024-02-18', 'Concussion protocol updates'),
(4, '2024-02-08', 'Return to play guidelines review'),
(6, '2024-02-22', 'Cognitive assessment results'),

-- Additional communications for general team health
(7, '2024-02-04', 'Team conditioning program review'),
(8, '2024-02-19', 'Injury prevention workshop planning'),
(9, '2024-02-06', 'Athletic performance metrics'),
(10, '2024-02-21', 'Training load management'),

-- Sport-specific communications
(1, '2024-02-07', 'Basketball-specific injury prevention'),
(2, '2024-02-23', 'Soccer training modifications'),
(3, '2024-02-09', 'Football contact protocols'),
(4, '2024-02-24', 'Volleyball jump training safety'),

-- Wellness and prevention communications
(5, '2024-02-11', 'Mental wellness program implementation'),
(6, '2024-02-26', 'Nutrition seminar planning'),
(7, '2024-02-13', 'Recovery protocol optimization'),
(8, '2024-02-27', 'Sleep hygiene guidelines'),
(9, '2024-02-14', 'Stress management strategies'),
(10, '2024-02-29', 'Long-term athlete development');

INSERT INTO Physiotherapist (HealthProvider_ID, Pt_Speciality, Treatment_Method)
VALUES
-- Initial physiotherapists with primary specialties
(1, 'Sports Rehabilitation', 'Manual therapy and exercise'),
(2, 'Orthopedic Therapy', 'Joint mobilization'),
(3, 'Spinal Management', 'McKenzie method'),
(4, 'Post-surgical Rehabilitation', 'Progressive strengthening'),
(5, 'Athletic Recovery', 'Soft tissue manipulation'),
(6, 'Injury Prevention', 'Movement analysis'),
(7, 'Pain Management', 'Therapeutic modalities'),
(8, 'Performance Enhancement', 'Functional training'),
(9, 'Musculoskeletal Therapy', 'Myofascial release'),
(10, 'Sport-specific Rehabilitation', 'Custom exercise programs');


-- Complete Athletic_Trainer table inserts
INSERT INTO Athletic_Trainer (StaffID, AthTrainer_Speciality, EmergencyTraining, Technical_Certification)
VALUES
-- Initial athletic trainers
(1, 'Injury Prevention', 1, 1),
(2, 'Emergency Response', 1, 1),
(3, 'Rehabilitation', 1, 0),
(4, 'Taping and Bracing', 1, 1),
(5, 'Strength Training', 0, 1),
(6, 'Conditioning', 1, 1),
(7, 'Performance Enhancement', 0, 1),
(8, 'Recovery Techniques', 1, 0),
(9, 'Nutrition Support', 1, 1),
(10, 'Mental Health First Aid', 1, 1),

-- Sport-specific trainers
(11, 'Basketball Training Specialist', 1, 1),
(12, 'Soccer Conditioning Expert', 1, 1),
(13, 'Football Recovery Specialist', 1, 1),
(14, 'Volleyball Performance Trainer', 1, 1),

-- Specialized focus areas
(15, 'ACL Prevention Specialist', 1, 1),
(16, 'Concussion Protocol Expert', 1, 1),
(17, 'Joint Stability Specialist', 1, 1),
(18, 'Speed Development Coach', 0, 1),
(19, 'Agility Training Expert', 0, 1),
(20, 'Flexibility Specialist', 1, 0),

-- Recovery and rehabilitation specialists
(21, 'Post-Injury Rehabilitation', 1, 1),
(22, 'Return-to-Play Protocol', 1, 1),
(23, 'Injury Prevention Specialist', 1, 1),
(24, 'Performance Recovery Expert', 0, 1),
(25, 'Acute Care Specialist', 1, 1),

-- Conditioning and performance specialists
(26, 'Strength and Power Development', 0, 1),
(27, 'Endurance Training Specialist', 0, 1),
(28, 'Movement Assessment Expert', 1, 1),
(29, 'Athletic Performance Analyst', 0, 1),
(30, 'Sports Science Application', 1, 1);

INSERT INTO Treatment_Injury (Treatment_ID, Injury_ID, Prescription_ID, InjuryTreatmentProgress, Outcome, InjuryTreatmentNotes)
VALUES
-- Initial treatment-injury relationships
(2, 2, 2, 'Recovered', 'Full recovery', 'Maintenance exercises recommended'),
(3, 3, 3, 'Early stages', 'Initial progress', 'Post-surgical care ongoing'),
(4, 4, 4, 'Progressing', 'Good improvement', 'Increasing activity level'),
(5, 5, 5, 'Monitoring', 'Stable condition', 'Following concussion protocol'),
(6, 6, 6, 'Resolved', 'Complete recovery', 'Preventive measures discussed'),
(7, 7, 7, 'Post-surgery', 'As expected', 'Following rehabilitation plan'),
(8, 8, 8, 'Improving', 'Positive trend', 'Continuing therapeutic exercises'),
(9, 9, 9, 'Recovered', 'Full resolution', 'Maintenance program provided'),
(10, 10, 10, 'Active treatment', 'Steady progress', 'Regular monitoring required'),

-- ACL injury treatments (using existing injury IDs 11-13)
(11, 11, 11, 'Post-surgery', 'Early stages', 'Following ACL protocol'),
(11, 12, 12, 'Rehabilitation', 'Progressing well', 'Strength improving'),
(11, 13, 13, 'Active rehab', 'Meeting milestones', 'Gait pattern normalizing'),

-- Ankle sprain treatments (using existing injury IDs 14-16)
(12, 14, 14, 'Early stages', 'Improving', 'RICE protocol effective'),
(12, 15, 15, 'Progressive loading', 'Good progress', 'Balance exercises added'),
(12, 16, 16, 'Late stage rehab', 'Near recovery', 'Sport-specific training started'),

-- Knee strain treatments (using existing injury IDs 17-19)
(13, 17, 17, 'Initial phase', 'Responding well', 'Pain reducing with treatment'),
(13, 18, 18, 'Mid rehabilitation', 'Steady progress', 'Strength training initiated'),
(13, 19, 19, 'Advanced phase', 'Excellent progress', 'Return to sport planning'),

-- Hamstring strain treatments (using existing injury IDs 20-22)
(14, 20, 20, 'Early intervention', 'Good response', 'Modified training program'),
(14, 21, 21, 'Progressive loading', 'Improving strength', 'Eccentric exercises added'),
(14, 22, 22, 'Final phase', 'Near complete', 'Sport-specific conditioning');

-- Initial Reports
INSERT INTO Health_Report (AthleteID, ReportDate, VitalSigns, HealthNotes)
VALUES
-- Initial health status records
(1, '2024-02-01', 'BP 120/80, HR 65, RR 16', 'Good overall condition'),
(2, '2024-02-15', 'BP 118/78, HR 68, RR 14', 'Recovering from knee strain'),
(3, '2024-01-25', 'BP 122/82, HR 70, RR 18', 'Post-surgical monitoring'),
(4, '2024-02-20', 'BP 116/76, HR 62, RR 15', 'Excellent fitness level'),
(5, '2024-02-10', 'BP 124/84, HR 72, RR 17', 'Concussion protocol ongoing'),
(6, '2024-02-05', 'BP 119/79, HR 64, RR 16', 'Good recovery progress'),
(7, '2024-01-30', 'BP 121/81, HR 69, RR 15', 'Post-ACL surgery status'),
(8, '2024-02-25', 'BP 117/77, HR 63, RR 14', 'Responding well to treatment'),
(9, '2024-02-12', 'BP 123/83, HR 67, RR 16', 'Maintenance phase'),
(10, '2024-02-28', 'BP 120/80, HR 66, RR 15', 'Regular monitoring advised');


-- Complete Athlete_Physician table inserts
INSERT INTO Athlete_Physician (HealthProviderID, AthleteID, Description)
VALUES
-- Initial relationships
(1, 1, 'Primary sports physician for basketball injuries'),
(2, 2, 'Orthopedic specialist for knee rehabilitation'),
(3, 3, 'Shoulder specialist monitoring post-surgery recovery'),
(4, 4, 'General sports medicine physician'),
(5, 5, 'Concussion protocol specialist'),
(6, 6, 'Lower extremity specialist'),
(7, 7, 'ACL reconstruction specialist'),
(8, 8, 'Upper extremity specialist'),
(9, 9, 'Spine specialist'),
(10, 10, 'Hand and wrist specialist'),

-- Additional specialists for ACL injuries
(3, 7, 'Secondary ACL rehabilitation specialist'),
(5, 7, 'Post-surgical pain management specialist'),
(8, 7, 'Physical rehabilitation coordinator'),

-- Additional specialists for concussion management
(2, 5, 'Neurology specialist for concussion'),
(7, 5, 'Balance and vestibular specialist'),
(10, 5, 'Return-to-play protocol supervisor'),

-- Additional specialists for ankle injuries
(4, 1, 'Ankle rehabilitation specialist'),
(6, 1, 'Movement assessment specialist'),
(9, 1, 'Gait analysis expert'),

-- Additional specialists for shoulder cases
(1, 3, 'Post-operative care specialist'),
(8, 3, 'Range of motion specialist'),
(10, 3, 'Rehabilitation protocol supervisor'),

-- Additional specialists for knee injuries
(3, 2, 'Knee stability expert'),
(5, 2, 'Joint rehabilitation specialist'),
(7, 2, 'Return to sport coordinator'),

-- Additional specialists for complex cases
(2, 4, 'Performance optimization specialist'),
(6, 4, 'Injury prevention coordinator'),
(4, 6, 'Recovery protocol specialist'),
(8, 6, 'Biomechanics expert'),
(1, 8, 'Post-injury care coordinator'),
(9, 8, 'Strength training specialist'),
(3, 9, 'Core stability expert'),
(7, 9, 'Posture correction specialist'),
(5, 10, 'Joint mobility specialist'),
(10, 10, 'Fine motor skills expert');

-- Complete SportsPersonnel table inserts
INSERT INTO SportsPersonnel (StaffID, StaffName, StaffContactDetails, StaffAdd_Street, StaffAdd_City, StaffAdd_Apt, StaffAdd_State, StaffAdd_Zip, Role, Prescription_Notes)
VALUES
-- Core staff members
(1, 'Mark Thompson', '617-555-0201', '123 Coach Lane', 'Boston', '3A', 'MA', '02108', 'Head Coach', 'Regular fitness assessment required'),
(2, 'Sarah Williams', '617-555-0202', '456 Training St', 'Cambridge', NULL, 'MA', '02139', 'Assistant Coach', 'Monitor player conditioning'),
(3, 'John Davis', '617-555-0203', '789 Sports Ave', 'Somerville', '5B', 'MA', '02144', 'Strength Coach', 'Weight training protocols'),
(4, 'Lisa Rodriguez', '617-555-0204', '321 Fitness Rd', 'Boston', NULL, 'MA', '02116', 'Athletic Trainer', 'Injury prevention focus'),
(5, 'Michael Chen', '617-555-0205', '654 Team St', 'Cambridge', '2C', 'MA', '02138', 'Performance Analyst', 'Regular performance metrics'),
(6, 'Emily Foster', '617-555-0206', '987 Athletic Dr', 'Somerville', NULL, 'MA', '02145', 'Rehabilitation Specialist', 'Post-injury protocols'),
(7, 'Robert Wilson', '617-555-0207', '147 Training Lane', 'Boston', '4D', 'MA', '02115', 'Nutrition Coach', 'Dietary requirements'),
(8, 'Amanda Martinez', '617-555-0208', '258 Coach St', 'Cambridge', NULL, 'MA', '02140', 'Mental Skills Coach', 'Performance psychology notes'),
(9, 'David Lee', '617-555-0209', '369 Sports Rd', 'Somerville', '1E', 'MA', '02143', 'Equipment Manager', 'Equipment fitting requirements'),
(10, 'Jennifer Taylor', '617-555-0210', '741 Team Ave', 'Boston', NULL, 'MA', '02109', 'Program Coordinator', 'Schedule coordination notes'),

-- Additional sport-specific staff
(11, 'Kevin Brown', '617-555-0211', '852 Basketball Ct', 'Boston', '2F', 'MA', '02110', 'Basketball Skills Coach', 'Individual skill development'),
(12, 'Maria Garcia', '617-555-0212', '963 Soccer Field', 'Cambridge', NULL, 'MA', '02141', 'Soccer Technical Coach', 'Technical drills focus'),
(13, 'James Wilson', '617-555-0213', '159 Football Ave', 'Somerville', '6C', 'MA', '02145', 'Football Specialist', 'Position-specific training'),
(14, 'Anna Lee', '617-555-0214', '357 Volleyball Ct', 'Boston', NULL, 'MA', '02117', 'Volleyball Coach', 'Jump training program'),

-- Support staff
(15, 'Thomas Moore', '617-555-0215', '246 Health St', 'Cambridge', '4E', 'MA', '02142', 'Wellness Coordinator', 'Holistic health approach'),
(16, 'Laura Chen', '617-555-0216', '135 Recovery Rd', 'Somerville', NULL, 'MA', '02146', 'Recovery Specialist', 'Post-game recovery protocols'),
(17, 'Daniel Smith', '617-555-0217', '468 Training Ctr', 'Boston', '1G', 'MA', '02111', 'Performance Coach', 'Specialized training plans'),
(18, 'Rachel Kim', '617-555-0218', '579 Fitness Ave', 'Cambridge', NULL, 'MA', '02143', 'Fitness Coordinator', 'General fitness monitoring'),
(19, 'Patrick Johnson', '617-555-0219', '791 Sports Med', 'Somerville', '3H', 'MA', '02147', 'Medical Coordinator', 'Injury tracking system'),
(20, 'Sofia Martinez', '617-555-0220', '824 Team Building', 'Boston', NULL, 'MA', '02112', 'Team Operations', 'Logistical support');


-- Then insert the data
INSERT INTO HealthProvider_Treatment (HealthProviderID, TreatmentID, TreatmentDetails, Duration)
VALUES
(1, 1, 'Physical therapy sessions for ankle rehabilitation including ROM exercises and strength training', 6.0),
(2, 2, 'Knee rehabilitation protocol with focus on stability and strength development', 4.5),
(3, 3, 'Post-surgical shoulder rehabilitation including passive and active ROM exercises', 12.0),
(4, 4, 'Deep tissue massage and myofascial release for muscle strain', 2.0),
(5, 5, 'Structured concussion recovery protocol with gradual return to activity', 3.0),
(6, 6, 'Ice therapy sessions combined with compression therapy for shin splints', 1.5),
(7, 7, 'Comprehensive ACL reconstruction rehabilitation program', 24.0),
(8, 8, 'Tennis elbow treatment including ultrasound therapy and exercises', 4.0),
(9, 9, 'Spinal manipulation and core strengthening program', 3.5),
(10, 10, 'Wrist rehabilitation including mobilization and strengthening exercises', 5.0);
-- Corrected INSERT statement with unique CoachStaffID values
INSERT INTO Athelete_SportsPersonnel (CoachStaffID, AthleteID, Exercise_Regime)
VALUES
-- Initial assignments
(1, 1, 'Advanced basketball conditioning program with focus on agility'),
(2, 2, 'Soccer-specific endurance training with sprint work'),
(3, 3, 'Modified football training program during injury recovery'),
(4, 4, 'Volleyball power development and jump training'),
(5, 5, 'Light conditioning program following concussion protocol'),
(6, 6, 'Soccer skill development with aerobic conditioning'),
(7, 7, 'Post-surgery rehabilitation exercises'),
(8, 8, 'Volleyball technique training with modified intensity'),
(9, 9, 'Basketball shooting drills and conditioning'),
(10, 10, 'Soccer tactical training with fitness components');


