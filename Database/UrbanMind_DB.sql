CREATE DATABASE UrbanMind;
USE UrbanMind;

CREATE TABLE CityZones (
    ZoneID VARCHAR(10) PRIMARY KEY,
    ZoneName VARCHAR(100) NOT NULL,
    ZoneType VARCHAR(50),
    Population INT,
    AreaSize DECIMAL(10,2),
    GreenCoverage DECIMAL(5,2)
    );

INSERT INTO CityZones VALUES
('Z001','Central District','Commercial',150000,25.50,12.00),
('Z002','North Zone','Residential',220000,40.00,18.50),
('Z003','South Zone','Residential',180000,35.00,15.00),
('Z004','East Industrial Zone','Industrial',100000,30.00,8.00),
('Z005','West Green Zone','Eco Zone',80000,50.00,60.00);



  CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
    );          


INSERT INTO Users
(FullName, Email, PasswordHash, Role)
VALUES
('Muskaan Kumari', 'muskaan@example.com', 'abc123', 'Admin');

INSERT INTO Users (FullName, Email, PasswordHash, Role)
VALUES
('Muskaan Kumari', 'muskaan@example.com', 'hashedpassword1', 'Admin'),
('Rahul Kumar', 'rahul@example.com', 'hashedpassword2', 'Citizen'),
('Priya Singh', 'priya@example.com', 'hashedpassword3', 'UrbanPlanner');



CREATE TABLE Complaints (
    ComplaintID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    ZoneID VARCHAR(10) NOT NULL,
    Title VARCHAR(200) NOT NULL,
    Description VARCHAR(1000) NOT NULL,
    Category VARCHAR(50),
    Status VARCHAR(20) DEFAULT 'Pending',
    CreatedAt DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ZoneID) REFERENCES CityZones(ZoneID)
    );

INSERT INTO Complaints
(UserID, ZoneID, Title, Description, Category)
VALUES
(1, 'Z002','Traffic Congestion','Heavy traffic during office hours','Traffic');

SELECT * FROM Users;
SELECT * FROM CityZones;
SELECT * FROM Complaints;

SELECT
    C.ComplaintID,
    U.FullName,
    Z.ZoneName,
    C.Title,
    C.Status
FROM Complaints C
JOIN Users U ON C.UserID = U.UserID
JOIN CityZones Z ON C.ZoneID = Z.ZoneID;

                                    -- TrafficData Table

CREATE TABLE TrafficData (
    TrafficID INT PRIMARY KEY IDENTITY(1,1),
    ZoneID VARCHAR(10) NOT NULL,
    VehicleCount INT NOT NULL,
    TrafficIndex DECIMAL(5,2),
    RecordDate DATE,

    FOREIGN KEY (ZoneID)
    REFERENCES CityZones(ZoneID)
);

INSERT INTO TrafficData
(ZoneID, VehicleCount, TrafficIndex, RecordDate)
VALUES
('Z001', 25000, 82.5, '2026-06-18'),

('Z002', 18000, 65.3, '2026-06-18'),

('Z003', 15000, 55.7, '2026-06-18'),

('Z004', 12000, 48.2, '2026-06-18'),

('Z005', 5000, 20.1, '2026-06-18');


SELECT
    C.ZoneName,
    T.VehicleCount,
    T.TrafficIndex
FROM CityZones C
JOIN TrafficData T
ON C.ZoneID = T.ZoneID;



                                         --AQIData

    CREATE TABLE AQIData (
    AQIID INT PRIMARY KEY IDENTITY(1,1),
    ZoneID VARCHAR(10) NOT NULL,
    AQIValue INT NOT NULL,
    CO2Level DECIMAL(10,2),
    RecordDate DATE,

    FOREIGN KEY (ZoneID)
    REFERENCES CityZones(ZoneID)
    );

INSERT INTO AQIData
(ZoneID, AQIValue, CO2Level, RecordDate)
VALUES
('Z001', 180, 420.50, '2026-06-18'),
('Z002', 140, 350.20, '2026-06-18'),
('Z003', 120, 300.80, '2026-06-18'),
('Z004', 210, 500.60, '2026-06-18'),
('Z005', 60, 180.30, '2026-06-18');

SELECT
    C.ZoneName,
    A.AQIValue,
    A.CO2Level
FROM CityZones C
JOIN AQIData A
ON C.ZoneID = A.ZoneID;


                          --WaterConsumption

CREATE TABLE WaterConsumption (
    WaterID INT PRIMARY KEY IDENTITY(1,1),
    ZoneID VARCHAR(10) NOT NULL,
    UsageLitres DECIMAL(12,2),
    RecordDate DATE,

    FOREIGN KEY (ZoneID)
    REFERENCES CityZones(ZoneID)
);



INSERT INTO WaterConsumption
(ZoneID, UsageLitres, RecordDate)
VALUES
('Z001', 850000, '2026-06-18'),
('Z002', 1200000, '2026-06-18'),
('Z003', 1000000, '2026-06-18'),
('Z004', 700000, '2026-06-18'),
('Z005', 400000, '2026-06-18');



                                          --EnergyConsumption

CREATE TABLE EnergyConsumption (
    EnergyID INT PRIMARY KEY IDENTITY(1,1),
    ZoneID VARCHAR(10) NOT NULL,
    UnitsConsumed DECIMAL(12,2),
    RecordDate DATE,

    FOREIGN KEY (ZoneID)
    REFERENCES CityZones(ZoneID)
);


INSERT INTO EnergyConsumption
(ZoneID, UnitsConsumed, RecordDate)
VALUES
('Z001', 250000, '2026-06-18'),
('Z002', 320000, '2026-06-18'),
('Z003', 280000, '2026-06-18'),
('Z004', 350000, '2026-06-18'),
('Z005', 120000, '2026-06-18');


SELECT
    CZ.ZoneName,
    T.TrafficIndex,
    A.AQIValue,
    W.UsageLitres,
    E.UnitsConsumed
FROM CityZones CZ
JOIN TrafficData T ON CZ.ZoneID = T.ZoneID
JOIN AQIData A ON CZ.ZoneID = A.ZoneID
JOIN WaterConsumption W ON CZ.ZoneID = W.ZoneID
JOIN EnergyConsumption E ON CZ.ZoneID = E.ZoneID;
