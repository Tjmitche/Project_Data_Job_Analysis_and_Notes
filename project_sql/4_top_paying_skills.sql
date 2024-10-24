/*
Question: What are the top 25 skills based on salary?
    - Look at the average salary associated with each skill for Data Analyst positions.
    - Focuses on roles with specified salaries, located in the U.S.
    - Why? It reveals how different skills impact salary levels for Data Analysts
        and helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT
    skills,
    type,
    ROUND(AVG(salary_year_avg),2) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg IS NOT NULL
    AND job_country = 'United States'
    AND job_title = 'Data Analyst'
GROUP BY
    skills,
    type
ORDER BY
    avg_salary DESC
LIMIT 25;


/*
Here is a breakdown for the top paying skills for data analysts in the U.S.

Programming Languages:
    Golang stands out as a high-paying programming skill, with an average salary of $145,000, making it one of the top skills for data analysts.
    Other notable languages include MongoDB and Swift, though they offer lower average salaries compared to Golang.

Databases:
    Redis ($128,500), Elasticsearch ($124,500), and DynamoDB ($115,000) are among the highest-paying database skills, which reflects the increasing demand for NoSQL and real-time data handling.
    MongoDB appears twice with an average salary of around $103,369, categorized both under programming and databases, emphasizing its versatile usage in both development and data analysis.

Machine Learning Libraries:
    Skills in PyTorch and TensorFlow both command the same high salary of $112,500, demonstrating the demand for deep learning frameworks.
    Scikit-learn and Keras also offer competitive salaries, highlighting the importance of machine learning proficiency in the data analyst space.

Cloud Technologies:
    GCP (Google Cloud Platform) and IBM Cloud are the top-paying cloud skills, each averaging over $104,000.
    BigQuery is another well-paying cloud skill, with an average salary close to $100,000, reflecting its importance in data warehousing and analytics.

Data Engineering Tools:
    Tools like Airflow ($104,145.31) and Kafka ($103,375) appear among the top earners, emphasizing the importance of data pipeline management and real-time data processing.

Data Analyst Tools:
    SSIS (SQL Server Integration Services) and Qlik are high-paying tools in the data analyst toolkit, with salaries around $105,000 and $104,000, respectively.
    These tools highlight the focus on data integration and visualization within the top-paying roles.

Other Notable Skills:
    Bitbucket ($111,175) and Puppet ($100,000) fall into the "other" category, but still command impressive salaries, reflecting the value of version control and automation in data workflows.


[
  {
    "skills": "golang",
    "type": "programming",
    "avg_salary": "145000.00"
  },
  {
    "skills": "redis",
    "type": "databases",
    "avg_salary": "128500.00"
  },
  {
    "skills": "elasticsearch",
    "type": "databases",
    "avg_salary": "124500.00"
  },
  {
    "skills": "dynamodb",
    "type": "databases",
    "avg_salary": "115000.00"
  },
  {
    "skills": "pytorch",
    "type": "libraries",
    "avg_salary": "112500.00"
  },
  {
    "skills": "tensorflow",
    "type": "libraries",
    "avg_salary": "112500.00"
  },
  {
    "skills": "bitbucket",
    "type": "other",
    "avg_salary": "111175.00"
  },
  {
    "skills": "scikit-learn",
    "type": "libraries",
    "avg_salary": "109794.64"
  },
  {
    "skills": "jupyter",
    "type": "libraries",
    "avg_salary": "108790.00"
  },
  {
    "skills": "ssis",
    "type": "analyst_tools",
    "avg_salary": "105099.13"
  },
  {
    "skills": "mongo",
    "type": "programming",
    "avg_salary": "104625.00"
  },
  {
    "skills": "gcp",
    "type": "cloud",
    "avg_salary": "104394.79"
  },
  {
    "skills": "airflow",
    "type": "libraries",
    "avg_salary": "104145.31"
  },
  {
    "skills": "ibm cloud",
    "type": "cloud",
    "avg_salary": "104083.33"
  },
  {
    "skills": "qlik",
    "type": "analyst_tools",
    "avg_salary": "104074.20"
  },
  {
    "skills": "kafka",
    "type": "libraries",
    "avg_salary": "103375.00"
  },
  {
    "skills": "mongodb",
    "type": "databases",
    "avg_salary": "103369.86"
  },
  {
    "skills": "mongodb",
    "type": "programming",
    "avg_salary": "103369.86"
  },
  {
    "skills": "nosql",
    "type": "programming",
    "avg_salary": "100633.67"
  },
  {
    "skills": "bigquery",
    "type": "cloud",
    "avg_salary": "100293.18"
  },
  {
    "skills": "swift",
    "type": "programming",
    "avg_salary": "100250.00"
  },
  {
    "skills": "keras",
    "type": "libraries",
    "avg_salary": "100000.00"
  },
  {
    "skills": "puppet",
    "type": "other",
    "avg_salary": "100000.00"
  },
  {
    "skills": "mxnet",
    "type": "libraries",
    "avg_salary": "100000.00"
  },
  {
    "skills": "chainer",
    "type": "libraries",
    "avg_salary": "100000.00"
  }
]
*/
