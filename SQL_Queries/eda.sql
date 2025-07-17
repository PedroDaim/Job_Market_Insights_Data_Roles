--This file contains queries for initial data exploration and analysis.

/*
--Get the total number of records in in the job postings, companies, skills, and skills_job tables.
--This will help in understanding the scale of the data we are working with.
*/

--Count total job postings, companies, skills, and skill-job links
WITH total_counts AS (
    SELECT 
        (SELECT COUNT(*) FROM job_postings_fact) AS total_job_postings,
        (SELECT COUNT(*) FROM company_dim) AS total_companies,
        (SELECT COUNT(*) FROM skills_dim) AS total_skills,
        (SELECT COUNT(*) FROM skills_job_dim) AS total_skill_job_links
)
SELECT * FROM total_counts;

-- =============================================================================
-- DATA QUALITY ASSESSMENT
-- =============================================================================

/*First, let's understand the overall dataset composition and data quality by region
  This helps us understand potential biases and make informed decisions about our analysis scope
*/
-- Step 1: Understand the dataset composition and data quality by region
SELECT
    CASE 
        WHEN job_country = 'United States' THEN 'USA'
        WHEN job_country IS NULL THEN 'Unknown Country'
        ELSE 'Other Countries'
    END AS region,
    COUNT(*) AS total_jobs,
    COUNT(salary_year_avg) AS jobs_with_salary,
    ROUND(COUNT(salary_year_avg) * 100.0 / COUNT(*), 2) AS percent_with_salary,
    COUNT(job_title_short) AS jobs_with_title,
    ROUND(COUNT(job_title_short) * 100.0 / COUNT(*), 2) AS percent_with_title
FROM job_postings_fact
GROUP BY 
    CASE 
        WHEN job_country = 'United States' THEN 'USA'
        WHEN job_country IS NULL THEN 'Unknown Country'
        ELSE 'Other Countries'
    END
ORDER BY total_jobs DESC;

-- Based on the above analysis, we can see that USA has 7.6% of jobs with salary data
-- Now let's focus specifically on USA jobs for our detailed analysis

-- Step 2: Deep dive into USA data quality for our main analysis
SELECT
    COUNT(*) AS total_usa_jobs,
    COUNT(salary_year_avg) AS non_null_salaries,
    COUNT(*) - COUNT(salary_year_avg) AS null_salaries,
    ROUND((COUNT(*) - COUNT(salary_year_avg)) * 100.0 / COUNT(*), 2) AS percent_null_salaries,
    COUNT(*) - COUNT(job_title_short) AS null_job_titles,
    ROUND((COUNT(*) - COUNT(job_title_short)) * 100.0 / COUNT(*), 2) AS percent_null_job_titles
FROM job_postings_fact
WHERE job_country = 'United States';

-- Descriptive statistics for salary in the USA
SELECT
    MIN(salary_year_avg) AS min_yearly_salary,
    MAX(salary_year_avg) AS max_yearly_salary,
    ROUND(AVG(salary_year_avg), 2) AS avg_yearly_salary,
    ROUND(STDDEV(salary_year_avg), 2) AS stddev_yearly_salary,
    -- Additional useful statistics
    ROUND(AVG(salary_year_avg) - STDDEV(salary_year_avg), 2) AS avg_minus_1_stddev,
    ROUND(AVG(salary_year_avg) + STDDEV(salary_year_avg), 2) AS avg_plus_1_stddev,
    -- Percentiles for better distribution understanding
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY salary_year_avg) AS q1_salary,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_year_avg) AS median_salary,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY salary_year_avg) AS q3_salary
FROM job_postings_fact 
WHERE salary_year_avg IS NOT NULL
AND job_country = 'United States'; 