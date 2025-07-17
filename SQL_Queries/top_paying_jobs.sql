/*
 * SQL Query to find the top paying Data Analyst jobs in the United States
 * This CTE retrieves job postings for Data Analysts, filtering by salary and location.
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
)

SELECT * FROM top_data_analyst_jobs