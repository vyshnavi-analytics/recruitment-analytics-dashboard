SELECT
    job_role,
    AVG(DATEDIFF(day, job_open_date, hire_date)) AS avg_time_to_hire
FROM recruitment_data
WHERE hire_date IS NOT NULL
GROUP BY job_role
ORDER BY avg_time_to_hire;
