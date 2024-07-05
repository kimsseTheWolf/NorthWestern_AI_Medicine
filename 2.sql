SELECT
    d1.patient_id,
    d1.discharge_id, -- returns the index discharge's ID
    d1.discharge_datetime, -- returns the date/time of discharge
    d2.discharge_id, -- returns the readmission discharge_id
    d2.admit_datetime, -- returns the readmission date/time
    datediff(d2.admit_datetime,d1.discharge_datetime) -- returns the number of days between discharge and readmission
FROM
    discharges d1 
CROSS JOIN 
    discharges d2 -- use cross join to be able to compare every discharge , probably not the most efficient method
WHERE
    d1.patient_id = d2.patient_id 
    AND -- only want to include when the same patient is admitted again
    d1.discharge_id != d2.discharge_id 
    AND -- do not want to include the original admission itself which is repeated due to use of the cross join
    d2.admit_datetime>d1.discharge_datetime 
    AND -- only include admits that occur after an index discharge
    datediff(d2.admit_datetime, d1.discharge_datetime)<30 
    AND -- only include admits that are <30 days after an index discharge
    d2.admit_type != 'Elective';
