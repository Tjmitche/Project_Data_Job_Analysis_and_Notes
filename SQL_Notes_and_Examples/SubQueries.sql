/*
Basic example of a SubQuery
*/
SELECT *
FROM ( -- SubQuery starts here
    Select *
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date) = 1
) As january_job;
--  SubQuery end here

/*
Slightly more advanced version of SubQuery 
- using a sub query to pull the name of the company since it sits in different dataset 
*/
SELECT 
	name as company_name
FROM 
	company_dim 
WHERE company_id IN ( 
    SELECT 
			company_id 
    FROM 
			job_postings_fact 
    WHERE 
			job_no_degree_mention = true
)
ORDER BY
    name ASC;


/* PRACTICE QUESTION 1
Identify the top 5 skills that are most frequently mentioned in job postings
*/ 
SELECT
    skills
FROM
    Skills_dim
INNER Join ( -- Start of SubQuerye
    SELECT 
        skill_id,
        COUNT (Skill_ID) AS skill_count
    FROM 
        skills_job_dim
    GROUP BY
        skill_id
    ORDER BY
        skill_count DESC
    Limit 5
) AS Top_skills ON skills_dim.skill_id = Top_skills.skill_id
ORDER BY
    top_skills.skill_count DESC


/* PRACTICE QUESTION 2
Determine the size category ('Small', 'Medium', or 'Large') for each company by  identifying the number of job postings they have.
Use a subquery to calculate the total job postings per company.
A company is considered
 - 'Small' if it has less than 10 job postings
 - 'Medium' if the number of job postings is between 10 and 50,
 - 'Large' if it has more than 50 job postings.
 Implement a subquery to aggregate job counts per company before classifying them based on size.
*/ 

SELECT
    company_dim.company_id,
    company_dim.name,
    company_job_count.total_job_postings,
    CASE
        WHEN company_job_count.total_job_postings < 10 Then  'Small'
        WHEN company_job_count.total_job_postings BETWEEN 10 and 50 THEN 'Medium'
        WHEN company_job_count.total_job_postings > 50 THEN 'Large'
    END AS company_size
FROM (
    SELECT
        company_id,
        Count(company_id) as total_job_postings
    FROM
        job_postings_fact
    GROUP BY
        company_id,
    ) AS company_job_count
Inner Join company_dim
    ON company_job_count.company_id = company_dim.company_id;


/* PRACTICE QUESTION 3
Find companies that offer an average salary above the overall average yearly salary of all job postings.
Use subqueries to select companies with an average salary higher than the overall average salary (which is another subquery).
*/ 
Select
    company_dim.name
FROM (
    Select
        company_id,
        AVG(salary_year_avg) AS company_avg_salary
    FROM
        job_postings_fact
    GROUP BY
        company_id
    HAVING 
        AVG(salary_year_avg) IS NOT NULL
    ) as avg_salaries
INNER JOIN company_dim
    ON avg_salaries.company_id = company_dim.company_id
WHERE avg_salaries.company_avg_salary > ( 
        Select
            AVG(salary_year_avg) AS total_avg_salary
        FROM
        job_postings_fact
        );

-- Same way to solve question 3 with the From and Inner Join swapped 
-- this was the solution used in the example, both produce the same answer
Select
    company_dim.name
FROM 
    company_dim
INNER JOIN (
        Select
            company_id,
            AVG(salary_year_avg) AS company_avg_salary
        FROM
            job_postings_fact
        GROUP BY
            company_id
        HAVING 
            AVG(salary_year_avg) IS NOT NULL
    ) as avg_salaries
    ON company_dim.company_id = avg_salaries.company_id
WHERE avg_salaries.company_avg_salary > ( 
        Select
            AVG(salary_year_avg) AS total_avg_salary
        FROM
        job_postings_fact
        );