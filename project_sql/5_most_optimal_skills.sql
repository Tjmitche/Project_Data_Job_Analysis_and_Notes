/*
Question: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill) for a data analyst? 
    - Identify skills in high demand and associated with high average salaries for Data Analyst roles
    - Concentrates on job located in the U.S. with specified salaries
    - Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
         offering strategic insights for career development in data analysis
*/
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    skills_dim.type,
    Count(skills_job_dim.job_id) AS skill_count,
    ROUND(AVG(salary_year_avg),2) AS avg_salary
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_country = 'United States'
        AND salary_year_avg IS NOT NULL
        AND job_title = 'Data Analyst'
GROUP BY
    skills_dim.skill_id
HAVING
    Count(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    skill_count DESC
LIMIT 25;