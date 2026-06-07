cd "D:\VGU\GFE\THESIS\Data"
*IMPORT CSV CES DATA (FROM 2020 - the end of 2024)
* Import the CSV
import delimited "ecb.CES_data_2020_monthly.csv", clear
gen year = 2020
save ces_2020.dta, replace
*2021
import delimited "ecb.CES_data_2021_monthly.csv", clear
gen year = 2021
save ces_2021.dta, replace
*2022
import delimited "ecb.CES_data_2022_monthly.csv", clear
gen year = 2022
save ces_2022.dta, replace
*2023
import delimited "ecb.CES_data_2023_monthly.csv", clear
gen year = 2023
save ces_2023.dta, replace
*2024
import delimited "ecb.CES_data_2024_monthly.csv", clear
gen year = 2024
save ces_2024.dta, replace
**Check the consistency:
use ces_2020.dta, clear
describe
use ces_2021.dta, clear
describe
*merge the data:

use ces_2020.dta, clear
count

append using ces_2021.dta
append using ces_2022.dta
append using ces_2023.dta
append using ces_2024.dta

save ces_2020_2024_master.dta, replace
***********************************************************************PROCESSING DATA*******************************************
*Rename all variables:
* Background and Technical Variables
rename a0010 respondent_id
rename a0020 country
rename a0030 wave
rename a1010_age_prec age_group
rename b7040_quintile income_quintile
rename wgt weight
save ces_2020_2024_master.dta, replace
*create the collumns for dates:
* Step 1: Generate start_date and end_date as string variables initially
gen start_date_str = ""
gen end_date_str = ""
* Step 2: Assign date ranges based on wave
replace start_date_str = "2/4/2020" if wave == 4
replace end_date_str = "6/5/2020" if wave == 4

replace start_date_str = "7/5/2020" if wave == 5
replace end_date_str = "3/6/2021" if wave == 5  // Assuming 3/6/2020 is a typo; likely 3/6/2021

replace start_date_str = "4/6/2020" if wave == 6
replace end_date_str = "1/7/2020" if wave == 6  // Another potential typo; likely 1/7/2021

replace start_date_str = "2/7/2020" if wave == 7
replace end_date_str = "5/8/2020" if wave == 7  // Likely 2/7/2021 – 5/8/2021

replace start_date_str = "6/8/2020" if wave == 8
replace end_date_str = "2/9/2020" if wave == 8  // Likely 6/8/2021 – 2/9/2021

replace start_date_str = "3/9/2020" if wave == 9
replace end_date_str = "30/9/2020" if wave == 9  // Likely 3/9/2021 – 30/9/2021

replace start_date_str = "1/10/2020" if wave == 10
replace end_date_str = "4/11/2020" if wave == 10  // Likely 1/10/2021 – 4/11/2021

replace start_date_str = "5/11/2020" if wave == 11
replace end_date_str = "2/12/2020" if wave == 11  // Likely 5/11/2021 – 2/12/2021

replace start_date_str = "3/12/2020" if wave == 12
replace end_date_str = "6/1/2021" if wave == 12  // Likely 3/12/2021 – 6/1/2022

replace start_date_str = "7/1/2021" if wave == 13
replace end_date_str = "3/2/2021" if wave == 13  // Likely 7/1/2022 – 3/2/2022

replace start_date_str = "4/2/2021" if wave == 14
replace end_date_str = "3/3/2021" if wave == 14  // Likely 4/2/2022 – 3/3/2022

replace start_date_str = "4/3/2021" if wave == 15
replace end_date_str = "31/3/2021" if wave == 15  // Likely 4/3/2022 – 31/3/2022

replace start_date_str = "1/4/2021" if wave == 16
replace end_date_str = "5/5/2021" if wave == 16  // Likely 1/4/2022 – 5/5/2022

replace start_date_str = "6/5/2021" if wave == 17
replace end_date_str = "2/6/2021" if wave == 17  // Likely 6/5/2022 – 2/6/2022

replace start_date_str = "3/6/2021" if wave == 18
replace end_date_str = "30/6/2021" if wave == 18  // Likely 3/6/2022 – 30/6/2022

replace start_date_str = "1/7/2021" if wave == 19
replace end_date_str = "4/8/2021" if wave == 19  // Likely 1/7/2022 – 4/8/2022

replace start_date_str = "5/8/2021" if wave == 20
replace end_date_str = "1/9/2021" if wave == 20  // Likely 5/8/2022 – 1/9/2022

replace start_date_str = "2/9/2021" if wave == 21
replace end_date_str = "6/10/2021" if wave == 21  // Likely 2/9/2022 – 6/10/2022

replace start_date_str = "7/10/2021" if wave == 22
replace end_date_str = "3/11/2021" if wave == 22  // Likely 7/10/2022 – 3/11/2022

replace start_date_str = "4/11/2021" if wave == 23
replace end_date_str = "1/12/2021" if wave == 23  // Likely 4/11/2022 – 1/12/2022

replace start_date_str = "2/12/2021" if wave == 24
replace end_date_str = "5/1/2022" if wave == 24  // Correct as-is

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
replace end_date_str = "31/1/2024" if wave == 49  // Typo; likely 1/2/2024 – 29/2/2024 (assuming February)

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
*Convert string dates to Stata date format (numeric, days since 1/1/1960)
gen start_date = date(start_date_str, "DMY")
gen end_date = date(end_date_str, "DMY")
*Format the new variables as dates for readability
format start_date %td
format end_date %td
*Label the new variables
label variable start_date "Survey Start Date"
label variable end_date "Survey End Date"
*Drop temporary string variables
drop start_date_str end_date_str
*Verify the results
list wave start_date end_date in 1/10
*Create monthdate for that:
label variable year "Survey Year (Based on End Date)"
gen day_num = day(end_date)
gen month_num = month(end_date)
* Step 3: Convert month number to three-letter month abbreviation
gen month_abbr = ""
replace month_abbr = "jan" if month_num == 1
replace month_abbr = "feb" if month_num == 2
replace month_abbr = "mar" if month_num == 3
replace month_abbr = "apr" if month_num == 4
replace month_abbr = "may" if month_num == 5
replace month_abbr = "jun" if month_num == 6
replace month_abbr = "jul" if month_num == 7
replace month_abbr = "aug" if month_num == 8
replace month_abbr = "sep" if month_num == 9
replace month_abbr = "oct" if month_num == 10
replace month_abbr = "nov" if month_num == 11
replace month_abbr = "dec" if month_num == 12
* Step 4: Format day as two-digit number and combine with month abbreviation
gen month_date = string(day_num, "%02.0f") + month_abbr
label variable month_date "Month-Date (Based on End Date, DDmon)"
* Step 5: Drop temporary variables
drop day_num month_num month_abbr
* Step 6: Verify the results
list wave end_date month_date in 1/10
list wave end_date month_date if wave >= 58 in 1/10
save ces_2020_2024_master.dta, replace
*Generate the now:
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
gen month_date_ces = mofd(survey_date)
format month_date_ces %tm
gen month_year_str = string(year(survey_date)) + string(month(survey_date), "%02.0f")
* Step 7: Categorize unemployment expectations (C4031 vs C4030)
/* Step: Calculate percent change in expected unemployment rate
gen unemp_change_pct = (c4031 - c4030) / c4030 * 100 if c4031 != . & c4030 != .
*/
/*Step: Categorize expectations based on ±20% threshold
gen unemp_exp_cat = .
replace unemp_exp_cat = 1 if unemp_change_pct > 20 & unemp_change_pct != .       // More
replace unemp_exp_cat = -1 if unemp_change_pct < -20 & unemp_change_pct != .     // Less
replace unemp_exp_cat = 0 if unemp_change_pct >= -20 & unemp_change_pct <= 20 & unemp_change_pct != .   // Same
* Step: Label categories
label define unemp_exp_cat_label -1 "Less" 0 "Same" 1 "More"
label values unemp_exp_cat unemp_exp_cat_label
keep if inlist(country, "BE", "DE", "ES", "FR", "IT", "NL")

*Visualize the unemployment:

* Step 1: Define and assign education labels
label define education_lbl2 1 "Low Educated" 2 "Medium Educated" 3 "High Educated"
label values education education_lbl2

* Step 2: Define and assign expectation labels
label define unemp_exp_cat_label -1 "Less" 0 "Same" 1 "More"
label values unemp_exp_cat unemp_exp_cat_label

* Step 3: Draw grouped bar chart
graph bar (count), over(unemp_exp_cat, label(angle(0))) over(education, label(angle(0))) ///
    bar(1, color(blue)) ///
    ytitle("Number of Respondents") ///
    title("Unemployment Expectations (based on Perceived Current Unemployment Rate)") ///
    legend(off)

*/
*Verify the remaining countries and wave range
tab country
summarize wave
save "ces_with_rates.dta", replace
************************************************************************************
*MERGE DATA SET WITH MORTGAGE RATE:
* Clear memory and set up
clear all
set more off
*Import the interest rate data/interest rate:
import excel "interest rate.xlsx", firstrow clear
describe
list DATE TIMEPERIOD in 1/5
destring DATE, replace force
* Convert Excel serial date to Stata daily date (base: January 1, 1960)
gen stata_date = DATE - 21916
* Convert to Stata monthly date
gen month_date_ces = mofd(stata_date)
format month_date_ces %tm
list month_date_ces in 1/5
* Drop unnecessary variables
drop stata_date DATE TIMEPERIOD
* Manually correct month_date_ces by adding 720 (shift from 1960 to 2020)
replace month_date_ces = month_date_ces + 720
* Verify the corrected month_date_ces values
list month_date_ces in 1/5
list Germany France Italy Spain Netherlands Belgium in 1/5
rename (Germany France Italy Spain Netherlands Belgium) (rate_Germany rate_France rate_Italy rate_Spain rate_Netherlands rate_Belgium)
reshape long rate_, i(month_date_ces) j(country) string
* Rename the reshaped variable to current_rate and standardize country codes
rename rate_ current_rate
replace country = "BE" if country == "Belgium"
replace country = "DE" if country == "Germany"
replace country = "ES" if country == "Spain"
replace country = "FR" if country == "France"
replace country = "IT" if country == "Italy"
replace country = "NL" if country == "Netherlands"
*Calculate to the nearest integer:
* Convert the period "2019m1" format into a Stata monthly date
* Check variable type (optional, for confirmation)
* Rename it to 'month' for clarity
gen month = month_date_ces
format month %tm
* Create numeric panel identifier from string country
egen country_id = group(country)
* Declare panel data with numeric ID
tsset country_id month
* Calculate 12-month rolling average (including current month)
rangestat (mean) rate_12mo_avg = current_rate, interval(month -11 0) by(country)
* Drop older data if you only want results from 2020 onward
gen year = yofd(dofm(month))
keep if year >= 2020
gen rate_12mo_avg_rounded = round(rate_12mo_avg)
* Keep only necessary variables and save the reshaped data
keep country month_date_ces rate_12mo_avg_rounded
save "current_mortgage_rates.dta", replace
* Load the filtered CES data
use "ces_with_rates.dta", clear
* Merge with the reshaped interest rate data using country and month_date_ces
merge m:1 country month_date_ces using "current_mortgage_rates.dta"
keep if _merge == 3
drop _merge
* Verify the merge
tab country
summarize wave
* Save the merged dataset
save "ces_with_rates.dta", replace
*****************************************************************************************
*MERGE DATA SET WITH INFLATION DATA:
* Clear memory and set up
clear all
set more off
* Load the inflation data
use "cpi_final.dta", clear
* Verify the range of month_year_str and country in the inflation data
tab month_year_str
* Save the inflation data (in case we need to modify it)
save "cpi_final.dta", replace
* Load the CES data with current rates
use "ces_with_rates.dta", clear
* Verify the variables and range of month_year_str and country in the CES data
describe
* Drop the month_date variable (if it exists)
capture confirm variable month_date
if !_rc {
    drop month_date
    display "Dropped month_date variable from CES data"
}
* Verify the range of month_year_str and country in the CES data
tab month_year_str
tab country
* Merge the CES data with the inflation data using country and month_year_str
merge m:1 country month_year_str using "cpi_final.dta"
* Check merge results
tab _merge
* Keep only matched observations
keep if _merge == 3
drop _merge
* Verify the merge
tab country
summarize wave
* Recreate month_date from month_year_str in the merged dataset
* Extract year and month from month_year_str
gen year_1 = real(substr(month_year_str, 1, 4))
gen month = real(substr(month_year_str, 5, 2))
* Convert to Stata monthly date (base: 1960m1 = 0)
drop month_date
gen month_date = (year_1 - 1960) * 12 + month - 1
format month_date %tm
* Verify the recreated month_date
tab month_date
* Verify the merge
tab country
summarize wave
* Step 16: Save the final merged dataset
save "ces_with_rates_inflation.dta", replace
****************************************************************************************************************
*VARIABLES CONSTRUCTION: EXPECTED INTEREST RATE + EXPECTED INFLATION + EXPECTED UNEMPLOYMENT
****************************************************************************************************************
*EXPECTED INFLATION:
clear all
set more off
*Categorize interest rate expectations (C5111/C5113)
use "ces_with_rates_inflation.dta", clear
gen percent_change = (c1120 - inflation_avg12) / inflation_avg12 * 100 if c1120 != . & inflation_avg12 != .
gen inflation_exp_cat = .
replace inflation_exp_cat = 1 if percent_change > 20 & percent_change != .         // Up
replace inflation_exp_cat = -1 if percent_change < -20 & percent_change != .       // Down
replace inflation_exp_cat = 0 if percent_change >= -20 & percent_change <= 20 & percent_change != .   // Same
replace inflation_exp_cat = 0 if c1110 == 5 & c1110 != .    // Same (qualitative override)
label define inflation_exp_cat_label -1 "Down" 0 "Same" 1 "Up"
label values inflation_exp_cat inflation_exp_cat_label
****************************************************************************************************************
*EXPECTED INTEREST RATE (Using mortgage rate as proxy)
*Categorize interest rate expectations (C5111/C5113)
* Create expected_rate by combining C5111 and C5113 based on wave
gen expected_interest_rate = .
replace expected_interest_rate = c5111 if wave >= 4 & wave <= 29 & c5111 != .  // Waves 4 to 29 (April 2020 to May 2022)
replace expected_interest_rate = c5113 if wave >= 30 & c5113 != .  // Waves 30 to 62 (June 2022 to February 2025)
gen interest_change_pct = (expected_interest_rate - rate_12mo_avg) / rate_12mo_avg * 100 if expected_interest_rate != . & rate_12mo_avg != .
gen interest_exp_cat = .
replace interest_exp_cat = 1 if interest_change_pct > 20 & interest_change_pct != .         // Up
replace interest_exp_cat = -1 if interest_change_pct < -20 & interest_change_pct != .       // Down
replace interest_exp_cat = 0 if interest_change_pct >= -20 & interest_change_pct <= 20 & interest_change_pct != .   // Same
* Step: Label values for interpretation
label define interest_exp_cat_label -1 "Down" 0 "Same" 1 "Up"
label values interest_exp_cat interest_exp_cat_label
save "ces_taylor_phillips.dta", replace
******************************************************************************************************************
* EXPECTED UNEMPLOYMENT:
*Merge with the data of unemployment:
use "ces_taylor_phillips.dta", clear
gen mdate = month_date
format mdate %tm
merge m:1 country mdate using "all_unemp_gaps_1.dta"
save "ces_taylor_phillips.dta", replace
** Now we can do the second comparision:
**Now we reconstruct the variable: Unemployment expectation:
drop unemp_change_pct  
drop unemp_exp_cat
* Step 1: Calculate percent difference relative to 12-month average
gen unemp_change_pct = (c4031 - avg_unemp_12) / avg_unemp_12 * 100 if c4031 != . & avg_unemp_12 != .
* Step 2: Categorize based on ±20% threshold
gen unemp_exp_cat = .
replace unemp_exp_cat = 1 if unemp_change_pct > 20 & unemp_change_pct != .        // Expecting more
replace unemp_exp_cat = -1 if unemp_change_pct < -20 & unemp_change_pct != .      // Expecting less
replace unemp_exp_cat = 0 if inrange(unemp_change_pct, -20, 20) & unemp_change_pct != .  // Expecting same
save "ces_taylor_phillips.dta", replace
*************************************************************************************************************
*Assess Phillips Curve consistency (using the full sample)
gen phillips_consistent = 0
replace phillips_consistent = 1 if inflation_exp_cat == 1 & unemp_exp_cat == -1
replace phillips_consistent = 1 if inflation_exp_cat == -1  & unemp_exp_cat == 1
replace phillips_consistent = 1 if inflation_exp_cat == 0 & unemp_exp_cat == 0
*  Summarize Phillips Curve consistency (full sample)
tab phillips_consistent
save "ces_taylor_phillips.dta", replace

* Visualize Phillips Curve consistency for each country
use "ces_taylor_phillips.dta", clear

* Convert A0020 (string) to a numeric variable with labels
encode country, gen(country_num)

* Define the label for the numeric country variable (alphabetical order, excluding Greece and Austria)
label define country_label ///
    1 "Belgium" ///      (BE)
    2 "Germany" ///      (DE)
    3 "Spain" ///        (ES)
    4 "France" ///       (FR)
    5 "Italy" ///        (IT)
    6 "Netherlands" //  (NL)
label values country_num country_label

* Compute proportions of consistent households by country and wave for Phillips Curve
collapse (mean) phillips_consistent, by(country_num month_date country)

* Check the data after collapse to ensure all countries are present
tab country_num

* Set the time variable for time-series plotting
tsset country_num month_date, monthly

* Generate graphs for Phillips Curve consistency for each country
levelsof country_num, local(countries)

* Loop through each country to create separate graphs
foreach country in `countries' {
    local country_label : label country_label `country'
    tsline phillips_consistent if country_num == `country', ///
        title("Phillips Curve Consistency - `country_label'") ///
        ytitle("Proportion Consistent") xtitle("Time") ///
        ylabel(0(0.1)1) yscale(range(0 1)) ///
        name(phillips_`country', replace)
}
* Graph 1: Combined graph with separate panels for each country (Phillips Curve)
tsline phillips_consistent, by(country_num, title("Phillips Curve Consistency by Country") rows(2)) ///
    ytitle("Proportion Consistent") xtitle("Time") ///
    ylabel(0(0.05)0.3, nogrid labsize(small)) yscale(range(0 0.3)) ///
    xlabel(720(12)781, angle(45) format(%tmCY) labsize(small)) ///
    lwidth(medium) lcolor(navy) ///
    name(phillips_all, replace)
	
	
tsline phillips_consistent, by(country_num, title("Phillips Curve Consistency by Country") rows(2)) /// 
    ytitle("Proportion Consistent") xtitle("Time") ///
    ylabel(0.05 0.3 0.5, nogrid labsize(small)) yscale(range(0 0.5)) ///
    xlabel(720(12)781, angle(45) format(%tmCY) labsize(small)) ///
    lwidth(medium) lcolor(navy) ///
    name(phillips_all, replace)

******** graph the graph according to the high-low educated households:
// Load your dataset
use "ces_taylor_phillips.dta", clear
// Generate a numeric respondent ID
gen resp_id_num = _n
// Set panel data
xtset resp_id_num wave
// Define education groups
gen educ_group = .
replace educ_group = 1 if education == 1              // Low: Lower secondary or less
replace educ_group = 2 if education == 2              // Medium: Higher secondary
replace educ_group = 3 if education == 3              // High: Tertiary
label define educ_label 1 "Low" 2 "Medium" 3 "High"
label values educ_group educ_label
drop if missing(educ_group)
*encode country, gen(country_num)
// Map wave to year_month
gen year_month = ym(2020, 1) + (wave - 4)
format year_month %tm
// Collapse by country, educ_group, and time
collapse (mean) phillips_consistent, by(country_num educ_group year_month)
// Reshape wide to overlay Low and High in same graph
reshape wide phillips_consistent, i(country_num year_month) j(educ_group)
// Create overlay plot per country
twoway ///
    (line phillips_consistent1 year_month, lcolor(navy) lwidth(med) lpattern(solid)) ///
    (line phillips_consistent2 year_month, lcolor(orange) lwidth(med) lpattern(dash)) ///
    (line phillips_consistent3 year_month, lcolor(red) lwidth(med) lpattern(dot)), ///
    by(country_num, title("Phillips Curve Consistency by Education and Country") ///
    note("Low = navy | Medium = orange | High = red") rows(3)) ///
    ytitle("") ///
    ylabel(, nogrid) ///
    xtitle("Time") ///
    xlabel(720(12)781, angle(45) format(%tmCY) labsize(small)) ///
    legend(order(1 "Low" 2 "Medium" 3 "High") size(small) position(6) ring(0)) ///
    name(phillips_3educ_lines, replace)
	
twoway /// 
    (line phillips_consistent1 year_month, lcolor(blue) lwidth(med) lpattern(solid)) /// 
    (line phillips_consistent3 year_month, lcolor(orange) lwidth(med) lpattern(solid)), /// 
    by(country_num, title("Phillips Curve Consistency by Education and Country") /// 
    note("Low = blue | High = orange") rows(3)) /// 
    ytitle("") /// 
    ylabel(, nogrid) /// 
    yscale(range(0.15 0.3)) /// 
    xtitle("Time") /// 
    xlabel(720(12)781, angle(45) format(%tmCY) labsize(small)) /// 
    legend(order(1 "Low" 3 "High") size(small) position(6) ring(0)) /// 
    name(phillips_3educ_lines, replace)

***************************Replicate table 2 - Lena Drager:
* Step 1: Load the dataset
use "ces_taylor_phillips.dta", clear

* Verify the countries in the dataset
tab country

* Step 2: Replicate Table 2 - Phillips Curve Consistency (Cross-tab of inflation_exp_cat and unemp_exp_cat)
* Full sample (April 2020 to February 2025, waves 4 to 62)
* Label the categories for readability
label define inflation_label 1 "Go up" 0 "Stay the same" -1 "Go down"
label define unemp_label 1 "More" 0 "About the same" -1 "Less"
label values inflation_exp_cat inflation_label
label values unemp_exp_cat unemp_label

* Create a cross-tabulation with frequencies and proportions
tab inflation_exp_cat unemp_exp_cat, matcell(freq) matrow(row) matcol(col)

* Calculate proportions
matrix prop = freq / r(N)
matrix list prop

* Generate a formatted table with percentages and frequencies
tab inflation_exp_cat unemp_exp_cat, cell freq

* Calculate totals for reporting
egen total = total(1) if !missing(inflation_exp_cat, unemp_exp_cat)
summarize total
local total = r(mean)
display "Total number of respondents: `total'"

************** Replicate table 3 - Taylor Rule - Lena Drager
* Step 3: Replicate Table 3 - Taylor Rule I: Interest rate and inflation expectations
* Restrict to post-ZLB period (waves 31 to 62, July 2022 to February 2025)
keep if wave >= 31

* Condition on consistent unemployment expectations (to match the paper)
gen unemp_consistent = (inflation_exp_cat == 1 & unemp_exp_cat == -1) | ///
                       (inflation_exp_cat == 0 & unemp_exp_cat == 0) | ///
                       (inflation_exp_cat == -1 & unemp_exp_cat == 1)
keep if unemp_consistent == 1

* Label the categories for readability
label define interest_label 1 "Go up" 0 "Stay the same" -1 "Go down"
label values interest_exp_cat interest_label

* Create a cross-tabulation with frequencies and proportions
tab interest_exp_cat inflation_exp_cat, matcell(freq) matrow(row) matcol(col)

* Calculate proportions
matrix prop = freq / r(N)
matrix list prop

* Generate a formatted table with percentages and frequencies
tab interest_exp_cat inflation_exp_cat, cell freq

* Calculate totals for reporting
/*egen total = total(1) if !missing(interest_exp_cat, inflation_exp_cat)
summarize total
local total = r(mean)
display "Total number of respondents: `total'"
*/

*/


*************************************************************************************************************
* Restrict sample to post-ZLB period for Taylor Rule analysis
use "ces_taylor_phillips.dta", clear
*keep if year(dofm(month_date)) >= 2022 & month(dofm(month_date)) >= 7  // Restrict to post-July 2022
gen taylor_consistent_strict = 0  // Strict alignment with Dräger et al.
gen taylor_consistent_ecb = 0     // ECB-adapted, focusing on inflation
* Primary conditions (strict, per Dräger et al.): Align interest rates with expected inflation AND unemployment
replace taylor_consistent_strict = 1 if interest_exp_cat == 1 & inflation_exp_cat == 1 & unemp_exp_cat == -1  // Rising rates, expected inflation up, unemployment down
replace taylor_consistent_strict = 1 if interest_exp_cat == -1 & inflation_exp_cat == -1 & unemp_exp_cat == 1  // Falling rates, expected inflation down, unemployment up
replace taylor_consistent_strict = 1 if interest_exp_cat == 0 & inflation_exp_cat == 0 & unemp_exp_cat == 0  // Constant rates, expected inflation same, unemployment same
* ECB-adapted conditions: Focus on expected inflation, unemployment secondary
replace taylor_consistent_ecb = 1 if interest_exp_cat == 1 & inflation_exp_cat == 1  // Rising rates, expected inflation up
replace taylor_consistent_ecb = 1 if interest_exp_cat == -1 & inflation_exp_cat == -1  // Falling rates, expected inflation down
replace taylor_consistent_ecb = 1 if interest_exp_cat == 0 & inflation_exp_cat == 0  // Constant rates, expected inflation same
* Step 9: Summarize Taylor Rule consistency (post-ZLB sample)
tab taylor_consistent_strict
tab taylor_consistent_ecb
*drop if missing(interest_change_pct)
save "ces_taylor_phillips.dta", replace
*/

**VISUALIZING GRAPH FOR TAYLOR CONSISTENCY:
use "ces_taylor_phillips.dta", clear
* Verify the countries in the dataset
tab country
drop if inrange(month_date, tm(2020m4), tm(2020m8))
* Check for missing taylor_consistent values by country
tab country if taylor_consistent_strict == ., missing
tab country if taylor_consistent_ecb == ., missing
* Convert A0020 (string) to a numeric variable with labels
encode country, gen(country_num)
* Define the label for the numeric country variable (specified order)
label define country_label ///
    1 "Belgium" ///      (BE)
    2 "Germany" ///      (DE)
    3 "Spain" ///        (ES)
    4 "France" ///       (FR)
    5 "Italy" ///        (IT)
    6 "Netherlands"     // (NL)
label values country_num country_label
* Compute proportions of consistent households by country and wave for Taylor Rule
collapse (mean) taylor_consistent_strict taylor_consistent_ecb, by(country_num month_date wave)

* Check the data after collapse to ensure all countries are present
tab country_num

* Set the time variable for time-series plotting (for separate panels)
tsset country_num month_date, monthly

/* Graph 1: Combined graph with separate panels for each country (Taylor Rule Strict)
tsline taylor_consistent_strict, ///
    by(country_num, title("Taylor Rule Consistency (Strict) by Country") rows(2)) ///
    ytitle("Proportion Consistent") xtitle("Time") ///
    ylabel(0(0.05)0.3, nogrid labsize(small)) ///
    yscale(range(0 0.3)) ///
    xlabel(720(12)781, angle(45) format(%tmCY) labsize(small)) ///
    lwidth(medium) lcolor(navy) ///
    name(taylor_strict_all, replace)
*/

gen zlb = inrange(month_date, tm(2020m3), tm(2022m12))
gen ZLB_upper = 0.3 if zlb
gen ZLB_lower = 0 if zlb


twoway ///
    (rarea ZLB_upper ZLB_lower month_date if zlb, color(gs14)) ///
    (line taylor_consistent_strict month_date, lcolor(navy) lwidth(medium)), ///
    by(country_num, title("Taylor Rule Consistency (Strict) by Country") rows(2)) ///
    ytitle("Proportion Consistent") xtitle("Time") ///
    ylabel(0(0.05)0.3, labsize(small) nogrid) ///
    xlabel(720(12)781, angle(45) format(%tmCY) labsize(small)) ///
    yscale(range(0 0.3)) ///
    name(taylor_strict_all_zlb, replace)
	
*VISUALIZING GRAPH FOR EDUCATION and TAYLOR RULE:

use "ces_taylor_phillips.dta", clear
// Load your dataset
encode country, gen(country_num)
drop if inrange(month_date, tm(2020m4), tm(2020m8))
// Define country labels
label define country_label ///
    1 "Belgium (BE)" ///
    2 "Germany (DE)" ///
    3 "Spain (ES)" ///
    4 "France (FR)" ///
    5 "Italy (IT)" ///
    6 "Netherlands (NL)"
label values country_num country_label
// Define 3 education groups
gen educ_group = .
replace educ_group = 1 if education == 1    // Low
replace educ_group = 2 if education == 2    // Medium
replace educ_group = 3 if education == 3    // High
label define educ_label 1 "Low" 2 "Medium" 3 "High"
label values educ_group educ_label
drop if missing(educ_group)
// Map wave to month_date (assuming wave 4 = Jan 2020)
*gen month_date = ym(2020, 1) + (wave - 4)
*format month_date %tm
// Create ZLB period
gen zlb = inrange(month_date, tm(2020m3), tm(2022m12))
gen ZLB_upper = 0.3 if zlb
gen ZLB_lower = 0 if zlb
// Collapse to mean Taylor rule consistency by country, education group, and time
collapse (mean) taylor_consistent_strict, by(country_num educ_group month_date)
// Reshape wide for plotting multiple lines
reshape wide taylor_consistent_strict, i(country_num month_date) j(educ_group)
// Plot with ZLB shading and 3 education levels
twoway ///
    (rarea ZLB_upper ZLB_lower month_date if zlb, color(gs14)) ///
    (line taylor_consistent_strict1 month_date, lcolor(navy) lwidth(med) lpattern(solid)) ///
    (line taylor_consistent_strict2 month_date, lcolor(orange) lwidth(med) lpattern(dash)) ///
    (line taylor_consistent_strict3 month_date, lcolor(red) lwidth(med) lpattern(dot)), ///
    by(country_num, title("Taylor Rule Consistency (Strict) by Education and Country") ///
    note("Low = solid navy | Medium = dashed orange | High = dotted red") rows(3)) ///
    ytitle("Proportion Consistent") xtitle("Time") ///
    ylabel(0 0.3, labsize(small) nogrid) /// Changed to show only 0 and 0.3
    yscale(range(0 0.3)) ///
    xlabel(720(12)781, angle(45) format(%tmCY) labsize(small)) ///
    legend(order(2 "Low" 3 "Medium" 4 "High") size(small) position(6) ring(0)) ///
    name(taylor_strict_educ_overlay, replace)
twoway ///
    (rarea ZLB_upper ZLB_lower month_date if zlb, color(gs14)) ///
    (line taylor_consistent_strict1 month_date, lcolor(navy) lwidth(med) lpattern(solid)) ///
    (line taylor_consistent_strict3 month_date, lcolor(orange) lwidth(med) lpattern(solid)), ///
    by(country_num, title("Taylor Rule Consistency (Strict) by Education and Country") ///
    note("Low = solid navy | High = solid orange | Y-axis zoomed for clarity") rows(3)) ///
    ytitle("") ///
    ylabel(, nogrid) ///
    yscale(range(0.19 0.21)) ///
    xtitle("Time") ///
    xlabel(720(12)781, angle(45) format(%tmCY) labsize(small)) ///
    legend(order(2 "Low" 3 "High") size(small) position(6) ring(0)) ///
    name(taylor_strict_educ_overlay, replace)

tsline taylor_consistent_ecb, by(country_num, title("Taylor Rule Consistency (ECB-Adapted) by Country") rows(2) norescale) ///
    ytitle("Proportion Consistent") xtitle("Time") ///
    ylabel(0 0.05 0.10 0.15 0.20 0.25 0.30, nogrid labsize(small) angle(horizontal)) yscale(range(0 0.35) noline) ///
    xlabel(751(12)781, format(%tmCY) angle(45) labsize(small) noticks) xscale(noline) ///
    lwidth(medium) lcolor(navy) ///
    plotregion(margin(small)) ///
    name(taylor_ecb_all, replace)
	
gen zlb_new = inrange(month_date, tm(2020m3), tm(2022m12))
gen ZLB_upper_ECB = 0.65 if zlb
gen ZLB_lower_ECB = 0 if zlb

* Plot Taylor Rule Consistency with shaded ZLB period
twoway ///
    (rarea ZLB_upper_ECB ZLB_lower_ECB month_date if zlb_new, color(gs14)) ///
    (line taylor_consistent_ecb month_date, lcolor(navy) lwidth(medium)), ///
    by(country_num, title("Taylor Rule Consistency (ECB-Adapted) by Country") rows(2)) ///
    ytitle("Proportion Consistent") xtitle("Time") ///
    ylabel(0(0.05)0.5, labsize(small) angle(horizontal) nogrid) ///
    yscale(range(0 0.35) noline) ///
    xlabel(720(12)781, format(%tmCY) angle(45) labsize(small) noticks) ///
    xscale(noline) ///
    plotregion(margin(small)) ///
    name(taylor_ecb_all_zlb, replace)

	
*Graph with educated people:
use "ces_taylor_phillips.dta", clear

encode country, gen(country_num)
drop if inrange(month_date, tm(2020m4), tm(2020m8))
// Define country labels
label define country_label ///
    1 "Belgium (BE)" ///
    2 "Germany (DE)" ///
    3 "Spain (ES)" ///
    4 "France (FR)" ///
    5 "Italy (IT)" ///
    6 "Netherlands (NL)"
label values country_num country_label

// Define 3 education groups
gen educ_group = .
replace educ_group = 1 if education == 1    // Low
replace educ_group = 2 if education == 2    // Medium
replace educ_group = 3 if education == 3    // High
label define educ_label 1 "Low" 2 "Medium" 3 "High"
label values educ_group educ_label
drop if missing(educ_group)

// Map wave to month_date (assuming wave 4 = Jan 2020)
gen month_date = ym(2020, 1) + (wave - 4)
format month_date %tm

// Create ZLB period
gen zlb = inrange(month_date, tm(2020m3), tm(2022m12))
gen ZLB_upper = 0.7 if zlb
gen ZLB_lower = 0 if zlb

// Collapse to mean Taylor rule consistency by country, education group, and time
collapse (mean) taylor_consistent_ecb, by(country_num educ_group month_date)

// Reshape wide for plotting multiple lines
reshape wide taylor_consistent_ecb, i(country_num month_date) j(educ_group)

// Plot with ZLB shading and 3 education levels
twoway ///
    (rarea ZLB_upper ZLB_lower month_date if zlb, color(gs14)) ///
    (line taylor_consistent_ecb1 month_date, lcolor(navy) lwidth(med) lpattern(solid)) ///
    (line taylor_consistent_ecb3 month_date, lcolor(orange) lwidth(med) lpattern(solid)), ///
    by(country_num, title("Taylor Rule Consistency (ECB-Adapted) by Education") ///
    note("Low = solid navy | High = solid orange") rows(3)) ///
    ytitle("Proportion Consistent") xtitle("Time") ///
    ylabel(0 0.5, labsize(small) nogrid) ///
    yscale(range(0 0.5)) ///
    xlabel(#8, format(%tmCY) angle(45) labsize(small)) ///
    legend(order(2 "Low" 3 "High") size(small) position(6) ring(0)) ///
    name(taylor_strict_educ_overlay, replace)


save "ces_taylor_phillips.dta", replace
*************** Replicate table 3:


/*
* Step 1: Generate Table 3 - Taylor Rule I: Interest rate and inflation expectations (ECB-Adapted, Full Distribution)
use "ces_taylor_phillips.dta", clear

* Restrict to post-ZLB period (waves 31 to 62, July 2022 to February 2025)
*keep if wave >= 31

* Label the categories for readability
label define interest_label 1 "Go up" 0 "Stay the same" -1 "Go down"
label define inflation_label 1 "Go up" 0 "Stay the same" -1 "Go down"
label values interest_exp_cat interest_label
label values inflation_exp_cat inflation_label

* Create a cross-tabulation with frequencies and proportions (full distribution)
tab interest_exp_cat inflation_exp_cat, matcell(freq) matrow(row) matcol(col)

* Calculate proportions
matrix prop = freq / r(N)
matrix list prop

* Generate a formatted table with percentages and frequencies
tab interest_exp_cat inflation_exp_cat, cell freq

* Calculate total number of respondents directly
count if !missing(interest_exp_cat, inflation_exp_cat)
local total = r(N)
display "Total number of respondents: `total'"

* Note: Manually highlight consistent combinations (Go down/Go down, Stay the same/Stay the same, Go up/Go up)

*Strict case:
* Step 1: Generate Table 3 - Taylor Rule I: Interest rate and inflation expectations (Strict Case, Full Distribution)
use "ces_taylor_phillips.dta", clear

* Restrict to post-ZLB period (waves 31 to 62, July 2022 to February 2025)
*keep if wave >= 31

* Condition on consistent unemployment expectations (to match the strict case methodology)
* Consistent combinations per the Taylor Rule:
* - Up inflation (1), Less unemployment (-1): Booming economy, expect higher interest rates
* - Same inflation (0), Same unemployment (0): Stable economy, expect stable interest rates
* - Down inflation (-1), More unemployment (1): Slowing economy, expect lower interest rates
gen unemp_consistent = (inflation_exp_cat == 1 & unemp_exp_cat == -1) | ///
                       (inflation_exp_cat == 0 & unemp_exp_cat == 0) | ///
                       (inflation_exp_cat == -1 & unemp_exp_cat == 1)
keep if unemp_consistent == 1

* Label the categories for readability
label define interest_label 1 "Go up" 0 "Stay the same" -1 "Go down"
label define inflation_label 1 "Go up" 0 "Stay the same" -1 "Go down"
label values interest_exp_cat interest_label
label values inflation_exp_cat inflation_label

* Create a cross-tabulation with frequencies and proportions (full distribution)
tab interest_exp_cat inflation_exp_cat, matcell(freq) matrow(row) matcol(col)

* Calculate proportions
matrix prop = freq / r(N)
matrix list prop

* Generate a formatted table with percentages and frequencies
tab interest_exp_cat inflation_exp_cat, cell freq

* Calculate total number of respondents directly
count if !missing(interest_exp_cat, inflation_exp_cat)
local total = r(N)
display "Total number of respondents: `total'"

* Note: Manually highlight consistent combinations (Go down/Go down, Stay the same/Stay the same, Go up/Go up)


// Load your dataset
use "ces_taylor_phillips.dta", clear

// Restrict to post-ZLB period (waves 31 to 62, July 2022 to February 2025)
*keep if wave >= 31

// Define strict Taylor Rule consistency with interest rate expectations
// Consistent combinations:
// - Expected inflation Up (1), expected interest rate Up (1), expected unemployment Less (-1)
// - Expected inflation Down (-1), expected interest rate Down (-1), expected unemployment More (1)
// - Expected inflation Same (0), expected interest rate Same (0), expected unemployment Same (0)
gen taylor_consistent_strict = ((inflation_exp_cat == 1 & interest_exp_cat == 1 & unemp_exp_cat == -1) | ///
                               (inflation_exp_cat == -1 & interest_exp_cat == -1 & unemp_exp_cat == 1) | ///
                               (inflation_exp_cat == 0 & interest_exp_cat == 0 & unemp_exp_cat == 0))
keep if taylor_consistent_strict == 1

// Label the categories for readability
label define interest_label 1 "Go up" 0 "Stay the same" -1 "Go down"
label define inflation_label 1 "Go up" 0 "Stay the same" -1 "Go down"
label values interest_exp_cat interest_label
label values inflation_exp_cat inflation_label

// Create a cross-tabulation with frequencies and proportions (full distribution)
tab interest_exp_cat inflation_exp_cat, matcell(freq) matrow(row) matcol(col)

// Calculate proportions
matrix prop = freq / r(N)
matrix list prop

// Generate a formatted table with percentages and frequencies
tab interest_exp_cat inflation_exp_cat, cell freq

// Calculate total number of respondents directly
count if !missing(interest_exp_cat, inflation_exp_cat)
local total = r(N)
display "Total number of respondents: `total'"


*Merge with the data of unemployment:
use "ces_taylor_phillips.dta", clear
gen mdate = month_date
format mdate %tm
merge m:1 country mdate using "all_unemp_gaps_1.dta"

save "ces_taylor_phillips.dta", replace
** Now we can do the second comparision:
**Now we reconstruct the variable: Unemployment expectation:
drop unemp_change_pct  
drop unemp_exp_cat
* Step 1: Calculate percent difference relative to 12-month average
gen unemp_change_pct = (c4031 - avg_unemp_12) / avg_unemp_12 * 100 if c4031 != . & avg_unemp_12 != .

* Step 2: Categorize based on ±20% threshold
gen unemp_exp_cat = .

replace unemp_exp_cat = 1 if unemp_change_pct > 20 & unemp_change_pct != .        // Expecting more
replace unemp_exp_cat = -1 if unemp_change_pct < -20 & unemp_change_pct != .      // Expecting less
replace unemp_exp_cat = 0 if inrange(unemp_change_pct, -20, 20) & unemp_change_pct != .  // Expecting same
save "ces_taylor_phillips.dta", replace
*/

*sau bước này thì chạy lại code từ phillip consistency and taylor consistency bình thường:

*-------------------------------------------------------------------------------------------------------------------
*RUNNING POOLED PROBIT REGRESSION FOR SENDER CHANNEL - Replication of Professor Lena Drager:
*Now, im going to run the regression with pooled probit regession:
use "ces_taylor_phillips.dta", clear
format survey_date %td

* Pandemic-era expansionary announcements
gen ecb_2020_12_10 = (survey_date >= date("2020-12-10", "YMD"))
gen ecb_2021_03_11 = (survey_date >= date("2021-03-11", "YMD"))

* Contractionary post-Ukraine shock phase
gen ecb_2022_06_09 = (survey_date >= date("2022-06-09", "YMD"))
gen ecb_2022_07_21 = (survey_date >= date("2022-07-21", "YMD"))
gen ecb_2022_09_08 = (survey_date >= date("2022-09-08", "YMD"))
gen ecb_2022_12_15 = (survey_date >= date("2022-12-15", "YMD"))

* Key policy milestones in 2023
gen ecb_2023_02_02 = (survey_date >= date("2023-02-02", "YMD"))
gen ecb_2023_03_16 = (survey_date >= date("2023-03-16", "YMD"))
gen ecb_2023_06_15 = (survey_date >= date("2023-06-15", "YMD"))
gen ecb_2023_09_14 = (survey_date >= date("2023-09-14", "YMD"))
gen ecb_2023_12_14 = (survey_date >= date("2023-12-14", "YMD"))

* Assuming 'survey_date' is in Stata date format (%td)
gen ecb_2024_06_06 = (survey_date >= date("2024-06-06", "YMD"))
gen ecb_2024_09_12 = (survey_date >= date("2024-09-12", "YMD"))
gen ecb_2024_10_17 = (survey_date >= date("2024-10-17", "YMD"))
drop _merge
save "ces_taylor_phillips.dta", replace

**now, we have to merge with the background datas:
import delimited "D:\VGU\GFE\THESIS\Data\ecb.CES_data_background.en.csv", clear
rename a0010 respondent_id
tostring respondent_id, replace
save CES_background_clean.dta, replace

*-----------------------------------------------------------------------------------------------------------------
*MERGE WITH HOUSEHOLD CHARACTERISTICS:

use ces_taylor_phillips.dta, clear
tostring respondent_id, replace
merge m:1 respondent_id using CES_background_clean.dta
drop if _merge == 1  // keep only matched rows (from both datasets)
drop _merge
rename b2100_prec education
rename a1020_prec gender
drop a0020
save ces_taylor_phillips.dta, replace
*Now im gonna run regression:

*MERGE WITH MACRO ECONOMICS EVENTS:

use ces_taylor_phillips.dta, clear
merge m:1 month_date using brent_yoy_growth.dta
drop _merge
sort country
*rename month_date mdate
save ces_taylor_phillips.dta, replace
*--------------------------------------------------------------------------------------------------------------------
use ces_taylor_phillips.dta, clear
rename income_quintile income
encode country, gen(country_num)
save ces_taylor_phillips.dta, replace
*--------------------------------------------------------------------------------------------------------------------
* Phillips Curve Consistency
* Taylor Rule (Strict)
*corrected code without the interactions:
** Reconstruct the variable : education
gen education_new = .
replace education_new = 1 if inlist(education, 1, 2)
replace education_new = 2 if education == 3
replace education_new = education_new - 1
label define country_num 1 "Belgium" 2 "Germany" 3 "Spain" 4 "France" 5 "Italy" 6 "Netherlands", replace
tab country_num
label define edu 0 "Low Education" 1 "High Education"
label values education_new edu
save ces_taylor_phillips.dta, replace

* Phillips consistent
drop if inrange(month_date, tm(2020m4), tm(2020m8))
eststo pc_noint: probit phillips_consistent ///
    i.income i.age_group i.gender brent_yoy_growth unemp_gap cpi inflation_volatility ///
    i.ecb_2020_12_10 i.ecb_2021_03_11 i.ecb_2022_06_09 i.ecb_2022_09_08 i.ecb_2023_03_16 i.ecb_2024_06_06 ///
    ib2.country_num i.education_new, vce(robust)

eststo pc_int: probit phillips_consistent ///
    i.income i.age_group i.gender brent_yoy_growth unemp_gap cpi inflation_volatility ///
    ib2.country_num##(i.ecb_2020_12_10 i.ecb_2021_03_11 i.ecb_2022_06_09 i.ecb_2022_09_08 i.ecb_2023_03_16 i.ecb_2024_06_06) ///
    i.education_new, vce(robust)

eststo pc_int_interact: probit phillips_consistent ///
    i.income i.age_group i.gender brent_yoy_growth unemp_gap cpi inflation_volatility ///
    ib2.country_num##i.education_new##(i.ecb_2020_12_10 i.ecb_2021_03_11 i.ecb_2022_06_09 i.ecb_2022_09_08 i.ecb_2023_03_16 i.ecb_2024_06_06), vce(robust)

margins, dydx(*)
eststo pc_int_ame, title(Phillips Consistent AME)

* Taylor strict
eststo tr_strict_noint: probit taylor_consistent_strict ///
    i.income i.age_group i.gender brent_yoy_growth unemp_gap cpi inflation_volatility ///
    i.ecb_2020_12_10 i.ecb_2021_03_11 i.ecb_2022_06_09 i.ecb_2022_09_08 i.ecb_2023_03_16 i.ecb_2024_06_06 ///
    ib2.country_num i.education_new, vce(robust)

eststo tr_strict_int: probit taylor_consistent_strict ///
    i.income i.age_group i.gender brent_yoy_growth unemp_gap cpi inflation_volatility ///
    ib2.country_num##(i.ecb_2020_12_10 i.ecb_2021_03_11 i.ecb_2022_06_09 i.ecb_2022_09_08 i.ecb_2023_03_16 i.ecb_2024_06_06) ///
    i.education_new, vce(robust)

eststo tr_strict_int_interact: probit taylor_consistent_strict ///
    i.income i.age_group i.gender brent_yoy_growth unemp_gap cpi inflation_volatility ///
    ib2.country_num##i.education_new##(i.ecb_2020_12_10 i.ecb_2021_03_11 i.ecb_2022_06_09 i.ecb_2022_09_08 i.ecb_2023_03_16 i.ecb_2024_06_06), vce(robust)
margins, dydx(*)
eststo tr_strict_ame, title(Taylor Strict AME)

* Taylor ECB
eststo tr_ecb_noint: probit taylor_consistent_ecb ///
    i.income i.age_group i.gender brent_yoy_growth unemp_gap cpi inflation_volatility ///
    i.ecb_2020_12_10 i.ecb_2021_03_11 i.ecb_2022_06_09 i.ecb_2022_09_08 i.ecb_2023_03_16 i.ecb_2024_06_06 ///
    ib2.country_num i.education_new, vce(robust)

eststo tr_ecb_int: probit taylor_consistent_ecb ///
    i.income i.age_group i.gender brent_yoy_growth unemp_gap cpi inflation_volatility ///
    ib2.country_num##(i.ecb_2020_12_10 i.ecb_2021_03_11 i.ecb_2022_06_09 i.ecb_2022_09_08 i.ecb_2023_03_16 i.ecb_2024_06_06) ///
    i.education_new, vce(robust)

eststo tr_ecb_int_interact: probit taylor_consistent_ecb ///
    i.income i.age_group i.gender brent_yoy_growth unemp_gap cpi inflation_volatility ///
    ib2.country_num##i.education_new##(i.ecb_2020_12_10 i.ecb_2021_03_11 i.ecb_2022_06_09 i.ecb_2022_09_08 i.ecb_2023_03_16 i.ecb_2024_06_06), vce(robust)
margins, dydx(*)
eststo tr_ecb_ame, title(Taylor ECB AME)
	


*--------------------------------------------------------
* EXPORT REGRESSION TABLE WITH SELECTED VARIABLES (TRIPLE INTERACTION)
*--------------------------------------------------------

** export combined AME table:
esttab pc_int_ame tr_strict_ame tr_ecb_ame ///
    using ame_table.rtf, replace se label star(* 0.05 ** 0.01 *** 0.001) ///
    title("Average Marginal Effects for All Variables") ///
    compress


** Margin plot for triple interactions with ecb_2022_06_09 _phillip curve
	
/*Drawing Margin Plot for 6 events in the three biggest countries in Euroup: Germany, Italy, France
margins country_num#education_new#ecb_2020_12_10 if inlist(country_num,2,4,5)
marginsplot, xdimension(country_num) ///
    plot1opts(lpattern(solid) lcolor(blue)) ///   // 1 = Low edu, ECB off
    plot2opts(lpattern(solid) lcolor(green)) ///  // 2 = Low edu, ECB on
    plot3opts(lpattern(dash) lcolor(maroon)) ///  // 3 = High edu, ECB off
    plot4opts(lpattern(dash) lcolor(orange)) ///  // 4 = High edu, ECB on
    legend(order(1 "Low edu, ECB off" 2 "Low edu, ECB on" 3 "High edu, ECB off" 4 "High edu, ECB on")) ///
    xlabel(2 "DE" 4 "FR" 5 "IT") ///
    ytitle("Pr(phillips_consistent)") ///
    title("ecb_2020_12_10") ///
    name(plot_ecb_2020_12_10, replace)

*/

/*label define edu 0 "Low education" 1 "High education"
label values education_new edu
*/

label define ecb 0 "ECB Off" 1 "ECB On"
label values ecb_2020_12_10 ecb
label values ecb_2021_03_11 ecb
label values ecb_2022_06_09 ecb
label values ecb_2022_09_08 ecb
label values ecb_2023_03_16 ecb
label values ecb_2024_06_06 ecb

** EVENT: 2020_12_10

margins country_num#education_new#ecb_2020_12_10 if inlist(country_num,2,4,5)
marginsplot, ///
    xdimension(country_num) ///
    plotdim(education_new ecb_2020_12_10) ///
    xlabel(, valuelabel) ///
    plot1opts(lpattern(solid)) ///
    plot2opts(lpattern(solid)) ///
    plot3opts(lpattern(dash)) ///
    plot4opts(lpattern(dash)) ///
    title("ECB 2020-12-10") ///
    name(gr1, replace)
	
** EVENT: 2021_03_11

margins country_num#education_new#ecb_2021_03_11 if inlist(country_num,2,4,5)
marginsplot, ///
    xdimension(country_num) ///
    plotdim(education_new ecb_2021_03_11) ///
    xlabel(, valuelabel) ///
    plot1opts(lpattern(solid)) ///
    plot2opts(lpattern(solid)) ///
    plot3opts(lpattern(dash)) ///
    plot4opts(lpattern(dash)) ///
    title("ECB 2021-03-11") ///
    name(gr2, replace)

** EVENT: 2022_06_09
margins country_num#education_new#ecb_2022_06_09 if inlist(country_num,2,4,5)
marginsplot, ///
    xdimension(country_num) ///
    plotdim(education_new ecb_2022_06_09) ///
    xlabel(, valuelabel) ///
    plot1opts(lpattern(solid)) ///
    plot2opts(lpattern(solid)) ///
    plot3opts(lpattern(dash)) ///
    plot4opts(lpattern(dash)) ///
    title("ECB 2022-06-09") ///
    name(gr3, replace)
	
** EVENT: 2022_09_08

margins country_num#education_new#ecb_2022_09_08 if inlist(country_num,2,4,5)
marginsplot, ///
    xdimension(country_num) ///
    plotdim(education_new ecb_2022_09_08) ///
    xlabel(, valuelabel) ///
    plot1opts(lpattern(solid)) ///
    plot2opts(lpattern(solid)) ///
    plot3opts(lpattern(dash)) ///
    plot4opts(lpattern(dash)) ///
    title("ECB 2022-09-08") ///
    name(gr4, replace)

** EVENT: 2023_03_16

margins country_num#education_new#ecb_2023_03_16 if inlist(country_num,2,4,5)
marginsplot, ///
    xdimension(country_num) ///
    plotdim(education_new ecb_2023_03_16) ///
    xlabel(, valuelabel) ///
    plot1opts(lpattern(solid)) ///
    plot2opts(lpattern(solid)) ///
    plot3opts(lpattern(dash)) ///
    plot4opts(lpattern(dash)) ///
    title("ECB 2023-03-16") ///
    name(gr5, replace)
	
	
** EVENT: 2024-06-06

margins country_num#education_new#ecb_2024_06_06 if inlist(country_num,2,4,5)
marginsplot, ///
    xdimension(country_num) ///
    plotdim(education_new ecb_2024_06_06) ///
    xlabel(, valuelabel) ///
    plot1opts(lpattern(solid)) ///
    plot2opts(lpattern(solid)) ///
    plot3opts(lpattern(dash)) ///
    plot4opts(lpattern(dash)) ///
    title("ECB 2024-06-06") ///
    name(gr6, replace)
	
graph combine gr1 gr2 gr3 gr4 gr5 gr6, col(3) row(2) iscale(0.8) title("Marginal Effects by ECB Event _Philips Curve")

*Exporting files for philips curve:

graph display gr1
graph export "ECB_2020_12_10_phillips.png", as(png) width(2400) replace

graph display gr2
graph export "ECB_2021_03_11_phillips.png", as(png) width(2400) replace

graph display gr3
graph export "ECB_2022_06_09_phillips.png", as(png) width(2400) replace

graph display gr4
graph export "ECB_2022_09_08_phillips.png", as(png) width(2400) replace

graph display gr5
graph export "ECB_2023_03_16_phillips.png", as(png) width(2400) replace

graph display gr6
graph export "ECB_2024_06_06_phillips.png", as(png) width(2400) replace


*Exporting files for Taylor Rule Strict:
graph display gr1
graph export "ECB_2020_12_10_Taylor Rule_strict.png", as(png) width(2400) replace

graph display gr2
graph export "ECB_2021_03_11_Taylor Rule_strict.png", as(png) width(2400) replace

graph display gr3
graph export "ECB_2022_06_09_Taylor Rule_strict.png", as(png) width(2400) replace

graph display gr4
graph export "ECB_2022_09_08_Taylor Rule_strict.png", as(png) width(2400) replace

graph display gr5
graph export "ECB_2023_03_16_Taylor Rule_strict.png", as(png) width(2400) replace

graph display gr6
graph export "ECB_2024_06_06_Taylor Rule_strict.png", as(png) width(2400) replace

*Exporting files for Taylor Rule ECB Adapted:

graph display gr1
graph export "ECB_2020_12_10_Taylor Rule_ECB.png", as(png) width(2400) replace

graph display gr2
graph export "ECB_2021_03_11_Taylor Rule_ECB.png", as(png) width(2400) replace

graph display gr3
graph export "ECB_2022_06_09_Taylor Rule_ECB.png", as(png) width(2400) replace

graph display gr4
graph export "ECB_2022_09_08_Taylor Rule_ECB.png", as(png) width(2400) replace

graph display gr5
graph export "ECB_2023_03_16_Taylor Rule_ECB.png", as(png) width(2400) replace

graph display gr6
graph export "ECB_2024_06_06_Taylor Rule_ECB.png", as(png) width(2400) replace


***********************************************************************************************8
**PER- ANOUNCEMENT EFFECT (MR.BETHMAGE REPLICATION) - Sender Extension
* 1. Setup ECB meetings and countries
**************************************

use ces_taylor_phillips.dta, clear

local meetings 12mar2020 30apr2020 04jun2020 16jul2020 10sep2020 29oct2020 10dec2020 21jan2021 11mar2021 22apr2021 10jun2021 22jul2021 09sep2021 28oct2021 16dec2021 03feb2022 10mar2022 14apr2022 09jun2022 21jul2022 08sep2022 27oct2022 15dec2022 02feb2023 16mar2023 04may2023 15jun2023 27jul2023 14sep2023 26oct2023 14dec2023
local names    mar2020 apr2020 jun2020 jul2020 sep2020 oct2020 dec2020 jan2021 mar2021 apr2021 jun2021 jul2021 sep2021 oct2021 dec2021 feb2022 mar2022 apr2022 jun2022 jul2022 sep2022 oct2022 dec2022 feb2023 mar2023 may2023 jun2023 jul2023 sep2023 oct2023 dec2023
local countries "DE IT FR"

* Define categorical controls
local controls i.income i.age_group i.gender i.education

**************************************
* 2. Generate treatment dummies (±30d)
**************************************
local i = 1
foreach m of local meetings {
    local name : word `i' of `names'
    local meeting_date = date("`m'", "DMY")

    gen treat_`name' = .
    replace treat_`name' = 0 if start_date >= `meeting_date' - 30 & start_date < `meeting_date'
    replace treat_`name' = 1 if start_date > `meeting_date' & start_date <= `meeting_date' + 30
    drop if start_date == `meeting_date'

    local ++i
}

**************************************
* 3. Run Probit regressions + store results
**************************************
postfile results str10 country str10 meeting double coef double se double pval using "results_temp.dta", replace

local i = 1
foreach m of local meetings {
    local name : word `i' of `names'
    local meeting_date = date("`m'", "DMY")

    foreach c of local countries {
        display "▶ Running PROBIT for `c' during `name'..."

        capture noisily probit phillips_consistent treat_`name' `controls' ///
            if country == "`c'" & inrange(start_date, `meeting_date' - 30, `meeting_date' + 30)

        if _rc == 0 {
            matrix b = e(b)
            matrix V = e(V)

            local coefvar = "treat_`name'"
            local col = colnumb(b, "`coefvar'")

            if `col' != . {
                local coef = b[1, `col']
                local se   = sqrt(V[`col', `col'])
                local pval = 2 * (1 - normal(abs(`coef' / `se')))

                post results ("`c'") ("`name'") (`coef') (`se') (`pval')
                display "✅ Posted: `c' - `name': coef=`coef', se=`se', p=`pval'"
            }
            else {
                display as error "⚠️  Coefficient `coefvar' not found in e(b) for `c' - `name'"
            }
        }
        else {
            display as error "⚠️  Probit failed for `c' - `name'"
        }
    }

    local ++i
}

postclose results

**************************************
* 4. Export results to Excel
**************************************
use "results_temp.dta", clear

gen sig = ""
replace sig = "***" if pval < 0.01
replace sig = "**"  if pval < 0.05 & pval >= 0.01
replace sig = "*"   if pval < 0.1  & pval >= 0.05

cap mkdir output
export excel using "output/phillips_consistent_probit_results.xlsx", firstrow(variables) replace

display "✅ DONE: Final results saved to 'output/phillips_consistent_probit_results.xlsx'"


*** Strict_case:
**************************************
* 1. Setup ECB meetings and countries
**************************************
/*ts.xlsx'"

*/
use ces_taylor_phillips.dta, clear

local meetings 12mar2020 30apr2020 04jun2020 16jul2020 10sep2020 29oct2020 10dec2020 21jan2021 11mar2021 22apr2021 10jun2021 22jul2021 09sep2021 28oct2021 16dec2021 03feb2022 10mar2022 14apr2022 09jun2022 21jul2022 08sep2022 27oct2022 15dec2022 02feb2023 16mar2023 04may2023 15jun2023 27jul2023 14sep2023 26oct2023 14dec2023
local names    mar2020 apr2020 jun2020 jul2020 sep2020 oct2020 dec2020 jan2021 mar2021 apr2021 jun2021 jul2021 sep2021 oct2021 dec2021 feb2022 mar2022 apr2022 jun2022 jul2022 sep2022 oct2022 dec2022 feb2023 mar2023 may2023 jun2023 jul2023 sep2023 oct2023 dec2023
local countries "DE IT FR"

* Factor variable controls for categorical variables
local controls i.income i.age_group i.gender i.education

**************************************
* 2. Generate treatment dummies (±30d)
**************************************

local i = 1
foreach m of local meetings {
    local name : word `i' of `names'
    local meeting_date = td("`m'")

    gen treat_`name' = .
    replace treat_`name' = 0 if start_date >= `meeting_date' - 30 & start_date < `meeting_date'
    replace treat_`name' = 1 if start_date > `meeting_date' & start_date <= `meeting_date' + 30
    drop if start_date == `meeting_date'

    local ++i
}

**************************************
* 3. Run Probit regressions on taylor_consistent_strict
**************************************

postfile results str10 country str10 meeting double coef double se double pval using "results_taylor.dta", replace

local i = 1
foreach m of local meetings {
    local name : word `i' of `names'
    local meeting_date = td("`m'")

    foreach c of local countries {
        display "▶ Running PROBIT for `c' during `name'..."

        * Skip if no observations in window
        count if country == "`c'" & inrange(start_date, `meeting_date' - 30, `meeting_date' + 30)
        if r(N) == 0 {
            display as error "⚠️ Skipping `c' - `name': no data in ±30d window"
            continue
        }

        capture noisily probit taylor_consistent_strict treat_`name' `controls' ///
            if country == "`c'" & inrange(start_date, `meeting_date' - 30, `meeting_date' + 30)

        if _rc == 0 {
            matrix b = e(b)
            matrix V = e(V)

            local coefvar = "treat_`name'"
            local col = colnumb(b, "`coefvar'")

            if `col' != . {
                local coef = b[1, `col']
                local se   = sqrt(V[`col', `col'])
                local pval = 2 * (1 - normal(abs(`coef' / `se')))

                post results ("`c'") ("`name'") (`coef') (`se') (`pval')
                display "✅ Posted: `c' - `name': coef=`coef', se=`se', p=`pval'"
            }
            else {
                display as error "⚠️  Coefficient `coefvar' not found in e(b) for `c' - `name'"
            }
        }
        else {
            display as error "⚠️  Probit failed for `c' - `name'"
        }
    }

    local ++i
}

postclose results

**************************************
* 4. Export results to Excel
**************************************

use "results_taylor.dta", clear

gen sig = ""
replace sig = "***" if pval < 0.01
replace sig = "**"  if pval < 0.05 & pval >= 0.01
replace sig = "*"   if pval < 0.1  & pval >= 0.05

cap mkdir output
export excel using "output/taylor_consistent_probit_results.xlsx", firstrow(variables) replace

display "✅ DONE: Results exported to 'output/taylor_consistent_probit_results.xlsx'"

*** ECB_case:
**************************************

*/
use ces_taylor_phillips.dta, clear

local meetings 12mar2020 30apr2020 04jun2020 16jul2020 10sep2020 29oct2020 10dec2020 21jan2021 11mar2021 22apr2021 10jun2021 22jul2021 09sep2021 28oct2021 16dec2021 03feb2022 10mar2022 14apr2022 09jun2022 21jul2022 08sep2022 27oct2022 15dec2022 02feb2023 16mar2023 04may2023 15jun2023 27jul2023 14sep2023 26oct2023 14dec2023
local names    mar2020 apr2020 jun2020 jul2020 sep2020 oct2020 dec2020 jan2021 mar2021 apr2021 jun2021 jul2021 sep2021 oct2021 dec2021 feb2022 mar2022 apr2022 jun2022 jul2022 sep2022 oct2022 dec2022 feb2023 mar2023 may2023 jun2023 jul2023 sep2023 oct2023 dec2023
local countries "DE IT FR"

* Controls (factor variables for categorical controls)
local controls i.income i.age_group i.gender i.education

**************************************
* 2. Generate treatment dummies (±30d)
**************************************

local i = 1
foreach m of local meetings {
    local name : word `i' of `names'
    local meeting_date = td("`m'")

    gen treat_`name' = .
    replace treat_`name' = 0 if start_date >= `meeting_date' - 30 & start_date < `meeting_date'
    replace treat_`name' = 1 if start_date > `meeting_date' & start_date <= `meeting_date' + 30
    drop if start_date == `meeting_date'

    local ++i
}

**************************************
* 3. Run Probit regressions on taylor_consistent_ecb (with controls)
**************************************

postfile results str10 country str10 meeting double coef double se double pval using "results_taylor_ecb.dta", replace

local i = 1
foreach m of local meetings {
    local name : word `i' of `names'
    local meeting_date = td("`m'")

    foreach c of local countries {
        display "▶ Running PROBIT for `c' during `name'..."

        * Skip if no data in window
        count if country == "`c'" & inrange(start_date, `meeting_date' - 30, `meeting_date' + 30)
        if r(N) == 0 {
            display as error "⚠️ Skipping `c' - `name': no observations in ±30d window"
            continue
        }

        * Skip if dependent variable doesn't vary
        quietly summarize taylor_consistent_ecb if country == "`c'" & inrange(start_date, `meeting_date' - 30, `meeting_date' + 30)
        if r(min) == r(max) {
            display as error "⚠️ Skipping `c' - `name': outcome does not vary"
            continue
        }

        * Run probit regression (add controls)
        capture noisily probit taylor_consistent_ecb treat_`name' `controls' ///
            if country == "`c'" & inrange(start_date, `meeting_date' - 30, `meeting_date' + 30)

        if _rc == 0 {
            matrix b = e(b)
            matrix V = e(V)

            local coefvar = "treat_`name'"
            local col = colnumb(b, "`coefvar'")

            if `col' != . {
                local coef = b[1, `col']
                local se   = sqrt(V[`col', `col'])
                local pval = 2 * (1 - normal(abs(`coef' / `se')))

                post results ("`c'") ("`name'") (`coef') (`se') (`pval')
                display "✅ Posted: `c' - `name': coef=`coef', se=`se', p=`pval'"
            }
            else {
                display as error "⚠️ Coefficient `coefvar' not found in e(b) for `c' - `name'"
            }
        }
        else {
            display as error "⚠️ Probit failed for `c' - `name'"
        }
    }

    local ++i
}

postclose results

**************************************
* 4. Export results to Excel
**************************************

use "results_taylor_ecb.dta", clear

gen sig = ""
replace sig = "***" if pval < 0.01
replace sig = "**"  if pval < 0.05 & pval >= 0.01
replace sig = "*"   if pval < 0.1  & pval >= 0.05

cap mkdir output
export excel using "output/taylor_consistent_ecb_results.xlsx", firstrow(variables) replace

display "✅ DONE: Results saved to 'output/taylor_consistent_ecb_results.xlsx'"

******************************* PLOTTING PROBIT COEFFICIENTS OF EVENT STUDY - PER-ANNOUNCEMENT EFFECT*******************************************88

import excel "D:\VGU\GFE\THESIS\Data\output\phillips_consistent_probit_results.xlsx", firstrow clear

* Generate numeric date for meeting period (monthly date)
gen meeting_date = monthly(meeting, "MY")
format meeting_date %tm

* Calculate 95% confidence intervals
gen lb = coef - 1.96 * se
gen ub = coef + 1.96 * se

* Bước 1: Tạo biến thời gian nếu chưa có

format meeting_date %tm

* Bước 2: Liệt kê giá trị duy nhất của biến meeting_date
levelsof meeting_date, local(ticks)

* Xác định mốc tháng đầu tiên và cuối cùng
summarize meeting_date
* Tạo giá trị số cho sep2020 nếu chưa có
gen double sep2020_tm = monthly("sep2020", "MY")
local start = sep2020_tm
summarize meeting_date
local end = r(max)

* Make sure you classified meeting_type first
gen meeting_type = ""

* Active meetings
replace meeting_type = "active" if ///
    inlist(meeting, "dec2020", "mar2021", "jun2022", "jul2022", "sep2022") ///
    | inlist(meeting, "oct2022", "dec2022", "feb2023", "mar2023", "may2023") ///
    | inlist(meeting, "jun2023", "jul2023", "sep2023")

* Affirmative meetings
replace meeting_type = "affirmative" if ///
    inlist(meeting, "sep2020", "oct2020", "jan2021", "apr2021") ///
    | inlist(meeting, "jun2021", "jul2021", "sep2021", "oct2021", "feb2022") ///
    | inlist(meeting, "mar2022", "apr2022", "oct2023", "dec2023")


* Plot: different markers instead of color
twoway ///
    (rcap lb ub meeting_date if country == "DE" & meeting_type == "active", lcolor(black)) ///
    (scatter coef meeting_date if country == "DE" & meeting_type == "active", msymbol(triangle) msize(medium) mcolor(black)) ///
    (rcap lb ub meeting_date if country == "DE" & meeting_type == "affirmative", lcolor(black)) ///
    (scatter coef meeting_date if country == "DE" & meeting_type == "affirmative", msymbol(oh) msize(medium) mcolor(black)) ///
    , ///
    yline(0, lpattern(dash) lcolor(red)) ///
    xtitle("Announcement Date") ///
    ytitle("Announcement Effect_Phillips Curve") ///
    title("Germany") ///
    xlabel(`start'(1)`end', format(%tmMonYY) angle(90) labsize(tiny)) ///
    legend(label(2 "Active") label(4 "Affirmative") rows(1)) ///
    name(effect_DE, replace)


***********************************************************************************************************************************

* Get time range for x-axis
summarize meeting_date
local start = r(min)
local end = r(max)

* Get list of countries
levelsof country, local(countries)

* Loop over each country
foreach c of local countries {

    * Define display name for chart title
    local display_name = "`c'"
    if "`c'" == "FR" {
        local display_name = "France"
    }
    else if "`c'" == "IT" {
        local display_name = "Italy"
    }
    else if "`c'" == "DE" {
        local display_name = "Germany"
    }

    * Generate the plot for each country
    twoway ///
        (rcap lb ub meeting_date if country == "`c'" & meeting_type == "active", lcolor(black)) ///
        (scatter coef meeting_date if country == "`c'" & meeting_type == "active", msymbol(triangle) msize(medium) mcolor(black)) ///
        (rcap lb ub meeting_date if country == "`c'" & meeting_type == "affirmative", lcolor(black)) ///
        (scatter coef meeting_date if country == "`c'" & meeting_type == "affirmative", msymbol(oh) msize(medium) mcolor(black)) ///
        , ///
        yline(0, lpattern(dash) lcolor(red)) ///
        xtitle("Announcement Date") ///
        ytitle("Announcement Effect_Phillips Curve") ///
        title(" `display_name'") ///
        xlabel(`start'(1)`end', format(%tmMonYY) angle(90) labsize(tiny)) ///
        legend(label(2 "Active") label(4 "Affirmative") rows(1)) ///
        name(effect_`c', replace)

    * Save the graph
    graph save "effect_`c'.gph", replace
}



* (Tùy chọn) Kết hợp các biểu đồ lại nếu cần
graph combine effect_*, rows(2)

graph use effect_FR.gph
graph copy effect_FR, replace

graph use effect_IT.gph
graph copy effect_IT, replace

graph combine effect_FR effect_IT effect_DE, rows(2)


*code riêng cho italy:
* Xác định mốc tháng nhỏ nhất và lớn nhất
summarize meeting_date
local start = r(min)
local end = r(max)

* Vẽ biểu đồ cho Italy với scale trục y điều chỉnh
twoway ///
    (rcap lb ub meeting_date if country == "IT", color(black)) ///
    (scatter coef meeting_date if country == "IT", msymbol(triangle) color(black)) ///
    , ///
    yline(0, lpattern(dash) lcolor(red)) ///
    yscale(range(-0.4 0.4)) ///
    xtitle("Announcement Date") ///
    ytitle("Announcement Effect") ///
    title("Announcement Effects for Italy") ///
    xlabel(`start'(1)`end', format(%tmMonYY) angle(90) labsize(tiny)) ///
    legend(off)

* Drawing the Taylor consistent probit results:
* Import the data
import excel "D:\VGU\GFE\THESIS\Data\output\taylor_consistent_probit_results.xlsx", firstrow clear

* Generate time variable
gen meeting_date = monthly(meeting, "MY")
format meeting_date %tm

* Calculate 95% confidence intervals
gen lb = coef - 1.96 * se
gen ub = coef + 1.96 * se

* Classify meetings as active or affirmative
gen meeting_type = ""
* Active meetings
replace meeting_type = "active" if ///
    inlist(meeting, "mar2021", "jun2022", "jul2022", "sep2022") ///
    | inlist(meeting, "oct2022", "dec2022", "feb2023", "mar2023", "may2023") ///
    | inlist(meeting, "jun2023", "jul2023", "sep2023")

* Affirmative meetings
replace meeting_type = "affirmative" if ///
    inlist(meeting, "sep2020", "oct2020", "jan2021", "apr2021") ///
    | inlist(meeting, "jun2021", "jul2021", "sep2021", "oct2021", "feb2022") ///
    | inlist(meeting, "mar2022", "apr2022", "oct2023", "dec2023")

* Step 5: Get time range for x-axis
summarize meeting_date
local start = r(min)
local end = r(max)

* Step 6: Loop over countries
levelsof country, local(countries)
local graphlist ""

foreach c of local countries {

    * Set display name
    local display_name "`c'"
    if "`c'" == "DE" local display_name "Germany"
    if "`c'" == "FR" local display_name "France"
    if "`c'" == "IT" local display_name "Italy"

    * Plot with active vs. affirmative markers
    if "`c'" == "IT" {
        twoway ///
            (rcap lb ub meeting_date if country == "`c'" & meeting_type == "active", lcolor(black)) ///
            (scatter coef meeting_date if country == "`c'" & meeting_type == "active", msymbol(triangle) msize(medium) mcolor(black)) ///
            (rcap lb ub meeting_date if country == "`c'" & meeting_type == "affirmative", lcolor(black)) ///
            (scatter coef meeting_date if country == "`c'" & meeting_type == "affirmative", msymbol(oh) msize(medium) mcolor(black)) ///
            , ///
            yline(0, lpattern(dash) lcolor(red)) ///
            yscale(range(-0.4 0.4)) ///
            xtitle("Announcement Date") ///
            ytitle("Announcement Effect_Taylor Rule_Strict Case") ///
            title("`display_name'") ///
            xlabel(`start'(1)`end', format(%tmMonYY) angle(90) labsize(tiny)) ///
            legend(label(2 "Active") label(4 "Affirmative") rows(1)) ///
            name(taylor_`c', replace)
    }
    else {
        twoway ///
            (rcap lb ub meeting_date if country == "`c'" & meeting_type == "active", lcolor(black)) ///
            (scatter coef meeting_date if country == "`c'" & meeting_type == "active", msymbol(triangle) msize(medium) mcolor(black)) ///
            (rcap lb ub meeting_date if country == "`c'" & meeting_type == "affirmative", lcolor(black)) ///
            (scatter coef meeting_date if country == "`c'" & meeting_type == "affirmative", msymbol(oh) msize(medium) mcolor(black)) ///
            , ///
            yline(0, lpattern(dash) lcolor(red)) ///
            xtitle("Announcement Date") ///
            ytitle("Announcement Effect_Taylor Rule_Strict Case") ///
            title("`display_name'") ///
            xlabel(`start'(1)`end', format(%tmMonYY) angle(90) labsize(tiny)) ///
            legend(label(2 "Active") label(4 "Affirmative") rows(1)) ///
            name(taylor_`c', replace)
    }

    * Save graph name
    local graphlist `graphlist' taylor_`c'
}


*** One more code for ECB_adapted case Taylor Rule Consistency:

*/

* Import the data
import excel "D:\VGU\GFE\THESIS\Data\output\taylor_consistent_ecb_results.xlsx", firstrow clear

* Generate time variable
gen meeting_date = monthly(meeting, "MY")
format meeting_date %tm

* Compute confidence intervals
gen lb = coef - 1.96 * se
gen ub = coef + 1.96 * se

* Classify meetings based on ECB policy action (from Bethmage 2023)
gen meeting_type = ""
* Active meetings
replace meeting_type = "active" if ///
    inlist(meeting, "dec2020", "mar2021", "jun2022", "jul2022", "sep2022") ///
    | inlist(meeting, "oct2022", "dec2022", "feb2023", "mar2023", "may2023") ///
    | inlist(meeting, "jun2023", "jul2023", "sep2023")

* Affirmative meetings
replace meeting_type = "affirmative" if ///
    inlist(meeting, "jul2020", "sep2020", "oct2020", "jan2021", "apr2021") ///
    | inlist(meeting, "jun2021", "jul2021", "sep2021", "oct2021", "feb2022") ///
    | inlist(meeting, "mar2022", "apr2022", "oct2023", "dec2023")


* Define x-axis range
summarize meeting_date
local start = r(min)
local end = r(max)

* Loop over countries and generate graphs
levelsof country, local(countries)
local graphlist ""

foreach c of local countries {

    * Country label for title
    local display_name "`c'"
    if "`c'" == "DE" local display_name "Germany"
    if "`c'" == "FR" local display_name "France"
    if "`c'" == "IT" local display_name "Italy"

    * Plot with active vs. affirmative markers
    if "`c'" == "IT" {
        twoway ///
            (rcap lb ub meeting_date if country == "`c'" & meeting_type == "active", lcolor(black)) ///
            (scatter coef meeting_date if country == "`c'" & meeting_type == "active", msymbol(triangle) mcolor(black)) ///
            (rcap lb ub meeting_date if country == "`c'" & meeting_type == "affirmative", lcolor(black)) ///
            (scatter coef meeting_date if country == "`c'" & meeting_type == "affirmative", msymbol(oh) mcolor(black)) ///
            , ///
            yline(0, lpattern(dash) lcolor(red)) ///
            yscale(range(-0.4 0.4)) ///
            xtitle("Announcement Date") ///
            ytitle("") ///
            title("`display_name'") ///
            xlabel(`start'(1)`end', format(%tmMonYY) angle(90) labsize(tiny)) ///
            legend(label(2 "Active") label(4 "Affirmative") rows(1)) ///
            name(taylor_ecb_`c', replace)
    }
    else {
        twoway ///
            (rcap lb ub meeting_date if country == "`c'" & meeting_type == "active", lcolor(black)) ///
            (scatter coef meeting_date if country == "`c'" & meeting_type == "active", msymbol(triangle) mcolor(black)) ///
            (rcap lb ub meeting_date if country == "`c'" & meeting_type == "affirmative", lcolor(black)) ///
            (scatter coef meeting_date if country == "`c'" & meeting_type == "affirmative", msymbol(oh) mcolor(black)) ///
            , ///
            yline(0, lpattern(dash) lcolor(red)) ///
            xtitle("Announcement Date") ///
            ytitle("") ///
            title("`display_name'") ///
            xlabel(`start'(1)`end', format(%tmMonYY) angle(90) labsize(tiny)) ///
            legend(label(2 "Active") label(4 "Affirmative") rows(1)) ///
            name(taylor_ecb_`c', replace)
    }

    * Add to graph list
    local graphlist `graphlist' taylor_ecb_`c'
}

graph combine taylor_ecb_DE taylor_ecb_FR taylor_ecb_IT, ///
    cols(2) ///
    title("Taylor Rule Consistency by Country - ECB Adapted Case")




**********************************************************************RECEIVER CHANNEL*********************************************************
**Now we include the receiver channel:
*** Merge with new data:
import delimited "ecb.CES_modules_topical_cb.en.csv", clear
rename a0010 respondent_id
rename a0030 wave
capture confirm numeric variable wave
if _rc {
    destring wave, replace
}
save new_data_temp.dta, replace
use ces_taylor_phillips.dta, clear

merge m:1 respondent_id wave using new_data_temp.dta



/* Construct receiver channel variable: whether respondent heard ECB news
gen heard_news = 0
replace heard_news = 1 if ///
    h2020_1 == 1 | h2020_2 == 1 | h2020_3 == 1 | ///
    h2020_4 == 1 | h2020_5 == 1 | h2020_6 == 1
*heard news is coded by define those who heard ecb related news from whatever sources they have, so we can see that act

gen heard_ecb_news = (h2020_3 == 1 | h2020_4 == 1)

save ces_taylor_phillips.dta, replace
*/

* Tạo biến phân loại cho việc tiếp xúc với thông tin về ECB
gen exposure_to_ecb_news = 0

*Group 2: People directly get exposed from ECB official channel
replace exposure_to_ecb_news = 2 if h2020_3 == 1 | h2020_4 == 1

*Group 1: People indirectly get exposed from ECB news from televisoon, newspaper
replace exposure_to_ecb_news = 1 if h2020_1 == 1 | h2020_2 == 1 | h2020_5 == 1 | h2020_6 == 1

*Group 0: People did not hear any infor relating to ECB


*Regression of receiver channel for heard_ecb_news:
* --- Model 1: Phillips Consistent
probit phillips_consistent heard_news ///
    i.income i.age_group i.gender ///
    brent_yoy_growth unemp_gap cpi inflation_volatility ///
    ecb_2020_12_10 ecb_2021_03_11 ecb_2022_06_09 ///
    ecb_2022_09_08 ecb_2023_03_16 ecb_2024_06_06 ///
    ib2.country_num##i.education, vce(cluster wave)
margins, dydx(*) post
eststo rc_phillips_AME

* --- Model 2: ECB Int
probit taylor_consistent_ecb heard_news ///
    i.income i.age_group i.gender ///
    brent_yoy_growth unemp_gap cpi inflation_volatility ///
    ecb_2020_12_10 ecb_2021_03_11 ecb_2022_06_09 ///
    ecb_2022_09_08 ecb_2023_03_16 ecb_2024_06_06 ///
    ib2.country_num##i.education, vce(cluster wave)
margins, dydx(*) post
eststo rc_ecb_int_AME

* --- Model 3: Taylor Strict
probit taylor_consistent_strict heard_news ///
    i.income i.age_group i.gender ///
    brent_yoy_growth unemp_gap cpi inflation_volatility ///
    ecb_2020_12_10 ecb_2021_03_11 ecb_2022_06_09 ///
    ecb_2022_09_08 ecb_2023_03_16 ecb_2024_06_06 ///
    ib2.country_num##i.education, vce(cluster wave)
margins, dydx(*) post
eststo rc_taylor_strict_AME


** Running the regression with "exposure_to_ecb_news"
* --- Model 1: Phillips Consistent
probit phillips_consistent i.exposure_to_ecb_news /// 
    i.income i.age_group i.gender /// 
    brent_yoy_growth unemp_gap cpi inflation_volatility /// 
    ecb_2020_12_10 ecb_2021_03_11 ecb_2022_06_09 /// 
    ecb_2022_09_08 ecb_2023_03_16 ecb_2024_06_06 /// 
    ib2.country_num##i.education, vce(cluster wave)

* Calculate marginal effects
margins, dydx(*) post

* Store the results
eststo rc_phillips_AME

* --- Model 2: ECB Int
probit taylor_consistent_ecb i.exposure_to_ecb_news /// 
    i.income i.age_group i.gender /// 
    brent_yoy_growth unemp_gap cpi inflation_volatility /// 
    ecb_2020_12_10 ecb_2021_03_11 ecb_2022_06_09 /// 
    ecb_2022_09_08 ecb_2023_03_16 ecb_2024_06_06 /// 
    ib2.country_num##i.education, vce(cluster wave)

* Calculate marginal effects
margins, dydx(*) post

* Store the results
eststo rc_ecb_int_AME

* --- Model 3: Taylor Strict
probit taylor_consistent_strict i.exposure_to_ecb_news /// 
    i.income i.age_group i.gender /// 
    brent_yoy_growth unemp_gap cpi inflation_volatility /// 
    ecb_2020_12_10 ecb_2021_03_11 ecb_2022_06_09 /// 
    ecb_2022_09_08 ecb_2023_03_16 ecb_2024_06_06 /// 
    ib2.country_num##i.education, vce(cluster wave)

* Calculate marginal effects
margins, dydx(*) post

* Store the results
eststo rc_taylor_strict_AME

******************************************************************************************************************************************
* Export all AME tables to Word
esttab rc_phillips_AME rc_ecb_int_AME rc_taylor_strict_AME ///
    using results.rtf, replace label title("Average Marginal Effects from Probit Models") ///
    se star(* 0.10 ** 0.05 *** 0.01) nogaps
	


	
********************************************************************************************************************************************
                                                                               *ROBERTNESS CHECK FOR RECEIVER CHANNEL PART:
***Difference in Difference effect Effect: Robertness Check - Dr Ha Recommendation:

probit phillips_consistent ///
    i.income i.age_group i.gender i.education_new ///
    c.brent_yoy_growth c.unemp_gap c.cpi c.inflation_volatility ///
    i.country_num ///
    heard_news##(i.ecb_2020_12_10 i.ecb_2021_03_11 i.ecb_2022_06_09 ///
                     i.ecb_2022_09_08 i.ecb_2023_03_16 i.ecb_2024_06_06), ///
    vce(cluster id)

quietly margins, dydx(*) post
eststo P1_AME

probit taylor_consistent_ecb ///
    i.income i.age_group i.gender i.education_new ///
    c.brent_yoy_growth c.unemp_gap c.cpi c.inflation_volatility ///
    i.country_num ///
    heard_news##(i.ecb_2020_12_10 i.ecb_2021_03_11 i.ecb_2022_06_09 ///
                     i.ecb_2022_09_08 i.ecb_2023_03_16 i.ecb_2024_06_06), ///
    vce(cluster id)

quietly margins, dydx(*) post
eststo T1_AME


probit taylor_consistent_strict ///
    i.income i.age_group i.gender ///
    c.brent_yoy_growth c.unemp_gap c.cpi c.inflation_volatility ///
    i.country_num ///
    heard_news##(i.ecb_2020_12_10 i.ecb_2021_03_11 i.ecb_2022_06_09 ///
                     i.ecb_2022_09_08 i.ecb_2023_03_16 i.ecb_2024_06_06), ///
    vce(cluster id)

margins, dydx(*)
quietly margins, dydx(*) post
eststo P2_AME

esttab P1_AME T1_AME P2_AME using "margins_AME.rtf", replace ///
    title("AME for Receiver channel robustness checks") ///
    mtitles("Phillips × general news (AME)" "Taylor × official (AME)" "Phillips × official (AME)") ///
    cells("b(fmt(3) star) se(fmt(3) par) p(fmt(3) par)") ///
    star(* 0.10 ** 0.05 *** 0.01) label compress ///
    addnotes("Average marginal effects (AME). Standard errors in ( ). p-values in ( ).", ///
             "Significance: * p<0.10, ** p<0.05, *** p<0.01.")
			 
                                                                 
***************************************************************************************************************************
                                                                         *** ROBERTNESS CHECK FOR SENDER CHANNEL 
*** Change the thresold from 20% to 50% 
*EXPECTED INFLATION:
clear all
set more off
*Categorize interest rate expectations (C5111/C5113)
use "ces_with_rates_inflation.dta", clear

gen inflation_exp_cat_robertness= .
replace inflation_exp_cat_robertness = 1 if percent_change > 50 & percent_change != .         // Up
replace inflation_exp_cat_robertness = -1 if percent_change < -50 & percent_change != .       // Down
replace inflation_exp_cat_robertness = 0 if percent_change >= -50 & percent_change <= 50 & percent_change != .   // Same
replace inflation_exp_cat_robertness = 0 if c1110 == 5 & c1110 != .    // Same (qualitative override)
label define infl_exp_robertness -1 "Down" 0 "Same" 1 "Up"
label values inflation_exp_cat_robertness infl_exp_robertness
****************************************************************************************************************
*EXPECTED INTEREST RATE (Using mortgage rate as proxy)
*Categorize interest rate expectations (C5111/C5113)
* Create expected_rate by combining C5111 and C5113 based on wave
gen interest_exp_cat_robertness = .
replace interest_exp_cat_robertness = 1 if interest_change_pct > 50 & interest_change_pct != .         // Up
replace interest_exp_cat_robertness = -1 if interest_change_pct < -50 & interest_change_pct != .       // Down
replace interest_exp_cat_robertness = 0 if interest_change_pct >= -50 & interest_change_pct <= 50 & interest_change_pct != .   // Same
* Step: Label values for interpretation
label define inte_exp_cat_label_robertness -1 "Down" 0 "Same" 1 "Up"
label values interest_exp_cat_robertness inte_exp_cat_label_robertness
******************************************************************************************************************
* EXPECTED UNEMPLOYMENT:
*Merge with the data of unemployment:
gen unemp_exp_cat_robertness = .
replace unemp_exp_cat_robertness = 1 if unemp_change_pct > 50 & unemp_change_pct != .        // Expecting more
replace unemp_exp_cat_robertness = -1 if unemp_change_pct < -50 & unemp_change_pct != .      // Expecting less
replace unemp_exp_cat_robertness = 0 if inrange(unemp_change_pct, -50, 50) & unemp_change_pct != .  // Expecting same
*************************************************************************************************************
*Assess Phillips Curve consistency (using the full sample)
gen phillips_consistent_robertness = 0
replace phillips_consistent_robertness = 1 if inflation_exp_cat_robertness == 1 & unemp_exp_cat_robertness == -1
replace phillips_consistent_robertness = 1 if inflation_exp_cat_robertness == -1  & unemp_exp_cat_robertness == 1
replace phillips_consistent_robertness = 1 if inflation_exp_cat_robertness == 0 & unemp_exp_cat_robertness == 0
*Acess Taylor rule 
*keep if year(dofm(month_date)) >= 2022 & month(dofm(month_date)) >= 7  // Restrict to post-July 2022
gen taylor_consistent_strict_robert = 0  // Strict alignment with Dräger et al.
gen taylor_consistent_ecb_robert = 0     // ECB-adapted, focusing on inflation
* Primary conditions (strict, per Dräger et al.): Align interest rates with expected inflation AND unemployment
replace taylor_consistent_strict_robert = 1 if interest_exp_cat_robertness == 1 & inflation_exp_cat_robertness == 1 & unemp_exp_cat_robertness == -1  // Rising rates, expected inflation up, unemployment down
replace taylor_consistent_strict_robert = 1 if interest_exp_cat_robertness == -1 & inflation_exp_cat_robertness == -1 & unemp_exp_cat_robertness == 1  // Falling rates, expected inflation down, unemployment up
replace taylor_consistent_strict_robert = 1 if interest_exp_cat_robertness == 0 & inflation_exp_cat_robertness == 0 & unemp_exp_cat_robertness == 0  // Constant rates, expected inflation same, unemployment same
* ECB-adapted conditions: Focus on expected inflation, unemployment secondary
replace taylor_consistent_ecb_robert = 1 if interest_exp_cat_robertness == 1 & inflation_exp_cat_robertness == 1  // Rising rates, expected inflation up
replace taylor_consistent_ecb_robert = 1 if interest_exp_cat_robertness == -1 & inflation_exp_cat_robertness == -1  // Falling rates, expected inflation down
replace taylor_consistent_ecb_robert = 1 if interest_exp_cat_robertness == 0 & inflation_exp_cat_robertness == 0  // Constant rates, expected inflation same
* Step 9: Summarize Taylor Rule consistency (post-ZLB sample)
** Run probit regression with new variable construction:
eststo pc_int_interact: probit phillips_consistent_robertness ///
    i.income i.age_group i.gender brent_yoy_growth unemp_gap cpi inflation_volatility ///
    ib2.country_num##i.education_new##(i.ecb_2020_12_10 i.ecb_2021_03_11 i.ecb_2022_06_09 i.ecb_2022_09_08 i.ecb_2023_03_16 i.ecb_2024_06_06), vce(robust)
**** RERUN REGRESSION FOR ROBUSTNESS CHECK - SENDER CHANNEL FOR PHILLIP CURVES-TAYLOR RULE
margins, dydx(*)
eststo pc_int_ame, title(Phillips Consistent AME_Robernesscheck)

eststo tr_strict_int_interact: probit taylor_consistent_strict_robert ///
    i.income i.age_group i.gender brent_yoy_growth unemp_gap cpi inflation_volatility ///
    ib2.country_num##i.education_new##(i.ecb_2020_12_10 i.ecb_2021_03_11 i.ecb_2022_06_09 i.ecb_2022_09_08 i.ecb_2023_03_16 i.ecb_2024_06_06), vce(robust)
margins, dydx(*)
eststo tr_strict_ame, title(Taylor Strict AME_Robernesscheck)

eststo tr_ecb_int_interact: probit taylor_consistent_ecb_robert ///
    i.income i.age_group i.gender brent_yoy_growth unemp_gap cpi inflation_volatility ///
    ib2.country_num##i.education_new##(i.ecb_2020_12_10 i.ecb_2021_03_11 i.ecb_2022_06_09 i.ecb_2022_09_08 i.ecb_2023_03_16 i.ecb_2024_06_06), vce(robust)
margins, dydx(*)
eststo tr_ecb_ame, title(Taylor ECB AME_Robernesscheck)

esttab pc_int_ame tr_strict_ame tr_ecb_ame ///
    using ame_table.rtf, replace se label star(* 0.05 ** 0.01 *** 0.001) ///
    title("Average Marginal Effects for All Variables - Robertness check - sender channel") ///
    compress

