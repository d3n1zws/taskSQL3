CREATE DATABASE task5


USE task5


CREATE TABLE Patients(
FirstName VARCHAR(20) CHECK(len(FirstName) > 2) NOT NULL,
LastName VARCHAR(25) CHECK(len(LastName) > 2) NOT NULL,
BirthDate DATETIME2 NOT NULL CHECK(BirthDate < GETDATE()),
Email VARCHAR(30) NOT NULL UNIQUE
)


CREATE TABLE Doctors(
FirstName VARCHAR(20) CHECK(len(FirstName) > 2) NOT NULL,
LastName VARCHAR(25) CHECK(len(LastName) > 2) NOT NULL,
Experience INT NOT NULL CHECK(Experience > 0)
)


ALTER TABLE Patients
ADD Id INT IDENTITY(1, 1) PRIMARY KEY


ALTER TABLE Doctors
ADD Id INT IDENTITY(1, 1) PRIMARY KEY


CREATE TABLE Departments(
[Name] VARCHAR(40) UNIQUE NOT NULL CHECK(len([Name]) > 2),
Id INT PRIMARY KEY IDENTITY(1, 1)
)


CREATE TABLE DoctorDepartments(
DoctorId INT REFERENCES Doctors(Id),
DepartmentId INT REFERENCES Departments(Id),
PRIMARY KEY(DoctorId, DepartmentId)
)

CREATE TABLE DoctorPatient(
DoctorId INT REFERENCES Doctors(Id),
PatientId INT REFERENCES Patients(Id),
[Date] DATETIME2 NOT NULL,
Result VARCHAR(15) CHECK(Result IN ('Pending', 'Completed', 'Cancelled'))
)

INSERT INTO Patients(FirstName, LastName, BirthDate, Email)
VALUES
('name1', 'surname1', '2011-09-17', 'name1@mail.com'),
('name2', 'surname2', '2010-06-01', 'name2@mail.com'),
('name3', 'surname3', '2007-09-17', 'name3@mail.com'),
('name4', 'surname4', '2005-12-12', 'name4@mail.com'),
('name5', 'surname5', '2009-05-24', 'name5@mail.com')

SELECT *
FROM Patients


INSERT INTO Doctors(FirstName, LastName, Experience)
VALUES
('doc1', 'surdoc1', 15),
('doc2', 'surdoc2', 20),
('doc3', 'surdoc3', 10),
('doc4', 'surdoc4', 30),
('doc5', 'surdoc5', 25)

SELECT *
FROM Doctors


INSERT INTO Departments([Name])
VALUES
('dep1'),
('dep2'),
('dep3'),
('dep4'),
('dep5')



SELECT * 
FROM Departments


INSERT INTO DoctorPatient(DoctorId, PatientId, [Date], Result)
VALUES
(1, 1, '2026-01-05', 'Completed'),
(1, 2, '2026-07-09', 'Completed'),
(3, 4, '2026-09-17', 'Pending'),
(5, 3, '2027-06-23', 'Cancelled'),
(2, 5, '2027-01-01', 'Pending')


SELECT *
FROM DoctorPatient



INSERT INTO DoctorDepartments(DepartmentId, DoctorId)
VALUES
(1, 5),
(2, 3),
(3, 4),
(3, 1),
(5, 2),
(1, 3),
(2, 4)


SELECT dc.FirstName, dc.LastName, dc.Experience, dp.Name AS DepartmentName
FROM Doctors AS dc
JOIN DoctorDepartments AS dd
ON dd.DoctorId = dc.Id
JOIN Departments AS dp
ON dp.Id = dd.DepartmentId



SELECT
dc.FirstName AS DoctorFirstName,
dc.LastName AS DoctorLastName,
dc.Experience,
p.FirstName AS PatientFirstName,
p.LastName AS PatientLastName,
dp.Date,
dp.Result
FROM Doctors AS dc
JOIN DoctorPatient AS dp
ON dp.DoctorId = dc.Id
JOIN Patients AS p
ON p.Id = dp.PatientId


SELECT 
dc.FirstName AS DoctorFirstName,
dc.LastName AS DoctorLastName,
dp.Result
FROM Doctors AS dc
JOIN DoctorPatient AS dp
ON dp.DoctorId = dc.Id
JOIN Patients AS p
ON p.Id = dp.PatientId
WHERE p.Id = 1


INSERT INTO DoctorPatient(DoctorId, PatientId, Date, Result)
VALUES
(1, 1, SYSDATETIME(), 'Pending'),
(3, 5, SYSDATETIME(), 'Cancelled')



SELECT 
p.FirstName,
p.LastName
FROM Doctors AS dc
JOIN DoctorPatient AS dp
ON dp.DoctorId = dc.Id
JOIN Patients AS p
ON p.Id = dp.PatientId
WHERE dc.Id = 1 AND dp.[Date] >= CAST(GETDATE() AS DATE) AND dp.[Date] < DATEADD(DAY, 1, CAST(GETDATE() AS DATE))



CREATE TABLE Medicine(
[Name] VARCHAR(20) CHECK(len([Name]) > 2) UNIQUE NOT NULL,
Id INT IDENTITY(1, 1) PRIMARY KEY
)

INSERT INTO Medicine([Name])
VALUES
('med1'),
('med2'),
('med3'),
('med4'),
('med5')



ALTER TABLE DoctorPatient
DROP MedicineId 



SELECT *
FROM Patients AS p
JOIN PatientMedicine AS pm
ON pm.PatientId = p.Id
JOIN Medicine AS m
ON pm.MedicineId = m.Id



ALTER TABLE DoctorPatient
DROP CONSTRAINT FK__DoctorPat__Medic__7F2BE32F


ALTER TABLE DoctorPatient
DROP COLUMN MedicineId

CREATE TABLE DoctorPatientMedicine(
DoctorId INT REFERENCES Doctors(Id),
MedicineId INT REFERENCES Medicine(Id),
PatientId INT REFERENCES Patients(Id)
)


INSERT INTO DoctorPatientMedicine(DoctorId, PatientId, MedicineId)
VALUES
(1, 1, 1),
(1, 2, 2),
(3, 4, 3),
(5, 3, 4),
(2, 5, 5)