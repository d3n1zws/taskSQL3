CREATE DATABASE task4



USE task4

CREATE TABLE Depots(
Id INT IDENTITY(1, 1) PRIMARY KEY,
[Name] VARCHAR(30) CHECK(len([Name]) > 2) UNIQUE NOT NULL,
City VARCHAR(30) NOT NULL,
ZipCode CHAR(7) NOT NULL check(len(ZipCode) = 7)
)



CREATE TABLE Medicines(
Id INT IDENTITY(1, 1) PRIMARY KEY,
[Name] VARCHAR(30) UNIQUE NOT NULL CHECK(len([Name]) > 3),
Manufacturer VARCHAR(30) NOT NULL CHECK(len(Manufacturer) > 2),
Price INT NOT NULL
)


CREATE TABLE Pharmacies(
Id INT IDENTITY(1, 1) PRIMARY KEY,
[Name] VARCHAR(30) UNIQUE NOT NULL CHECK(len([Name]) > 3),
City VARCHAR(30) NOT NULL CHECK(len(City) > 3),
ZipCode CHAR(7) NOT NULL check(len(ZipCode) = 7)
)


CREATE TABLE DepotMedicines(
Id INT IDENTITY(1, 1) PRIMARY KEY,
DepotId INT REFERENCES Depots(Id) NOT NULL,
MedicineId INT REFERENCES Medicines(Id) NOT NULL,
Quantity INT NOT NULL CHECK(Quantity > 0),
UNIQUE(DepotId, MedicineId)
)


CREATE TABLE PharmacyMedicines(
Id INT IDENTITY(1, 1) PRIMARY KEY,
PharmacyId INT REFERENCES Pharmacies(Id) NOT NULL,
MedicineId INT REFERENCES Medicines(Id) NOT NULL,
Quantity INT NOT NULL CHECK(Quantity > 0),
UNIQUE(PharmacyId, MedicineId)
)


SELECT 
m.Name AS MedicineName,
m.Price,
m.Manufacturer, 
d.Name AS DepotName,
p.Name AS PharmacyName
FROM Medicines AS m
LEFT JOIN DepotMedicines AS dm
ON m.Id = dm.MedicineId
JOIN Depots AS d
ON d.Id = dm.DepotId
LEFT JOIN PharmacyMedicines as pm
ON pm.MedicineId = m.Id
JOIN Pharmacies AS p
ON p.Id = pm.PharmacyId
ORDER BY m.Name ASC





