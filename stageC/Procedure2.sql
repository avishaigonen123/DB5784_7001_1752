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
                DELETE FROM Driver
                WHERE DriverID = v_driver_id;
                DBMS_OUTPUT.PUT_LINE('Deleted driver with invalid license number: ' || v_driver_id);
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

