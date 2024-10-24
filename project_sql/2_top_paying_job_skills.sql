/*
Question: What are the top-paying data analyst jobs, and what skills are required?
    - Identify the top 10 highest-paying Data Analyst jobs and the specific skills required for these roles.
    - Filters for roles with specified salaries that are located in the U.S.
    - Why? It provides a detailed look at which high-paying jobs demand certain skills, 
        helping job seekers understand which skills to develop that align with top salaries
*/ 
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        name AS company_name,
        salary_year_avg,
        job_country
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
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills,
    type
FROM top_paying_jobs
INNER JOIN skills_job_dim
    ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg;
    
/*
Here are the highlights of the most common skills for the top 10 highest-paying data analyst roles in the U.S. in 2023:
    SQL: 6 mentions
    Python: 5 mentions
    Tableau: 4 mentions
    R: 3 mentions
    SAS: 2 mentions
    Excel, MS Access, Flow, SharePoint, Snowflake, Spark, MATLAB, Pandas, and Looker: 1 mention each

[
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "165000.0",
    "job_country": "United States",
    "skills": "python",
    "type": "programming"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "165000.0",
    "job_country": "United States",
    "skills": "sql",
    "type": "programming"
  },
  {
    "job_id": 1413561,
    "job_title": "Data Analyst",
    "company_name": "Autodesk, Inc.",
    "salary_year_avg": "165000.0",
    "job_country": "United States",
    "skills": "snowflake",
    "type": "cloud"
  },
  {
    "job_id": 1413561,
    "job_title": "Data Analyst",
    "company_name": "Autodesk, Inc.",
    "salary_year_avg": "165000.0",
    "job_country": "United States",
    "skills": "r",
    "type": "programming"
  },
  {
    "job_id": 1413561,
    "job_title": "Data Analyst",
    "company_name": "Autodesk, Inc.",
    "salary_year_avg": "165000.0",
    "job_country": "United States",
    "skills": "python",
    "type": "programming"
  },
  {
    "job_id": 1413561,
    "job_title": "Data Analyst",
    "company_name": "Autodesk, Inc.",
    "salary_year_avg": "165000.0",
    "job_country": "United States",
    "skills": "sql",
    "type": "programming"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "165000.0",
    "job_country": "United States",
    "skills": "sas",
    "type": "analyst_tools"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "165000.0",
    "job_country": "United States",
    "skills": "looker",
    "type": "analyst_tools"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "165000.0",
    "job_country": "United States",
    "skills": "tableau",
    "type": "analyst_tools"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "165000.0",
    "job_country": "United States",
    "skills": "pandas",
    "type": "libraries"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "165000.0",
    "job_country": "United States",
    "skills": "matlab",
    "type": "programming"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "165000.0",
    "job_country": "United States",
    "skills": "sas",
    "type": "programming"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "165000.0",
    "job_country": "United States",
    "skills": "r",
    "type": "programming"
  },
  {
    "job_id": 1413561,
    "job_title": "Data Analyst",
    "company_name": "Autodesk, Inc.",
    "salary_year_avg": "165000.0",
    "job_country": "United States",
    "skills": "spark",
    "type": "libraries"
  },
  {
    "job_id": 913588,
    "job_title": "Data Analyst",
    "company_name": "Noblis",
    "salary_year_avg": "166100.0",
    "job_country": "United States",
    "skills": "sharepoint",
    "type": "analyst_tools"
  },
  {
    "job_id": 913588,
    "job_title": "Data Analyst",
    "company_name": "Noblis",
    "salary_year_avg": "166100.0",
    "job_country": "United States",
    "skills": "tableau",
    "type": "analyst_tools"
  },
  {
    "job_id": 588023,
    "job_title": "Data Analyst",
    "company_name": "Motion Recruitment",
    "salary_year_avg": "170000.0",
    "job_country": "United States",
    "skills": "tableau",
    "type": "analyst_tools"
  },
  {
    "job_id": 588023,
    "job_title": "Data Analyst",
    "company_name": "Motion Recruitment",
    "salary_year_avg": "170000.0",
    "job_country": "United States",
    "skills": "sql",
    "type": "programming"
  },
  {
    "job_id": 1707460,
    "job_title": "Data Analyst",
    "company_name": "Xator Corp",
    "salary_year_avg": "175000.0",
    "job_country": "United States",
    "skills": "tableau",
    "type": "analyst_tools"
  },
  {
    "job_id": 1707460,
    "job_title": "Data Analyst",
    "company_name": "Xator Corp",
    "salary_year_avg": "175000.0",
    "job_country": "United States",
    "skills": "excel",
    "type": "analyst_tools"
  },
  {
    "job_id": 1707460,
    "job_title": "Data Analyst",
    "company_name": "Xator Corp",
    "salary_year_avg": "175000.0",
    "job_country": "United States",
    "skills": "r",
    "type": "programming"
  },
  {
    "job_id": 1707460,
    "job_title": "Data Analyst",
    "company_name": "Xator Corp",
    "salary_year_avg": "175000.0",
    "job_country": "United States",
    "skills": "python",
    "type": "programming"
  },
  {
    "job_id": 136669,
    "job_title": "Data Analyst",
    "company_name": "Centauri",
    "salary_year_avg": "175000.0",
    "job_country": "United States",
    "skills": "flow",
    "type": "other"
  },
  {
    "job_id": 1707460,
    "job_title": "Data Analyst",
    "company_name": "Xator Corp",
    "salary_year_avg": "175000.0",
    "job_country": "United States",
    "skills": "sql",
    "type": "programming"
  },
  {
    "job_id": 1707460,
    "job_title": "Data Analyst",
    "company_name": "Xator Corp",
    "salary_year_avg": "175000.0",
    "job_country": "United States",
    "skills": "ms access",
    "type": "analyst_tools"
  },
  {
    "job_id": 144450,
    "job_title": "Data Analyst",
    "company_name": "Anthropic",
    "salary_year_avg": "240000.0",
    "job_country": "United States",
    "skills": "python",
    "type": "programming"
  },
  {
    "job_id": 144450,
    "job_title": "Data Analyst",
    "company_name": "Anthropic",
    "salary_year_avg": "240000.0",
    "job_country": "United States",
    "skills": "sql",
    "type": "programming"
  },
  {
    "job_id": 1059665,
    "job_title": "Data Analyst",
    "company_name": "Anthropic",
    "salary_year_avg": "350000.0",
    "job_country": "United States",
    "skills": "python",
    "type": "programming"
  },
  {
    "job_id": 1059665,
    "job_title": "Data Analyst",
    "company_name": "Anthropic",
    "salary_year_avg": "350000.0",
    "job_country": "United States",
    "skills": "sql",
    "type": "programming"
  }
]
*/