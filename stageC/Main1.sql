DECLARE
    input_date DATE := TO_DATE('2023-01-01', 'YYYY-MM-DD');
    current_date DATE := SYSDATE;
    ref_cur SYS_REFCURSOR;
    driver_id INT;
BEGIN
    input_date := TO_DATE('&input_date', 'YYYY-MM-DD');
    -- Call Function 1 to get drivers hired between input_date and current_date
    ref_cur := getDriversBetweenDates(input_date, current_date);

    printAndDeleteDrivers(ref_cur);
    
    -- Close the cursor after fetching
    CLOSE ref_cur;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
