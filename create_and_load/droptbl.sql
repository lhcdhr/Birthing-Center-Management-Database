-- Include your drop table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the drop table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been dropped (reverse of the creation order).

-- This is only an example of how you add drop table ddls to this file.
--   You may remove it.
DROP TABLE Mothers;
DROP TABLE Fathers;
DROP TABLE Couples;
DROP TABLE Healthcare_Institutions;
DROP TABLE Community_Clinics;
DROP TABLE Birthing_Centers;
DROP TABLE Midwives;
DROP TABLE Pregnancies;
DROP TABLE Babies;
DROP TABLE Info_Sessions;
DROP TABLE invites;
DROP TABLE registers;
DROP TABLE attends;
DROP TABLE Appointments;
DROP TABLE Notes;
DROP TABLE Technicians;
DROP TABLE Tests;
DROP TABLE Dating_Ultrasounds;
DROP TABLE estimates;

