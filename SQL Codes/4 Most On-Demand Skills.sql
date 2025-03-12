--Most on-demand skills for a Data Analyst


SELECT 
    skills_dim.skills,
    COUNT(most_on_demand_skills.job_id) AS demand_count
FROM 
    job_postings_fact AS most_on_demand_skills
INNER JOIN 
    skills_job_dim ON most_on_demand_skills.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY 
    skills_dim.skills
ORDER BY 
    demand_count DESC
LIMIT 10;
