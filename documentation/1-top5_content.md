# Documentation for QUERY 1: Top 5 pieces of content

This query creates a table with the following columns:
* All columns from `Content_Metadata`, describing the content
* `n_user_views`: Number of distinct users who viewed the content  

## Analytic Value
* This table can be used to determine which pieces of content are most popular with users. 
* The less popular article Ids can then be inserted into the `Related_Media` array to get more viewers for them
* The most popular content pieces could also be used to determine the real estate value for the displayed ads

## Performance Considerations
* This query performs a JOIN and an aggregation on the `Page_Impression` table (100 B records). 
* While the aggregation to get counts is a necessary and slow operation, the JOIN can be optimized by making it a hash join, since the `Content_Metadata` table is 4 orders of magnitude smaller (10 M records) than the `Page_Impression` table

## Scheduling
This can be scheduled multiple times a day for faster time-to-value for latest content.
