-- total complaints
SELECT COUNT(*) AS n_complaints
FROM nyc311_db.complaints;

-- first and last dates
SELECT 
  MIN(created_date) AS earliest,
  MAX(created_date) AS latest
FROM nyc311_db.complaints;

-- top 10 agencies by complaints
SELECT agency, COUNT(*) AS n
FROM nyc311_db.complaints
GROUP BY agency
ORDER BY n DESC
LIMIT 10;

-- top 20 borough + problem pairs
SELECT borough, problem, COUNT(*) AS n
FROM nyc311_db.complaints
GROUP BY borough, problem
ORDER BY n DESC
LIMIT 20;

-- complaints by agency with names
SELECT 
  c.agency,
  a.agency_name,
  COUNT(*) AS n
FROM nyc311_db.complaints c
JOIN nyc311_db.agencies a
  ON c.agency = a.agency
GROUP BY c.agency, a.agency_name
ORDER BY n DESC;