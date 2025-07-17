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
)
-- Combine all the top jobs
SELECT * FROM top_data_analyst_jobs
UNION ALL
SELECT * FROM top_data_scientist_jobs
UNION ALL
SELECT * FROM top_data_engineer_jobs
ORDER BY
    job_category, salary_year_avg DESC;

