SELECT
    (CASE
        WHEN LOWER(discharges.discharge_disposition) LIKE "%home%" AND LOWER(discharges.discharge_disposition) LIKE "%nursing%" IS NOT TRUE THEN "Home"
        WHEN (
            LOWER(discharges.discharge_disposition) LIKE "%hospital%"
            OR
            LOWER(discharges.discharge_disposition) LIKE "%nursing%"
            OR
            LOWER(discharges.discharge_disposition) LIKE "%hospice%"
            OR
            LOWER(discharges.discharge_disposition) LIKE "%medical%"
            ) 
            AND 
            LOWER(discharges.discharge_disposition) LIKE "%home%" IS NOT TRUE 
            THEN "Medical Institution"
        WHEN LOWER(discharges.discharge_disposition) LIKE "%expired%" THEN "Expired"
        ELSE "Non-nursing Facilities"
    END) loc,
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
    loc;

SELECT
    (CASE
        WHEN LOWER(discharges.discharge_disposition) LIKE "%home%" AND LOWER(discharges.discharge_disposition) LIKE "%nursing%" IS NOT TRUE THEN "Home"
        WHEN (
            LOWER(discharges.discharge_disposition) LIKE "%hospital%"
            OR
            LOWER(discharges.discharge_disposition) LIKE "%nursing%"
            OR
            LOWER(discharges.discharge_disposition) LIKE "%hospice%"
            OR
            LOWER(discharges.discharge_disposition) LIKE "%medical%"
            ) 
            AND 
            LOWER(discharges.discharge_disposition) LIKE "%home%" IS NOT TRUE 
            THEN "Medical Institution"
        WHEN LOWER(discharges.discharge_disposition) LIKE "%expired%" THEN "Expired"
        ELSE "Non-nursing Facilities"
    END) loc,
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
    loc;

SELECT
    (CASE
        WHEN LOWER(discharges.discharge_disposition) LIKE "%home%" AND LOWER(discharges.discharge_disposition) LIKE "%nursing%" IS NOT TRUE THEN "Home"
        WHEN (
            LOWER(discharges.discharge_disposition) LIKE "%hospital%"
            OR
            LOWER(discharges.discharge_disposition) LIKE "%nursing%"
            OR
            LOWER(discharges.discharge_disposition) LIKE "%hospice%"
            OR
            LOWER(discharges.discharge_disposition) LIKE "%medical%"
            ) 
            AND 
            LOWER(discharges.discharge_disposition) LIKE "%home%" IS NOT TRUE 
            THEN "Medical Institution"
        WHEN LOWER(discharges.discharge_disposition) LIKE "%expired%" THEN "Expired"
        ELSE "Non-nursing Facilities"
    END) loc,
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
    loc;