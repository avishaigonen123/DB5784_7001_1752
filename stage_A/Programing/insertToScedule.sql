-- insert to Scheduale

BEGIN
    FOR i IN 1..400 LOOP
        INSERT INTO Schedule (ScheduleID, RouteID, DepartureTime, ArrivalTime)
        VALUES (
            i,
            MOD(i, 20) + 1,
            TIMESTAMP '2024-05-21 08:00:00' + NUMTODSINTERVAL(i, 'HOUR'),
            TIMESTAMP '2024-05-21 10:00:00' + NUMTODSINTERVAL(i, 'HOUR')
        );
    END LOOP;
    COMMIT;
END;
/

COMMIT;
