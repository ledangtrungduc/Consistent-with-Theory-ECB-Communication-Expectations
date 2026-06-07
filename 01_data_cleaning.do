/*******************************************************************************
File: 01_data_cleaning.do
Description: Data preparation, wave-mapping, merging macro data, and 
             constructing consistency measures (Phillips Curve & Taylor Rule).
*******************************************************************************/
cd "$datadir"

*==============================================================================*
* 1. APPEND CES DATA & RENAME VARIABLES
*==============================================================================*
use "ces_2020.dta", clear
append using "ces_2021.dta"
append using "ces_2022.dta"
append using "ces_2023.dta"
append using "ces_2024.dta"

rename a0010 respondent_id
rename a0020 country
rename a0030 wave
rename a1010_age_prec age_group
rename b7040_quintile income_quintile
rename wgt weight

*==============================================================================*
* 2. DATE PROCESSING (WAVE MAPPING)
*==============================================================================*
gen start_date_str = ""
gen end_date_str = ""

replace start_date_str = "2/4/2020" if wave == 4
replace end_date_str = "6/5/2020" if wave == 4
replace start_date_str = "7/5/2020" if wave == 5
replace end_date_str = "3/6/2021" if wave == 5  
replace start_date_str = "4/6/2020" if wave == 6
replace end_date_str = "1/7/2020" if wave == 6  
replace start_date_str = "2/7/2020" if wave == 7
replace end_date_str = "5/8/2020" if wave == 7  
replace start_date_str = "6/8/2020" if wave == 8
replace end_date_str = "2/9/2020" if wave == 8  
replace start_date_str = "3/9/2020" if wave == 9
replace end_date_str = "30/9/2020" if wave == 9  
replace start_date_str = "1/10/2020" if wave == 10
replace end_date_str = "4/11/2020" if wave == 10  
replace start_date_str = "5/11/2020" if wave == 11
replace end_date_str = "2/12/2020" if wave == 11  
replace start_date_str = "3/12/2020" if wave == 12
replace end_date_str = "6/1/2021" if wave == 12  
replace start_date_str = "7/1/2021" if wave == 13
replace end_date_str = "3/2/2021" if wave == 13  
replace start_date_str = "4/2/2021" if wave == 14
replace end_date_str = "3/3/2021" if wave == 14  
replace start_date_str = "4/3/2021" if wave == 15
replace end_date_str = "31/3/2021" if wave == 15  
replace start_date_str = "1/4/2021" if wave == 16
replace end_date_str = "5/5/2021" if wave == 16  
replace start_date_str = "6/5/2021" if wave == 17
replace end_date_str = "2/6/2021" if wave == 17  
replace start_date_str = "3/6/2021" if wave == 18
replace end_date_str = "30/6/2021" if wave == 18  
replace start_date_str = "1/7/2021" if wave == 19
replace end_date_str = "4/8/2021" if wave == 19  
replace start_date_str = "5/8/2021" if wave == 20
replace end_date_str = "1/9/2021" if wave == 20  
replace start_date_str = "2/9/2021" if wave == 21
replace end_date_str = "6/10/2021" if wave == 21  
replace start_date_str = "7/10/2021" if wave == 22
replace end_date_str = "3/11/2021" if wave == 22  
replace start_date_str = "4/11/2021" if wave == 23
replace end_date_str = "1/12/2021" if wave == 23  
replace start_date_str = "2/12/2021" if wave == 24
replace end_date_str = "5/1/2022" if wave == 24  
replace start_date_str = "6/1/2022" if wave == 25
replace end_date_str = "2/2/2022" if wave == 25
replace start_date_str = "3/2/2022" if wave == 26
replace end_date_str = "2/3/2022" if wave == 26
replace start_date_str = "3/3/2022" if wave == 27
replace end_date_str = "6/4/2022" if wave == 27
replace start_date_str = "7/4/2022" if wave == 28
replace end_date_str = "4/5/2022" if wave == 28
replace start_date_str = "5/5/2022" if wave == 29
replace end_date_str = "1/6/2022" if wave == 29
replace start_date_str = "2/6/2022" if wave == 30
replace end_date_str = "6/7/2022" if wave == 30
replace start_date_str = "7/7/2022" if wave == 31
replace end_date_str = "3/8/2022" if wave == 31
replace start_date_str = "4/8/2022" if wave == 32
replace end_date_str = "7/9/2022" if wave == 32
replace start_date_str = "8/9/2022" if wave == 33
replace end_date_str = "5/10/2022" if wave == 33
replace start_date_str = "6/10/2022" if wave == 34
replace end_date_str = "2/11/2022" if wave == 34
replace start_date_str = "3/11/2022" if wave == 35
replace end_date_str = "30/11/2022" if wave == 35
replace start_date_str = "2/12/2022" if wave == 36
replace end_date_str = "4/1/2023" if wave == 36
replace start_date_str = "5/1/2023" if wave == 37
replace end_date_str = "1/2/2023" if wave == 37
replace start_date_str = "2/2/2023" if wave == 38
replace end_date_str = "1/3/2023" if wave == 38
replace start_date_str = "2/3/2023" if wave == 39
replace end_date_str = "5/4/2023" if wave == 39
replace start_date_str = "6/4/2023" if wave == 40
replace end_date_str = "3/5/2023" if wave == 40
replace start_date_str = "4/5/2023" if wave == 41
replace end_date_str = "31/5/2023" if wave == 41
replace start_date_str = "1/6/2023" if wave == 42
replace end_date_str = "5/7/2023" if wave == 42
replace start_date_str = "6/7/2023" if wave == 43
replace end_date_str = "2/8/2023" if wave == 43
replace start_date_str = "3/8/2023" if wave == 44
replace end_date_str = "6/9/2023" if wave == 44
replace start_date_str = "7/9/2023" if wave == 45
replace end_date_str = "4/10/2023" if wave == 45
replace start_date_str = "5/10/2023" if wave == 46
replace end_date_str = "1/11/2023" if wave == 46
replace start_date_str = "2/11/2023" if wave == 47
replace end_date_str = "6/12/2023" if wave == 47
replace start_date_str = "7/12/2023" if wave == 48
replace end_date_str = "31/1/2024" if wave == 48
replace start_date_str = "1/2/2024" if wave == 49
replace end_date_str = "31/1/2024" if wave == 49
replace start_date_str = "1/2/2024" if wave == 50
replace end_date_str = "6/3/2024" if wave == 50
replace start_date_str = "7/3/2024" if wave == 51
replace end_date_str = "3/4/2024" if wave == 51
replace start_date_str = "4/4/2024" if wave == 52
replace end_date_str = "1/5/2024" if wave == 52
replace start_date_str = "2/5/2024" if wave == 53
replace end_date_str = "5/6/2024" if wave == 53
replace start_date_str = "6/6/2024" if wave == 54
replace end_date_str = "3/7/2024" if wave == 54
replace start_date_str = "4/7/2024" if wave == 55
replace end_date_str = "31/7/2024" if wave == 55
replace start_date_str = "1/8/2024" if wave == 56
replace end_date_str = "4/9/2024" if wave == 56
replace start_date_str = "5/9/2024" if wave == 57
replace end_date_str = "2/10/2024" if wave == 57
replace start_date_str = "3/10/2024" if wave == 58
replace end_date_str = "2/11/2024" if wave == 58
replace start_date_str = "3/11/2024" if wave == 59
replace end_date_str = "2/12/2024" if wave == 59
replace start_date_str = "3/12/2024" if wave == 60
replace end_date_str = "2/1/2025" if wave == 60

* Convert string dates to Stata date format
gen start_date = date(start_date_str, "DMY")
gen end_date = date(end_date_str, "DMY")
format start_date %td
format end_date %td
label variable start_date "Survey Start Date"
label variable end_date "Survey End Date"
drop start_date_str end_date_str

* Generate exact survey dates based on waves
gen survey_date = .
replace survey_date = mdy(4, 2, 2020) if wave == 4
replace survey_date = mdy(5, 7, 2020) if wave == 5
replace survey_date = mdy(6, 4, 2020) if wave == 6
replace survey_date = mdy(7, 2, 2020) if wave == 7
replace survey_date = mdy(8, 6, 2020) if wave == 8
replace survey_date = mdy(9, 3, 2020) if wave == 9
replace survey_date = mdy(10, 1, 2020) if wave == 10
replace survey_date = mdy(11, 5, 2020) if wave == 11
replace survey_date = mdy(12, 3, 2020) if wave == 12
replace survey_date = mdy(1, 7, 2021) if wave == 13
replace survey_date = mdy(2, 4, 2021) if wave == 14
replace survey_date = mdy(3, 4, 2021) if wave == 15
replace survey_date = mdy(4, 1, 2021) if wave == 16
replace survey_date = mdy(5, 6, 2021) if wave == 17
replace survey_date = mdy(6, 3, 2021) if wave == 18
replace survey_date = mdy(7, 1, 2021) if wave == 19
replace survey_date = mdy(8, 5, 2021) if wave == 20
replace survey_date = mdy(9, 2, 2021) if wave == 21
replace survey_date = mdy(10, 7, 2021) if wave == 22
replace survey_date = mdy(11, 4, 2021) if wave == 23
replace survey_date = mdy(12, 2, 2021) if wave == 24
replace survey_date = mdy(1, 6, 2022) if wave == 25
replace survey_date = mdy(2, 3, 2022) if wave == 26
replace survey_date = mdy(3, 3, 2022) if wave == 27
replace survey_date = mdy(4, 7, 2022) if wave == 28
replace survey_date = mdy(5, 5, 2022) if wave == 29
replace survey_date = mdy(6, 2, 2022) if wave == 30
replace survey_date = mdy(7, 7, 2022) if wave == 31
replace survey_date = mdy(8, 4, 2022) if wave == 32
replace survey_date = mdy(9, 8, 2022) if wave == 33
replace survey_date = mdy(10, 6, 2022) if wave == 34
replace survey_date = mdy(11, 3, 2022) if wave == 35
replace survey_date = mdy(12, 2, 2022) if wave == 36
replace survey_date = mdy(1, 5, 2023) if wave == 37
replace survey_date = mdy(2, 2, 2023) if wave == 38
replace survey_date = mdy(3, 2, 2023) if wave == 39
replace survey_date = mdy(4, 6, 2023) if wave == 40
replace survey_date = mdy(5, 4, 2023) if wave == 41
replace survey_date = mdy(6, 1, 2023) if wave == 42
replace survey_date = mdy(7, 6, 2023) if wave == 43
replace survey_date = mdy(8, 3, 2023) if wave == 44
replace survey_date = mdy(9, 7, 2023) if wave == 45
replace survey_date = mdy(10, 5, 2023) if wave == 46
replace survey_date = mdy(11, 2, 2023) if wave == 47
replace survey_date = mdy(12, 7, 2023) if wave == 48
replace survey_date = mdy(1, 4, 2024) if wave == 49
replace survey_date = mdy(2, 1, 2024) if wave == 50
replace survey_date = mdy(3, 7, 2024) if wave == 51
replace survey_date = mdy(4, 4, 2024) if wave == 52
replace survey_date = mdy(5, 2, 2024) if wave == 53
replace survey_date = mdy(6, 6, 2024) if wave == 54
replace survey_date = mdy(7, 4, 2024) if wave == 55
replace survey_date = mdy(8, 1, 2024) if wave == 56
replace survey_date = mdy(9, 5, 2024) if wave == 57
replace survey_date = mdy(10, 3, 2024) if wave == 58
replace survey_date = mdy(11, 7, 2024) if wave == 59
replace survey_date = mdy(12, 5, 2024) if wave == 60
replace survey_date = mdy(1, 2, 2025) if wave == 61
replace survey_date = mdy(2, 6, 2025) if wave == 62
replace survey_date = mdy(3, 6, 2025) if wave == 63
format survey_date %td

gen month_date_ces = mofd(survey_date)
format month_date_ces %tm
gen month_year_str = string(year(survey_date)) + string(month(survey_date), "%02.0f")

* Restrict countries
keep if inlist(country, "BE", "DE", "ES", "FR", "IT", "NL")
encode country, gen(country_num)
label define country_label 1 "Belgium" 2 "Germany" 3 "Spain" 4 "France" 5 "Italy" 6 "Netherlands"
label values country_num country_label

*==============================================================================*
* 3. MERGING MACROECONOMIC INDICATORS & BACKGROUND DATA
*==============================================================================*
* Merge 1: Mortgage Rates
merge m:1 country month_date_ces using "current_mortgage_rates.dta", keep(master match) nogene

* Merge 2: Inflation Data (CPI)
merge m:1 country month_year_str using "cpi_final.dta", keep(master match) nogene
gen year_1 = real(substr(month_year_str, 1, 4))
gen month = real(substr(month_year_str, 5, 2))
capture drop month_date
gen month_date = (year_1 - 1960) * 12 + month - 1
format month_date %tm

* Merge 3: Unemployment Gaps
gen mdate = month_date
format mdate %tm
merge m:1 country mdate using "all_unemp_gaps_1.dta", keep(master match) nogene

* Merge 4: Background Data (Education & Gender)
tostring respondent_id, replace
merge m:1 respondent_id using "CES_background_clean.dta", keep(master match) nogene
capture rename b2100_prec education
capture rename a1020_prec gender
gen education_new = .
replace education_new = 1 if inlist(education, 1, 2)
replace education_new = 2 if education == 3
replace education_new = education_new - 1
label define edu_lbl 0 "Low Education" 1 "High Education"
label values education_new edu_lbl

* Merge 5: Macro Economic Events (Brent YoY)
merge m:1 month_date using "brent_yoy_growth.dta", keep(master match) nogene

* Merge 6: Receiver Channel Data (News exposure)
capture destring wave, replace
merge m:1 respondent_id wave using "new_data_temp.dta", keep(master match) nogene

*==============================================================================*
* 4. CONSTRUCTING EXPECTATION VARIABLES (Baseline 20% & Robustness 50%)
*==============================================================================*
label define exp_lbl -1 "Down" 0 "Same" 1 "Up"

* 4.1 Expected Inflation
gen percent_change = (c1120 - inflation_avg12) / inflation_avg12 * 100 if c1120 != . & inflation_avg12 != .
* Baseline (20%)
gen inflation_exp_cat = .
replace inflation_exp_cat = 1 if percent_change > 20 & percent_change != .
replace inflation_exp_cat = -1 if percent_change < -20 & percent_change != .
replace inflation_exp_cat = 0 if inrange(percent_change, -20, 20) | c1110 == 5
label values inflation_exp_cat exp_lbl
* Robustness (50%)
gen inflation_exp_cat_robustness = .
replace inflation_exp_cat_robustness = 1 if percent_change > 50 & percent_change != .
replace inflation_exp_cat_robustness = -1 if percent_change < -50 & percent_change != .
replace inflation_exp_cat_robustness = 0 if inrange(percent_change, -50, 50) | c1110 == 5
label values inflation_exp_cat_robustness exp_lbl

* 4.2 Expected Interest Rate
gen expected_interest_rate = .
replace expected_interest_rate = c5111 if wave >= 4 & wave <= 29 & c5111 != .
replace expected_interest_rate = c5113 if wave >= 30 & c5113 != .
gen interest_change_pct = (expected_interest_rate - rate_12mo_avg) / rate_12mo_avg * 100 if expected_interest_rate != . & rate_12mo_avg != .
* Baseline (20%)
gen interest_exp_cat = .
replace interest_exp_cat = 1 if interest_change_pct > 20 & interest_change_pct != .
replace interest_exp_cat = -1 if interest_change_pct < -20 & interest_change_pct != .
replace interest_exp_cat = 0 if inrange(interest_change_pct, -20, 20)
label values interest_exp_cat exp_lbl
* Robustness (50%)
gen interest_exp_cat_robustness = .
replace interest_exp_cat_robustness = 1 if interest_change_pct > 50 & interest_change_pct != .
replace interest_exp_cat_robustness = -1 if interest_change_pct < -50 & interest_change_pct != .
replace interest_exp_cat_robustness = 0 if inrange(interest_change_pct, -50, 50)
label values interest_exp_cat_robustness exp_lbl

* 4.3 Expected Unemployment
gen unemp_change_pct = (c4031 - avg_unemp_12) / avg_unemp_12 * 100 if c4031 != . & avg_unemp_12 != .
* Baseline (20%)
gen unemp_exp_cat = .
replace unemp_exp_cat = 1 if unemp_change_pct > 20 & unemp_change_pct != .
replace unemp_exp_cat = -1 if unemp_change_pct < -20 & unemp_change_pct != .
replace unemp_exp_cat = 0 if inrange(unemp_change_pct, -20, 20)
label values unemp_exp_cat exp_lbl
* Robustness (50%)
gen unemp_exp_cat_robustness = .
replace unemp_exp_cat_robustness = 1 if unemp_change_pct > 50 & unemp_change_pct != .
replace unemp_exp_cat_robustness = -1 if unemp_change_pct < -50 & unemp_change_pct != .
replace unemp_exp_cat_robustness = 0 if inrange(unemp_change_pct, -50, 50)
label values unemp_exp_cat_robustness exp_lbl

*==============================================================================*
* 5. CONSISTENCY DUMMIES & RECEIVER CHANNEL VARIABLES
*==============================================================================*
* 5.1 Baseline Consistency
gen phillips_consistent = 0
replace phillips_consistent = 1 if (inflation_exp_cat == 1 & unemp_exp_cat == -1) | ///
                                   (inflation_exp_cat == -1 & unemp_exp_cat == 1) | ///
                                   (inflation_exp_cat == 0 & unemp_exp_cat == 0)

gen taylor_consistent_strict = 0
replace taylor_consistent_strict = 1 if (interest_exp_cat == 1 & inflation_exp_cat == 1 & unemp_exp_cat == -1) | ///
                                        (interest_exp_cat == -1 & inflation_exp_cat == -1 & unemp_exp_cat == 1) | ///
                                        (interest_exp_cat == 0 & inflation_exp_cat == 0 & unemp_exp_cat == 0)

gen taylor_consistent_ecb = 0
replace taylor_consistent_ecb = 1 if (interest_exp_cat == 1 & inflation_exp_cat == 1) | ///
                                     (interest_exp_cat == -1 & inflation_exp_cat == -1) | ///
                                     (interest_exp_cat == 0 & inflation_exp_cat == 0)

* 5.2 Robustness Consistency (50% threshold)
gen phillips_consistent_robustness = 0
replace phillips_consistent_robustness = 1 if (inflation_exp_cat_robustness == 1 & unemp_exp_cat_robustness == -1) | ///
                                              (inflation_exp_cat_robustness == -1 & unemp_exp_cat_robustness == 1) | ///
                                              (inflation_exp_cat_robustness == 0 & unemp_exp_cat_robustness == 0)

gen taylor_consistent_strict_robust = 0 
replace taylor_consistent_strict_robust = 1 if (interest_exp_cat_robustness == 1 & inflation_exp_cat_robustness == 1 & unemp_exp_cat_robustness == -1) | ///
                                               (interest_exp_cat_robustness == -1 & inflation_exp_cat_robustness == -1 & unemp_exp_cat_robustness == 1) | ///
                                               (interest_exp_cat_robustness == 0 & inflation_exp_cat_robustness == 0 & unemp_exp_cat_robustness == 0)

gen taylor_consistent_ecb_robust = 0 
replace taylor_consistent_ecb_robust = 1 if (interest_exp_cat_robustness == 1 & inflation_exp_cat_robustness == 1) | ///
                                            (interest_exp_cat_robustness == -1 & inflation_exp_cat_robustness == -1) | ///
                                            (interest_exp_cat_robustness == 0 & inflation_exp_cat_robustness == 0)

* 5.3 Event Dummy Variables (Sender Channel)
gen ecb_2020_12_10 = (survey_date >= date("2020-12-10", "YMD"))
gen ecb_2021_03_11 = (survey_date >= date("2021-03-11", "YMD"))
gen ecb_2022_06_09 = (survey_date >= date("2022-06-09", "YMD"))
gen ecb_2022_07_21 = (survey_date >= date("2022-07-21", "YMD"))
gen ecb_2022_09_08 = (survey_date >= date("2022-09-08", "YMD"))
gen ecb_2022_12_15 = (survey_date >= date("2022-12-15", "YMD"))
gen ecb_2023_02_02 = (survey_date >= date("2023-02-02", "YMD"))
gen ecb_2023_03_16 = (survey_date >= date("2023-03-16", "YMD"))
gen ecb_2023_06_15 = (survey_date >= date("2023-06-15", "YMD"))
gen ecb_2023_09_14 = (survey_date >= date("2023-09-14", "YMD"))
gen ecb_2023_12_14 = (survey_date >= date("2023-12-14", "YMD"))
gen ecb_2024_06_06 = (survey_date >= date("2024-06-06", "YMD"))
gen ecb_2024_09_12 = (survey_date >= date("2024-09-12", "YMD"))
gen ecb_2024_10_17 = (survey_date >= date("2024-10-17", "YMD"))

label define ecb_lbl 0 "ECB Off" 1 "ECB On"
label values ecb_2020_12_10 ecb_lbl
label values ecb_2021_03_11 ecb_lbl
label values ecb_2022_06_09 ecb_lbl
label values ecb_2022_09_08 ecb_lbl
label values ecb_2023_03_16 ecb_lbl
label values ecb_2024_06_06 ecb_lbl

* 5.4 Receiver Channel Categorization
gen heard_news = 0
replace heard_news = 1 if h2020_1 == 1 | h2020_2 == 1 | h2020_3 == 1 | h2020_4 == 1 | h2020_5 == 1 | h2020_6 == 1

gen exposure_to_ecb_news = 0
* Indirect exposure from TV, newspaper
replace exposure_to_ecb_news = 1 if h2020_1 == 1 | h2020_2 == 1 | h2020_5 == 1 | h2020_6 == 1
* Direct exposure from ECB official channels
replace exposure_to_ecb_news = 2 if h2020_3 == 1 | h2020_4 == 1

save "ces_cleaned_ready_for_analysis.dta", replace