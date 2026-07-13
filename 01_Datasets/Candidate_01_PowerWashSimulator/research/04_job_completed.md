-- TABLE OVERVIEW
Total rows 155100
Total columns 10

Sample row.
p1	job_completed	2022-08-18 18:38:58	2022-08-18 23:38:58	0.02631579	Career	0	HOME_VAN	WASH_PWVan.WASH_PWVan.PowerWashVan	WASH_PWVan

It tells last task and sub task completed as well. Have to make full utilisation of this table.

-- SCHEMA
1	pid	character varying
2	EventName	character varying
3	Time	timestamp without time zone
4	Time_utc	timestamp without time zone
5	CampaignProgressionAmount	double precision
6	CurrentGameMode	character varying
7	CurrentSessionLength	integer
8	LastJobCompleted	character varying
9	LastSubtaskCompleted	character varying
10	LastTaskCompleted	character varying

Just a check whether we have pid or not to relate it with the other tables and we have that. This too has CurrentSessionLength and have to check the difference between the tables job_started, job_completed. And I need to investigate whether session length is about the time length of session or not. In that case it should be checked whether time stamp between the job started and job completed giving the same length or not. Anyways, No need to worry so much here as we can find the correlation always. CampaignProgressionAmount will give the player progress it seems.

-- DATA QUALITY
No missing pid's. This is something which I like a lot as we have the pid assigned for each event.
Surprisingly no missing LastJobCompleted's as I would like to understand if all players are finishing atleast one job.
No missing GameMode's
No missing Time
No missing CampaignProgressionAmount

-- DUPLICATE ANALYSIS
Total rows and Total unique players are respectively 155100,10105. Now 11080 players launched the game and 10489 started the job and 10105 have completed the job. I can see there are more players didn't start the job relative to completed job from who started the job.

-- TIMELINE
It has the same time span and below are the first job completed and last_job_completed are 2022-08-18 05:41:53, 2023-03-29 03:20:06

-- JOBS COMPLETED PER PLAYER
It is spread over 1 to 566. But there is only one 566 and the next player is 319 as I could see a very sharp decline and the others have soft decline from there. job_started was spread till 418 and the finished is till 319. Have to investigate more on jobs which are started and successfully completed or unsuccessful.

-- MOST COMPLETED JOBS
HOME_VAN's completion count is more. So from the job_started table, It is clear that Current job is the job which might have been finished also. So the current job is set only when player starts or assign with the new job. It might need an investigation but not sure the impact of the assignment though

-- GAME MODES

Added the last column to tell job_started for the comparison. 

Career	135649  141722
FreePlay	10925   19393
Special	5120    11153
Challenge	3406    4556

Freeplay and Special seem to have some serious issues with the completion.

-- CAMPAIGN PROGRESSION
Min, Max and Average are as follows 0,1,0.405904679338445. It seems that 1 is the full campaign progression. Have to check the different values available though.

-- LAST JOB COMPLETED

HOME_VAN	11532
RESIDENTIALSMALL_BACKYARD	8817
HOME_DIRTBIKE	8081
RESIDENTIALSMALL_BUNGALOW	7508
RECREATIONGROUND_PLAYGROUND	6451
HOME_GOLFCART	6298
SUBURBIA_DETACHEDHOUSE	6019
NATIONALPARK_SHOEHOUSE	5500
SUBURBIA_VINTAGECAR	5238
RECREATIONGROUND_SKATEPARK	5078
HOME_MOTORBIKESIDECAR	4621
NATIONALPARK_STORYBOOKHOUSE	4495
HOME_SUV	4345
FIRESTATION_FIRESTATION	4307
RESIDENTIALSMALL_RACINGCAR	4190
FIRESTATION_FIRETRUCK	3877
HOME_PENNYFARTHING	3744
SUBURBIA_CAMPERVAN	3675
FIRESTATION_FIREHELICOPTER	3363
MANSION_FRONT	2991

Intersting fact here is that job completed count is reduced one after the other which means the player journey seems to be in this order. There is a sudden decline in the first place then It is a gradual decline it seems. This finding might help us. Check the more details in job started vs completed comparison.

-- JOB STARTED vs JOB COMPLETED

HOME_VAN	13088	11532	88.11
RESIDENTIALSMALL_BACKYARD	11077	8817	79.60
RESIDENTIALSMALL_BUNGALOW	8358	7508	89.83
HOME_DIRTBIKE	8209	8081	98.44
RECREATIONGROUND_PLAYGROUND	8097	6451	79.67
SUBURBIA_DETACHEDHOUSE	6594	6019	91.28
HOME_GOLFCART	6394	6298	98.50
RECREATIONGROUND_SKATEPARK	5947	5078	85.39
NATIONALPARK_SHOEHOUSE	5692	5500	96.63
SUBURBIA_VINTAGECAR	5420	5238	96.64
FIRESTATION_FIRESTATION	5154	4307	83.57
NATIONALPARK_STORYBOOKHOUSE	4831	4495	93.04
HOME_MOTORBIKESIDECAR	4640	4621	99.59
HOME_SUV	4385	4345	99.09
RESIDENTIALSMALL_RACINGCAR	4277	4190	97.97
FIRESTATION_FIRETRUCK	4129	3877	93.90
HOME_PENNYFARTHING	3969	3744	94.33
SUBURBIA_CAMPERVAN	3815	3675	96.33
FIRESTATION_FIREHELICOPTER	3471	3363	96.89
MARS_MARSROVER	3215	2517	78.29
FAIRGROUND_MERRYGOROUND	3175	2840	89.45
MANSION_FRONT	3093	2991	96.70
RECREATIONGROUND_MINIGOLF	3066	854	27.85
RECREATIONGROUND_FOUNTAIN	3022	798	26.41
NATIONALPARK_TREEHOUSE	2943	2424	82.36
SUBWAY_SUBWAYWASHROOM	2826	2498	88.39
COUNTRYSIDE_TEMPLE	2759	2499	90.58
HOME_DRILL	2756	2751	99.82
SUBWAY_SUBWAYPLATFORM	2471	1833	74.18
FAIRGROUND_HELTERSKELTER	2438	2128	87.28
AIRPORT_PRIVATEJET	2265	2053	90.64
SEATEMPLE	2218	1473	66.41
FAIRGROUND_BIGWHEEL	2113	1891	89.49
HANGAR_MONSTERTRUCK	2087	1977	94.73
MANSION_FROLICBOAT	2055	2013	97.96
DESERT_STEAMLOCOMOTIVE	1850	951	51.41
DESERT_ANCIENTHAND	1838	1701	92.55
DESERT_ANCIENTSTATUE	1806	1681	93.08
FAIRGROUND_FORTUNETELLERCARAVAN	1770	1959	110.68
MARINA_FISHINGBOAT	1754	1565	89.22
HANGAR_STUNTPLANE	1683	1657	98.46
DESERT_UFO	1518	1501	98.88
TIME_HOME_DIRTBIKE	874	708	81.01
TIME_HOME_VAN	768	598	77.86
WATER_HOME_VAN	415	305	73.49
WATER_HOME_DIRTBIKE	361	213	59.00
TIME_HOME_GOLFCART	346	325	93.93
WATER_HOME_GOLFCART	305	185	60.66
TIME_RESIDENTIALSMALL_BACKYARD	300	192	64.00
TIME_HOME_MOTORBIKESIDECAR	291	193	66.32
TIME_RESIDENTIALSMALL_BUNGALOW	158	128	81.01
TIME_SUBURBIA_VINTAGECAR	148	117	79.05
WATER_RESIDENTIALSMALL_BACKYARD	116	79	68.10
TIME_FIRESTATION_FIRETRUCK	101	76	75.25
WATER_RESIDENTIALSMALL_BUNGALOW	81	60	74.07
WATER_HOME_MOTORBIKESIDECAR	75	62	82.67
WATER_SUBURBIA_VINTAGECAR	71	55	77.46
WATER_FIRESTATION_FIRETRUCK	71	49	69.01
TIME_AIRPORT_STUNTPLANE	49	37	75.51
WATER_AIRPORT_STUNTPLANE	26	24	92.31

May be restructuring the jobs are required based on this data.


/*
===========================================================

Research Questions

1. Does completing the first job influence early retention? NO, It seems most of them are finishing the first job then decline starts

2. Are there jobs frequently started but rarely completed? yes, There are few when we compare the jobs started and completed counts side by side, We can see RESIDENTIALSMALL_BACKYARD, RESIDENTIALSMALL_BUNGALOW etc., and there are some which are very well finished as well.

3. Is gameplay progression a stronger behavioural signal than login frequency? Yes, of course.

4. Can CampaignProgressionAmount become a predictive feature? Have to dig more into this still. Haven't checked how the progression is moving.

===========================================================
*/

