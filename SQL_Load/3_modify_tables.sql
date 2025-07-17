-- SQL script to load data into the database tables from CSV files

COPY company_dim
FROM 'C:\Users\Pedro\OneDrive\Documents\Github\sql_project_data_jobs\csv_files\company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM 'C:\Users\Pedro\OneDrive\Documents\Github\sql_project_data_jobs\csv_files\skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM 'C:\Users\Pedro\OneDrive\Documents\Github\sql_project_data_jobs\csv_files\job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM 'C:\Users\Pedro\OneDrive\Documents\Github\sql_project_data_jobs\csv_files\skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy company_dim FROM 'C:\Users\Pedro\OneDrive\Documents\Github\sql_project_data_jobs\csv_files\company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_dim FROM 'C:\Users\Pedro\OneDrive\Documents\Github\sql_project_data_jobs\csv_files\skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_postings_fact FROM 'C:\Users\Pedro\OneDrive\Documents\Github\sql_project_data_jobs\csv_files\job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_job_dim FROM 'C:\Users\Pedro\OneDrive\Documents\Github\sql_project_data_jobs\csv_files\skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');