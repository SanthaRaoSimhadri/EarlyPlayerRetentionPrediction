# Research Journal

## Project Title

**Early Player Retention Prediction Using Longitudinal Gameplay Telemetry**

---

## Version

**0.1**

## Last Updated

**11 July 2026**

---

# Project Objective

To investigate whether behavioural patterns observed during players' initial gameplay sessions can explain and predict early player retention using verified longitudinal gameplay telemetry from the PowerWash Simulator Longitudinal Dataset.

---

# Current Research Direction

Rather than relying on an existing retention label, this study aims to derive an operational definition of **Early Player Retention** from longitudinal player login behaviour and investigate the gameplay behaviours associated with retained and non-retained players.

---

# Table Exploration Progress

| Table | Status | SQL | Python | Notes |
|-------|--------|:---:|:------:|------|
| demographics | ✅ Completed | ✅ | ✅ | Completed |
| player_logged_in | ✅ Completed | ✅ | ✅ | Completed |
| job_started | ⏳ Pending | | | |
| task_completed | ⏳ Pending | | | |
| job_completed | ⏳ Pending | | | |
| job_exited | ⏳ Pending | | | |
| subtask_completed | ⏳ Pending | | | |
| game_saved | ⏳ Pending | | | |
| update_current_state | ⏳ Pending | | | |
| item_purchased | ⏳ Pending | | | |
| mood_reported | ⏳ Pending | | | |
| study_prompt_answered | ⏳ Pending | | | |
| study_reward_claimed | ⏳ Pending | | | |
| study_reward_unlocked | ⏳ Pending | | | |

---

# Table 1 : demographics

## Purpose

To understand the characteristics of the study participants before analysing gameplay behaviour.

---

## Key Findings

- One record represents one player.
- Player identifiers (`pid`) are unique.
- Dataset contains demographic attributes including age, gender and country.
- Summary engagement metrics such as login count, first login and last login are already available.
- Average player age is approximately 28 years.
- Maximum age of 118 appears to be a potential outlier and requires further validation.
- Player population is geographically imbalanced, with the United States contributing the largest proportion of participants.
- Login counts vary considerably across players, indicating heterogeneous engagement levels.

---

## Research Observations

- Demographic information alone is unlikely to explain retention but can support segmentation analyses.
- Login-related summary statistics suggest behavioural diversity across players.
- Country imbalance should be considered when interpreting generalisability.
- Players entering the study near the end of the observation period should not automatically be classified as non-retained because of potential right-censoring.

---

## Candidate Features

- age
- gender
- country
- login_count
- study_duration_days
- average_logins_per_day

---

## Research Questions Raised

- Does player age influence early retention?
- Does geographic region influence retention?
- Is login count already an indicator of engagement?
- Should demographic variables be treated as supporting variables rather than primary predictors?

---

## Next Tables Required

- player_logged_in
- task_completed
- job_completed

---

# Table 2 : player_logged_in

## Purpose

To understand player return behaviour and establish the foundation for defining early player retention.

---

## Key Findings

- Login events span approximately 222 days.
- Login frequency ranges from 1 to 274 events per player.
- Approximately one-quarter of players recorded only one login event during the observation period.
- Login behaviour varies considerably across the player population.
- Daily login activity declines over time, although this may reflect player acquisition patterns rather than retention alone.
- The interval between consecutive logins appears to be an important behavioural characteristic for further investigation.

---

## Research Observations

- Early player retention is not explicitly available in the dataset and must be derived from login behaviour.
- A single login event should not immediately be interpreted as player churn because players entering the study near its end may not have had sufficient opportunity to return.
- Return interval appears to be a promising behavioural metric for operationally defining early retention.
- Login frequency is likely to become one of the strongest candidate features for predictive modelling.
- The distinction between new player acquisition and returning player behaviour must be considered when interpreting temporal login trends.

---

## Candidate Features

- login_count
- first_login
- last_login
- study_duration_days
- average_days_between_logins
- maximum_days_between_logins
- returned_player
- single_login_player
- login_frequency_bucket

---

## Research Questions Raised

- How should Early Player Retention be operationally defined?
- Which login interval best represents early retention?
- Do players with only one login differ behaviourally from returning players?
- Does gameplay progression explain why some players never return?
- Should right-censored players be excluded from predictive modelling?

---

## Next Tables Required

- job_started
- task_completed
- job_completed
- job_exited

---

# Emerging Candidate Features

## Demographic Features

- age
- gender
- country

## Engagement Features

- login_count
- study_duration_days
- first_login
- last_login
- returned_player

## Temporal Features

- average_days_between_logins
- maximum_days_between_logins

---

# Emerging Methodological Decisions

## Confirmed Decisions

- PostgreSQL will serve as the single source of truth.
- SQL will be used for data exploration, validation and feature extraction.
- Python notebooks will be used for visualization and research interpretation.
- Research questions will evolve from exploratory analysis rather than being fixed before understanding the data.

---

## Decisions Under Investigation

- Operational definition of Early Player Retention.
- Inclusion and exclusion criteria for right-censored players.
- Observation window for defining early retention.
- Final player-level analytical dataset.

---

# Emerging Research Themes

1. Behavioural Characterisation
   - Understanding how players behave during their initial gameplay experience.

2. Behavioural Determinants
   - Identifying behavioural telemetry associated with early player retention.

3. Predictive Analytics
   - Evaluating machine learning models for predicting early player retention.

4. Explainable Decision Support
   - Translating analytical findings into actionable recommendations for improving player onboarding and engagement.

---

# Open Questions

- How should **Early Player Retention** be operationally defined?
- What constitutes a meaningful return (1-day, 3-day, 7-day, or data-driven threshold)?
- How should right-censored players be handled?
- Which gameplay progression variables best explain player return behaviour?
- How should the final player-level analytical dataset be constructed from the event-level telemetry?

---

# Version History

| Version | Date | Description |
|---------|------|-------------|
| 0.1 | 11-Jul-2026 | Research journal initialized after exploration of `demographics` and `player_logged_in`. |