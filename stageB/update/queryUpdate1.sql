-- UPDATE:

-- Query 1: Update the working zone of all taxis operating between 7 AM and 8 AM to 'Nahariya'

SELECT *
FROM Taxi;

UPDATE Taxi
SET WorkingZone = 'Nahariya'
WHERE TO_TIMESTAMP(StartTime, 'HH24:MI:SS') >= TO_TIMESTAMP('07:00:00', 'HH24:MI:SS')
  AND TO_TIMESTAMP(FinishTime, 'HH24:MI:SS') <= TO_TIMESTAMP('08:00:00', 'HH24:MI:SS');

SELECT *
FROM Taxi;