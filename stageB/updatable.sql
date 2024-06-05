-- DELETE:

-- Query 1: Delete all taxi records with workingZone = 'Nahariya' start time before 6 AM

SELECT *  
FROM DrivesInTaxi t
WHERE t.WorkingZone = 'Nahariya';

-- Step 1: Delete related records in DrivesInTaxi
DELETE FROM DrivesInTaxi dit
WHERE TaxiID IN (
    SELECT TaxiID
    FROM Taxi
    WHERE WorkingZone = 'Nahariya' AND TO_TIMESTAMP(StartTime, 'HH24:MI:SS') < TO_TIMESTAMP('06:00:00', 'HH24:MI:SS')
);

SELECT * 
FROM DrivesInTaxi t
WHERE t.WorkingZone = 'Nahariya';



-- Query 2: Delete all bus rides for a specific bus that has a purchase date before 2015
SELECT * 
FROM BusRide br;

DELETE FROM BusRide
WHERE BusID IN (SELECT BusID FROM Bus WHERE PurchaseDate < TO_DATE('2022-01-01', 'YYYY-MM-DD'));

SELECT * 
FROM BusRide br;
*/

-- UPDATE:
/*
-- Query 1: Update the working zone of all taxis operating between 8 AM and 4 PM to 'Zone B'
UPDATE Taxi
SET WorkingZone = 'Zone B'
WHERE TO_TIMESTAMP(StartTime, 'HH24:MI:SS') >= TO_TIMESTAMP('08:00:00', 'HH24:MI:SS')
  AND TO_TIMESTAMP(FinishTime, 'HH24:MI:SS') <= TO_TIMESTAMP('16:00:00', 'HH24:MI:SS');

-- Query 2: Update the capacity of buses purchased in the year 2020 to 60
UPDATE Bus
SET Capacity = 60
WHERE EXTRACT(YEAR FROM PurchaseDate) = 2020;


*/