
-- QUESTIONS 

 -- 1. What is the gender breakdown of employees in the company?--

SELECT gender, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND IFNULL(termdate, '0000-00-00') = '0000-00-00'
GROUP BY gender;

-- 2.What is the race/ethnicity breakdown of employees in the company?
SELECT race, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND IFNULL(termdate, '0000-00-00') = '0000-00-00'
GROUP BY race
ORDER BY count DESC;

-- 3.What is the age distribution of employees in the company?
/* SELECT
  MIN(age) AS youngest,
  MAX(age) AS oldest
FROM
  hr
WHERE
  age >= 18
  AND COALESCE(termdate, '0000-00-00') = '0000-00-00'
  AND age IS NOT NULL;

SELECT 
  CASE 
    WHEN age >= 18 AND age <= 24 THEN '18-24'
    WHEN age >= 25 AND age <= 34 THEN '25-34'
    WHEN age >= 35 AND age <= 44 THEN '35-44'
    WHEN age >= 45 AND age <= 54 THEN '45-54'
    WHEN age >= 55 AND age <= 64 THEN '55-64'
    ELSE '65+'
  END AS age_group,
  COUNT(*) AS count 
FROM hr 
WHERE
  age >= 18
  AND COALESCE(termdate, '0000-00-00') = '0000-00-00'
  AND age IS NOT NULL
GROUP BY age_group 
ORDER BY age_group;
*/
SELECT 
  gender,
  CASE 
    WHEN age >= 18 AND age <= 24 THEN '18-24'
    WHEN age >= 25 AND age <= 34 THEN '25-34'
    WHEN age >= 35 AND age <= 44 THEN '35-44'
    WHEN age >= 45 AND age <= 54 THEN '45-54'
    WHEN age >= 55 AND age <= 64 THEN '55-64'
    ELSE '65+'
  END AS age_group,
  COUNT(*) AS count 
FROM hr 
WHERE
  age >= 18
  AND COALESCE(termdate, '0000-00-00') = '0000-00-00'
  AND age IS NOT NULL
GROUP BY gender, age_group 
ORDER BY gender, age_group;
-- 4.How many employees work at headquarters versus remote locations?
SELECT location, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND (termdate IS NULL OR termdate != '1000-01-01') AND age IS NOT NULL
GROUP BY location;

-- 5.What is the average length of the employeement for employees who have been terminated?
SELECT round(AVG(DATEDIFF(termdate, hire_date))/365,0)  AS avg_employment_length
FROM hr
WHERE termdate IS NOT NULL;

-- 6.How does the gender distribution vary across departments and job titles?
SELECT department, gender, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY department, gender
ORDER BY department, gender DESC;

-- 7. What is the distribution of job titles across the company?
SELECT jobtitle, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8. Which department has the highest turnover rate ?
SELECT
  department,
  COUNT(*) AS total_count,
  SUM(termdate IS NOT NULL AND termdate <= CURDATE()) AS terminated_count,
  SUM(termdate IS NOT NULL AND termdate <= CURDATE()) / NULLIF(COUNT(*), 0) AS termination_rate
FROM
  hr
WHERE
  age >= 18
  AND termdate IS NOT NULL
GROUP BY
  department
ORDER BY
  termination_rate DESC;

-- 9. What is the distribution of employees across the locations by city and state?
SELECT location_state, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate IS NULL 
GROUP BY location_state
ORDER BY count DESC;

-- 10. How has the company's employees count changed over time based on hire and term dates?
SELECT year, hires,terminations,hires - terminations AS net_change, ROUND((hires - terminations) / hires * 100, 2) AS net_change_percent
FROM (SELECT YEAR(hire_date) AS year, COUNT(*) AS hires,
SUM(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations
FROM hr
WHERE age > 18
GROUP BY YEAR(hire_date)
) AS subquery
ORDER BY year ASC;

-- 11.What is the tenure distribution for each department ?

SELECT department, ROUND(AVG(DATEDIFF(COALESCE(termdate, CURDATE()), hire_date) / 365), 0) AS avg_tenure
FROM hr
WHERE age >= 18
GROUP BY department;








