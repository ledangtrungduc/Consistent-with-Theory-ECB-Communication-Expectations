/*******************************************************************************
File: 02_main_analysis.do
Description: Regressions for Sender/Receiver channels, Margins visualizations,
             and full execution of the Event Study (Bethmage replication).
*******************************************************************************/
cd "$datadir"
use "ces_cleaned_ready_for_analysis.dta", clear
rename income_quintile income

* Define control macros for cleaner syntax
local macro_ctrls brent_yoy_growth unemp_gap cpi inflation_volatility
local ecb_events i.ecb_2020_12_10 i.ecb_2021_03_11 i.ecb_2022_06_09 i.ecb_2022_09_08 i.ecb_2023_03_16 i.ecb_2024_06_06

*==============================================================================*
* PART 1: SENDER CHANNEL - POOLED PROBIT REGRESSIONS
*==============================================================================*
drop if inrange(month_date, tm(2020m4), tm(2020m8))

* 1.1 Phillips Curve
eststo pc_int_interact: probit phillips_consistent i.income i.age_group i.gender `macro_ctrls' ///
    ib2.country_num##i.education_new##(`ecb_events'), vce(robust)
margins, dydx(*)
eststo pc_int_ame, title(Phillips Consistent AME)

* 1.2 Taylor Rule (Strict)
eststo tr_strict_int_interact: probit taylor_consistent_strict i.income i.age_group i.gender `macro_ctrls' ///
    ib2.country_num##i.education_new##(`ecb_events'), vce(robust)
margins, dydx(*)
eststo tr_strict_ame, title(Taylor Strict AME)

* 1.3 Taylor Rule (ECB Adapted)
eststo tr_ecb_int_interact: probit taylor_consistent_ecb i.income i.age_group i.gender `macro_ctrls' ///
    ib2.country_num##i.education_new##(`ecb_events'), vce(robust)
margins, dydx(*)
eststo tr_ecb_ame, title(Taylor ECB AME)

* Export Baseline AME Table
esttab pc_int_ame tr_strict_ame tr_ecb_ame using "$outdir\ame_sender_table.rtf", ///
    replace se label star(* 0.05 ** 0.01 *** 0.001) ///
    title("Average Marginal Effects for All Variables (Sender Channel)") compress

*==============================================================================*
* PART 2: VISUALIZING MARGIN PLOTS (TRIPLE INTERACTIONS)
*==============================================================================*
* Loop to generate and export marginsplot for 6 main events
local dates_str "2020_12_10 2021_03_11 2022_06_09 2022_09_08 2023_03_16 2024_06_06"
local i = 1

foreach event in `dates_str' {
    quietly margins country_num#education_new#ecb_`event' if inlist(country_num,2,4,5)
    marginsplot, xdimension(country_num) plotdim(education_new ecb_`event') xlabel(, valuelabel) ///
        plot1opts(lpattern(solid)) plot2opts(lpattern(solid)) ///
        plot3opts(lpattern(dash)) plot4opts(lpattern(dash)) ///
        title("ECB `event'") name(gr`i', replace)
    
    * Export immediately to save code lines
    graph export "$outdir\ECB_`event'_phillips.png", as(png) width(2400) replace
    local ++i
}
graph combine gr1 gr2 gr3 gr4 gr5 gr6, col(3) row(2) iscale(0.8) title("Marginal Effects by ECB Event (Phillips Curve)")

*==============================================================================*
* PART 3: EVENT STUDY - PER-ANNOUNCEMENT EFFECT (BETHMAGE REPLICATION)
*==============================================================================*
local meetings 12mar2020 30apr2020 04jun2020 16jul2020 10sep2020 29oct2020 10dec2020 21jan2021 11mar2021 22apr2021 10jun2021 22jul2021 09sep2021 28oct2021 16dec2021 03feb2022 10mar2022 14apr2022 09jun2022 21jul2022 08sep2022 27oct2022 15dec2022 02feb2023 16mar2023 04may2023 15jun2023 27jul2023 14sep2023 26oct2023 14dec2023
local names    mar2020 apr2020 jun2020 jul2020 sep2020 oct2020 dec2020 jan2021 mar2021 apr2021 jun2021 jul2021 sep2021 oct2021 dec2021 feb2022 mar2022 apr2022 jun2022 jul2022 sep2022 oct2022 dec2022 feb2023 mar2023 may2023 jun2023 jul2023 sep2023 oct2023 dec2023
local countries "DE IT FR"
local controls i.income i.age_group i.gender i.education_new

* Generate treatment dummies (±30d)
local i = 1
foreach m of local meetings {
    local name : word `i' of `names'
    local meeting_date = date("`m'", "DMY")
    gen treat_`name' = 0 if start_date >= `meeting_date' - 30 & start_date < `meeting_date'
    replace treat_`name' = 1 if start_date > `meeting_date' & start_date <= `meeting_date' + 30
    drop if start_date == `meeting_date'
    local ++i
}

*--- 3.1 Phillips Curve Event Study ---*
postfile results str10 country str10 meeting double coef double se double pval using "$outdir\results_phillips.dta", replace
local i = 1
foreach m of local meetings {
    local name : word `i' of `names'
    local meeting_date = date("`m'", "DMY")
    foreach c of local countries {
        capture noisily probit phillips_consistent treat_`name' `controls' if country == "`c'" & inrange(start_date, `meeting_date' - 30, `meeting_date' + 30)
        if _rc == 0 {
            matrix b = e(b)
            matrix V = e(V)
            local col = colnumb(b, "treat_`name'")
            if `col' != . {
                local coef = b[1, `col']
                local se   = sqrt(V[`col', `col'])
                local pval = 2 * (1 - normal(abs(`coef' / `se')))
                post results ("`c'") ("`name'") (`coef') (`se') (`pval')
            }
        }
    }
    local ++i
}
postclose results

*--- 3.2 Taylor Strict Event Study ---*
postfile results str10 country str10 meeting double coef double se double pval using "$outdir\results_taylor.dta", replace
local i = 1
foreach m of local meetings {
    local name : word `i' of `names'
    local meeting_date = date("`m'", "DMY")
    foreach c of local countries {
        capture noisily probit taylor_consistent_strict treat_`name' `controls' if country == "`c'" & inrange(start_date, `meeting_date' - 30, `meeting_date' + 30)
        if _rc == 0 {
            matrix b = e(b)
            matrix V = e(V)
            local col = colnumb(b, "treat_`name'")
            if `col' != . {
                local coef = b[1, `col']
                local se   = sqrt(V[`col', `col'])
                local pval = 2 * (1 - normal(abs(`coef' / `se')))
                post results ("`c'") ("`name'") (`coef') (`se') (`pval')
            }
        }
    }
    local ++i
}
postclose results

*--- 3.3 Taylor ECB Event Study ---*
postfile results str10 country str10 meeting double coef double se double pval using "$outdir\results_taylor_ecb.dta", replace
local i = 1
foreach m of local meetings {
    local name : word `i' of `names'
    local meeting_date = date("`m'", "DMY")
    foreach c of local countries {
        capture noisily probit taylor_consistent_ecb treat_`name' `controls' if country == "`c'" & inrange(start_date, `meeting_date' - 30, `meeting_date' + 30)
        if _rc == 0 {
            matrix b = e(b)
            matrix V = e(V)
            local col = colnumb(b, "treat_`name'")
            if `col' != . {
                local coef = b[1, `col']
                local se   = sqrt(V[`col', `col'])
                local pval = 2 * (1 - normal(abs(`coef' / `se')))
                post results ("`c'") ("`name'") (`coef') (`se') (`pval')
            }
        }
    }
    local ++i
}
postclose results

* Export Event Studies to Excel
foreach model in phillips taylor taylor_ecb {
    use "$outdir\results_`model'.dta", clear
    gen sig = ""
    replace sig = "***" if pval < 0.01
    replace sig = "**"  if pval < 0.05 & pval >= 0.01
    replace sig = "*"   if pval < 0.1  & pval >= 0.05
    export excel using "$outdir\event_study_`model'_results.xlsx", firstrow(variables) replace
}

*==============================================================================*
* PART 4: RECEIVER CHANNEL ANALYSIS
*==============================================================================*
use "ces_cleaned_ready_for_analysis.dta", clear

* 4.1 Probit Regressions for Exposure to ECB News
probit phillips_consistent i.exposure_to_ecb_news i.income i.age_group i.gender /// 
    `macro_ctrls' ib2.country_num##i.education, vce(cluster wave)
margins, dydx(*) post
eststo rc_phillips_AME

probit taylor_consistent_strict i.exposure_to_ecb_news i.income i.age_group i.gender /// 
    `macro_ctrls' ib2.country_num##i.education, vce(cluster wave)
margins, dydx(*) post
eststo rc_taylor_strict_AME

probit taylor_consistent_ecb i.exposure_to_ecb_news i.income i.age_group i.gender /// 
    `macro_ctrls' ib2.country_num##i.education, vce(cluster wave)
margins, dydx(*) post
eststo rc_ecb_int_AME

* Export Receiver Channel AME
esttab rc_phillips_AME rc_taylor_strict_AME rc_ecb_int_AME using "$outdir\ame_receiver_channel.rtf", ///
    replace label title("Average Marginal Effects - Receiver Channel") se star(* 0.10 ** 0.05 *** 0.01) nogaps

* 4.2 Robustness Checks (Receiver Channel - DiD Method)
probit phillips_consistent i.income i.age_group i.gender i.education_new ///
    c.brent_yoy_growth c.unemp_gap c.cpi c.inflation_volatility i.country_num ///
    heard_news##(`ecb_events'), vce(cluster respondent_id)
quietly margins, dydx(*) post
eststo P1_AME

probit taylor_consistent_strict i.income i.age_group i.gender i.education_new ///
    c.brent_yoy_growth c.unemp_gap c.cpi c.inflation_volatility i.country_num ///
    heard_news##(`ecb_events'), vce(cluster respondent_id)
quietly margins, dydx(*) post
eststo P2_AME

probit taylor_consistent_ecb i.income i.age_group i.gender i.education_new ///
    c.brent_yoy_growth c.unemp_gap c.cpi c.inflation_volatility i.country_num ///
    heard_news##(`ecb_events'), vce(cluster respondent_id)
quietly margins, dydx(*) post
eststo T1_AME

esttab P1_AME T1_AME P2_AME using "$outdir\ame_receiver_robustness.rtf", replace ///
    title("AME for Receiver Channel Robustness Checks") ///
    mtitles("Phillips × general" "Taylor ECB × official" "Taylor Strict × official") ///
    cells("b(fmt(3) star) se(fmt(3) par) p(fmt(3) par)") star(* 0.10 ** 0.05 *** 0.01) label compress

*==============================================================================*
* PART 5: ROBUSTNESS CHECK (SENDER CHANNEL - 50% THRESHOLD)
*==============================================================================*
eststo pc_robust_interact: probit phillips_consistent_robustness i.income i.age_group i.gender ///
    `macro_ctrls' ib2.country_num##i.education_new##(`ecb_events'), vce(robust)
margins, dydx(*)
eststo pc_robust_ame, title(Phillips Consistent AME - Robustness)

eststo tr_strict_robust_interact: probit taylor_consistent_strict_robust i.income i.age_group i.gender ///
    `macro_ctrls' ib2.country_num##i.education_new##(`ecb_events'), vce(robust)
margins, dydx(*)
eststo tr_strict_robust_ame, title(Taylor Strict AME - Robustness)

eststo tr_ecb_robust_interact: probit taylor_consistent_ecb_robust i.income i.age_group i.gender ///
    `macro_ctrls' ib2.country_num##i.education_new##(`ecb_events'), vce(robust)
margins, dydx(*)
eststo tr_ecb_robust_ame, title(Taylor ECB AME - Robustness)

esttab pc_robust_ame tr_strict_robust_ame tr_ecb_robust_ame using "$outdir\ame_sender_robustness.rtf", ///
    replace se label star(* 0.05 ** 0.01 *** 0.001) ///
    title("Average Marginal Effects for All Variables - Robustness Check (50% Threshold)") compress

disp "✅ FULL ANALYSIS COMPLETE!"