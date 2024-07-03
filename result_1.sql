SELECT 
    diagnoses.diagnosis_desc, 
    discharges.discharge_id, 
    discharges.insurance_type, 
    discharges.discharge_disposition, 
    DATEDIFF(discharges.admit_datetime, discharges.discharge_datetime) AS stay_duration, 
    discharges.gender, 
    discharges.age_at_admit ,
    CASE
        WHEN ABS(DATEDIFF(discharges.admit_datetime, discharges.discharge_datetime)) < 4 THEN "Short"
        WHEN ABS(DATEDIFF(discharges.admit_datetime, discharges.discharge_datetime)) >= 4 AND ABS(DATEDIFF(discharges.admit_datetime, discharges.discharge_datetime)) < 8 THEN "Medium"
        ELSE "Long"
    END
FROM 
    discharges 
INNER JOIN 
    diagnoses 
ON 
    discharges.discharge_id = diagnoses.discharge_id 
WHERE 
    diagnoses.diagnosis_desc LIKE "%heart failure%"
ORDER BY
    discharges.insurance_type ASC;