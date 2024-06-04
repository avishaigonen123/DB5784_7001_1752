-- Query 1: Select the names of drivers hired after a specified date
DECLARE 
    hire_date DATE IN;
SELECT d.FullName, d.HireDate
FROM Driver d
WHERE d.HireDate > TO_DATE(:hire_date, 'YYYY-MM-DD')
ORDER BY d.HireDate;
