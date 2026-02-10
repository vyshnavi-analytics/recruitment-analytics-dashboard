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
