SELECT
  agency,
  AVG(days_open) AS avg_days_to_close
FROM (
  SELECT
    agency,
    date_diff(
      'day',
      date_parse(created_date, '%Y-%m-%d %H:%i:%s'),
      date_parse(closed_date, '%Y-%m-%d %H:%i:%s')
    ) AS days_open
  FROM nyc311_db.complaints
  WHERE closed_date IS NOT NULL
    AND closed_date <> ''
) t
GROUP BY agency
ORDER BY avg_days_to_close DESC;