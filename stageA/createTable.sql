-- Create Station Table
CREATE TABLE Station (
    StationID INT NOT NULL,
    StationName VARCHAR(100) NOT NULL, -- Name of the station
    StationAddress VARCHAR(255) NOT NULL, -- Address of the station
    PRIMARY KEY (StationID)
);

-- Create Driver Table
CREATE TABLE Driver (
    DriverID INT NOT NULL,
    FullName VARCHAR(100) NOT NULL, -- Name of the driver
    LicenseNumber INT NOT NULL, -- License number of the driver
    HireDate DATE NOT NULL, -- Hire date of the driver
    PRIMARY KEY (DriverID)
);
-- Create Schedule Table
CREATE TABLE Schedule (
    ScheduleID INT NOT NULL, -- Unique identifier for the schedule
    Frequency INT NOT NULL, -- Frequency of the schedule
    FirstDepartureTime VARCHAR2(8) NOT NULL, -- First departure time in HH24:MI:SS format
    LastDepartureTime VARCHAR2(8) NOT NULL, -- Last departure time in HH24:MI:SS format
    PRIMARY KEY (ScheduleID),
    CONSTRAINT chk_FirstDepartureTime CHECK (REGEXP_LIKE(FirstDepartureTime, '^\d{2}:\d{2}:\d{2}$')),
    CONSTRAINT chk_LastDepartureTime CHECK (REGEXP_LIKE(LastDepartureTime, '^\d{2}:\d{2}:\d{2}$'))
);

-- Create Taxi Table
CREATE TABLE Taxi (
    TaxiID INT NOT NULL,
    WorkingZone VARCHAR(100) NOT NULL, -- Working zone of the taxi
    StartTime VARCHAR2(8) NOT NULL, -- Start time of the taxi shift in HH24:MI:SS format
    FinishTime VARCHAR2(8) NOT NULL, -- Finish time of the taxi shift in HH24:MI:SS format
    PRIMARY KEY (TaxiID),
    CONSTRAINT chk_StartTime CHECK (REGEXP_LIKE(StartTime, '^\d{2}:\d{2}:\d{2}$')),
    CONSTRAINT chk_FinishTime CHECK (REGEXP_LIKE(FinishTime, '^\d{2}:\d{2}:\d{2}$'))

);

-- Create Line Table
CREATE TABLE Line (
    LineID INT NOT NULL,
    LineName VARCHAR(100) NOT NULL, -- Name of the line
    ScheduleID INT NOT NULL, -- Foreign Key referencing Schedule
    StartOfStationID INT NOT NULL, -- Foreign Key referencing Station (start station)
    EndOfStationID INT NOT NULL, -- Foreign Key referencing Station (end station)
    PRIMARY KEY (LineID),
    FOREIGN KEY (ScheduleID) REFERENCES Schedule(ScheduleID),
    FOREIGN KEY (StartOfStationID) REFERENCES Station(StationID),
    FOREIGN KEY (EndOfStationID) REFERENCES Station(StationID)
);


-- Create Bus Table
CREATE TABLE Bus (
    BusID INT NOT NULL,
    Model VARCHAR(100) NOT NULL, -- Model of the bus
    Capacity INT NOT NULL, -- Capacity of the bus
    PurchaseDate DATE NOT NULL, -- Purchase date of the bus
    PRIMARY KEY (BusID)
);

-- Create BusRide Table
CREATE TABLE BusRide (
    BusID INT NOT NULL, -- Foreign Key referencing Bus
    LineID INT NOT NULL, -- Foreign Key referencing Line
    ScheduleID INT NOT NULL, -- Foreign Key referencing Schedule
    PRIMARY KEY (BusID, LineID, ScheduleID),
    FOREIGN KEY (BusID) REFERENCES Bus(BusID),
    FOREIGN KEY (LineID) REFERENCES Line(LineID),
    FOREIGN KEY (ScheduleID) REFERENCES Schedule(ScheduleID)
);

-- Create DrivesInTaxi Table
CREATE TABLE DrivesInTaxi (
    DriverID INT NOT NULL, -- Foreign Key referencing Driver
    TaxiID INT NOT NULL, -- Foreign Key referencing Taxi
    PRIMARY KEY (DriverID, TaxiID),
    FOREIGN KEY (DriverID) REFERENCES Driver(DriverID),
    FOREIGN KEY (TaxiID) REFERENCES Taxi(TaxiID)
);

