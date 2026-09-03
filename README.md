# Healthcare Patient Data Analysis

## Project Overview

This project analyzes healthcare patient and appointment data to identify trends in patient demographics, departmental performance, billing, appointment scheduling, and follow-up requirements.

## Tools Used
1. Microsoft Excel
2. MySQL
3. Power BI

The analysis seeks to answer:

1. Which departments receive the most appointments?
2. Which departments generate the most revenue?
3. Which doctors handle the highest number of appointments?
4. What percentage of patients require follow-up?
5. Which departments have the highest follow-up rates?
6. What is the age distribution of patients?
7. How far in advance are appointments booked?
8. How does appointment volume change over time?
9. Which doctors generate the highest billing amounts?
10. Are there noticeable relationships between patient demographics and billing?

## Data Cleaning

The dataset was cleaned and standardized using Excel and MySQL. EBoth tools were used to showcase strenght in the use of the tool. The processed involved are:

1. Removing unnecessary spaces
2. Standardizing categorical values
3. Checking duplicates
4. Handling missing values
5. Converting dates to appropriate formats
6. Converting billing amounts to numeric values
7. Creating calculated fields
8. Validating booking and appointment dates
9. Analysis of Key business insights

## SQL Queries used in cleaning the Dataset

```MySQL
CREATE TABLE healthcare_pd (
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
```

-- Checking for missing values and inconsistent values

```MySQL
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
```

```MySQL
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
```

Duplicates

```MySQL
SELECT 
    patient_id,
    COUNT(*) AS duplicate_count
FROM healthcare_pd
GROUP BY patient_id
HAVING COUNT(*) > 1;
```

Inconsistent characters

```MySQL
SELECT
    gender,
    COUNT(*) AS frequency
FROM healthcare_pd
GROUP BY gender
ORDER BY frequency DESC;
```

## Visualizing the Data on Excel
<img width="1158" height="489" alt="Excel Dashboard new" src="https://github.com/user-attachments/assets/6775f10e-1944-47e1-a0e8-93445b86647a" />





