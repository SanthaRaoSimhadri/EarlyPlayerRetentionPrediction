-- TABLE OVERVIEW
Total rows - 176824
Total columns - 8
First rows of the table - 
p1	job_started	2022-08-18 17:55:30	2022-08-18 22:55:30	Career	HOME_VAN	2	NULL
p1	job_started	2022-08-18 18:39:26	2022-08-18 23:39:26	Career	RESIDENTIALSMALL_BACKYARD	1	HOME_VAN
p1	job_started	2022-08-18 19:18:18	2022-08-19 00:18:18	Career	HOME_DIRTBIKE	23	RESIDENTIALSMALL_BACKYARD
p1	job_started	2022-08-18 19:20:25	2022-08-19 00:20:25	Career	RESIDENTIALSMALL_BUNGALOW	25	HOME_DIRTBIKE
p1	job_started	2022-08-19 13:14:47	2022-08-19 18:14:47	Special	MARS_MARSROVER	0	NULL

Let us discuss more on the data but before that there are couple of things which are clear and some are yet to be understood. 'pid' is still can be used as Primary key and this can be used to connect with the other tables too. It has the time and time_utc which tells about the started time. And it tells the current job name and last completed job name both. And I didn't understand totally what is CurrentSessionLength here, I see that could be the time spent by the player on the current job in that session especially as I could see the length as 0 which could be the case where player hasn't spent much time there. But still there are no conclusions here on the session length. One more interesting fact which I understood is about the GameMode which I was not knowing before that this game has different modes.

-- SCHEMA

1	pid	character varying
2	EventName	character varying
3	Time	timestamp without time zone
4	Time_utc	timestamp without time zone
5	CurrentGameMode	character varying
6	CurrentJobName	character varying
7	CurrentSessionLength	integer
8	LastJobCompleted	character varying

pid - which we know and can be the key to connect with the other tables and can't be the primary key as there are multiple rows with the same pid value and it is not the discussion about finding the primary key though
CurrentSessionLength is an integer and Time and Time_utc are time stamps. Remaining are character varying.

-- DATA QUALITY
No missing pid's
No missing CurrentJobName as well
No missing CurrentGameMode
No missing CurrentSessionLength - But I can see the length as 0 which needs investigation 
No missing time as well

-- DUPLICATES
Values for the total rows and unique players as follows 176824,10489. I don't see all the players started the job as actual number of players is 11080.
Found one duplicate for the player id p5884

There are 2 duplicates for that player at this time stamp "2023-02-15 14:00:12"

I checked those rows.
p5884	job_started	2023-02-15 14:00:12	2023-02-15 20:00:12	FreePlay	RECREATIONGROUND_PLAYGROUND	38	NULL
p5884	job_started	2023-02-15 14:00:12	2023-02-15 20:00:12	FreePlay	SUBURBIA_DETACHEDHOUSE	38	NULL

As far as I see there is only difference between both the rows is 'CurrentJobName'.

-- TIMELINE
These are the values for first job started and last job started respectively 2022-08-18 05:35:28, 2023-03-29 03:20:29

-- JOBS PER PLAYER
They are distributed across 1 to 418. Will get more details during visualization.

-- MOST STARTED JOBS

HOME_VAN	13088
RESIDENTIALSMALL_BACKYARD	11077
RESIDENTIALSMALL_BUNGALOW	8358
HOME_DIRTBIKE	8209
RECREATIONGROUND_PLAYGROUND	8097
SUBURBIA_DETACHEDHOUSE	6594
HOME_GOLFCART	6394
RECREATIONGROUND_SKATEPARK	5947
NATIONALPARK_SHOEHOUSE	5692
SUBURBIA_VINTAGECAR	5420
FIRESTATION_FIRESTATION	5154
NATIONALPARK_STORYBOOKHOUSE	4831
HOME_MOTORBIKESIDECAR	4640
HOME_SUV	4385
RESIDENTIALSMALL_RACINGCAR	4277
FIRESTATION_FIRETRUCK	4129
HOME_PENNYFARTHING	3969
SUBURBIA_CAMPERVAN	3815
FIRESTATION_FIREHELICOPTER	3471
MARS_MARSROVER	3215
FAIRGROUND_MERRYGOROUND	3175
MANSION_FRONT	3093
RECREATIONGROUND_MINIGOLF	3066
RECREATIONGROUND_FOUNTAIN	3022
NATIONALPARK_TREEHOUSE	2943
SUBWAY_SUBWAYWASHROOM	2826
COUNTRYSIDE_TEMPLE	2759
HOME_DRILL	2756
SUBWAY_SUBWAYPLATFORM	2471
FAIRGROUND_HELTERSKELTER	2438
AIRPORT_PRIVATEJET	2265
SEATEMPLE	2218
FAIRGROUND_BIGWHEEL	2113
HANGAR_MONSTERTRUCK	2087
MANSION_FROLICBOAT	2055
DESERT_STEAMLOCOMOTIVE	1850
DESERT_ANCIENTHAND	1838
DESERT_ANCIENTSTATUE	1806
FAIRGROUND_FORTUNETELLERCARAVAN	1770
MARINA_FISHINGBOAT	1754
HANGAR_STUNTPLANE	1683
DESERT_UFO	1518
TIME_HOME_DIRTBIKE	874
TIME_HOME_VAN	768
WATER_HOME_VAN	415
WATER_HOME_DIRTBIKE	361
TIME_HOME_GOLFCART	346
WATER_HOME_GOLFCART	305
TIME_RESIDENTIALSMALL_BACKYARD	300
TIME_HOME_MOTORBIKESIDECAR	291
TIME_RESIDENTIALSMALL_BUNGALOW	158
TIME_SUBURBIA_VINTAGECAR	148
WATER_RESIDENTIALSMALL_BACKYARD	116
TIME_FIRESTATION_FIRETRUCK	101
WATER_RESIDENTIALSMALL_BUNGALOW	81
WATER_HOME_MOTORBIKESIDECAR	75
WATER_SUBURBIA_VINTAGECAR	71
WATER_FIRESTATION_FIRETRUCK	71
TIME_AIRPORT_STUNTPLANE	49
WATER_AIRPORT_STUNTPLANE	26

It tells an interesting thing that there are specific jobs which we have very high in count which means people might be interested in those jobs or the initial jobs. Order of jobs for the player is important to understand if there is really a correlation with the specifc job to understand whether there is a specific job might be causing the early player retention

-- GAME MODES

Career	141722
FreePlay	19393
Special	11153
Challenge	4556

There are four different modes for the players. Not sure about the player journey though for different modes. Needs a deep dive here

-- SESSION LENGTH
Min, max, Average are -26, 7232, 72.6484922861150070

Need to enqyuire why session length has negative values.

-- PREVIOUS COMPLETED JOB

NULL	48657
HOME_VAN	11004
RESIDENTIALSMALL_BACKYARD	7200
HOME_DIRTBIKE	6909
RESIDENTIALSMALL_BUNGALOW	6098
RECREATIONGROUND_PLAYGROUND	5301
HOME_GOLFCART	5179
NATIONALPARK_SHOEHOUSE	4920
SUBURBIA_DETACHEDHOUSE	4739
SUBURBIA_VINTAGECAR	4219
RECREATIONGROUND_SKATEPARK	4034
HOME_MOTORBIKESIDECAR	3885
HOME_SUV	3831
NATIONALPARK_STORYBOOKHOUSE	3709
FIRESTATION_FIRESTATION	3670
RESIDENTIALSMALL_RACINGCAR	3422
FIRESTATION_FIRETRUCK	3389
HOME_PENNYFARTHING	3307
FIRESTATION_FIREHELICOPTER	2932
SUBURBIA_CAMPERVAN	2872

There are many NULL's. Are people churning even not finishing one completed job?

/*
===========================================================

Research Questions

1. Do retained players start more jobs? Yes, More chances. Have to investigate more.

2. Does CurrentSessionLength relate to retention? Could be. Need to deep dive.

3. Which jobs are commonly started but never completed? Yet to check job completed table

4. Does gameplay progression explain early retention? Yes, but need to understand job completed and exited too.

===========================================================
*/


There are more people had the current job 'HOME_VAN' and not sure whether people are stuck here? Have to investigate it in that direction.

