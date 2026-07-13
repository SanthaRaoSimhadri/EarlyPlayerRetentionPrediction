-- SECTION 1 : TABLE OVERVIEW

Total rows - 113004
Total columns - 4
Preview Data - 
    It has the pid (Unique id) to connect with the other tables
    EventName is the other column and it seems to have only one value it seems. 
    Time
    Time_utc

-- SECTION 2 : SCHEMA UNDERSTANDING

pid - It's the unique id and which can be used to connect the different tables. So it's a primary key
EventName - It is mentioned as character varying means it might have multiple values.
Time & Time_Utc are timestamps.

-- SECTION 3 : DATA QUALITY

There are no missing pids.
There are no missing EventNames too.
There are no missing Time & Time_Utc both. 

Best quality with the table is no missing values.

-- SECTION 4 : DUPLICATE ANALYSIS

These are the values for total_rows and unique pids 113004,11080 and this is obvious as we already knew that there can be more than one time player should have logged in based on the demographics table.

And there are no duplicate events as each player has one event at the particular time.

I checked and there is only one unique value for the EventName. Checked with the below sql statement.
SELECT
    COUNT(*) total_rows,
    COUNT(DISTINCT "EventName") unique_event_names
FROM player_logged_in;

-- SECTION 5 : TIMELINE UNDERSTANDING

It has the same values as demographics for first_login and last_login which are respectively 2022-08-18 05:32:03, 2023-03-31 13:57:34

-- SECTION 6 : LOGIN EVENTS PER PLAYER

I could see the values are spread across 1 to 274. Yet to deep dive into the number of players for the different regions and eventually we will dig more into the other tables to understand which players are having good login journeys through other tables to understand how many jobs are finished as such.

-- SECTION 7 : LOGIN DISTRIBUTION

These are the min,max and average values for login counts 1, 274, 10.1989169675090253. I could sense that There are values from 1 to 274 distributed though what I would like to observe more is that whether there are more than one cluster and one cluster is towards the values near 1 which is dominated it seems and the other cluster is of the players with higher login count. Basically it is more about increasing the player count.

-- SECTION 8 : RETURNING PLAYERS

Single Login	2832
Returned	8248

This is something I have not expected. Approximately 25.6% of players recorded only a single login event during the observation period. It should be there in the focus now to understand how far the players are reaching who are logged in only once. Players who do not return after their first login may have discontinued playing for a variety of reasons. Further investigation of gameplay progression, task completion, and session behaviour is required before drawing conclusions regarding the underlying causes.

-- SECTION 9 : DAILY LOGIN VOLUME

Daily login seems to have the declining nature. 
2022-08-18	1727
2022-08-19	2726
2022-08-20	2645
2022-08-21	2634
2022-08-22	2457
2022-08-23	2185
2022-08-24	1920
2022-08-25	1861
2022-08-26	1745
2022-08-27	1886
2022-08-28	1820
2022-08-29	1600
2022-08-30	1549
2022-08-31	1452
2022-09-01	1328
2022-09-02	1350
2022-09-03	1453
2022-09-04	1525
2022-09-05	1512
2022-09-06	1268
2022-09-07	1230
2022-09-08	1264
2022-09-09	1156
2022-09-10	1247
2022-09-11	1254
2022-09-12	1089
2022-09-13	1054
2022-09-14	954
2022-09-15	901
2022-09-16	839

But I am not sure about this as it doesn't tell about the old or new users login. We may need to derive it in a way by deducting the players who launched for the first time as we don't know exactly the player acquisition here as it could be different on different days.


Research Observations

1. Does every player return after the first login? No. 

2. What percentage of players login only once? ~25%

3. Is there a long-tail distribution of login frequency? The distribution of login frequency should be visualized before concluding whether it exhibits a long-tail or heavy-tailed distribution.

4. Can login frequency become a feature? Yes as it tells us the returning of the user

5. Can return interval define Early Retention? Yes, It would become a major metric too.

6. Does the observation window introduce right-censoring? yes

7. Are login events uniformly distributed over time? Keeps declining.