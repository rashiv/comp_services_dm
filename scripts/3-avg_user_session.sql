--
-- QUERY 3: Average user session duration trends
--
WITH temp_user_sesion AS 
    -- temp table storing average dwell time for one user in one session:
    (SELECT Ads_User_Id, Session_Id, SUM(asid.Dwell_Time)/COUNT(asid.Ad_Id) AS avg_time 
    FROM Page_Impression AS pi
    LEFT JOIN Ad_Service_Interaction_Data AS asid ON pi.Ads_User_Id == asid.Ads_User_Id
    GROUP BY Ads_User_Id, Session_Id)
SELECT
floor(avg_time/5.00)*5 as time_bin_floor,
COUNT(*) as count
FROM temp_user_sesion
GROUP BY 1
ORDER BY 1;
-- NOTE: This yields a histogram of average dwell time of a user on an ad per session, with binsize = 5s


