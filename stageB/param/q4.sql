-- Query 4: Retrieve lines starting from a specific station
SELECT 
    line.LineID,
    start_station.StationName AS StartStationName,
    end_station.StationName AS EndStationName,
    line.LineName
FROM Line line
JOIN Station start_station ON line.StartOfStationID = start_station.StationID
JOIN Station end_station ON line.EndOfStationID = end_station.StationID
WHERE start_station.StationName = '&<name="StationName" list="SELECT StationName from Station">' 
