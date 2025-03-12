-- Total Data Analyst Jobs
SELECT
    count(job_id) AS total_jobs
FROM
    job_postings_fact 
WHERE
    job_title_short = 'Data Analyst'



-- Average Salary of a Data Analyst
SELECT 
    to_char(round(avg(salary_year_avg), 0), 'FM$999,999,999')
    AS average_salary
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'

-- Total Data Analyst Remote Jobs
SELECT
    count(job_id) AS total_remote_jobs
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    and job_work_from_home = TRUE


---Combine all 3 KPIs
SELECT
    COUNT(job_id) AS total_jobs,
    TO_CHAR(ROUND(AVG(salary_year_avg), 0), 'FM$999,999,999') AS average_salary,
    SUM(CASE WHEN job_work_from_home = TRUE THEN 1 ELSE 0 END) AS total_remote_jobs
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst';
