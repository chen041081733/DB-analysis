create database PoliceData

USE PoliceData

---create stage table for detail table
CREATE TABLE Staging_Bike_Theft_Data (
    OBJECTID INT,
    ID INT,
    Year INT,
    ReportedDate DATETIME,
    OccurredDate DATETIME,
    DayOfWeek VARCHAR(20),
    OffenceCategory VARCHAR(100),
    BicycleStyle VARCHAR(100),
    BicycleValue INT,
    BicycleMake VARCHAR(100),
    BicycleModel VARCHAR(100),
    BicycleType VARCHAR(100),
    BicycleFrame VARCHAR(100),
    BicycleColour VARCHAR(100),
    BicycleSpeed VARCHAR(20),  -- Temporarily store as VARCHAR
    Neighbourhood VARCHAR(100),
    Sector VARCHAR(50),
    Division VARCHAR(50),
    CensusTract VARCHAR(50),
    x VARCHAR(50),
    y VARCHAR(50)
);

-- Create Detail Table
CREATE TABLE Criminal_Detail (
    Theft_ID INT PRIMARY KEY,
    BicycleStyle NVARCHAR(255),
    BicycleValue NVARCHAR(255),
    BicycleMake NVARCHAR(255),
    BicycleModel NVARCHAR(255),
    BicycleType NVARCHAR(255),
    BicycleFrame NVARCHAR(255),
    BicycleColour NVARCHAR(50),
    BicycleSpeed NVARCHAR(255)
);


----upload data to stage theft table
BULK INSERT Staging_Bike_Theft_Data
FROM 'C:\algonquin\2024F\2112-Data Engineering & Integration\2112 assignment\group assignment\ga4_ottawaPolice\Bike_Theft_Open_Data.csv'
WITH  (
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n', 
    FIRSTROW = 2-- Skip the header row
);

select * from  Staging_Bike_Theft_Data

---transfer selected data from staging table to detail table
INSERT INTO Criminal_Detail (
    Theft_ID,
    BicycleStyle,
    BicycleValue,
    BicycleMake,
    BicycleModel,
    BicycleType,
    BicycleFrame,
    BicycleColour,
    BicycleSpeed
)
SELECT
    ID AS Theft_ID,
    BicycleStyle,
    BicycleValue,
    BicycleMake,
    BicycleModel,
    BicycleType,
    BicycleFrame,
    BicycleColour,
	BicycleSpeed
    FROM 
	Staging_Bike_Theft_Data

select * from Criminal_Detail

---create stage table for detail table
CREATE TABLE Staging_Criminal_Offences_Data (
Object_ID INT PRIMARY KEY,
    Year INT,
    ReportedDate DATE,
    ReprotedHour INT,
	OccurredDate DATE,
    OccurrencyHour INT,
	DayOfWeek NVARCHAR(50),
    OffenseSummary NVARCHAR(255),
    OffenseCategory NVARCHAR(255),
    Neighbourhood NVARCHAR(255),
    Sector NVARCHAR(50),
    Division NVARCHAR(50),
    CensusTract NVARCHAR(50),
    x FLOAT NULL,
    y FLOAT NULL
);

-- Create Criminal_Master Table
CREATE TABLE Criminal_Master (
    Criminal_ID INT IDENTITY(1,1) PRIMARY KEY,
    Theft_ID Int,
	Year INT,
    ReportedDate DATE,
    ReprotedHour INT,
	OccurredDate DATE,
    OccurrencyHour INT,
	DayOfWeek NVARCHAR(50),
    OffenseSummary NVARCHAR(255),
    OffenseCategory NVARCHAR(255),
    Neighbourhood NVARCHAR(255),
    Sector NVARCHAR(50),
    Division NVARCHAR(50),
    CensusTract NVARCHAR(50),
    x FLOAT NULL,
    y FLOAT NULL
);

----upload data to stage criminal offences table
BULK INSERT Staging_Criminal_Offences_Data
FROM 'C:\algonquin\2024F\2112-Data Engineering & Integration\2112 assignment\group assignment\ga4_ottawaPolice\Criminal_offences_Open_Data.csv'
WITH  (
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n', 
    FIRSTROW = 2-- Skip the header row
);

alter 


---transfer selected data from staging criminal offences table to master table
INSERT INTO Criminal_master (
    Theft_ID ,
	Year ,
    ReportedDate ,
    ReprotedHour ,
	OccurredDate ,
    OccurrencyHour ,
	DayOfWeek ,
    OffenseSummary ,
    OffenseCategory ,
    Neighbourhood ,
    Sector ,
    Division ,
    CensusTract ,
    x,
    y
)
SELECT
    NULL AS theft_ID,
    Year,
    ReportedDate ,
    ReprotedHour ,
	OccurredDate ,
    OccurrencyHour ,
	DayOfWeek ,
    OffenseSummary ,
    OffenseCategory ,
    Neighbourhood ,
    Sector ,
    Division ,
    CensusTract ,
    x ,
    y 
FROM 
	Staging_criminal_offences_Data;


ALTER TABLE Criminal_master
ALTER COLUMN x VARCHAR(50) NOT NULL;

ALTER TABLE Criminal_master
ALTER COLUMN y VARCHAR(50) NOT NULL;

---transfer selected data from staging theft table to master table
INSERT INTO Criminal_master (
    Theft_ID ,
	Year ,
    ReportedDate ,
    ReprotedHour ,
	OccurredDate ,
    OccurrencyHour ,
	DayOfWeek ,
    OffenseSummary ,
    OffenseCategory ,
    Neighbourhood ,
    Sector ,
    Division ,
    CensusTract ,
    x,
    y
)
SELECT
    ID as theft_ID,
    Year,
    ReportedDate ,
    NULL AS ReprotedHour ,
  	OccurredDate ,
    NULL AS OccurrencyHour ,
	DayOfWeek ,
    NULL AS OffenseSummary ,
    OffenceCategory ,
    Neighbourhood ,
    Sector ,
    Division ,
    CensusTract ,
    x ,
    y 
FROM 
	Staging_Bike_Theft_Data;


select * from Criminal_Master


