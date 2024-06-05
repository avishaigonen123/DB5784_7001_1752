-- Query 1: get the drivers names that drive in a Taxi and there Taxi licenses plate and there working zone and order by the name
SELECT Driver.FullName, Taxi.LicensePlate, DrivesInTaxi.WorkingZone
FROM Driver
JOIN DrivesInTaxi ON Driver.DriverID = DrivesInTaxi.DriverID
JOIN Taxi ON DrivesInTaxi.TaxiID = Taxi.TaxiID
ORDER BY Driver.FullName;

-- Query 2: Select the bus model that has the highest number of associated rides in the BusRide table
SELECT b.Model, COUNT(*) AS TotalRides
FROM Bus b
JOIN BusRide br ON b.BusID = br.BusID
GROUP BY b.Model
ORDER BY TotalRides DESC
FETCH FIRST 1 ROWS ONLY;

-- Query 3: Select the total number of schedules and average frequency for each bus line, including line names
SELECT lne.LineName
FROM Line lne
JOIN Schedule schd ON lne.ScheduleID = schd.ScheduleID
JOIN Station start_station ON lne.StartOfStationID = start_station.StationID
JOIN Station end_station ON lne.EndOfStationID = end_station.StationID
WHERE start_station.StationName = 'Elon Morre'
  AND end_station.StationName = 'Malha Mall'
  AND schd.FirstDepartureTime >= TO_TIMESTAMP('17:00:00', 'HH24:MI:SS');

-- Query 4: Select all bus rides with drivers who have been hired before a certain date
SELECT br.BusID, br.LineID, d.FullName, d.HireDate
FROM BusRide br
JOIN Driver d ON br.DriverID = d.DriverID
WHERE d.HireDate < TO_DATE('2020-01-01', 'YYYY-MM-DD');
