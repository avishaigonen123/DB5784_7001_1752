-- Constraint 1: Unique License Plate
ALTER TABLE Taxi
ADD CONSTRAINT uc_LicensePlate UNIQUE (LicensePlate);
