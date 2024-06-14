-- Query 2: List drivers with the most bus rides in a specific period.
SELECT driver.DriverID, driver.FullName, COUNT(busride.BusID) AS NumberOfRides
FROM Driver driver
JOIN BusRide busride ON driver.DriverID = busride.DriverID
WHERE TO_TIMESTAMP(busride.StartTime, 'HH24:MI:SS') BETWEEN TO_TIMESTAMP('&StartPeriod', 'HH24:MI:SS') AND TO_TIMESTAMP('&EndPeriod', 'HH24:MI:SS')
GROUP BY driver.DriverID, driver.FullName
ORDER BY NumberOfRides DESC;
