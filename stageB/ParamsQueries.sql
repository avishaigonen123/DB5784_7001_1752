-- Query 1: Select the names of drivers hired after a specified date
SELECT d.FullName, d.HireDate
FROM Driver d
WHERE d.HireDate > TO_DATE(:hire_date, 'YYYY-MM-DD')
ORDER BY d.HireDate;

-- Query 2: Select all taxis working in a specified zone with start time within a range
SELECT t.TaxiID, t.WorkingZone, t.StartTime, t.FinishTime
FROM Taxi t
WHERE t.WorkingZone = :working_zone 
  AND TO_TIMESTAMP(t.StartTime, 'HH24:MI:SS') BETWEEN TO_TIMESTAMP(:start_time_min, 'HH24:MI:SS') 
  AND TO_TIMESTAMP(:start_time_max, 'HH24:MI:SS');

-- Query 3: Select bus rides for specified bus and line within a date range
SELECT br.BusID, br.LineID, d.FullName, d.HireDate
FROM BusRide br
JOIN Driver d ON br.DriverID = d.DriverID
WHERE br.BusID = :bus_id AND br.LineID = :line_id
AND d.HireDate BETWEEN TO_DATE(:date_start, 'YYYY-MM-DD') AND TO_DATE(:date_end, 'YYYY-MM-DD');

-- Query 4: Select bus lines operating in a specified station and with frequency less than specified value
SELECT l.LineName, l.LineID, s.Frequency
FROM Line l
JOIN Schedule s ON l.ScheduleID = s.ScheduleID
WHERE (l.StartOfStationID = :station_id OR l.EndOfStationID = :station_id)
AND s.Frequency < :frequency;
