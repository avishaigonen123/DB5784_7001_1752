SELECT 
    a.table_name,
    a.column_name,
    a.constraint_name,
    c.owner AS referenced_owner,
    c.table_name AS referenced_table_name,
    c.column_name AS referenced_column_name
FROM 
    all_cons_columns a
JOIN 
    all_constraints c 
    ON a.constraint_name = c.constraint_name
WHERE 
    c.constraint_type = 'R'
    AND c.r_owner = 'YOUR_SCHEMA'
    AND c.r_constraint_name IN (
        SELECT constraint_name
        FROM all_cons_columns
        WHERE table_name = 'STATION'
        AND column_name = 'STATIONID'
    );
