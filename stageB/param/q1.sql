-- Query 1: Select the names of drivers hired after a specified date
SELECT d.FullName, d.HireDate
FROM Driver d
WHERE d.HireDate > TO_DATE(:hire_date, 'YYYY-MM-DD')
ORDER BY d.HireDate;