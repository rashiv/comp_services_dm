-- 
-- QUERY 1: Top 5 pieces of content
-- 
SELECT *, count(DISTINCT pi.Ads_User_Id) AS n_user_views
FROM Content_Metadata AS cm
RIGHT JOIN Page_Impression AS pi ON cm.Content_Id == pi.Content_Id
GROUP BY Content_Id
ORDER BY n_user_views DESC
LIMIT 5;


