-- Query 1: get the drivers names that drive in a Taxi and there Taxi licenses plate and there working zone and order by the name
SELECT Driver.FullName, t.TaxiID, t.WorkingZone
FROM Driver
JOIN DrivesInTaxi dit ON Driver.DriverID = DrivesInTaxi.DriverID
JOIN Taxi ON DrivesInTaxi.TaxiID = Taxi.TaxiID
ORDER BY Driver.FullName;

-- Query 2: Select the average capacity of buses purchased in each year, grouped by year
SELECT EXTRACT(YEAR FROM b.PurchaseDate) AS PurchaseYear, AVG(b.Capacity) AS AverageCapacity
FROM Bus b
GROUP BY EXTRACT(YEAR FROM b.PurchaseDate)
ORDER BY PurchaseYear;

-- Query 3: Select the total number of schedules and average frequency for each bus line, including line names
SELECT l.LineName, COUNT(s.ScheduleID) AS TotalSchedules, AVG(s.Frequency) AS AverageFrequency
FROM Line l
JOIN Schedule s ON l.ScheduleID = s.ScheduleID
GROUP BY l.LineName
ORDER BY TotalSchedules DESC;

-- Query 4: Select all bus rides with drivers who have been hired before a certain date
SELECT br.BusID, br.LineID, d.FullName, d.HireDate
FROM BusRide br
JOIN Driver d ON br.DriverID = d.DriverID
WHERE d.HireDate < TO_DATE('2020-01-01', 'YYYY-MM-DD');
