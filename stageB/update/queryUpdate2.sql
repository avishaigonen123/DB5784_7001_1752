-- UPDATE:

-- Query 2: Update the capacity of buses purchased in the year 2020 to 60
SELECT *
FROM Bus b
WHERE b.Capacity = 60;

UPDATE Bus
SET Capacity = 60
WHERE (Model = "Tracer" or Model = "Camaro" or Model = "RAV4")

SELECT *
FROM Bus b
WHERE b.Capacity = 60;