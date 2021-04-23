# Documentation for QUERY 5: Representation for non-registered users

This query creates a table with the following columns:
* `Ads_User_Id`: Id for each non-registered user
* `unique_content_count`: total number of unique pieces of content viewed by a non-registered user
* `most_viewed_content_type`: most common content type viewed by a non-registered user
* `unique_referrer_url_count`: total number of unique referral urls
* `avg_ad_time`: average time spent on an ad by a non-registered user

## Analytic Value
* This table tracks user activity for non-registered users.
* In conjunction with the QUERY 4 table for registered users, it can be used in A/B testing types of comparative analyses to determine what content types and ad durations are most likely to convert users.

## Performance Considerations
* This query performs multiple JOIN operations with multiple aggregations. 
* While the aggregation to get counts is a necessary and slow operation, some of the JOINs can be optimized by making them hash joins, since the `Registered_Users` and `OAuth_Id_Service` tables are 4 orders of magnitude smaller (60-80 M records) than the `Page_Impression` and `Ad_Service_Interaction_Data` tables.


## Scheduling
* These don't need to be scheduled in real-time, as A/B testing is usually planned over multiple days/ events. 