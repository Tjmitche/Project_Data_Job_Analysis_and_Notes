/* Example, make a new colum with the job_location data where anywhere is 'remote', 
    jobs in NY are 'Local' and all other jobs are 'Onsite' 
    only include jobs that are Data Analysts */
SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        Else 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    location_category
ORDER BY
    number_of_jobs DESC;

/* QUESTION 1
    Categorize the salaries from job postings that are data analyst jobs and who have a yearly salarly information.
    Put salary into 3 different categories 
    - Greater thatn $100k then return 'High Salary'
    - Between $60k and $99.999k then return 'Standard Salary'
    - Less than $60k then return 'Low Salary' */

Select
    job_id,
    job_title,
    salary_year_avg,
    CASE
        WHEN salary_year_avg > 100000 Then 'High Salary'
        WHEN salary_year_avg BETWEEN 60000 AND 99999 THEN 'Standard Salary'
        WHEN salary_year_avg < 60000 THEN 'Low Salary'
    END AS salary_range
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC;


/*QUESTION 2 
    Count the number of unique companies that offer work from home (WFH) versus those requiring work to be on-site.
    Use the job_postings_fact table to count and compare the distinct companies based on their WFH policy (job_work_from_home)*/

SELECT
    COUNT(DISTINCT CASE 
        WHEN job_work_from_home = TRUE THEN company_id END) AS WFM_comapnies,
    COUNT(DISTINCT CASE
        WHEN job_work_from_home = FALSE THEN company_id END) AS non_WFM_comapnies
FROM
    job_postings_fact;


/*QUESTION 3
    Write a query that lists all job postings with their job_id, salary_year_avg,
    and two additional columns using CASE WHEN statements called: experience_level and remote_option.
    - For experience_level, categorize jobs based on keywords found in their titles (job_title)
         as 'Senior', 'Lead/Manager', 'Junior/Entry', or 'Not Specified'.
    - For remote_option, specify whether a job offers a remote option as either 'Yes' or 'No' */

SELECT
    job_id,
    salary_year_avg,
    CASE
        WHEN job_title LIKE '%Senior%' THEN 'Senior'
        WHEN job_title like '%Manager%' or job_title LIKE '%Lead%' Then 'Lead/Manager'
        WHEN job_title LIKE '%Junionr%' or job_title LIKE '%Entry%' Then 'Junior/Entry'
        ELSE 'Not Specified'
    END AS experience_level,
    CASE
        WHEN job_work_from_home = TRUE THEN 'Yes'
        WHEN job_work_from_home = FALSE THEN 'No'
    END AS remote_option
FROM 
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
ORDER BY 
    job_id;
