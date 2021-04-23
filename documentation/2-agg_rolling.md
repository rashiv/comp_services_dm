# Documentation for QUERY 2: Aggregations across a rolling 30, 60, 90 days

This query creates a table with the following columns:
* `pi_date`: Date corresponding to each day of recorded activity
* `users_per_day`: number of active users viewing content for each recorded day
* `avg`: rolling 30 day average of number of active users for each recorded day

## Analytic Value
* This table can be used to observe user activity trends
* Rolling averages make reading trends easier, and smoothe over any anomalies or seasonal spikes
* The number 30 can be replaced by any value N, to get the rolling average for N days

## Performance Considerations
* This query contains a WINDOW functionn on the `Page_Impression` table (100 B records).
* It is slow, but still a lot more efficient than creating sub queries for every N day window explicitly.

## Scheduling
Since this query is observing daily trends, it can be scheduled to run at the beginning of every day.
