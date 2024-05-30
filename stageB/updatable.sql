-- DELETE:

-- Query 1: Delete all taxi records with a working zone 'Zone A' and start time before 6 AM
DELETE FROM Taxi
WHERE WorkingZone = 'Zone A' AND StartTime < '06:00:00';

-- Query 2: Delete all bus rides for a specific bus that has a purchase date before 2015
DELETE FROM BusRide
WHERE BusID IN (SELECT BusID FROM Bus WHERE PurchaseDate < TO_DATE('2015-01-01', 'YYYY-MM-DD'));


-- UPDATE:

-- Query 1: Update the working zone of all taxis operating between 8 AM and 4 PM to 'Zone B'
UPDATE Taxi
SET WorkingZone = 'Zone B'
WHERE StartTime <= '08:00:00' AND FinishTime >= '16:00:00';

-- Query 2: Update the capacity of buses purchased in the year 2020 to 60
UPDATE Bus
SET Capacity = 60
WHERE EXTRACT(YEAR FROM PurchaseDate) = 2020;

