-- insert data that violates constraint 3
INSERT INTO Driver (DriverID, FullName, LicenseNumber, HireDate)
VALUES (459, 'John Smith', '69-291-39', SYSDATE + 1);

