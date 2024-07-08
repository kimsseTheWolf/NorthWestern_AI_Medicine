SELECT
    (CASE
        WHEN discharges.age_at_admit < 20 THEN "Young"
        WHEN discharges.age_at_admit >= 20 AND discharges.age_at_admit < 50 THEN "Medium Age"
        WHEN discharges.age_at_admit > 50 AND discharges.age_at_admit <= 70 THEN "Old"
        ELSE "Elder"
    END) age,
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
    age;

SELECT
    (CASE
        WHEN discharges.age_at_admit < 20 THEN "Young"
        WHEN discharges.age_at_admit >= 20 AND discharges.age_at_admit < 50 THEN "Medium Age"
        WHEN discharges.age_at_admit > 50 AND discharges.age_at_admit <= 70 THEN "Old"
        ELSE "Elder"
    END) age,
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
    age;

SELECT
    (CASE
        WHEN discharges.age_at_admit < 20 THEN "Young"
        WHEN discharges.age_at_admit >= 20 AND discharges.age_at_admit < 50 THEN "Medium Age"
        WHEN discharges.age_at_admit > 50 AND discharges.age_at_admit <= 70 THEN "Old"
        ELSE "Elder"
    END) age,
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
    age;