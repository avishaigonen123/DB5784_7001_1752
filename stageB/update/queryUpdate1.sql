-- UPDATE:

-- Select all records from Line where EndOfStationID matches the StationID of 'Elon Morre'
SELECT lne.LineName, station.StationName AS endStation, station.StationAddress  AS endStationAddress
FROM Line lne
JOIN Station station ON station.StationID = lne.EndOfStationID
WHERE lne.EndOfStationID = (
    SELECT station.StationID
    FROM Station station
    WHERE station.StationName = 'Hawarra'
    FETCH FIRST 1 ROWS ONLY
);

UPDATE Line
SET EndOfStationID = (
    SELECT station.StationID
    FROM Station station
    WHERE station.StationName = 'Elon Morre'
    FETCH FIRST 1 ROWS ONLY
)
WHERE EndOfStationID = (
    SELECT station.StationID
    FROM Station station
    WHERE station.StationName = 'Hawarra'
    FETCH FIRST 1 ROWS ONLY
);

SELECT lne.LineName, station.StationName AS endStation, station.StationAddress  AS endStationAddress
FROM Line lne
JOIN Station station ON station.StationID = lne.EndOfStationID
WHERE lne.EndOfStationID = (
    SELECT station.StationID
    FROM Station station
    WHERE station.StationName = 'Elon Morre'
    FETCH FIRST 1 ROWS ONLY
);

