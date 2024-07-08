SELECT
    COUNT(patient_id)
FROM
    discharges
INNER JOIN
    diagnoses ON discharges.discharge_id = diagnoses.discharge_id
WHERE
    LOWER(discharges.insurance_type) = 'medicare' AND
    diagnoses.diagnosis_desc LIKE "%heart failure%"
