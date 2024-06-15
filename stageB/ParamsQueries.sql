-- List all drivers available within a specific time range.
SELECT driver.DriverID, driver.FullName
FROM Driver driver 
JOIN Drivesintaxi drivesintaxi ON driver.driverid = drivesintaxi.driverid
WHERE driver.DriverID NOT IN (
    SELECT DriverID
    FROM DrivesInTaxi drivesintaxi
    WHERE (TO_TIMESTAMP('&StartTime', 'HH24:MI:SS') BETWEEN TO_TIMESTAMP(drivesintaxi.StartTime, 'HH24:MI:SS') AND TO_TIMESTAMP(drivesintaxi.FinishTime, 'HH24:MI:SS') 
       OR TO_TIMESTAMP('&FinishTime', 'HH24:MI:SS') BETWEEN TO_TIMESTAMP(drivesintaxi.StartTime, 'HH24:MI:SS') AND TO_TIMESTAMP(drivesintaxi.FinishTime, 'HH24:MI:SS'))
)
AND drivesintaxi.WorkingZone = '&WorkingZone';

-- Query 2: List drivers with the most bus rides in a specific period.
SELECT driver.DriverID, driver.FullName, COUNT(busride.BusID) AS NumberOfRides
FROM Driver driver
JOIN BusRide busride ON driver.DriverID = busride.DriverID
WHERE TO_TIMESTAMP(busride.StartTime, 'HH24:MI:SS') BETWEEN TO_TIMESTAMP('&StartPeriod', 'HH24:MI:SS') AND TO_TIMESTAMP('&EndPeriod', 'HH24:MI:SS')
GROUP BY driver.DriverID, driver.FullName
ORDER BY NumberOfRides DESC;


-- Query 3: Retrieve the driver who works the most hours in a specific working zone.
SELECT 
    driverinstaxi.DriverID, 
    driver.FullName,
    SUM(
        (EXTRACT(HOUR FROM (TO_TIMESTAMP(driverinstaxi.FinishTime, 'HH24:MI:SS') - TO_TIMESTAMP(driverinstaxi.StartTime, 'HH24:MI:SS'))) * 60 
        + EXTRACT(MINUTE FROM (TO_TIMESTAMP(driverinstaxi.FinishTime, 'HH24:MI:SS') - TO_TIMESTAMP(driverinstaxi.StartTime, 'HH24:MI:SS')))) / 60
    ) AS TotalHours
FROM DrivesInTaxi driverinstaxi
JOIN Driver driver ON driverinstaxi.DriverID = driver.DriverID
WHERE driverinstaxi.WorkingZone = '&WorkingZone'
GROUP BY driverinstaxi.DriverID, driver.FullName
ORDER BY TotalHours DESC
FETCH FIRST 1 ROWS ONLY;


-- Query 4: Retrieve lines starting from a specific station
SELECT 
    line.LineID,
    start_station.StationName AS StartStationName,
    end_station.StationName AS EndStationName,
    line.LineName
FROM Line line
JOIN Station start_station ON line.StartOfStationID = start_station.StationID
JOIN Station end_station ON line.EndOfStationID = end_station.StationID
WHERE start_station.StationName = '&<name="StationName" list="SELECT StationName from Station">' 
