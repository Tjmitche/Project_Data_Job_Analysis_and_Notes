/*QUESTION 1
    Get Job Details for Both 'Data Analyst' or 'Business Analyst' postions 
     - For Data Analyst, only jobs > $100k
     - For Business Analyst, only jobs > $70k
     - Only include jobs in either 'Boston, MA'or 'Anywhere' (remote)
     - Include job title, location, posting source, average yearly salary */

SELECT
    job_title_short,
    job_location,
    job_via,
    salary_year_avg
FROM
    job_postings_fact
WHERE
    job_location IN ('Boston, MA', 'Anywhere')
    AND (
        (job_title_short = 'Data Analyst' and salary_year_avg > 100000)
        OR
        (job_title_short = 'Business Analyst' and salary_year_avg > 70000)
    ); 


/*QUESTION 2
    Look for non-senior data analyst or business analyst roles
    - Get job title, location, and average yearly salary
    - (added line to excldue job where yearly salary is NULL)
    - (added line to only include jobs found in NC) */

SELECT
    job_title,
    job_location,
    salary_year_avg
FROM
    job_postings_fact
WHERE
    (job_title LIKE '%Data%' or job_title LIKE '%Business%')
    AND job_title LIke '%Analyst%'
    AND job_title NOT LIKE '%Senior%'
    AND salary_year_avg IS NOT NULL
    AND job_location LIKE '% NC%';


/*QUESTION 4
    - Find the AVG, MIN and MAX salary range for each job_title_short
    - only include jobm titles with more than 5 postings
    - Group by job title short
    Why? To compare the salary metrics between the different types of data jobs*/

SELECT
    job_title_short,
    MIN(salary_year_avg) AS min_avg_salary,
    AVG(salary_year_avg) AS avg_salary,
    MAX(salary_year_avg) AS max_avg_salary
FROM 
    job_postings_fact
GROUP BY
    job_title_short
Having
    Count(job_id) > 5


/*Question 5
    - Write a query to list each unique skill from the skills_dim table.
    - Count how many job postings mention each skill from the skills_to_job_dim table.
    - Calculate the average yearly salary for job postings associated with each skill.
    - Group the results by the skill name.
    - Order By the average salary
    - (Added line to remove skills with a avg_salary value of NOT NULL) */

SELECT
    skills_dim.skills AS Skill,
    Count(skills_job_dim.job_id) AS number_of_jobs,
    AVG(job_postings_fact.salary_year_avg) AS avg_salary
FROM
    Skills_dim
    LEFT JOIN 
        skills_job_dim on skills_dim.skill_id = skills_job_dim.skill_id
    LEFT JOIN
        job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
GROUP BY
    skills_dim.skills
Having
    AVG(job_postings_fact.salary_year_avg) IS NOT NULL
ORDER BY
    number_of_jobs DESC;


/*QUESTION 6
    Create 3 tables
    - Jan 2023 jobs
    - Feb 2023 jobs
    - Mar 2023 jobs*/

--January Jobs
Create Table january_jobs AS
    Select *
    From job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

--February Jobs
Create Table february_jobs AS
    Select *
    From job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

--March Jobs
Create Table march_jobs AS
    Select *
    From job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;


/* QUESTION 7
Find the count of the number of remote job postings per skill
- Display the top 5 skills in descending order by their demand in remote jobs
- include skill ID, name, and count of postings requiring the skill
- Why? Identify the top 5 skills for remote jobs
*/

-- My first attempt at the question
    -- My solution is correct but done differently from the example solution
    -- wanted to note, because of how different the two solutions were
    WITH wfh_jobs AS ( -- Common Table Expression (CTE) to filter jobs that are work-from-home
        SELECT 
            job_postings_fact.job_id
        FROM 
            job_postings_fact
        WHERE
            job_work_from_home = TRUE
        )
    SELECT -- Main query to count skills for work-from-home jobs
        skills_job_dim.skill_id,
        skills_dim.skills,
        COUNT(wfh_jobs.job_id) AS job_count
    FROM
        skills_job_dim
    INNER JOIN wfh_jobs
        ON skills_job_dim.job_id = wfh_jobs.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    GROUP BY 
        skills_job_dim.skill_id, skills_dim.skills
    ORDER BY
        job_count DESC
    Limit 5;

-- The example solution that was porvided
    WITH wfm_job_count AS (
        SELECT
            skill_id,
            COUNT(skills_job_dim.job_id) AS job_count
        FROM 
            skills_job_dim
        INNER JOIN job_postings_fact
            ON skills_job_dim.job_id = job_postings_fact.job_id
        WHERE
            job_postings_fact.job_work_from_home = TRUE
        GROUP BY
            skill_id
        )
    SELECT
        wfm_job_count.skill_id,
        skills_dim.skills AS skill_name,
        wfm_job_count.job_count
    FROM
        wfm_job_count
    INNER JOIN skills_dim
        ON wfm_job_count.skill_id = skills_dim.skill_id
    ORDER BY
        wfm_job_count.job_count DESC
    LIMIT 5;


/* QUESTION 8
I only want to look at job postings from the first quarter that have a salary greater than $70k. 
    - Why? Look at job postings for the first quarter of 2023 (Jan-Mar) that has a salary > $70,000
    */

-- Solving the question using a CTE 
    WITH q1_jobs AS (
        SELECT *
        FROM january_jobs
        UNION ALL
        SELECT *
        FROM february_jobs
        UNION ALL
        SELECT *
        FROM march_jobs
        )
    SELECT  
        q1_jobs.job_title_short,
        q1_jobs.job_location,
        q1_jobs.job_via,
        q1_jobs.job_posted_date::Date
    FROM 
        q1_jobs
    WHERE
        q1_jobs.salary_year_avg > 70000
    ORDER BY
        q1_jobs.salary_year_avg DESC;

-- Solving the question useing a subquery 
    SELECT
        quarter1_job_postings.job_title_short,
        quarter1_job_postings.job_location,
        quarter1_job_postings.job_via,
        quarter1_job_postings.job_posted_date::DATE
    FROM
    -- Gets all rows from January, February, and March job postings 
        (
            SELECT *
            FROM january_jobs
            UNION ALL
            SELECT *
            FROM february_jobs
            UNION ALL 
            SELECT *
            FROM march_jobs
        ) AS quarter1_job_postings 
    WHERE
        quarter1_job_postings.salary_year_avg > 70000
    ORDER BY
        quarter1_job_postings.salary_year_avg DESC

