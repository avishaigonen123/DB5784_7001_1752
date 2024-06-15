-- insert data without FullName, to show constraint 2
INSERT INTO Driver (DriverID, LicenseNumber, HireDate)
VALUES (450, '39-102-39', to_date('19-07-2020', 'dd-mm-yyyy'));

Select * from Driver 
Where DriverID = 450 