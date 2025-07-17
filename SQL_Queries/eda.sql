--This file contains queries for initial data exploration and analysis.

/*
--Get the total number of records in in the job postings, companies, skills, and skills_job tables.
--This will help in understanding the scale of the data we are working with.
*/

-- Count total job postings, companies, skills, and skill-job links
WITH total_counts AS (
    SELECT 
        (SELECT COUNT(*) FROM job_postings_fact) AS total_job_postings,
        (SELECT COUNT(*) FROM company_dim) AS total_companies,
        (SELECT COUNT(*) FROM skills_dim) AS total_skills,
        (SELECT COUNT(*) FROM skills_job_dim) AS total_skill_job_links
)
SELECT * FROM total_counts;


   