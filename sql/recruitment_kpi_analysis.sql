-- Recruitment Analytics KPI Analysis

-- Total Candidates
SELECT COUNT(*) AS total_candidates
FROM recruitment;

-- Status-wise Candidate Distribution
SELECT 
    status, 
    COUNT(*) AS candidate_count
FROM recruitment
GROUP BY status
ORDER BY candidate_count DESC;

-- Department-wise Recruitment Funnel
SELECT
    department,
    COUNT(*) AS applied,
    COUNT(interview_date) AS interviewed,
    COUNT(offer_date) AS offered,
    COUNT(joining_date) AS joined
FROM recruitment
GROUP BY department
ORDER BY applied DESC;

-- Time-to-Hire (Individual Level)
SELECT
    candidate_id,
    department,
    recruiter,
    DATEDIFF(joining_date, application_date) AS time_to_hire_days
FROM recruitment
WHERE joining_date IS NOT NULL
ORDER BY time_to_hire_days DESC;

-- Average Time-to-Hire by Recruiter
SELECT
    recruiter,
    ROUND(AVG(DATEDIFF(joining_date, application_date)), 2) AS avg_time_to_hire
FROM recruitment
WHERE joining_date IS NOT NULL
GROUP BY recruiter
ORDER BY avg_time_to_hire;

-- Recruiter-wise Conversion Rate
SELECT
    recruiter,
    COUNT(*) AS total_applications,
    SUM(CASE WHEN joining_date IS NOT NULL THEN 1 ELSE 0 END) AS total_hires,
    ROUND(
        SUM(CASE WHEN joining_date IS NOT NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
    2) AS conversion_rate_percent
FROM recruitment
GROUP BY recruiter
ORDER BY conversion_rate_percent DESC;

-- Offer Acceptance Rate
SELECT
    ROUND(
        COUNT(CASE WHEN joining_date IS NOT NULL THEN 1 END) * 100.0
        / NULLIF(COUNT(CASE WHEN offer_date IS NOT NULL THEN 1 END), 0),
    2) AS offer_acceptance_rate_percent
FROM recruitment;

-- Aging Candidates (Still In Process)
SELECT
    candidate_id,
    recruiter,
    department,
    DATEDIFF(CURRENT_DATE, application_date) AS aging_days
FROM recruitment
WHERE status = 'In process'
ORDER BY aging_days DESC;

-- Average Cost per Hire by Department
SELECT
    department,
    ROUND(AVG(cost_per_hire), 2) AS avg_cost_per_hire
FROM recruitment
WHERE joining_date IS NOT NULL
GROUP BY department
ORDER BY avg_cost_per_hire DESC;

-- Recruiter with Most Successful Hires
SELECT
    recruiter,
    COUNT(*) AS successful_hires
FROM recruitment
WHERE joining_date IS NOT NULL
GROUP BY recruiter
ORDER BY successful_hires DESC;
