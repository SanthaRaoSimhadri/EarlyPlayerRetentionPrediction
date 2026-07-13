-- TABLE OVERVIEW
Total rows - 240417
Total columns - 10

Sample row
p1	job_exited	2022-08-18 18:00:33	2022-08-18 23:00:33	45	Career	HOME_VAN	7	WASH_PWVan.WASH_PWVan.Window_1	NULL	0.89633083

-- SCHEMA

1	pid	character varying
2	EventName	character varying
3	Time	timestamp without time zone
4	Time_utc	timestamp without time zone
5	CurrentCreditAmount	double precision
6	CurrentGameMode	character varying
7	CurrentJobName	character varying
8	CurrentSessionLength	integer
9	LastSubtaskCompleted	character varying
10	LastTaskCompleted	character varying
11	LevelProgressionAmount	double precision

Couple of interesting facts here are related to the Currency how it grows and not worried about spends now though, LevelProgressionAmount is stored even when the job is exited with some of the tasks/sub-tasks left.


-- DATA QUALITY
No missing pid's as always.
LastTaskCompleted is NULL in the case not finishing a single task it seems as I could see NULL in almost for 41098 instances. And the value is set to NULL when the job is completed and new job is started as well. If we need those details then have to go for an investigation
LastSubtaskCompleted is also NULL for the 5798 instances.
No missing CurrentGameMode
LevelProgressionAmount is also NULL for 16143 instances which is bothering me at the same time it could be happening with the people not finished even a single task too. But the instances are not exactly same with LastSubtaskCompleted NULL count. Have to deep dive into this.
Time is not missing anywhere which would help us in tracing some missing values if required.
No missing values for CurrentSessionLength.

-- DUPLICATE ANALYSIS
Total rows are 240417 much higher than unique pid 10478 and it is expected as we can see multiple entries for each player here.

p6866	2022-08-19 20:29:08	2 
Digging more into the above one

p6866	job_exited	2022-08-19 20:29:08	2022-08-20 00:29:08	999050	Career	HOME_PENNYFARTHING	101	WASH_SUV.WASH_SUV.AlloyWheel_1	WASH_SUV	0
p6866	job_exited	2022-08-19 20:29:08	2022-08-20 00:29:08	999100	Career	HOME_SUV	45	WASH_StoryBookCottage.WASH_StoryBookCottage.TimberFrame_0	WASH_StoryBookCottage	0

May be it is happening when one job is finished and the next job is assigned at the same moment. Still needs an investigation if it gets more priority.

-- TIMELINE
First and last job exited are 2022-08-18 05:45:37, 2023-03-29 09:44:28 which seems to be inline with the other tables and the data.

-- EXITING JOBS BASED ON PLAYER UNIQUE ID
All 10478 players are exiting the jobs.

-- MOST EXITED JOB

RECREATIONGROUND_PLAYGROUND	17577
RESIDENTIALSMALL_BACKYARD	17167
SUBURBIA_DETACHEDHOUSE	12768
RESIDENTIALSMALL_BUNGALOW	12312
RECREATIONGROUND_SKATEPARK	11700
FIRESTATION_FIRESTATION	10400


I am borrowing these values from job started 
HOME_VAN	13088
RESIDENTIALSMALL_BACKYARD	11077
RESIDENTIALSMALL_BUNGALOW	8358
HOME_DIRTBIKE	8209
RECREATIONGROUND_PLAYGROUND	8097

I can see higher values for some of them, Needs to understand how job_exited count is calculated. It is definitely clear that job_exited is getting triggered in some cases when job_started is not triggered or job_exited is triggered multiple times in some case. Not sure whether we can rely on this particularly or not. If we have to rely on this then we should investigate why there is a difference in count between these two. 

-- GAME MODES
Career	206468
FreePlay	18885
Special	10289
Challenge	4519
None	256

I could see null also. In the same way I can see there are more instances relative to job_started here also.

and hey, I can see job_exited consists of 240417 rows and job_started consists of 176824 rows. It clearlly tells that one job_started can have multiple job_exits.

