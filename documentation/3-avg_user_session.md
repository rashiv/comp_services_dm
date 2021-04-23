# Documentation for QUERY 3: Average user session duration trends

This query creates a table with the following columns:
* `time_bin_floor`: lower bin value for average dwell time of a user on an ad per session (binsize = 5s)
* `count`: number of active users viewing content for each recorded day

## Analytic Value
* This table yields a histogram of average dwell time of a user on an ad per session, with binsize = 5s
* It can be used to determine which ads generate the most revenue

## Performance Considerations
* This query performs a JOIN and an aggregation on the `Ad_Service_Interaction_Data` table (150 B records). 
* The aggregation to get counts is a slow operation, especially since the JOIN  is with the `Page_Impression` table (100 B records). 
* It can be further optimized by increasing the bin size, which is effectively the grouping key.

## Scheduling
* This can be scheduled multiple times a day for revenue analysis on the displayed Ads. 
* Alternatively, it can also be scheduled with the cadence of Ad refreshes.
