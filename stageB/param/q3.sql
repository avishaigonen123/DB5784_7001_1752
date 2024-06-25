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
WHERE driverinstaxi.WorkingZone = '&<name="WorkingZone" list="SELECT WorkingZone from DrivesInTaxi driverinstaxi
JOIN Driver driver ON driverinstaxi.DriverID = driver.DriverID">'  
GROUP BY driverinstaxi.DriverID, driver.FullName
ORDER BY TotalHours DESC
FETCH FIRST 1 ROWS ONLY;
