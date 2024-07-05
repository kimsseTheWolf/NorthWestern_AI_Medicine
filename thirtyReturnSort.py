import mysql.connector

conn = mysql.connector.connect(host='localhost',user='root',password='070401',database='healthcare')

cursor = conn.cursor()

cursor.execute("""
SELECT 
    diagnoses.diagnosis_desc, 
    d1.discharge_id, 
    CASE
        WHEN d1.insurance_type REGEXP '[Mm][Ee][Dd][Ii][Cc][Aa][Rr][Ee]' THEN "Medicare"
        WHEN d1.insurance_type REGEXP '[Mm][Ee][Dd][Ii][Cc][Aa][Ii][Dd]' THEN "Medicaid"
        ELSE "Commercial"
    END, 
    d1.discharge_disposition, 
    ABS(DATEDIFF(d1.admit_datetime, d1.discharge_datetime)) AS stay_duration, 
    d1.gender, 
    CASE
        WHEN d1.age_at_admit < 20 THEN "Young"
        WHEN d1.age_at_admit >= 20 AND d1.age_at_admit < 50 THEN "Medium Age"
        WHEN d1.age_at_admit > 50 AND d1.age_at_admit <= 70 THEN "Old"
        ELSE "Very old"
    END,
    CASE
        WHEN ABS(DATEDIFF(d1.admit_datetime, d1.discharge_datetime)) < 4 THEN "Short"
        WHEN ABS(DATEDIFF(d1.admit_datetime, d1.discharge_datetime)) >= 4 AND ABS(DATEDIFF(d1.admit_datetime, d1.discharge_datetime)) < 8 THEN "Medium"
        ELSE "Long"
    END,
    d1.patient_id,
    d1.discharge_datetime,
    d1.admit_datetime,
    d1.admit_type
    -- CASE
    --     WHEN DATEDIFF(d2.discharge_datetime, d1.discharge_datetime) < 30 AND d2.patient_id = d1.patient_id THEN "Returned within 30 days"
    --     ELSE "Did not returned within 30 days"
    -- END
FROM 
    discharges d1
-- CROSS JOIN
--     discharges d2
INNER JOIN 
    diagnoses 
ON 
    d1.discharge_id = diagnoses.discharge_id 
WHERE 
    diagnoses.diagnosis_desc LIKE "%heart failure%"
ORDER BY
    d1.insurance_type ASC;
""")

patient_dict = {}

result = cursor.fetchall()
for i in result:
    print(i)

cursor.close()
conn.close()