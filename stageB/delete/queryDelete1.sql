-- Step 1: Verify the existing records
SELECT *  
FROM DrivesInTaxi dit
WHERE dit.WorkingZone = 'Nahariya';

-- Step 2: Delete related records in DrivesInTaxi
DELETE FROM DrivesInTaxi dit
WHERE dit.WorkingZone = 'Nahariya'
AND TO_TIMESTAMP(dit.StartTime, 'HH24:MI:SS') BETWEEN TO_TIMESTAMP('02:00:00', 'HH24:MI:SS') AND TO_TIMESTAMP('07:00:00', 'HH24:MI:SS')
AND TO_TIMESTAMP(dit.FinishTime, 'HH24:MI:SS') BETWEEN TO_TIMESTAMP('02:00:00', 'HH24:MI:SS') AND TO_TIMESTAMP('07:00:00', 'HH24:MI:SS');

-- Step 3: Verify the deletion
SELECT *  
FROM DrivesInTaxi dit
WHERE dit.WorkingZone = 'Nahariya';
