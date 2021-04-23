--
-- QUERY 5: Representation for non-registered users
--
WITH temp_top_content AS 
    -- temp table storing top content type for each user:
    (SELECT pi_temp.Ads_User_Id AS Ads_User_Id, Content_Type, ROW_NUMBER() OVER (PARTITION BY Ads_User_Id ORDER BY COUNT(Content_Type) DESC) AS rn
    FROM Page_Impression AS pi_temp
    LEFT JOIN Content_Metadata AS cm ON pi_temp.Content_Id == cm.Content_Id
    GROUP BY pi_temp.Ads_User_Id, Content_Type
    HAVING rn == 1),
SELECT 
    Ads_User_Id, 
    count(DISTINCT Content_Id) AS unique_content_count, 
    ttc.Content_Type AS most_viewed_content_type, 
    count(DISTINCT Referrer_URL) AS unique_referrer_url_count,
    SUM(asid.Dwell_Time)/COUNT(asid.Ad_Id) AS avg_ad_time 
FROM Page_Impression AS pi
LEFT JOIN temp_top_content AS ttc ON pi.Ads_User_Id == ttc.Ads_User_Id
LEFT JOIN Ad_Service_Interaction_Data AS asid ON pi.Ads_User_Id == asid.Ads_User_Id
LEFT JOIN OAuth_Id_Service AS ois ON ois.Ads_User_Id == pi.Ads_User_Id
LEFT JOIN Registered_Users AS ru.Ads_User_Id == pi.Ads_User_Id
GROUP BY Ads_User_Id
-- isolating for non-registered users only, with an anti join
HAVING ru.Ads_User_Id == NULL;
-- NOTE: This captures 1) the number of unique contents viewed by a user BEFORE becoming registered, 
-- 2) the most common content type for that user,
-- 3) how many of those were referred from other URLs
-- 4) how much time on average the user spent 
