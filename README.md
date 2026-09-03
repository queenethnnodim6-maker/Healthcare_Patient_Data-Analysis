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

## Visualizing the Data on Excel
<img width="1158" height="489" alt="Excel Dashboard new" src="https://github.com/user-attachments/assets/6775f10e-1944-47e1-a0e8-93445b86647a" />


## KEY INSIGHTS ANALYZED USING SQL
- Question: Which patients are visiting the hospital most frequently?
- Question: Which departments have the highest revenue?
- Question: Is there a difference in follow-up requirements between male and female patients?
- Question: What is the average age of patients visiting each department?
-Question: How many patients returned for more than one appointment?


Which patients are visiting the hospital most frequently?
```MySQL
SELECT
    patient_id,
    patient_name,
    COUNT(*) AS visit_count
FROM cleaned_health_pd
GROUP BY patient_id, patient_name
ORDER BY visit_count DESC;
```

Which department has the highest appointment volume?
```MySQL
SELECT
    department,
    COUNT(*) AS appointment_count
FROM cleaned_health_pd
GROUP BY department
ORDER BY appointment_count DESC;
```

Which department generates the highest revenue?
```MySQL
SELECT
    department,
    COUNT(*) AS appointment_count,
	ROUND(SUM(billing_amount),2) AS total_revenue,
    ROUND(AVG(billing_amount),2) AS average_billing
FROM cleaned_health_pd
GROUP BY department
ORDER BY  total_revenue DESC;
```

Is there a difference in follow-up requirements between male and female patients?
```MySQL
SELECT DISTINCT Follow_up_required, gender,
COUNT(*) AS follow_up_rate
FROM cleaned_health_pd
GROUP BY Follow_up_required, gender
HAVING follow_up_rate
ORDER BY  follow_up_rate DESC;
```

What is the average age of patients visiting each department?
```MySQL
SELECT department, 
ROUND(AVG(age), 2) AS Avg_Age_Department
FROM cleaned_health_pd
GROUP BY department
HAVING Avg_Age_Department;
```

How many patients returned for more than one appointment?
```MySQL
SELECT
    patient_id,
    COUNT(*) AS frequency
FROM cleaned_health_pd
GROUP BY patient_id
HAVING frequency > 1
ORDER BY frequency DESC;
```




