SELECT 
    job_schedule_type,
    AVG(salary_year_avg) as yearly_avg_salary,
    AVG(salary_hour_avg) as hourly_avg_salary
FROM
    job_postings_fact
WHERE
 /*Example 1*/   job_posted_date::Date > '2023-06-01'
GROUP BY
    job_schedule_type
ORDER BY
    job_schedule_type;
-- 1 Find the average salary for yearly and hourly for jobs posted after June 1 2023, group and order by job_schedule_type

SELECT
    count(Job_id) AS job_postings_count,
   /*Example 2*/ EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS Month
FROM
    job_postings_fact
GROUP BY 
    Month
ORDER BY 
    Month;
/* Count the number of posting in each month in 2023, adjusting the job_posted_dates to be in America_New_York
assuming that the orignal times are UTC and then group and order by Month*/

SELECT
    company_dim.name as company_name,
    COUNT(job_postings_fact.job_id) as posting_count
FROM
    job_postings_fact
        INNER JOIN 
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE   
    job_postings_fact.job_health_insurance = TRUE
    AND EXTRACT(QUARTER FROM job_postings_fact.job_posted_date) = 2
GROUP BY 
    company_name
HAVING
    count(job_postings_fact.job_id) > 0
ORDER BY
    posting_count DESC;
/* Find Companies that have posted jobs offering Health insurance, where the job posting was made in Q2 of 2023, order by Descending*/

