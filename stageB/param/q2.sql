-- Query 2: Select all taxis working in a specified zone with start time within a range
SELECT t.TaxiID, t.WorkingZone, t.StartTime, t.FinishTime
FROM Taxi t
WHERE t.WorkingZone = :working_zone 
  AND TO_TIMESTAMP(t.StartTime, 'HH24:MI:SS') BETWEEN TO_TIMESTAMP(:start_time_min, 'HH24:MI:SS') 
  AND TO_TIMESTAMP(:start_time_max, 'HH24:MI:SS');
