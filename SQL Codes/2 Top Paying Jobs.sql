-- Top 10 highest-paying jobs

WITH distinct_jobs AS (
  SELECT DISTINCT ON (job_title_short)
      job_id,
      job_title,
      job_title_short,
      company_dim.name AS company_name,
      job_location,
      job_schedule_type,
      salary_year_avg,
      job_posted_date::DATE AS job_posted_date
  FROM job_postings_fact AS top_paying_jobs
  LEFT JOIN company_dim ON top_paying_jobs.company_id = company_dim.company_id
  WHERE salary_year_avg IS NOT NULL
  ORDER BY job_title_short, salary_year_avg DESC
)
SELECT
    job_id,
    job_title,
    job_title_short,
    company_name,
    job_location,
    job_schedule_type,
    TO_CHAR(ROUND(salary_year_avg, 0), 'FM$999,999,999') AS salary,
    job_posted_date
FROM distinct_jobs
ORDER BY salary_year_avg DESC
LIMIT 10;
