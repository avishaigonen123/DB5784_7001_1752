-- UPDATE:

-- Query 2: Update the capacity of buses purchased in the year 2020 to 60

UPDATE Bus
SET Capacity = 60
WHERE EXTRACT(YEAR FROM PurchaseDate) = 2020;
