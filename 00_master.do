/*******************************************************************************
Project: The Impact of ECB Communication and News on Household Expectations
Author: Le Dang Trung Duc
File: 00_master.do
Description: Master script to execute the entire data pipeline and analysis.
*******************************************************************************/
clear all
set more off
macro drop _all

* 1. SET GLOBAL DIRECTORY (Users cloning this repo only need to change this path)
global maindir "D:\VGU\GFE\THESIS"
global datadir "$maindir\Data"
global outdir  "$maindir\Output"

* Create output directory if it does not exist
cap mkdir "$outdir"

* 2. EXECUTE SCRIPTS
cd "$maindir"

* Step 1: Run data cleaning, merging, and variable construction
do "01_data_cleaning.do"

* Step 2: Run all regressions, event studies, and export visualizations
do "02_main_analysis.do"

disp "================================================================="
disp "✅ ALL SCRIPTS EXECUTED SUCCESSFULLY. CHECK THE OUTPUT FOLDER!"
disp "================================================================="