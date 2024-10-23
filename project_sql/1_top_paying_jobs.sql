/*
Question: What are the top-paying data analyst jobs?
    - Identify the top 10 highest-paying Data Analyst roles that are available in the USA.
    - Focuses on job postings with specified salaries.
    - Why? Aims to highlight the top-paying opportunities for Data Analysts,
         offering insights into employment options and location flexibility.
*/
SELECT
    job_postings_fact.job_id,
    job_postings_fact.job_title,
    company_dim.name AS company_name,
    job_postings_fact.job_via,
    job_postings_fact.salary_year_avg,
    job_postings_fact.job_schedule_type,
    job_postings_fact.job_work_from_home AS romote_working_status,
    job_postings_fact.job_country,
    job_postings_fact.job_location,
    job_postings_fact.job_posted_date::Date
FROM
    job_postings_fact
LEFT JOIN company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_postings_fact.job_title = 'Data Analyst'
    AND job_postings_fact.job_country = 'United States'
    AND job_postings_fact.salary_year_avg IS NOT NULL

ORDER BY
    job_postings_fact.salary_year_avg DESC
