-- procedure
CREATE OR REPLACE FUNCTION isValidLicenseNumber(license_number IN VARCHAR2)
RETURN BOOLEAN
IS
    v_length NUMBER;
    v_sum NUMBER := 0;
    v_last_digit NUMBER;
BEGIN
    -- Check if the license number is exactly 14 characters long (including hyphens)
    v_length := LENGTH(license_number);
    IF v_length != 14 THEN
        RETURN FALSE;
    END IF;

    -- Calculate the sum of the digits excluding the hyphens
    FOR i IN 1..13 LOOP
        IF SUBSTR(license_number, i, 1) != '-' THEN
            v_sum := v_sum + TO_NUMBER(SUBSTR(license_number, i, 1));
        END IF;
    END LOOP;

    -- Get the last digit
    v_last_digit := TO_NUMBER(SUBSTR(license_number, 14, 1));

    -- Check if the last digit is equal to the sum of the other digits mod 10
    IF v_last_digit = MOD(v_sum, 10) THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RETURN FALSE;
END isValidLicenseNumber;
/


CREATE OR REPLACE PROCEDURE deleteDriversWithInvalidLicenses(
    driver_ids_list VARCHAR2
) IS
    driver_id_list VARCHAR2(4000);
    v_driver_id Driver.DriverID%TYPE;
BEGIN
    -- Check if input driver_ids_list is empty
    IF driver_ids_list IS NULL OR driver_ids_list = '' THEN
        RAISE_APPLICATION_ERROR(-20003, 'Input driver IDs list is empty');
    END IF;

    -- Delete drivers with invalid license numbers
    FOR driver_rec IN (
        SELECT trim(regexp_substr(driver_ids_list, '[^,]+', 1, LEVEL)) driver_id
        FROM dual
        CONNECT BY LEVEL <= regexp_count(driver_ids_list, ',') + 1
    ) LOOP
        v_driver_id := TO_NUMBER(driver_rec.driver_id);

        -- Check if driver exists
        SELECT COUNT(*)
        INTO driver_id_list
        FROM Driver
        WHERE DriverID = v_driver_id;

        IF driver_id_list > 0 THEN
            -- Validate license number and delete driver if invalid
            IF NOT isValidLicenseNumber(v_driver_id) THEN
                -- Get driver name
                SELECT FullName INTO driver_name
                FROM Driver
                WHERE DriverID = driver_id;

                -- Delete dependent records first (if needed)
                DELETE FROM DrivesInTaxi WHERE DriverID = driver_id;
                DELETE FROM BusRide WHERE DriverID = driver_id;

                DBMS_OUTPUT.PUT_LINE('DrivesInTaxi: \n');


                -- Print driver name
                DBMS_OUTPUT.PUT_LINE('Deleting dasklmriverdlskl: ' || driver_name);

                -- Delete driver from Driver table
                DELETE FROM Driver
                WHERE DriverID = driver_id; 
            END IF;
        ELSE
            -- Throw exception if driver does not exist
            RAISE_APPLICATION_ERROR(-20004, 'Driver with ID ' || v_driver_id || ' does not exist');
        END IF;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        -- Handle any exceptions
        RAISE;
END deleteDriversWithInvalidLicenses;
/

-- 3476-8840-8675
-- function
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



DECLARE
    license_plates_list VARCHAR2(200); -- Declare variable to hold license plates list
    ref_cur SYS_REFCURSOR;
BEGIN
    -- Prompt user for input
    license_plates_list := '&Enter_license_plates_list';

    -- Call Function 2 to get drivers driving taxis or buses with given license plates
    ref_cur := getDriversByLicensePlates(license_plates_list);

    -- Call Procedure 1 to print driver names and delete them from database
    printAndDeleteDrivers(ref_cur);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
