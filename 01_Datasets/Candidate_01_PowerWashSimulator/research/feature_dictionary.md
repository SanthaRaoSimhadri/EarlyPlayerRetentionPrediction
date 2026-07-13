# Feature Dictionary

## Project

**Early Player Retention Prediction Using Longitudinal Gameplay Telemetry**

---

# Purpose

This document serves as the master inventory of all features considered throughout the capstone project.

Each feature will be tracked from its source telemetry through feature engineering, statistical validation, and eventual machine learning modelling.

---

# Feature Status Legend

| Status | Meaning |
|---------|---------|
| 🟢 | Confirmed Feature |
| 🟡 | Candidate Feature |
| 🔴 | Rejected Feature |
| 🔵 | Derived Feature |

---

# Demographic Features

| Feature | Source Table | Type | Status | Description | Research Purpose |
|----------|--------------|------|--------|-------------|------------------|
| age | demographics | Numeric | 🟡 | Player age | Control variable |
| gender | demographics | Categorical | 🟡 | Player gender | Segmentation |
| country | demographics | Categorical | 🟡 | Player country | Geographic analysis |

---

# Login Behaviour Features

| Feature | Source Table | Type | Status | Description | Research Purpose |
|----------|--------------|------|--------|-------------|------------------|
| login_count | player_logged_in | Numeric | 🟢 | Total login events | Engagement |
| first_login | player_logged_in | Timestamp | 🟢 | First observed login | Timeline |
| last_login | player_logged_in | Timestamp | 🟢 | Last observed login | Timeline |
| study_duration_days | player_logged_in | Numeric | 🔵 | Days between first and last login | Engagement |
| returned_player | player_logged_in | Boolean | 🔵 | Whether player returned after first login | Target Engineering |
| single_login_player | player_logged_in | Boolean | 🔵 | Only one observed login | Behaviour Classification |
| average_days_between_logins | player_logged_in | Numeric | 🔵 | Mean interval between logins | Temporal Behaviour |
| maximum_days_between_logins | player_logged_in | Numeric | 🔵 | Longest inactivity period | Retention Behaviour |
| login_frequency_bucket | player_logged_in | Categorical | 🔵 | Bucketed login frequency | Segmentation |

---

# Gameplay Progression Features

(To be updated after exploring gameplay tables.)

| Feature | Source Table | Type | Status | Description | Research Purpose |
|----------|--------------|------|--------|-------------|------------------|

---

# Session Features

(To be updated.)

| Feature | Source Table | Type | Status | Description | Research Purpose |
|----------|--------------|------|--------|-------------|------------------|

---

# Economy Features

(To be updated.)

| Feature | Source Table | Type | Status | Description | Research Purpose |
|----------|--------------|------|--------|-------------|------------------|

---

# Psychological Features

(To be updated.)

| Feature | Source Table | Type | Status | Description | Research Purpose |
|----------|--------------|------|--------|-------------|------------------|

---

# Candidate Target Variables

| Variable | Status | Notes |
|-----------|--------|------|
| Early Player Retention | 🟡 Under Investigation | Will be derived from login behaviour |
| Early Churn | 🟡 Under Investigation | Complementary outcome |
| Returning Player | 🔵 Derived | Candidate binary target |

---

# Feature Engineering Decisions

## Confirmed

- PostgreSQL will be used for feature extraction.
- Player-level datasets will be created from event-level telemetry.
- Derived features will be documented before modelling.

---

## Under Investigation

- Early Retention Threshold
- Observation Window
- Right Censoring Strategy
- Feature Normalization
- Feature Selection Strategy

---

# Features Rejected

(To be updated.)

| Feature | Reason |
|----------|--------|

---

# Feature Importance (To be Updated)

After statistical analysis and machine learning.

| Feature | Statistical Significance | ML Importance | Final Decision |
|----------|-------------------------|---------------|----------------|