
INSERT INTO Station (StationID, StationName, StationAddress)
VALUES (401, 'Elon Morre', 'Hateena 10');
INSERT INTO Station (StationID, StationName, StationAddress)
VALUES (402, 'Malha Mall', 'Avizohar Street 8 Jerusalem');

INSERT INTO Line (LineID, LineName, ScheduleID, StartOfStationID, EndOfStationID)
VALUES (401, '472a', 3, 401, 402);

INSERT INTO Line (LineID, LineName, ScheduleID, StartOfStationID, EndOfStationID)
VALUES (402, '412', 10, 401, 402);

INSERT INTO Line (LineID, LineName, ScheduleID, StartOfStationID, EndOfStationID)
VALUES (403, '367c', 87, 401, 402);

INSERT INTO Line (LineID, LineName, ScheduleID, StartOfStationID, EndOfStationID)
VALUES (404, '489', 120, 401, 402);


INSERT INTO Station (StationID, StationName, StationAddress)
VALUES (404, 'Hawarra', 'Jabel Dawlla 11');

INSERT INTO Line (LineID, LineName, ScheduleID, StartOfStationID, EndOfStationID)
VALUES (405, '425a', 59, 402, 404);

INSERT INTO Line (LineID, LineName, ScheduleID, StartOfStationID, EndOfStationID)
VALUES (406, '76', 305, 402, 404);

INSERT INTO Line (LineID, LineName, ScheduleID, StartOfStationID, EndOfStationID)
VALUES (407, '209', 94, 402, 404);

INSERT INTO Line (LineID, LineName, ScheduleID, StartOfStationID, EndOfStationID)
VALUES (408, '770', 276, 402, 404);

commit;
