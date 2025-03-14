-- skills required for the top-paying jobs

WITH top_paying_jobs AS (
    SELECT	
        job_postings_fact.job_id,
        job_title,
        salary_year_avg,
        company_dim.name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim 
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.job_id,
    top_paying_jobs.job_title,
    TO_CHAR(top_paying_jobs.salary_year_avg, 'FM$999,999,999') AS salary,  
    top_paying_jobs.company_name,
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim 
    ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    top_paying_jobs.salary_year_avg DESC;
