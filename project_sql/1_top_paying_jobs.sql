/*
Question: What are the top-paying data analyst jobs?
    - Identify the top 10 highest-paying Data Analyst roles that are available in the U.S.
    - Focuses on job postings with specified salaries.
    - Why? Aims to highlight the top-paying opportunities for Data Analysts,
         offering insights into employment options and location.
*/
SELECT
    job_id,
    job_title,
    name AS company_name,
    job_schedule_type,
    salary_year_avg,
    job_work_from_home AS romote_working_status,
    job_country,
    job_location,
    job_posted_date::Date
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
LIMIT 10;


/*
[
  {
    "job_id": 1059665,
    "job_title": "Data Analyst",
    "company_name": "Anthropic",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "350000.0",
    "romote_working_status": false,
    "job_country": "United States",
    "job_location": "San Francisco, CA",
    "job_posted_date": "2023-06-22"
  },
  {
    "job_id": 144450,
    "job_title": "Data Analyst",
    "company_name": "Anthropic",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "240000.0",
    "romote_working_status": false,
    "job_country": "United States",
    "job_location": "San Francisco, CA",
    "job_posted_date": "2023-06-21"
  },
  {
    "job_id": 1254565,
    "job_title": "Data Analyst",
    "company_name": "GovCIO",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "225000.0",
    "romote_working_status": false,
    "job_country": "United States",
    "job_location": "Fairfax, VA",
    "job_posted_date": "2023-02-23"
  },
  {
    "job_id": 136669,
    "job_title": "Data Analyst",
    "company_name": "Centauri",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "175000.0",
    "romote_working_status": false,
    "job_country": "United States",
    "job_location": "Orange Park, FL",
    "job_posted_date": "2023-06-02"
  },
  {
    "job_id": 1707460,
    "job_title": "Data Analyst",
    "company_name": "Xator Corp",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "175000.0",
    "romote_working_status": false,
    "job_country": "United States",
    "job_location": "Bethesda, MD",
    "job_posted_date": "2023-01-16"
  },
  {
    "job_id": 1699984,
    "job_title": "Data Analyst",
    "company_name": "Meta",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "175000.0",
    "romote_working_status": false,
    "job_country": "United States",
    "job_location": "New York, NY",
    "job_posted_date": "2023-06-28"
  },
  {
    "job_id": 588023,
    "job_title": "Data Analyst",
    "company_name": "Motion Recruitment",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "170000.0",
    "romote_working_status": false,
    "job_country": "United States",
    "job_location": "Washington, DC",
    "job_posted_date": "2023-05-12"
  },
  {
    "job_id": 913588,
    "job_title": "Data Analyst",
    "company_name": "Noblis",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "166100.0",
    "romote_working_status": false,
    "job_country": "United States",
    "job_location": "Chantilly, VA",
    "job_posted_date": "2023-03-02"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "165000.0",
    "romote_working_status": true,
    "job_country": "United States",
    "job_location": "Anywhere",
    "job_posted_date": "2023-08-14"
  },
  {
    "job_id": 1413561,
    "job_title": "Data Analyst",
    "company_name": "Autodesk, Inc.",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "165000.0",
    "romote_working_status": false,
    "job_country": "United States",
    "job_location": "San Francisco, CA",
    "job_posted_date": "2023-12-07"
  }
]
*/