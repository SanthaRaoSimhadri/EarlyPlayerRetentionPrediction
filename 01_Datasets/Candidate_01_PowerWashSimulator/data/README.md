# PowerWash Simulator Dataset

## Overview

This project uses the **PowerWash Simulator Longitudinal Dataset**, a publicly available gameplay telemetry dataset released by the Open Science Framework (OSF) for academic research.

The dataset contains longitudinal gameplay events collected from players of *PowerWash Simulator* and includes player demographics, login history, gameplay progression, task completion, purchasing behaviour, in-game state updates, survey responses, and other gameplay telemetry.

The dataset is used in this research to investigate **Early Player Retention Prediction** using behavioural analytics and machine learning techniques.

---

## Why the Dataset is Not Stored in This Repository

The original dataset contains multiple large CSV files (approximately **5 GB** in total).

GitHub's file size limitations make it impractical to store the complete dataset within this repository. Therefore, only the research code, SQL scripts, notebooks, and documentation are included here.

The dataset can be downloaded directly from the official source.

---

## Official Dataset Source

Open Science Framework (OSF)

Dataset Overview

https://osf.io/wpeh6/overview

Git Repository

https://osf.io/wpeh6/

---

## Dataset Citation

Vuorre, M., Ryan, R. M., Velez, J. A., & Tyack, A. (2023). *PowerWash Simulator Longitudinal Dataset*. Open Science Framework.

---

## Repository Structure

After downloading the dataset, place the extracted CSV files inside the following directory:

```
01_Datasets/
└── Candidate_01_PowerWashSimulator/
    └── data/
        ├── demographics.csv
        ├── player_logged_in.csv
        ├── job_started.csv
        ├── job_completed.csv
        ├── task_completed.csv
        ├── subtask_completed.csv
        ├── update_current_state.csv
        ├── ...
```

---

## Database Setup

The SQL scripts required to recreate the PostgreSQL database are available in:

```
01_Datasets/
└── Candidate_01_PowerWashSimulator/
    └── sql/
```

Execute the scripts in the following order:

1. `01_create_database.sql`
2. `02_create_schema.sql`
3. `02a_validate_schema.sql`
4. `03_load_data.sql`
5. `03a_validate_data_load.sql`

---

## Project Workflow

After loading the dataset, execute the remaining SQL scripts in sequence to reproduce the analysis:

- Dataset understanding
- Player journey analysis
- Behavioural feature engineering
- Retention definition
- Feature export

Jupyter notebooks used for exploratory analysis are available under:

```
01_Datasets/
└── Candidate_01_PowerWashSimulator/
    └── notebooks/
```

---

## Reproducibility

This repository contains everything required to reproduce the research workflow except the raw gameplay dataset itself, which must be obtained from the official Open Science Framework repository.

The project includes:

- SQL scripts
- PostgreSQL schema
- Feature engineering pipeline
- Jupyter notebooks
- Research documentation
- Interim and final reports