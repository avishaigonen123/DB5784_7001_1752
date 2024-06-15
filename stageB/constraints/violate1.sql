-- insert data that violates constraint 1
INSERT INTO Taxi (TaxiID, LicensePlate, Model, Capacity, PurchaseDate)
VALUES (560, '56-023-12', 'Toyota', 7, to_date('11-08-2020', 'dd-mm-yyyy'));
SELECT *
FROM all_cons_columns
WHERE table_name = 'DRIVER';

-- same license plate
INSERT INTO Taxi (TaxiID, LicensePlate, Model, Capacity, PurchaseDate)
VALUES (561, '56-023-12', 'Mercedes', 5, to_date('19-11-2021', 'dd-mm-yyyy'));
