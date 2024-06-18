CREATE OR REPLACE FUNCTION getDriversByLicensePlates(
    license_plates_list VARCHAR2
) RETURN SYS_REFCURSOR IS
    ref_cur SYS_REFCURSOR;
BEGIN
    -- Open the ref cursor for drivers with given license plates
    OPEN ref_cur FOR
        SELECT DISTINCT DriverID
        FROM DrivesInTaxi
        WHERE TaxiID IN (
            SELECT TaxiID
            FROM Taxi
            WHERE LicensePlate IN (
                SELECT trim(regexp_substr(license_plates_list, '[^,]+', 1, LEVEL)) license_plate
                FROM dual
                CONNECT BY LEVEL <= regexp_count(license_plates_list, ',') + 1
            )
        )
        UNION
        SELECT DISTINCT DriverID
        FROM BusRide
        WHERE BusID IN (
            SELECT BusID
            FROM Bus
            WHERE LicensePlate IN (
                SELECT trim(regexp_substr(license_plates_list, '[^,]+', 1, LEVEL)) license_plate
                FROM dual
                CONNECT BY LEVEL <= regexp_count(license_plates_list, ',') + 1
            )
        );
    
    -- Return the ref cursor
    RETURN ref_cur;
EXCEPTION
    WHEN OTHERS THEN
        -- Handle any exceptions and ensure ref cursor is closed
        IF (ref_cur IS NOT NULL) THEN
            CLOSE ref_cur;
        END IF;
        -- Re-raise the exception for the caller
        RAISE;
END getDriversByLicensePlates;
/
