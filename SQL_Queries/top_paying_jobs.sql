/* This SQL query retrieves the top paying data jobs in the United States,
   specifically focusing on Data Analyst, Data Scientist, and Data Engineer roles.
   It combines results from three separate queries for each job category 
*/

WITH top_data_analyst_jobs AS (
    SELECT
        job_id,
        job_title_short,
        job_title,
        job_location,
        job_country,
        salary_year_avg,
        company_id,
        'Data Analyst' AS job_category -- Keep the category for clarity
    FROM
        job_postings_fact
    WHERE
        salary_year_avg IS NOT NULL
        AND job_country = 'United States'
        AND job_title_short ILIKE '%Data Analyst%' -- Using ILIKE for broader match
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
),
top_data_scientist_jobs AS (
    SELECT
        job_id,
        job_title_short,
        job_title,
        job_location,
        job_country,
        salary_year_avg,
        company_id,
        'Data Scientist' AS job_category
    FROM
        job_postings_fact
    WHERE
        salary_year_avg IS NOT NULL
        AND job_country = 'United States'
        AND job_title_short ILIKE '%Data Scientist%'
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
),
top_data_engineer_jobs AS (
    SELECT
        job_id,
        job_title_short,
        job_title,
        job_location,
        job_country,
        salary_year_avg,
        company_id,
        'Data Engineer' AS job_category
    FROM
        job_postings_fact
    WHERE
        salary_year_avg IS NOT NULL
        AND job_country = 'United States'
        AND job_title_short ILIKE '%Data Engineer%'
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
),

-- Combine all the top jobs into a single reusable CTE
all_top_jobs AS (
    SELECT * FROM top_data_analyst_jobs
    UNION ALL
    SELECT * FROM top_data_scientist_jobs
    UNION ALL
    SELECT * FROM top_data_engineer_jobs
),

-- New CTE to get skill counts per category and total skills per category
skill_counts_by_category AS (
    SELECT
        job_category,
        s.skills AS skill_name,
        COUNT(s.skills) AS skill_count
    FROM
        all_top_jobs AS atj
    JOIN
        skills_job_dim AS sjd ON atj.job_id = sjd.job_id
    JOIN
        skills_dim AS s ON sjd.skill_id = s.skill_id
    GROUP BY
        atj.job_category,
        s.skills
)
-- #######################################################
-- ## END OF BASE CTEs ##
-- #######################################################

--QUESTION 1: Top-Paying Jobs Overview##
-- #######################################################
/*
Business Question:
What are the top-paying jobs for Data Analysts, Data Scientists, and Data Engineers across the USA?
*/
-- This query retrieves the top-paying jobs for each category and combines them into a single result set

--SELECT * FROM all_top_jobs
--ORDER BY job_category, salary_year_avg DESC;

/*
-- #######################################################
-- ## QUESTION 2: Most Frequently Required Skills for Top-Paying Jobs ##
-- #######################################################

Business Question:
What are the most frequently required skills for the top-paying Data Analyst, Data Scientist, and Data Engineer jobs in the USA?
*/
SELECT
    s.skills AS skill_name,
    COUNT(*) AS skill_count
FROM
    all_top_jobs AS atj
JOIN
    skills_job_dim AS sjd ON atj.job_id = sjd.job_id
JOIN
    skills_dim AS s ON sjd.skill_id = s.skill_id
GROUP BY
    s.skills_name
ORDER BY
    skill_count DESC;