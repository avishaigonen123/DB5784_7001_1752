
-- Query 4: Select bus lines operating in a specified station and with frequency less than specified value
SELECT l.LineName, l.LineID, s.Frequency
FROM Line l
JOIN Schedule s ON l.ScheduleID = s.ScheduleID
WHERE (l.StartOfStationID = :station_id OR l.EndOfStationID = :station_id)
AND s.Frequency < :frequency;
