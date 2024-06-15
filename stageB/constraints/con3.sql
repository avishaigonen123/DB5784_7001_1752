-- Constraint 3: check that HireDate is not in the future
-- i used here trigger, because SYSDATE is non-deterministic, and it can't be done with constraint
CREATE OR REPLACE TRIGGER trg_check_hiredate
BEFORE INSERT OR UPDATE ON Driver
FOR EACH ROW
DECLARE
    cur_date DATE := TRUNC(SYSDATE);
BEGIN
    IF :NEW.HireDate > cur_date THEN
        RAISE_APPLICATION_ERROR(-20001, 'HireDate cannot be in the future.');
    END IF;
END;
/

