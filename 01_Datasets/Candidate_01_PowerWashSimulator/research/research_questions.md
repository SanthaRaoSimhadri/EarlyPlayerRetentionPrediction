# Research Questions Evolution

## Project

**Early Player Retention Prediction Using Longitudinal Gameplay Telemetry**

---

# Purpose

This document captures the evolution of the research questions throughout the capstone.

Research questions will not be fixed at the beginning of the project. Instead, they will emerge from exploratory analysis, literature review, and understanding of the gameplay telemetry.

---

# Current Research Goal

To understand whether behavioural patterns observed during players' initial gameplay sessions can explain and predict early player retention.

---

# Evolution Timeline

| Version | Stage | Status |
|---------|-------|--------|
| v0.1 | Initial Brainstorming | Completed |
| v0.2 | After Demographics | Completed |
| v0.3 | After Player Login | Completed |
| v0.4 | After Gameplay Progression | Pending |
| v0.5 | Final Synopsis Version | Pending |

---

# Current Research Direction

The study is gradually converging toward four complementary research themes rather than isolated research questions.

---

# Theme 1 — Behavioural Characterisation

## Objective

Understand behavioural differences between retained and non-retained players during the early gameplay period.

### Current Evidence

- Login behaviour differs considerably across players.
- Approximately one-quarter of players recorded only one login event.
- Login frequency varies substantially.

### Supporting Tables

- demographics
- player_logged_in

### Current Status

🟡 Under Investigation

---

# Theme 2 — Behavioural Determinants

## Objective

Identify gameplay behaviours associated with early player retention.

### Current Evidence

Waiting for exploration of:

- job_started
- task_completed
- job_completed
- job_exited

### Current Status

🟡 Under Investigation

---

# Theme 3 — Predictive Modelling

## Objective

Evaluate whether behavioural telemetry collected during the early gameplay period can accurately predict early player retention.

### Candidate Models

- Logistic Regression
- Decision Tree
- Random Forest
- XGBoost
- Support Vector Machine

### Evaluation Metrics

- Accuracy
- Precision
- Recall
- F1-score
- ROC-AUC

### Current Status

🟡 Under Investigation

---

# Theme 4 — Explainable Decision Support

## Objective

Translate statistical and machine learning findings into actionable recommendations for improving player onboarding and engagement.

### Candidate Techniques

- SHAP
- Feature Importance
- Logistic Regression Coefficients
- Partial Dependence Analysis

### Current Status

🟡 Under Investigation

---

# Candidate Research Questions

These are working questions and are expected to evolve.

---

## Candidate RQ1

How do behavioural patterns observed during players' initial gameplay sessions differ between players who exhibit early retention and those who do not?

### Current Confidence

⭐⭐⭐⭐☆

### Supporting Tables

- demographics
- player_logged_in

---

## Candidate RQ2

Which behavioural telemetry features collected during players' initial gameplay sessions are significantly associated with early player retention?

### Current Confidence

⭐⭐⭐☆☆

### Supporting Tables

- player_logged_in
- gameplay progression tables (pending)

---

## Candidate RQ3

To what extent can machine learning models accurately predict early player retention using behavioural telemetry collected during players' initial gameplay sessions?

### Current Confidence

⭐⭐⭐☆☆

### Supporting Tables

Pending further feature engineering.

---

## Candidate RQ4

How can interpretable statistical and machine learning models generate actionable recommendations to improve early player retention?

### Current Confidence

⭐⭐⭐⭐☆

### Supporting Tables

Pending model development.

---

# Open Research Decisions

The following questions must be answered before finalizing the synopsis.

- What is the operational definition of Early Player Retention?
- What observation window should be used?
- What inclusion and exclusion criteria should define the study population?
- How should right-censored players be handled?
- Which behavioural variables should become final model features?

---

# Research Questions Deferred

Questions considered but currently not prioritized.

- Does player mood directly influence retention?
- Does item purchasing behaviour predict retention?
- Can player segmentation improve predictive performance?

These questions may become future work depending on dataset exploration.

---

# Synopsis Readiness Checklist

| Item | Status |
|------|--------|
| Research Problem | ✅ |
| Dataset Selection | ✅ |
| Research Direction | ✅ |
| Candidate RQs | ✅ |
| Final RQs | ⏳ Pending |
| Statistical Methods | ⏳ Pending |
| Sample Size | ⏳ Pending |
| Population Definition | ⏳ Pending |
| Hypotheses | ⏳ Pending |

---

# Notes

**Important:** Research questions should be finalized only after sufficient exploration of the behavioural telemetry tables. The current questions represent the evolving direction of the study rather than the final submission version.