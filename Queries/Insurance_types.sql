SELECT
    discharges.gender,
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
    discharges.gender;

SELECT
    discharges.gender,
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
    discharges.gender;

SELECT
    discharges.gender,
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
    discharges.gender;