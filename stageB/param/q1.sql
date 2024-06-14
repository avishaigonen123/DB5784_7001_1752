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
