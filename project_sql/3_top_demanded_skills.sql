/*
Question: What are the most in-demand skills for data analysts?
    - Identify the top 5 in-demand skills for a data analyst.
    - Focus on all job postings in the U.S.
    - Why? Retrieves the top 5 skills with the highest demand in the job market,
        providing insights into the most valuable skills for job seekers.
*/


SELECT
    skills,
    type,
    Count(job_postings_fact.job_id) AS skill_count
FROM
    job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_country = 'United States'
    AND job_title = 'Data Analyst'
GROUP BY
    skills,
    type
ORDER BY
    skill_count DESC
LIMIT 5;


/*
[
  {
    "skills": "sql",
    "type": "programming",
    "skill_count": "8317"
  },
  {
    "skills": "excel",
    "type": "analyst_tools",
    "skill_count": "5831"
  },
  {
    "skills": "tableau",
    "type": "analyst_tools",
    "skill_count": "4596"
  },
  {
    "skills": "python",
    "type": "programming",
    "skill_count": "4238"
  },
  {
    "skills": "power bi",
    "type": "analyst_tools",
    "skill_count": "2944"
  }
]
*/