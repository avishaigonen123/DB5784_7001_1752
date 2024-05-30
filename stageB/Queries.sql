-- Query 1: Select the names of drivers and the taxis they drive, including the time range of their shifts
SELECT d.FullName, t.TaxiID, t.WorkingZone, t.StartTime, t.FinishTime
FROM Driver d
JOIN DrivesInTaxi dit ON d.DriverID = dit.DriverID
JOIN Taxi t ON dit.TaxiID = t.TaxiID
ORDER BY d.FullName;

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
WHERE d.HireDate < '2020\01\01';

-- DELETE:

-- Query 1: Delete all taxi records with a working zone 'Zone A' and start time before 6 AM
DELETE FROM Taxi
WHERE WorkingZone = 'Zone A' AND StartTime < '06:00:00';

-- Query 2: Delete all bus rides for a specific bus that has a purchase date before 2015
DELETE FROM BusRide
WHERE BusID IN (SELECT BusID FROM Bus WHERE PurchaseDate < '2015/01/01');

-- UPDATE:

-- Query 1: Update the working zone of all taxis operating between 8 AM and 4 PM to 'Zone B'
UPDATE Taxi
SET WorkingZone = 'Zone B'
WHERE StartTime <= '08:00:00' AND FinishTime >= '16:00:00';

-- Query 2: Update the capacity of buses purchased in the year 2020 to 60
UPDATE Bus
SET Capacity = 60
WHERE EXTRACT(YEAR FROM PurchaseDate) = 2020;

