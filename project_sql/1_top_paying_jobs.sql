/*
Question: What are the top-paying data analyst jobs?
    - Identify the top 10 highest-paying Data Analyst roles that are available in the USA.
    - Focuses on job postings with specified salaries.
    - Why? Aims to highlight the top-paying opportunities for Data Analysts,
         offering insights into employment options and location.
*/
SELECT
    job_id,
    job_title,
    name AS company_name,
    job_schedule_type,
    salary_year_avg,
    job_work_from_home AS romote_working_status,
    job_country,
    job_location,
    job_posted_date::Date
FROM
    job_postings_fact
LEFT JOIN company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title = 'Data Analyst'
    AND job_country = 'United States'
    AND salary_year_avg IS NOT NULL

ORDER BY
    salary_year_avg DESC
LIMIT 10;
