-- Constraint 1: Unique License Plate
ALTER TABLE Taxi
ADD CONSTRAINT uc_LicensePlate UNIQUE (LicensePlate);

-- Constraint 2: Default value for driver's name
ALTER TABLE Driver
ALTER COLUMN FullName SET DEFAULT 'Dekel Vaknin';

-- Constraint 3: Preventing overlapping bus rides for a driver
ALTER TABLE BusRide
ADD CONSTRAINT chk_NoOverlappingBusRides
CHECK (
    NOT EXISTS (
        SELECT 1
        FROM BusRide br1
        INNER JOIN BusRide br2 ON br1.DriverID = br2.DriverID
        WHERE br1.BusID <> br2.BusID
        AND br1.LineID <> br2.LineID
        AND (
            (br1.StartTime BETWEEN br2.StartTime AND br2.FinishTime)
            OR (br1.FinishTime BETWEEN br2.StartTime AND br2.FinishTime)
            OR (br2.StartTime BETWEEN br1.StartTime AND br1.FinishTime)
            OR (br2.FinishTime BETWEEN br1.StartTime AND br1.FinishTime)
        )
    )
);

-- Constraint 3: Preventing overlapping drives in taxi for a driver
ALTER TABLE DrivesInTaxi
ADD CONSTRAINT chk_NoOverlappingDrivesInTaxi
CHECK (
    NOT EXISTS (
        SELECT 1
        FROM DrivesInTaxi dt1
        INNER JOIN DrivesInTaxi dt2 ON dt1.DriverID = dt2.DriverID
        WHERE dt1.TaxiID <> dt2.TaxiID
        AND (
            (dt1.StartTime BETWEEN dt2.StartTime AND dt2.FinishTime)
            OR (dt1.FinishTime BETWEEN dt2.StartTime AND dt2.FinishTime)
            OR (dt2.StartTime BETWEEN dt1.StartTime AND dt1.FinishTime)
            OR (dt2.FinishTime BETWEEN dt1.StartTime AND dt1.FinishTime)
        )
    )
);

-- Constraint 4: Preventing two lines from having the same path
ALTER TABLE Line
ADD CONSTRAINT chk_UniqueLinePath
UNIQUE (StartOfStationID, EndOfStationID);

