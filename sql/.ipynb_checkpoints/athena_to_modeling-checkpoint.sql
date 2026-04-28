-- Athena query for model data generation (motivated by stakeholder question 2)

-- Goal:
-- Predict how long a complaint will take to be resolved (in days)

-- Features:
-- agency: agency handling the complaint
-- borough: NYC borough
-- problem: complaint type
-- incident_zip: location of complaint
-- day_of_week: day complaint was created
-- hour_of_day: hour complaint was created
-- same_day_complaint_volume: number of similar complaints on same day

-- Target:
-- days_to_close: number of days between created_date and closed_date

CREATE TABLE nyc311_db.resolution_time_modeling AS
SELECT
    agency,
    borough,
    problem,
    incident_zip,
    day_of_week(date_parse(created_date, '%Y-%m-%d %H:%i:%s')) AS day_of_week,
    hour(date_parse(created_date, '%Y-%m-%d %H:%i:%s')) AS hour_of_day,
    COUNT(*) OVER (
        PARTITION BY agency, problem,
        DATE(date_parse(created_date, '%Y-%m-%d %H:%i:%s'))
    ) AS same_day_complaint_volume,
    date_diff('day',
        date_parse(created_date, '%Y-%m-%d %H:%i:%s'),
        date_parse(closed_date, '%Y-%m-%d %H:%i:%s')
    ) AS days_to_close
FROM nyc311_db.complaints
WHERE closed_date <> ''
  AND borough IN ('BROOKLYN','QUEENS','BRONX','MANHATTAN','STATEN ISLAND')
  AND date_diff('day',
        date_parse(created_date, '%Y-%m-%d %H:%i:%s'),
        date_parse(closed_date, '%Y-%m-%d %H:%i:%s')
    ) BETWEEN 0 AND 365;
