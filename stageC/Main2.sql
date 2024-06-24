DECLARE
    license_plates_list VARCHAR2(200); -- Declare variable to hold license plates list
    ref_cur SYS_REFCURSOR;
    driver_id INT;
    driver_ids_list VARCHAR2(4000); -- Variable to hold comma-separated list of DriverIDs

BEGIN
    -- Prompt user for input
    license_plates_list := '&Enter_license_plates_list';
    
    -- Initialize driver_ids_list
    driver_ids_list := '';

    -- Call Function 2 to get drivers driving taxis or buses with given license plates
    ref_cur := getDriversByLicensePlates(license_plates_list);
    LOOP
        FETCH ref_cur INTO driver_id;
        EXIT WHEN ref_cur%NOTFOUND;
        
        -- Concatenate driver_id to driver_ids_list
        IF driver_ids_list IS NULL THEN
            driver_ids_list := TO_CHAR(driver_id);
        ELSE
            driver_ids_list := driver_ids_list || ',' || TO_CHAR(driver_id);
        END IF;
    END LOOP;


    -- Call Procedure 2 to delete drivers with invalid license plates
    deleteDriversWithInvalidLicenses(driver_ids_list);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
