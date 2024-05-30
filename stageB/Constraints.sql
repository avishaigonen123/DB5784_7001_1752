-- Constraint 1: Add NOT NULL constraint to LineName in Line table
ALTER TABLE Line
MODIFY LineName VARCHAR(100) NOT NULL;

-- Constraint 2: Add CHECK constraint to ensure Capacity in Bus table is greater than 0
ALTER TABLE Bus
ADD CONSTRAINT chk_bus_capacity CHECK (Capacity > 0);

-- Constraint 3: Add DEFAULT constraint to set default frequency in Schedule table to 15
ALTER TABLE Schedule
MODIFY Frequency INT DEFAULT 15;
