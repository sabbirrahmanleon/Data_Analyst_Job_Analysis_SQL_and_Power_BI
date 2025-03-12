--Most optimal skills to learn for a Data Analyst
WITH skills_demand AS
(
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM 
        job_postings_fact AS most_on_demand_skills
    INNER JOIN 
        skills_job_dim ON most_on_demand_skills.job_id = skills_job_dim.job_id
    INNER JOIN 
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY 
        skills_dim.skill_id, skills_dim.skills
    ORDER BY 
        demand_count DESC
),
average_salary AS
(
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(salary_year_avg), 0) AS average_salary_numeric,
        TO_CHAR(ROUND(AVG(salary_year_avg), 0), 'FM$999,999,999') AS average_salary
    FROM 
        job_postings_fact AS top_paying_skills
    INNER JOIN 
        skills_job_dim ON top_paying_skills.job_id = skills_job_dim.job_id
    INNER JOIN 
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY 
        skills_dim.skill_id, skills_dim.skills
    ORDER BY
        average_salary DESC
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    average_salary.average_salary
FROM
    skills_demand
INNER JOIN 
    average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE 
    demand_count > 10
order by 
    average_salary DESC,
    demand_count DESC
LIMIT 25











