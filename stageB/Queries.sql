-- Query 1: get the drivers names that drive in a Taxi and there Taxi licenses plate and there working zone and order by the name
SELECT Driver.FullName, Taxi.LicensePlate, DrivesInTaxi.WorkingZone
FROM Driver
JOIN DrivesInTaxi ON Driver.DriverID = DrivesInTaxi.DriverID
JOIN Taxi ON DrivesInTaxi.TaxiID = Taxi.TaxiID
ORDER BY Driver.FullName;

-- Query 2: Select the bus model that has the highest number of associated rides in the BusRide table
SELECT bus.Model, COUNT(*) AS TotalRides
FROM Bus bus
JOIN BusRide busride ON bus.BusID = busride.BusID
GROUP BY bus.Model
ORDER BY TotalRides DESC
FETCH FIRST 1 ROWS ONLY;

-- Query 3: Select the total number of schedules and average frequency for each bus line, including line names
SELECT lne.LineName, schedule.FirstDepartureTime
FROM Line lne
JOIN Schedule schedule ON lne.ScheduleID = schedule.ScheduleID
JOIN Station start_station ON lne.StartOfStationID = start_station.StationID
JOIN Station end_station ON lne.EndOfStationID = end_station.StationID
WHERE start_station.StationName = 'Elon Morre'
  AND end_station.StationName = 'Malha Mall'
  AND TO_TIMESTAMP(schedule.FirstDepartureTime, 'HH24:MI:SS') >= TO_TIMESTAMP('17:00:00', 'HH24:MI:SS');

-- Query 4: Select all bus rides with drivers who have been hired before a certain date
SELECT driver.FullName, driver.HireDate
FROM BusRide busride
JOIN Driver driver ON busride.DriverID = driver.DriverID
WHERE MONTHS_BETWEEN(SYSDATE, driver.HireDate) / 12 >= 2;
