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
            WHERE HireDate < inputDate2 AND HireDate > inputDate1;
        
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
