
CREATE OR REPLACE PROCEDURE printAndDeleteDrivers(
    ref_cur IN SYS_REFCURSOR
) IS
    driver_id Driver.DriverID%TYPE;
    driver_name Driver.FullName%TYPE;
BEGIN
    -- Check if ref cursor is valid
    IF ref_cur IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'Input ref cursor is NULL');
    END IF;

    LOOP
        FETCH ref_cur INTO driver_id;
        EXIT WHEN ref_cur%NOTFOUND;

        -- Get driver name
        SELECT FullName INTO driver_name
        FROM Driver
        WHERE DriverID = driver_id;

        -- Print driver name
        DBMS_OUTPUT.PUT_LINE('Deleting driver: ' || driver_name);
        
        -- Delete instances from table BusRide where driverID = driverID
        DELETE FROM BusRide
        WHERE DriverID = driver_id;

        -- Delete instances from table Drives in taxi where driverID = driverID
        DELETE FROM DrivesInTaxi;
        WHERE DriverID = driver_id;


        -- Delete driver from Driver table
        DELETE FROM Driver
        WHERE DriverID = driver_id;
    END LOOP;

    CLOSE ref_cur;
EXCEPTION
    WHEN OTHERS THEN
        -- Handle any exceptions and ensure ref cursor is closed
        IF (ref_cur IS NOT NULL) THEN
            CLOSE ref_cur;
        END IF;
        -- Re-raise the exception for the caller
        RAISE;
END printAndDeleteDrivers;
/
