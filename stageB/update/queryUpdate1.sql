-- UPDATE:

-- Query 1: Update the working zone of all taxis operating between 8 AM and 4 PM to 'Zone B'
UPDATE Taxi
SET WorkingZone = 'Zone B'
WHERE TO_TIMESTAMP(StartTime, 'HH24:MI:SS') >= TO_TIMESTAMP('08:00:00', 'HH24:MI:SS')
  AND TO_TIMESTAMP(FinishTime, 'HH24:MI:SS') <= TO_TIMESTAMP('16:00:00', 'HH24:MI:SS');
