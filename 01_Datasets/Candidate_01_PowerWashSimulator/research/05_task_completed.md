-- TABLE OVERVIEW
Total rows - 212818
Total columns - 13

Example row 
p1	task_completed	2022-08-18 18:38:58	2022-08-18 23:38:58	Standing	EXTENSION_BRANDA_LIGHT_STUBBY_NAME	Career	NOZZLE_BRANDA_LIGHT_25DEGREE_NAME	(-0.14, 2.14, 0.28)	POWERWASHER_BRANDA_LIGHT_NAME	WASH_PWVan.WASH_PWVan.PowerWashVan	WASH_PWVan	1

-- SCHEMA

1	pid	character varying
2	EventName	character varying
3	Time	timestamp without time zone
4	Time_utc	timestamp without time zone
5	CrouchState	character varying
6	CurrentExtension	character varying
7	CurrentGameMode	character varying
8	CurrentNozzle	character varying
9	CurrentPosition	character varying
10	CurrentWasher	character varying
11	LastSubtaskCompleted	character varying
12	LastTaskCompleted	character varying
13	LevelProgressionAmount	double precision

pid is there which is a saviour
It has the LastTaskCompleted and LastSubtaskCompleted both with the LevelProgressionAmount which seems to be a good combination to understand the actual player progress.

-- DATA QUALITY
No missing pid's.
No missing LastTaskCompleted which means either the value is being assigned when the task is in progress or there is no player without finishing at least one task. We will deep dive here if required.
No missing LastSubtaskCompleted which is expected after looking at LastTaskCompleted not having any missing entries.
No missing CurrentGameMode
LevelProgressionAmount doesn't have null as it starts with 0 as default
No missing Time stamps.

-- DUPLICATE ANALYSIS
Total rows and unique pids are 212818,10107 which is expected as same pid can have multiple rows during their journeys.
Seeing many duplicates for a particular pid with the specific timestamp. Some of them are below.
p10914	2023-02-01 04:07:01	3
p3260	2022-09-03 14:19:04	150
p3260	2022-09-03 13:36:45	27
p3260	2022-09-03 14:19:03	3
p10891	2022-09-11 22:09:35	2

Like above there are some instances p3260 having the duplicate instances with some timestamps around 150, 27 etc., I'm adding some rows which have time duplicates with the player id p3260 here.

p3260	task_completed	2022-09-03 13:36:44	2022-09-03 11:36:44	Standing	EXTENSION_BRANDA_HEAVY_LONG_NAME	Career	NOZZLE_BRANDA_HEAVY_15DEGREE_NAME	(18.20, 0.00, -30.42)	POWERWASHER_BRANDA_HEAVY_NAME	WASH_FireHelicopter.WASH_FireHelicopter.Tyre_2	WASH_FireHelicopter	1
p3260	task_completed	2022-09-03 13:36:44	2022-09-03 11:36:44	Standing	EXTENSION_BRANDA_HEAVY_LONG_NAME	Career	NOZZLE_BRANDA_HEAVY_15DEGREE_NAME	(18.20, 0.00, -30.42)	POWERWASHER_BRANDA_HEAVY_NAME	WASH_FireHelicopter.WASH_FireHelicopter.SnorkelConnector_1	WASH_FireHelicopter	1
p3260	task_completed	2022-09-03 13:36:44	2022-09-03 11:36:44	Standing	EXTENSION_BRANDA_HEAVY_LONG_NAME	Career	NOZZLE_BRANDA_HEAVY_15DEGREE_NAME	(18.20, 0.00, -30.42)	POWERWASHER_BRANDA_HEAVY_NAME	WASH_FireHelicopter.WASH_FireHelicopter.SnorkelConnector_0	WASH_FireHelicopter	1
p3260	task_completed	2022-09-03 13:36:44	2022-09-03 11:36:44	Standing	EXTENSION_BRANDA_HEAVY_LONG_NAME	Career	NOZZLE_BRANDA_HEAVY_15DEGREE_NAME	(18.20, 0.00, -30.42)	POWERWASHER_BRANDA_HEAVY_NAME	WASH_FireHelicopter.WASH_FireHelicopter.Window_0	WASH_FireHelicopter	1
p3260	task_completed	2022-09-03 13:36:44	2022-09-03 11:36:44	Standing	EXTENSION_BRANDA_HEAVY_LONG_NAME	Career	NOZZLE_BRANDA_HEAVY_15DEGREE_NAME	(18.20, 0.00, -30.42)	POWERWASHER_BRANDA_HEAVY_NAME	WASH_FireHelicopter.WASH_FireHelicopter.Window_1	WASH_FireHelicopter	1
p3260	task_completed	2022-09-03 13:36:44	2022-09-03 11:36:44	Standing	EXTENSION_BRANDA_HEAVY_LONG_NAME	Career	NOZZLE_BRANDA_HEAVY_15DEGREE_NAME	(18.20, 0.00, -30.42)	POWERWASHER_BRANDA_HEAVY_NAME	WASH_FireHelicopter.WASH_FireHelicopter.Window_4	WASH_FireHelicopter	1
p3260	task_completed	2022-09-03 13:36:44	2022-09-03 11:36:44	Standing	EXTENSION_BRANDA_HEAVY_LONG_NAME	Career	NOZZLE_BRANDA_HEAVY_15DEGREE_NAME	(18.20, 0.00, -30.42)	POWERWASHER_BRANDA_HEAVY_NAME	WASH_FireHelicopter.WASH_FireHelicopter.Window_3	WASH_FireHelicopter	1
p3260	task_completed	2022-09-03 13:36:44	2022-09-03 11:36:44	Standing	EXTENSION_BRANDA_HEAVY_LONG_NAME	Career	NOZZLE_BRANDA_HEAVY_15DEGREE_NAME	(18.20, 0.00, -30.42)	POWERWASHER_BRANDA_HEAVY_NAME	WASH_FireHelicopter.WASH_FireHelicopter.Tyre_0	WASH_FireHelicopter	1
p3260	task_completed	2022-09-03 13:36:44	2022-09-03 11:36:44	Standing	EXTENSION_BRANDA_HEAVY_LONG_NAME	Career	NOZZLE_BRANDA_HEAVY_15DEGREE_NAME	(18.20, 0.00, -30.42)	POWERWASHER_BRANDA_HEAVY_NAME	WASH_FireHelicopter.WASH_FireHelicopter.Tyre_1	WASH_FireHelicopter	1
p3260	task_completed	2022-09-03 13:36:44	2022-09-03 11:36:44	Standing	EXTENSION_BRANDA_HEAVY_LONG_NAME	Career	NOZZLE_BRANDA_HEAVY_15DEGREE_NAME	(18.20, 0.00, -30.42)	POWERWASHER_BRANDA_HEAVY_NAME	WASH_FireHelicopter.WASH_FireHelicopter.Window_2	WASH_FireHelicopter	1

As far as I see there is a difference with the only one column i.e, LastSubTaskCompleted. With this I see this player can be someone using an internal tool to finish the tasks or should be a cheater.

Not sure howmany players or as such. It really pushes towards understanding the telemetries implementation.

-- TIMELINE
First and last task completed are 2022-08-18 05:41:53, 2023-03-29 03:20:06. This timeline looks good and align with the other tables and the telemetry timeline.

-- TASKS COMPLETED PER PLAYER
It varies between 1 to 574 and the highest events holder is 'p3260' again with the next one having almost the 140 events difference. Have to investigate further to keep these kind of players as outliers.

-- MOST COMPLETED TASKS
WASH_*** tasks are most finished it and also the most jobs are finished related to WASH only. It is matching as far as I see.

-- UNIQUE TASKS
There are 51 unique tasks identified across different jobs.

-- GAME MODES

CurrentGameMode CompletionEvents
Career	187597
FreePlay	14585
Special	7671
Challenge	2965

Career has the more users and so CompletionEvents too. Have to check the proportions of completion events to figure out the right flow.

-- LEVEL PROGRESSION

Min, Max and average follows 1.7010412e-05, 1,0.8387147570106993
Not sure whether min can be considered as 0. And the average seems to be good.

-- TASK FREQUENCY
PlayersCompletedTasks   UniqueTasks TotalTaskEvents
10107	51	212818

-- PLAYERS STARTED JOB - COMPLETED TASK - COMPLETED JOB
    10489   10107   10105

    So it is very clear that almost all the players completing the tasks are completing the job at glance. It needs own investigation though to understand the player journey.