
use "$dat\WBL_analysis.dta", clear

encode economy, gen(neconomy)
encode Region, gen(nregion)

xtset neconomy year
xi i.year

************************************************************************************************************************
****************************************   DATA PREPARATION     ********************************************************
************************************************************************************************************************

*Calculate non-agricultural FLFP (FEMALE LABOUR FORCE PARTICIPATOIN)

*Total female population aged 15+:
gen pop_fml_15p = pop_fml_1564 + pop_fml_65p
*Number of women employed:
gen num_fml_empl = (empl_pop_fml/100)*pop_fml_15p
*Number of women employed in agriculture:
gen num_fml_empl_agr = (agr_empl_fml/100)*num_fml_empl
*Step 3: Number of women in the the labor force:
gen num_flfp_15p = (flfp_15p/100)*pop_fml_15p
*Step 4: Non-agricultural FLFP:
gen non_agr_flfp = ((num_flfp_15p - num_fml_empl_agr)/pop_fml_15p)*100

*Generate a new variable for FLFP that combines ILO data with national estimates from high-income economies (this gives a longer time series):

gen FLFP = non_agr_flfp
replace FLFP = flfp_15p_nat if Region == "High income: OECD"

*Country weights (set at value in year 2000)

bys year: egen world_pop = max(population)
gen pop_wt_2000 = population/world_pop if year == 2000
bys neconomy: egen ctry_wt = max(pop_wt_2000)

*Country weights by region (set at value in year 2000)

bys year nregion: egen region_pop = total(population)
gen pop_wtR_2000 = population/region_pop if year == 2000
bys neconomy: egen ctry_wtR = max(pop_wtR_2000)

*Generate population-weighted scores:

global indicator WBL_index GR1_mobility GR2_workplace GR3_pay GR4_marriage GR5_parenthood GR6_entrep GR7_assets GR8_pension
foreach var of global indicator {
	*Global weighted averages:
	gen `var'_popwt = `var'*ctry_wt if !missing(`var')
	bys year: egen wt_`var' = total(`var'_popwt) if !missing(`var')
	*Regional weighted averages:
	gen `var'_popwtR = `var'*ctry_wtR  if !missing(`var')
	bys year nregion: egen wtR_`var' = total(`var'_popwtR) if !missing(`var')
}

foreach var of global indicator{
	bys year: egen a`var' = mean(`var') if !missing(`var')
 }

*Count reforms (reform is a change in any of the 35 underlying data points, referred to hear as "subindicators"):
global subindicator gr1_1passpmrd gr1_2trvlctrymrd gr1_3trvlhmmrd gr1_4whlivemrd ///
gr2_5profhmmrd gr2_6nondiscempl gr2_7sexhrssemp gr2_8sexcomb ///
gr3_9eqremunval gr3_10nprgeqnight gr3_11jobshazard gr3_12industry ///
gr4_13obeymrd gr4_14hhmrd gr4_15domleg gr4_16dvrcjdgmnt gr4_17equalremarr ///
gr5_18wpdleave14 gr5_19govleaveprov gr5_20patleave gr5_21paidprntl gr5_22pregdism ///
gr6_23cntrcthmmrd gr6_24regbusmrd gr6_25bnkaccmrd gr6_26disgend ///
gr7_27prtyeqownmrdbth gr7_28prtyeqsondght gr7_29prtyeqsuvrspse gr7_30prtylegadmin gr7_31valnonmntry ///
gr8_32retagequal gr8_33penagequal gr8_34mandagequal gr8_35carecredit

*Generate dummy for countries that gained independence within the time period covered by the data (to avoid double-counting of reforms)
gen not_independent = 0
*Eritrea (gained independence from Ethiopia in 1993)
replace not_independent = 1 if economy == "Eritrea" & year < 1993
*South Sudan (gained independence from Sudan in 2011)
replace not_independent = 1 if economy == "South Sudan" & year < 2011
*Timor Leste (gained independence from Indonesia in 2002)
replace not_independent = 1 if economy == "Timor-Leste" & year < 2002

foreach var of global subindicator {
	sort neconomy year
	gen D`var' = 0 if !missing(`var')
	replace D`var' = 1 if (`var'-l.`var')>0 & !missing(`var') & year!=1970 & not_independent == 0
	gen D`var'wt = D`var'*ctry_wt
}
gen N_reforms = Dgr1_1passpmrd + Dgr1_2trvlctrymrd + Dgr1_3trvlhmmrd + Dgr1_4whlivemrd ///
+ Dgr2_5profhmmrd + Dgr2_6nondiscempl + Dgr2_7sexhrssemp + Dgr2_8sexcomb ///
+ Dgr3_9eqremunval + Dgr3_10nprgeqnight + Dgr3_11jobshazard + Dgr3_12industry ///
+ Dgr4_13obeymrd + Dgr4_14hhmrd + Dgr4_15domleg + Dgr4_16dvrcjdgmnt + Dgr4_17equalremarr ///
+ Dgr5_18wpdleave14 + Dgr5_19govleaveprov + Dgr5_20patleave + Dgr5_21paidprntl + Dgr5_22pregdism ///
+ Dgr6_23cntrcthmmrd + Dgr6_24regbusmrd + Dgr6_25bnkaccmrd + Dgr6_26disgend ///
+ Dgr7_27prtyeqownmrdbth + Dgr7_28prtyeqsondght + Dgr7_29prtyeqsuvrspse + Dgr7_30prtylegadmin + Dgr7_31valnonmntry ///
+ Dgr8_32retagequal + Dgr8_33penagequal + Dgr8_34mandagequal + Dgr8_35carecredit

*Weighted by population
gen N_reforms_wt = Dgr1_1passpmrdwt + Dgr1_2trvlctrymrdwt + Dgr1_3trvlhmmrdwt + Dgr1_4whlivemrdwt ///
+ Dgr2_5profhmmrdwt + Dgr2_6nondiscemplwt + Dgr2_7sexhrssempwt + Dgr2_8sexcombwt ///
+ Dgr3_9eqremunvalwt + Dgr3_10nprgeqnightwt + Dgr3_11jobshazardwt + Dgr3_12industrywt ///
+ Dgr4_13obeymrdwt + Dgr4_14hhmrdwt + Dgr4_15domlegwt + Dgr4_16dvrcjdgmntwt + Dgr4_17equalremarrwt ///
+ Dgr5_18wpdleave14wt + Dgr5_19govleaveprovwt + Dgr5_20patleavewt + Dgr5_21paidprntlwt + Dgr5_22pregdismwt ///
+ Dgr6_23cntrcthmmrdwt + Dgr6_24regbusmrdwt + Dgr6_25bnkaccmrdwt + Dgr6_26disgendwt ///
+ Dgr7_27prtyeqownmrdbthwt + Dgr7_28prtyeqsondghtwt + Dgr7_29prtyeqsuvrspsewt + Dgr7_30prtylegadminwt + Dgr7_31valnonmntrywt ///
+ Dgr8_32retagequalwt + Dgr8_33penagequalwt + Dgr8_34mandagequalwt + Dgr8_35carecreditwt

*Total reforms by year (weighted and unweighted):
bys year: egen N_reforms_byYr = total(N_reforms)
bys year: egen N_reforms_wt_byYr = total(N_reforms_wt)

*Total reforms by region and year (unweighted):
bys nregion year: egen N_reforms_byRYr = total(N_reforms)

*Total reforms by region and year (applying population weights):
bys nregion year: egen var_temp = total(N_reforms_wt)
gen N_reforms_wt_byRYr = var_temp*100
drop var_temp

************************************************************************************************************************
**************************************************** DESCRIPTIVE STATISTICS ********************************************
************************************************************************************************************************

*Figure 1A: Average scores by region - weighted and unweighted
graph bar WBL_index wtR_WBL_index if year == 2019, plotregion(fcolor(white)) graphregion(fcolor(white)) over(Region, label(angle(45))) ///
  ytitle("Aggregate WBL score") legend(off) ///
bar(1, bcolor(blue)) bar(2,bcolor(red)) name(by_region, replace) title("Panel A: Regional average of aggregate index") 
gr export  "Figure1A.png", replace

*Figure 1B: Average global score for each indicator in 2019 - weighted and unweighted
mkdir "$dat\temp"
cd "$dat\temp"

foreach ind in GR1_mobility GR2_workplace GR3_pay GR4_marriage GR5_parenthood GR6_entrep GR7_assets GR8_pension{
	preserve
	keep if year == 2019
	drop if WBL_index==.
	egen wa`ind' = total(ctry_wt*`ind')
	keep year a`ind' wa`ind'
	rename a`ind' unweighted
	rename wa`ind' weighted
	
	duplicates drop
	save `ind'.dta, replace
	restore
}
preserve
use GR1_mobility.dta, clear
append using GR2_workplace.dta
append using GR3_pay.dta
append using GR4_marriage.dta
append using GR5_parenthood.dta
append using GR6_entrep.dta
append using GR7_assets.dta
append using GR8_pension.dta

gen component = _n
label var component "WBL indicator"
label define component 1 "Mobility" 2 "Workplace" 3 "Pay" 4 "Marriage" 5 "Parenthood" 6 "Entrepreneurship" 7 "Assets"  8 "Pension"
label values component component

graph bar unweighted weighted, plotregion(fcolor(white)) graphregion(fcolor(white)) over( component, label(angle(45))) ///
  ytitle("WBL indicator score") legend(order (1 "Unweighted" 2 "Population-weighted") pos(6) col(2)) ///
bar(1, bcolor(blue)) bar(2,bcolor(red)) name(by_component,replace) title("Panel B: Global average of indicators")
gr export  "$dir\Figure1B.png", replace
restore	
cd "$dir"

*Figure 2: Charting the progress of legal gender equality over time
*Unweighted regional average of WBL aggregate:
lgraph WBL_index year nregion , plotregion(fcolor(white)) graphregion(fcolor(white))  nom ytitle("WBL index") leg(pos(6) row(3)) ///
 loptions( lwidth(thick); 1 lpat(dot); 2 lpat(dash); 3 lpat(solid); 4 lpat(dash_dot); 5 lpat(shortdash); 5 lpat(longdash); 6 lpat(shortdash_dot) ; 7 lpat(longdash_dot); 3 lcolor(green) ; 7 lcolor(yellow)) 
gr export  "Figure2.png", replace

*Figure 3a: Total count of global reforms by year
graph bar N_reforms_byYr if year>1970 & year <2020, ytitle("") plotregion(fcolor(white)) graphregion(fcolor(white)) ///
 over(year, label( angle(90) labsize(small))) bar(1, bcolor(blue)) name("Fig3a", replace) title("Panel A: Total reforms by year, unweighted") 
gr export  "Figure3a.png", replace

*Figure 3b: Population-weighted count of reforms by region
gen regionabr = nregion
label var regionabr "Region abreviations"
label define regionabr 1 "EAP" 2 "ECA" 3 "OECD" 4 "LAC" 5 "MENA" 6 "SA" 7 "SSA" 
label values regionabr regionabr
 
graph bar N_reforms_wt_byRYr if year>1970, over(regionabr) plotregion(fcolor(white)) graphregion(fcolor(white)) ///
over(year, label( angle(90) labsize(small))) asyvars ytitle("") legend(size(small) pos(6) col(7)) ///
bar(3, bcolor(green)) bar(7,bcolor(yellow)) name("Fig3b", replace) title("Panel B: Reforms by region and year, population weighted")
gr export  "Figure3b.png", replace

*Figure 4: 
 tsline aGR1_mobility  aGR2_workplace aGR3_pay aGR4_marriage  aGR5_parenthood aGR6_entrep aGR7_assets aGR8_pension if year>1969 & year<2020, ///
 plotregion(fcolor(white)) graphregion(fcolor(white)) ///
legend(order (1 "Mobility" 2 "Workplace" 3 "Pay" 4 "Marriage" ///
 5 "Parenthood" 6 "Entrepreneurship" 7 "Assets" 8 "Pension") row(2) pos(6)) ///
title("Panel A: Unweighted scores")  name(components_byYr, replace) ///
lwidth(medthick medthick medthick medthick medthick medthick medthick medthick ) lpat(dot dash solid dash_dot shortdash longdash shortdash_dot longdash_dot) lcolor(2 black)

tsline wt_GR1_mobility  wt_GR2_workplace wt_GR3_pay wt_GR4_marriage  wt_GR5_parenthood wt_GR6_entrep wt_GR7_assets wt_GR8_pension if year>1969 & year<2020, ///
plotregion(fcolor(white)) graphregion(fcolor(white)) ///
legend(order (1 "Mobility" 2 "Workplace" 3 "Pay" 4 "Marriage" ///
 5 "Parenthood" 6 "Entrepreneurship" 7 "Assets" 8 "Pension") row(2) pos(6)) ///
 title("Panel B: Population-weighted scores") name(components_byYrwt, replace) ///
lwidth(medthick medthick medthick medthick medthick medthick medthick medthick ) lpat(dot dash solid dash_dot shortdash longdash shortdash_dot longdash_dot) lcolor(2 black)

grc1leg components_byYr components_byYrwt
gr export  "Figure4.png", replace

*Regional averages in 2019 (presented in Table A2 of the Online Appendix)
di in red "2019 average in EAP:"
tabstat GR1_mobility GR2_workplace GR3_pay GR4_marriage GR5_parenthood GR6_entrep GR7_assets GR8_pension if nregion == 1 & year == 2019, stat(mean sd) format(%9.2f)
di in red "2019 average in ECA:"
tabstat GR1_mobility GR2_workplace GR3_pay GR4_marriage GR5_parenthood GR6_entrep GR7_assets GR8_pension if nregion == 2 & year == 2019, stat(mean sd) format(%9.2f)
di in red "2019 average in OECD:"
tabstat GR1_mobility GR2_workplace GR3_pay GR4_marriage GR5_parenthood GR6_entrep GR7_assets GR8_pension if nregion == 3 & year == 2019, stat(mean sd) format(%9.2f)
di in red "2019 average in LAC:"
tabstat GR1_mobility GR2_workplace GR3_pay GR4_marriage GR5_parenthood GR6_entrep GR7_assets GR8_pension if nregion == 4 & year == 2019, stat(mean sd) format(%9.2f)
di in red "2019 average in MENA:"
tabstat GR1_mobility GR2_workplace GR3_pay GR4_marriage GR5_parenthood GR6_entrep GR7_assets GR8_pension if nregion == 5 & year == 2019, stat(mean sd) format(%9.2f)
di in red "2019 average in SA:"
tabstat GR1_mobility GR2_workplace GR3_pay GR4_marriage GR5_parenthood GR6_entrep GR7_assets GR8_pension if nregion == 6 & year == 2019, stat(mean sd) format(%9.2f)
di in red "2019 average in SSA:"
tabstat GR1_mobility GR2_workplace GR3_pay GR4_marriage GR5_parenthood GR6_entrep GR7_assets GR8_pension if nregion == 7 & year == 2019, stat(mean sd) format(%9.2f)


************************************************************************************************************************
*******************************************    OLS CORRELATIONS    *****************************************************
************************************************************************************************************************
*OLS regression of FLPF and wage gap on WBL data
xtreg FLFP WBL_index ib1.year, fe
est store flfp
xtreg wagegap WBL_index ib1.year, fe
est store wagegap

xml_tab flfp wagegap, save("correlations.xls") replace stats(N) below format(NCLR4)


************************************************************************************************************************
*******************************************    IN-TEXT NUMBERS     *****************************************************
************************************************************************************************************************

*Illustration of how the WBL score is calculated, using data for Afghanistan as an example (last parargaph of section 2)
sum GR1_mobility GR2_workplace WBL_index if economy == "Afghanistan" & year == 2019

*Statistics discussed under stylized fact #1
**Global average WBL score in 2019 - unweighted and population weighted:
sum  WBL_index wt_WBL_index if year == 2019
**List of Countries with a WBL score of 100 in 2019:
tab economy if year == 2019 & WBL_index==100
**List of Countries with a WBL score of less than 30 in 2019:
tab economy if year == 2019 & WBL_index<30
**Score in Bangladesh and Pakistan in 2019:
tab economy if (economy =="Bangladesh" | economy == "Pakistan") & year == 2019, sum(WBL_index)
**Regional scores in 2019:
tab Region if year == 2019, sum(WBL_index)

*Statistics discussed under stylized fact #2
**Score for "Pay" indicator(covering laws related to compensation) in China & India in 2019:
tab economy if (economy =="China" | economy == "India") & year == 2019, sum(GR3_pay)

*Statistics discussed under stylized fact #3
**Unweighted average WBL score in 1970 and 2019:
tab year, sum(WBL_index)
**Progress in MENA region, and 2019 score in Tunisia:
tab year if Region == "Middle East & North Africa", sum(WBL_index)
tab  WBL_index if economy == "Tunisia" & year == 2019
**Example of reform in Afghanistan on the equality of legal treatment when applying for a passport:
tab gr1_1passpmrd if year == 2015 & economy == "Afghanistan"
tab gr1_1passpmrd if year == 2016 & economy == "Afghanistan"
**Peak year in terms of the number of reforms:
tab year, sum(N_reforms_byYr)
**Total number of reforms by region in the peak reform year (i.e., 2008):
tab Region if year == 2008, sum(N_reforms_byRYr)
**Reforms in Indonesia caused the spike in the number of reforms in East Asia & Pacific region in 1974:
tab economy if Region == "East Asia & Pacific" & year == 1974, sum(N_reforms)
**Reforms in India caused the spike in the number of reforms in South Asia region in 1995:
tab economy if Region == "South Asia" & year == 1995, sum(N_reforms)

*Statistics discussed under stylized fact #4
**Negative reform in China in 2008 - subindicator on equality of mandatory retirement ages changed from "Yes" (value = 1) in 2007 to "No" (value = 0) in 2008:
tab year if economy == "China", sum(gr8_34mandagequal)
