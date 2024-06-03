-- DELETE:

-- Query 2: Delete all bus rides for a specific bus that has a purchase date before 2015
SELECT * 
FROM BusRide br;

DELETE FROM BusRide
WHERE BusID IN (SELECT BusID FROM Bus WHERE PurchaseDate < TO_DATE('2022-01-01', 'YYYY-MM-DD'));

SELECT * 
FROM BusRide br;
