Empirical Analysis: The Impact of ECB Communication on Household Expectations
📌 Overview
This repository contains the replication code for the Master's dissertation titled "Consistent with Theory? The Impact of ECB Communication and News on European Household Expectations", submitted to Goethe Business School and Vietnamese-German University.

This research investigates how European Central Bank (ECB) communication influenced household macroeconomic expectations across six major Euro-area economies (Belgium, France, Germany, Italy, Netherlands, and Spain) during the period 2020–2025. It assesses the consistency of these expectations with the Phillips Curve and Taylor Rule frameworks.

📊 Research Highlights
Theory-Consistency: Evaluates how households align their expectations with standard macroeconomic theories.

Sender Channel Analysis: Uses a pooled probit regression and an extended event-study design (based on Bethmage) to measure the impact of ECB Governing Council meetings on theory-consistent expectations.

Receiver Channel Analysis: Investigates how news exposure (general vs. official ECB channels) affects the probability of theory-consistent expectation formation.

Heterogeneity: Explores how responses vary by country, education level, and ECB policy episodes (e.g., pandemic stimulus vs. post-Ukraine shock tightening).

📂 Repository Structure
00_master.do: The master script that coordinates the entire data pipeline and analysis.

01_data_cleaning.do: Processes raw CES microdata, merges macroeconomic indicators (HICP, mortgage rates, unemployment gaps), and constructs theory-consistent measures.

02_main_analysis.do: Executes all Probit regressions, event studies, and generates visualization plots.

results/: (Folder) Stores the output files including regression tables (.rtf) and event-study plots (.png).
Note: ##
...
* `Code/`: Contains the refactored, modularized scripts (`00_master.do`, `01_data_cleaning.do`, `02_main_analysis.do`) optimized for reproducibility.

* `Original_Code/`: Contains the original, monolithic thesis code (as submitted) for archival purposes and transparency. 
  * *Note: Paths in the original scripts are specific to the author's machine at the time of the thesis completion.*
...
🛠 Prerequisites
Stata: Tested on Stata 16 or newer.

Packages: The following community-contributed packages are required:

ssc install estout, replace
ssc install rangestat, replace

## 🔐 Data Availability Statement
The raw microdata used in this study (ECB Consumer Expectations Survey - CES) is subject to strict data access agreements and confidentiality protocols. Consequently, the raw datasets (`.csv`, `.dta`) are **not included** in this repository. Researchers interested in replicating these results can apply for official access through the [ECB's Data Portal](https://www.ecb.europa.eu/stats/ecb_surveys/consumer_exp_survey/html/index.en.html#data).

## 📝 Citation
If you use this code or findings in your research, please cite:
*Le Dang Trung Duc (2025). Consistent with Theory? The Impact of ECB Communication and News on European Household Expectations. Master's Dissertation, Goethe Business School/Vietnamese-German University.*

---
