SELECT
    (CASE
        WHEN ABS(DATEDIFF(discharges.admit_datetime, discharges.discharge_datetime)) < 4 THEN "Short"
        WHEN ABS(DATEDIFF(discharges.admit_datetime, discharges.discharge_datetime)) >= 4 AND ABS(DATEDIFF(discharges.admit_datetime, discharges.discharge_datetime)) < 8 THEN "Medium"
        ELSE "Long"
    END) duration,
    COUNT(*)
FROM
    discharges
INNER JOIN
    diagnoses ON discharges.discharge_id = diagnoses.discharge_id
WHERE
    LOWER(discharges.insurance_type) = 'medicare'
    AND
    diagnoses.diagnosis_desc LIKE "%heart failure%"
GROUP BY
    duration;

SELECT
    (CASE
        WHEN ABS(DATEDIFF(discharges.admit_datetime, discharges.discharge_datetime)) < 4 THEN "Short"
        WHEN ABS(DATEDIFF(discharges.admit_datetime, discharges.discharge_datetime)) >= 4 AND ABS(DATEDIFF(discharges.admit_datetime, discharges.discharge_datetime)) < 8 THEN "Medium"
        ELSE "Long"
    END) duration,
    COUNT(*)
FROM
    discharges
INNER JOIN
    diagnoses ON discharges.discharge_id = diagnoses.discharge_id
WHERE
    LOWER(discharges.insurance_type) = 'medicaid'
    AND
    diagnoses.diagnosis_desc LIKE "%heart failure%"
GROUP BY
    duration;

SELECT
    (CASE
        WHEN ABS(DATEDIFF(discharges.admit_datetime, discharges.discharge_datetime)) < 4 THEN "Short"
        WHEN ABS(DATEDIFF(discharges.admit_datetime, discharges.discharge_datetime)) >= 4 AND ABS(DATEDIFF(discharges.admit_datetime, discharges.discharge_datetime)) < 8 THEN "Medium"
        ELSE "Long"
    END) duration,
    COUNT(*)
FROM
    discharges
INNER JOIN
    diagnoses ON discharges.discharge_id = diagnoses.discharge_id
WHERE
    LOWER(discharges.insurance_type) != 'medicare'
    AND
    LOWER(discharges.insurance_type) != 'medicaid'
    AND
    diagnoses.diagnosis_desc LIKE "%heart failure%"
GROUP BY
    duration;