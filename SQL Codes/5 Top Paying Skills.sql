-- Top Data Analyst skills based on salary

SELECT
    skills_dim.skills,
    TO_CHAR(AVG(top_paying_skills.salary_year_avg), 'FM$999,999,999') AS average_salary
FROM 
    job_postings_fact AS top_paying_skills
INNER JOIN 
    skills_job_dim ON top_paying_skills.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND top_paying_skills.salary_year_avg IS NOT NULL
GROUP BY 
    skills_dim.skills
ORDER BY
    AVG(top_paying_skills.salary_year_avg) DESC 
LIMIT 25;


