SELECT 
    diagnoses.diagnosis_desc, 
    discharges.discharge_id, 
    CASE
        WHEN discharges.insurance_type REGEXP '[Mm][Ee][Dd][Ii][Cc][Aa][Rr][Ee]' THEN "Medicare"
        WHEN discharges.insurance_type REGEXP '[Mm][Ee][Dd][Ii][Cc][Aa][Ii][Dd]' THEN "Medicaid"
        ELSE "Commercial"
    END, 
    discharges.discharge_disposition, 
    ABS(DATEDIFF(discharges.admit_datetime, discharges.discharge_datetime)) AS stay_duration, 
    discharges.gender, 
    CASE
        WHEN discharges.age_at_admit < 20 THEN "Young"
        WHEN discharges.age_at_admit >= 20 AND discharges.age_at_admit < 50 THEN "Medium Age"
        WHEN discharges.age_at_admit > 50 AND discharges.age_at_admit <= 70 THEN "Old"
        ELSE "Very old"
    END,
    CASE
        WHEN ABS(DATEDIFF(discharges.admit_datetime, discharges.discharge_datetime)) < 4 THEN "Short"
        WHEN ABS(DATEDIFF(discharges.admit_datetime, discharges.discharge_datetime)) >= 4 AND ABS(DATEDIFF(discharges.admit_datetime, discharges.discharge_datetime)) < 8 THEN "Medium"
        ELSE "Long"
    END
FROM 
    discharges d1
CROSS JOIN
    discharges d2
INNER JOIN 
    diagnoses 
ON 
    discharges.discharge_id = diagnoses.discharge_id 
WHERE 
    diagnoses.diagnosis_desc LIKE "%heart failure%"
ORDER BY
    discharges.insurance_type ASC;