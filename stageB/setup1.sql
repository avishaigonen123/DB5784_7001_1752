
UPDATE DrivesInTaxi dit
SET workingZone = 'Nahariya'
WHERE MOD(dit.TaxiID, 40) = 8;

commit;
