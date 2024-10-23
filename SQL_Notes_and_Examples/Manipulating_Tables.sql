Create Table data_science_jobs (
    job_id int Primary Key,
    job_title text,
    company_name text,
    post_date date
);
-- ^^ Created the table for data science job 

INSERT INTO data_science_jobs (job_id, job_title, company_name, post_date)
    VAlUES
    (1, 'Data Scientist', 'Tech Innovations', 'January 1, 2023'),
    (2, 'Machine Learning Engineer', 'Data Driven Co', 'January 15, 2023'),
    (3, 'AI Specialist', 'Future Tech', 'February 1, 2023')
    ;
SELECT *
FRom data_science_jobs;
-- Added in 3 rows of data, pulled all columns from table to visualize

ALTER TABLE data_science_jobs
ADD Column remote Boolean;
SELECT *
FRom data_science_jobs;
-- Added a new colum  called remote, with a data type of Boolean

ALTER TABLE data_science_jobs
RENAME COLUMN post_date to posted_on;
Select *
FROM data_science_jobs;
-- Renamed column post_date to be named posted_on

ALTER TABLE data_science_jobs
ALTER Column remote SET DEFAULT FALSE;
INSERT INTO data_science_jobs (job_id, job_title, company_name, posted_on)
VALUES
(4, 'Data Scientist', 'Google', '2023-02-05');
Select *
FROM data_science_jobs;
-- Made it so that for any new rows of data that got inputed would 
-- default to false in the remote column

DROP TABLE data_science_jobs;
-- data_science_jobs will no longer exist as a table
