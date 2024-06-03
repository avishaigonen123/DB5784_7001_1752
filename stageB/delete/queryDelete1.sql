-- DELETE:

-- Query 1: Delete all taxi records with workingZone = 'Nahariya' start time before 6 AM

SELECT *  
FROM Taxi t
WHERE t.WorkingZone = 'Nahariya';

-- Step 1: Delete related records in DrivesInTaxi
DELETE FROM DrivesInTaxi
WHERE TaxiID IN (
    SELECT TaxiID
    FROM Taxi
    WHERE WorkingZone = 'Nahariya' AND TO_TIMESTAMP(StartTime, 'HH24:MI:SS') < TO_TIMESTAMP('06:00:00', 'HH24:MI:SS')
);

-- Step 2: Delete the taxi records
DELETE FROM Taxi
WHERE WorkingZone = 'Nahariya' AND TO_TIMESTAMP(StartTime, 'HH24:MI:SS') < TO_TIMESTAMP('06:00:00', 'HH24:MI:SS');

SELECT * 
FROM Taxi t
WHERE t.WorkingZone = 'Nahariya';
