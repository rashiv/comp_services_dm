-- 
-- QUERY 2: Aggregations across a rolling 30, 60, 90 days
--
WITH  pi_per_day AS 
    -- temp table storing count of distinct users per day:
    (SELECT DATE(FROM_UNIXTIME(Timestamp)) AS pi_date, COUNT(DISTINCT Ads_User_Id) AS users_per_day
    FROM Page_Impression
    GROUP BY DATE(FROM_UNIXTIME(Timestamp))
    ORDER BY pi_date)
SELECT pi_date, users_per_day, AVG(users_per_day) 
OVER (ORDER BY pi_date ROWS BETWEEN 30 PRECEDING AND CURRENT ROW) AS avg,
-- Replace 30 by 60 or 90 to get rolling averages for those durations
FROM pi_per_day
ORDER BY 1 DESC;

