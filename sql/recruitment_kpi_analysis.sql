-- Recruitment Analytics KPI Analysis

-- Total candidates
SELECT COUNT(*) AS total_candidates
FROM recruitment;

-- Status-wise candidate distribution
SELECT status, COUNT(*) AS candidate_count
FROM recruitment
GROUP BY status;

-- Department-wise hiring funnel
SELECT department,
       COUNT(*) AS applied,
       COUNT(interview_date) AS interviewed,
       COUNT(offer_date) AS offered,
       COUNT(joining_date) AS joined
FROM recruitment
GROUP BY department;

-- Time-to-Hire (days)
SELECT
    candidate_id,
    department,
    recruiter,
    joining_date - application_date AS time_to_hire_days
FROM recruitment
WHERE joining_date IS NOT NULL;

-- Average Time-to-Hire by recruiter
SELECT
    recruiter,
    AVG(joining_date - application_date) AS avg_time_to_hire
FROM recruitment
WHERE joining_date IS NOT NULL
GROUP BY recruiter;

-- Offer Acceptance Rate
SELECT
    COUNT(CASE WHEN joining_date IS NOT NULL THEN 1 END) * 100.0
    / COUNT(CASE WHEN offer_date IS NOT NULL THEN 1 END)
    AS offer_acceptance_rate
FROM recruitment;

-- Recruitment funnel analysis
SELECT
    department,
    COUNT(*) AS applied,
    COUNT(interview_date) AS interviewed,
    COUNT(offer_date) AS offered,
    COUNT(joining_date) AS joined
FROM recruitment
GROUP BY department;

-- Aging candidates still in process
SELECT
    candidate_id,
    recruiter,
    department,
    CURRENT_DATE - application_date AS aging_days
FROM recruitment
WHERE status = 'In process'
ORDER BY aging_days DESC;

-- Average cost per hire by department
SELECT
    department,
    AVG(cost_per_hire) AS avg_cost_per_hire
FROM recruitment
GROUP BY department;

-- Recruiter with most successful hires
SELECT
    recruiter,
    COUNT(*) AS successful_hires
FROM recruitment
WHERE joining_date IS NOT NULL
GROUP BY recruiter
ORDER BY successful_hires DESC;
