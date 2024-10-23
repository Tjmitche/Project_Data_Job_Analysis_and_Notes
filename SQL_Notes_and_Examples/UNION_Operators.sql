/* QUESTION 1
Create a unified query that categorizes job postings into two groups:
- those with salary information
- those without it
- Each job posting should be listed with its job_id, job_title, and an indicator of whether salary information is provided.
*/
    (
        SELECT
            job_id,
            job_title,
            'With Salary Information' AS salary_info
        FROM
            job_postings_fact
        WHERE
            salary_year_avg IS NOT NULL OR salary_hour_avg IS NOT NULL
    )
    UNION ALL
    (
        SELECT
            job_id,
            job_title,
            'Without Salary Information' AS salary_info
        FROM
            job_postings_fact
        WHERE
            salary_year_avg IS NULL AND salary_hour_avg IS NULL
    )
    ORDER BY
        salary_info DESC,
        job_id;


/* QUESTION 2
Retrieve the job id, job title short, job location, job via, salart year avg, skill and skill type for each job posting from the first quarter (January to March).
*/
    SELECT
        job_postings_q1.job_id,
        job_postings_q1.job_title_short,
        job_postings_q1.job_location,
        job_postings_q1.job_via,
        job_postings_q1.salary_year_avg,
        skills_dim.skills,
        skills_dim.type
    FROM ( 
        -- Get job postings from the first quarter of 2023
        SELECT *
        FROM january_jobs
        UNION ALL
        SELECT *
        FROM february_jobs
        UNION ALL
        SELECT *
        FROM march_jobs
    ) as job_postings_q1
    LEFT JOIN skills_job_dim
        ON job_postings_q1.job_id = skills_job_dim.job_id
    LEFT JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_postings_q1.salary_year_avg > 70000
    ORDER BY 
        job_postings_q1.job_id;


/* QUESTION 3
Analyze the monthly demand for skills by counting the number of job postings for each skill in the first quarter,
utilizing data from separate tables for each month. Ensure to include skills from all job postings across these months. 
*/
    WITH q1_jobs AS 
        (  -- Get job postings from the first quarter of 2023
        SELECT *
        FROM january_jobs
        UNION ALL
        SELECT *
        FROM february_jobs
        UNION ALL
        SELECT *
        FROM march_jobs
        ),
    q1_job_skills AS (
    SELECT
        skills_dim.skills AS skill,
        EXTRACT(YEAR FROM q1_jobs.job_posted_date) as year,
        EXTRACT(MONTH FROM q1_jobs.job_posted_date) as month,
        COUNT (q1_jobs.job_id) as job_count
    FROM q1_jobs
    LEFT JOIN skills_job_dim
        ON q1_jobs.job_id = skills_job_dim.job_id
    LEFT JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    GROUP BY
        skills_dim.skills,
        month,
        year
    )
    SELECT
        skill,
        year,
        month,
        job_count
    FROM q1_job_skills;

