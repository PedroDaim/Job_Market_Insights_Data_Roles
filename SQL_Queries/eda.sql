--This file contains queries for initial data exploration and analysis.

/*
--Get the total number of records in in the job postings, companies, skills, and skills_job tables.
--This will help in understanding the scale of the data we are working with.
*/

-- Step 1: Count total job postings, companies, skills, and skill-job links
WITH total_counts AS (
    SELECT 
        (SELECT COUNT(*) FROM job_postings_fact) AS total_job_postings,
        (SELECT COUNT(*) FROM company_dim) AS total_companies,
        (SELECT COUNT(*) FROM skills_dim) AS total_skills,
        (SELECT COUNT(*) FROM skills_job_dim) AS total_skill_job_links
)
SELECT * FROM total_counts;

-- Step 2: Understand the dataset composition and data quality by region
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







   