/* 
Basic example of a CTE
*/
WITH Jan_job AS (
    Select *
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date) = 1
) -- CTE ends here
Select *
FROM Jan_job;

/*
More advanced use of CTE
Find the companies that have the most job openings
- Get the total number of job postings per company id
- Return the total number of jobs with the company name
*/

With Company_job_count AS (
    SELECT
        company_id,
        count(*) AS job_counte
    FROM 
        job_postings_fact
    group BY
        company_id
)
Select 
    company_dim.name AS compnay_name,
    Company_job_count.job_count AS total_jobs
FROM 
    company_dim
LEFT JOIN Company_job_count
    ON company_dim.company_id = Company_job_count.company_id
ORDER BY 
    Company_job_count.job_count DESC;


/* PRACTICE QUESTION 1
Identify companies with the most diverse (unique) job titles. Use a CTE to count the number of unique job titles per company,
then select companies with the highest diversity in job titles.
*/ 
WITH unique_job_titles AS(
    SELECT
        COMPANY_ID,
        Count(DISTINCT job_title) as unique_count
    FROM 
        job_postings_fact
    GROUP BY
        company_id
    )
SELECT 
    company_dim.name,
    unique_job_titles.unique_count
FROM unique_job_titles
INNER JOIN company_dim
    ON unique_job_titles.COMPANY_ID = company_dim.company_id
ORDER BY unique_job_titles.unique_count DESC
LIMIT 10;


/* PRACTICE QUESTION 2
Explore job postings by listing job id, job titles, company names, and their average salary rates,
while categorizing these salaries relative to the average in their respective countries.
Include the month of the job posted date. Use CTEs, conditional logic, and date functions,
to compare individual salaries with national averages.
*/ 
WITH country_avg_salaries AS (
SELECT 
    job_country,
    AVG(salary_year_avg) AS country_salary
FROM
    job_postings_fact
GROUP BY
    job_country
)
SELECT 
    job_postings_fact.Job_id,
    job_postings_fact.job_title,
    company_dim.name as company_name, 
    job_postings_fact.salary_year_avg,
    EXTRACT(MONTH FROM job_postings_fact.job_posted_date) AS Month,
    CASE
        WHEN salary_year_avg > country_salary THEN 'Above Average'
        ELSE 'Below Average'
    END AS salary_comparison
FROM 
    job_postings_fact
INNER JOIN country_avg_salaries 
    ON job_postings_fact.job_country = country_avg_salaries.job_country
INNER JOIN company_dim
    on job_postings_fact.company_id = company_dim.company_id
ORDER BY
    Month DESC;


/* PRACTICE QUESTION 3
Calculate the number of unique skills required by each company.
Aim to quantify the unique skills required per company and identify which of these companies offer the highest salary for positions with at least one skill.
For entities without skill-related job postings, list it as a zero skill requirement and a null salary.
Use CTEs to separately assess the unique skill count and the maximum average salary offered by these companies.
*/
WITH skill_count AS ( -- Counts the distinct skills required for each company's job posting
    SELECT
        job_postings_fact.company_id,
        COUNT(DISTINCT skills_job_dim.skill_id) as distinct_skill_count
    FROM
        job_postings_fact
    LEFT JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.Job_id
    GROUP BY
        job_postings_fact.company_id
    ),
highest_avg_salary AS ( -- Gets the highest average yearly salary from the jobs that require at least one skills 
    SELECT
        job_postings_fact.company_id,
        MAX(job_postings_fact.salary_year_avg) as max_salary
    FROM
        job_postings_fact
    WHERE
        job_postings_fact.job_id IN (SELECT job_id FROM skills_job_dim)
    GROUP BY
        job_postings_fact.company_id
    )
SELECT -- Joins 2 CTEs with table to get the query
    company_dim.name AS company_name,
    skill_count.distinct_skill_count,
    highest_avg_salary.max_salary
FROM
    skill_count
LEFT JOIN company_dim
    ON skill_count.company_id = company_dim.company_id
LEFT JOIN highest_avg_salary
    ON skill_count.company_id = highest_avg_salary.company_id
ORDER BY
    company_dim.name;