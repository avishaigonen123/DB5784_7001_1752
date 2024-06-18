CREATE OR REPLACE FUNCTION getDriversBetweenDates(
    inputDate1 DATE,
    inputDate2 DATE
) RETURN SYS_REFCURSOR IS
    ref_cur SYS_REFCURSOR;
BEGIN
    -- Check if input dates are valid
    IF inputDate1 < inputDate2 THEN
        -- Open the ref cursor for drivers hired between inputDate2 and inputDate1
        OPEN ref_cur FOR
            SELECT DriverID
            FROM Driver
            WHERE HireDate > inputDate2 AND HireDate < inputDate1;
        
        -- Return the ref cursor
        RETURN ref_cur;
    ELSE
        -- Throw an exception if input dates are invalid
        RAISE_APPLICATION_ERROR(-20001, 'Invalid input dates: inputDate1 should be greater than inputDate2');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        -- Handle any exceptions and ensure ref cursor is closed
        IF (ref_cur IS NOT NULL) THEN
            CLOSE ref_cur;
        END IF;
        -- Re-raise the exception for the caller
        RAISE;
END getDriversBetweenDates;
/

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


DECLARE
    input_date DATE := TO_DATE('2023-01-01', 'YYYY-MM-DD');
    current_date DATE := SYSDATE;
    ref_cur SYS_REFCURSOR;
BEGIN
    -- Call Function 1 to get drivers hired between input_date and current_date
    ref_cur := getDriversBetweenDates(input_date, current_date);

    -- Call Procedure 1 to print driver names and delete them from database
    printAndDeleteDrivers(ref_cur);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
