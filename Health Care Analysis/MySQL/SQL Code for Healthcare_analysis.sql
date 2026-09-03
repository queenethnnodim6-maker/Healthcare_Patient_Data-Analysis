CREATE DATABASE healthcare_analysis;

USE healthcare_analysis;

SELECT DATABASE();

SHOW TABLES;


CREATE TABLE patient_data (
    Patient_ID INT,
    Patient_Name VARCHAR(100),
    Age INT,
    Age_Group VARCHAR(20),
    Gender VARCHAR(10),
    Booking_Date DATE,
    Appointment_Date DATE,
    Booking_Lead_Days INT,
    Appointment_Year INT,
    Appointment_Month VARCHAR(20),
    Appointment_Month_Year VARCHAR(20),
    Doctor VARCHAR(100),
    Department VARCHAR(50),
    Billing_Amount DECIMAL(10,2),
    Follow_Up_Required VARCHAR(5)
);


SELECT *
FROM healthcare_analysis.healthcare_pd;

DESCRIBE healthcare_pd;

-- Checking for missing values
SELECT
    SUM(patient_id IS NULL) AS missing_patient_id,
    SUM(patient_name IS NULL) AS missing_patient_name,
    SUM(age IS NULL) AS missing_age,
    SUM(gender IS NULL) AS missing_gender,
    SUM(appointment_date IS NULL) AS missing_appointment_date,
    SUM(booking_date IS NULL) AS missing_booking_date,
    SUM(doctor IS NULL) AS missing_doctor,
    SUM(department IS NULL) AS missing_department,
    SUM(billing_amount IS NULL) AS missing_billing_amount,
    SUM(follow_up_required IS NULL) AS missing_follow_up
FROM healthcare_pd;

SELECT COUNT(*) AS total_records
FROM healthcare_pd;

DESCRIBE healthcare_pd;

SELECT *
FROM healthcare_pd
LIMIT 10;

-- Cheking for duplicates

SELECT 
    patient_id,
    COUNT(*) AS duplicate_count
FROM healthcare_pd
GROUP BY patient_id
HAVING COUNT(*) > 1;


SELECT *
FROM healthcare_pd
WHERE TRIM(patient_name) = ''
   OR TRIM(gender) = ''
   OR TRIM(follow_up_required) = ''
   OR TRIM(doctor) = ''
   OR TRIM(department) = ''
   OR TRIM(booking_date) = ''
   OR TRIM(billing_amount) = ''
   OR TRIM(appointment_date) = '';

SELECT
    SUM(TRIM(patient_name) = '') AS missing_patient_name,
    SUM(TRIM(gender) = '') AS missing_gender,
    SUM(TRIM(follow_up_required) = '') AS missing_follow_up,
    SUM(TRIM(doctor) = '') AS missing_doctor,
    SUM(TRIM(department) = '') AS missing_department,
    SUM(TRIM(booking_date) = '') AS missing_booking_date,
    SUM(TRIM(billing_amount) = '') AS missing_billing_amount,
    SUM(TRIM(appointment_date) = '') AS missing_appointment_date
FROM healthcare_pd;

SELECT
    patient_id,
    patient_name,
    gender,
    billing_amount,
    appointment_date,
    department
FROM healthcare_pd
WHERE TRIM(gender) = ''
   OR TRIM(billing_amount) = '';
   
   SELECT
    gender,
    COUNT(*) AS frequency
FROM healthcare_pd
GROUP BY gender
ORDER BY frequency DESC;

SELECT
    department,
    COUNT(*) AS total_appointments,
    ROUND(SUM(billing_amount), 2) AS total_revenue,
    ROUND(AVG(billing_amount), 2) AS average_billing
FROM cleaned_health_pd
GROUP BY department
ORDER BY total_appointments DESC;


UPDATE healthcare_pd
SET gender = 'Male'
WHERE gender = '1';

SELECT
    gender,
    age,
    department,
    COUNT(*) AS frequency
FROM healthcare_pd
WHERE gender IN ('0', '1')
GROUP BY gender, age, department
ORDER BY gender, frequency DESC;

SELECT
    gender,
    COUNT(*) AS frequency
FROM healthcare_pd
GROUP BY gender
ORDER BY frequency DESC;


SELECT
    MIN(patient_id) AS smallest_patient_id,
    MAX(patient_id) AS largest_patient_id,
    COUNT(DISTINCT patient_id) AS unique_patient_ids,
    COUNT(*) AS total_records
FROM healthcare_pd;

SELECT
    gender,
    COUNT(*) AS frequency
FROM healthcare_pd
GROUP BY gender
ORDER BY gender;

SELECT
    patient_id,
    COUNT(*) AS appointment_count
FROM healthcare_pd
GROUP BY patient_id
ORDER BY patient_id;

SELECT
    patient_id,
    patient_name,
    age,
    appointment_date,
    department,
    billing_amount
FROM healthcare_pd
WHERE gender IS NULL
   OR TRIM(gender) = '';
   
   SELECT
    patient_id,
    patient_name,
    age,
    appointment_date,
    department,
    billing_amount,
    follow_up_required
FROM healthcare_pd
WHERE gender = '0';

SELECT
    SUM(patient_id IS NULL OR TRIM(patient_id) = '') AS missing_patient_id,
    SUM(patient_name IS NULL OR TRIM(patient_name) = '') AS missing_patient_name,
    SUM(age IS NULL) AS missing_age,
    SUM(gender IS NULL OR TRIM(gender) = '') AS missing_gender,
    SUM(appointment_date IS NULL OR TRIM(appointment_date) = '') AS missing_appointment_date,
    SUM(booking_date IS NULL OR TRIM(booking_date) = '') AS missing_booking_date,
    SUM(doctor IS NULL OR TRIM(doctor) = '') AS missing_doctor,
    SUM(department IS NULL OR TRIM(department) = '') AS missing_department,
    SUM(billing_amount IS NULL OR TRIM(billing_amount) = '') AS missing_billing_amount,
    SUM(follow_up_required IS NULL OR TRIM(follow_up_required) = '') AS missing_follow_up
FROM healthcare_pd;

SELECT COUNT(*) AS records_to_remove
FROM healthcare_pd
WHERE gender IS NULL
   OR TRIM(gender) = ''
   OR billing_amount IS NULL
   OR TRIM(billing_amount) = '';
   
CREATE TABLE healthcare_pd_clean AS
SELECT *
FROM healthcare_pd
WHERE NOT (
    gender IS NULL
    OR TRIM(gender) = ''
    OR billing_amount IS NULL
    OR TRIM(billing_amount) = ''
);

SELECT COUNT(*) AS total_records
FROM healthcare_pd_clean;

UPDATE healthcare_pd_clean
SET gender = CASE
    WHEN TRIM(LOWER(gender)) IN ('male', 'm') THEN 'Male'
    WHEN TRIM(LOWER(gender)) IN ('female', 'f') THEN 'Female'
    ELSE gender
END;

SELECT
    gender,
    COUNT(*) AS frequency
FROM healthcare_pd_clean
GROUP BY gender
ORDER BY gender;

SELECT
    gender,
    COUNT(*) AS frequency
FROM cleaned_health_pd
GROUP BY gender
ORDER BY gender;

SELECT
    gender,
    COUNT(*) AS frequency
FROM healthcare_pd_clean
GROUP BY gender
ORDER BY gender;


-- Patient Appointment Frequency
--  Which patients are visiting the hospital most frequently?
SELECT
    patient_id,
    patient_name,
    COUNT(*) AS visit_count
FROM cleaned_health_pd
GROUP BY patient_id, patient_name
ORDER BY visit_count DESC;

-- Which department has the highest appointment volume?
SELECT
    department,
    COUNT(*) AS appointment_count
FROM cleaned_health_pd
GROUP BY department
ORDER BY appointment_count DESC;


ALTER TABLE cleaned_health_pd
RENAME COLUMN ï»¿Patient_ID TO Patient_id;

-- Which department has generates highest revenue?

SELECT
    department,
    COUNT(*) AS appointment_count,
	ROUND(SUM(billing_amount),2) AS total_revenue,
    ROUND(AVG(billing_amount),2) AS average_billing
FROM cleaned_health_pd
GROUP BY department
ORDER BY  total_revenue DESC;


UPDATE cleaned_health_pd
SET Billing_Amount=
REPLACE (Billing_Amount, '$',' ');

UPDATE cleaned_health_pd
SET Billing_Amount=
REPLACE (Billing_Amount, 'Rs',' ');


SELECT *
FROM cleaned_health_pd;

-- Follow-Up Rate by Gender 
-- Business question:
-- Is there a difference in follow-up requirements between male and female patients?

SELECT DISTINCT Follow_up_required, gender,
COUNT(*) AS follow_up_rate
FROM cleaned_health_pd
GROUP BY Follow_up_required, gender
HAVING follow_up_rate
ORDER BY  follow_up_rate DESC;



-- Average Patient Age by Department ⭐⭐⭐⭐
-- Business question:
-- What is the average age of patients visiting each department?

SELECT department, 
ROUND(AVG(age), 2) AS Avg_Age_Department
FROM cleaned_health_pd
GROUP BY department
HAVING Avg_Age_Department;


-- Patients with Multiple Appointments
-- Business question:
-- How many patients returned for more than one appointment?

SELECT
    patient_id,
    COUNT(*) AS frequency
FROM cleaned_health_pd
GROUP BY patient_id
ORDER BY frequency DESC;
