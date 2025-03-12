CREATE DATABASE project;

USE project;

SELECT * FROM hospital_data;

ALTER TABLE hospital_data
RENAME COLUMN `ï»¿Hospital Name` TO Hospital_Name;


/* o Write an SQL query to find the total number of patients across all hospitals. */

SELECT SUM(`Patients Count`) AS TOTAL_PATIENTS
FROM hospital_data;

/* o Retrieve the average count of doctors available in each hospital. */

SELECT  Hospital_Name,`Location`, ROUND(AVG(`Doctors Count`), 2) AS AVG_OF_DOCTORS_COUNT
FROM hospital_data
GROUP BY Hospital_Name, `Location` ;

/* o Find the top 3 hospital departments that have the highest number of patients. */

SELECT `Department`, SUM(`Patients Count`) AS NO_OF_PATIENTS
FROM hospital_data
GROUP BY `Department`
ORDER BY  NO_OF_PATIENTS DESC
LIMIT 3;


 /* Identify the hospital that recorded the highest medical expenses. */

SELECT *
FROM hospital_data
ORDER BY `Medical Expenses` DESC;

/* o Calculate the average medical expenses per day for each hospital. */
SELECT 
    `Hospital_Name`,
    `Location`,
    SUM(`Medical Expenses`) / SUM(IFNULL(DATEDIFF(`Discharge Date`, `Admission Date`), 1)) AS Average_Medical_Expenses_Per_Day
FROM 
    hospital_data
GROUP BY 
    `Hospital_Name`, 
    `Location`;


/* o Find the patient with the longest stay by calculating the difference between 
Discharge Date and Admission Date. */ 

SELECT *,
   DATEDIFF(STR_TO_DATE(`Discharge Date`, '%d-%m-%Y'), STR_TO_DATE(`Admission Date`, '%d-%m-%Y')) AS `Stay Duration`
FROM hospital_data
ORDER BY `Stay Duration` DESC
LIMIT 1;  

/* o Count the total number of patients treated in each city. */
 SELECT `Location`,SUM(`Patients Count`) AS NO_OF_PATIENTS
 FROM hospital_data
 GROUP BY `Location`;
/* o Calculate the average number of days patients spend in each department. */

SELECT `Department`, 
       ROUND(AVG(DATEDIFF(STR_TO_DATE(`Discharge Date`, '%d-%m-%Y'), 
                          STR_TO_DATE(`Admission Date`, '%d-%m-%Y'))), 2) AS `Avg Stay Duration`
FROM hospital_data
GROUP BY `Department`
ORDER BY `Avg Stay Duration` DESC;


/* o Find the department with the least number of patients. */

SELECT `Department`, SUM(`Patients Count`) AS NO_OF_PATIENTS
FROM hospital_data
GROUP BY `Department`
ORDER BY NO_OF_PATIENTS ASC;

/* • Group the data by month and calculate the total medical expenses for each month */

 SELECT MONTHNAME(STR_TO_DATE(`Admission Date`, '%d-%m-%Y')) AS `Month`,
       SUM(`Medical Expenses`) AS `Total Medical Expenses (₹)`
FROM hospital_data
GROUP BY `Month`
ORDER BY FIELD(`Month`, 'January', 'February', 'March', 'April', 'May', 'June', 
                            'July', 'August', 'September', 'October', 'November', 'December');

