-- Query 3: Select bus rides for specified bus and line within a date range
SELECT br.BusID, br.LineID, d.FullName, d.HireDate
FROM BusRide br
JOIN Driver d ON br.DriverID = d.DriverID
WHERE br.BusID = :bus_id AND br.LineID = :line_id
AND d.HireDate BETWEEN TO_DATE(:date_start, 'YYYY-MM-DD') AND TO_DATE(:date_end, 'YYYY-MM-DD');
