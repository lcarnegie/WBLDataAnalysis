 
************************************************************************
*************** 	Data source 1: WBL balanced panel 	****************
************************************************************************

import excel using "$dat\WBL50YearPanelData.xlsx", sheet("WBL1971-2020")  cellrange(B2)  firstrow clear
gen year = WBLReportYear-1

rename WBLINDEX WBL_index
rename MOBILITY GR1_mobility
rename Canawomanapplyforapassport gr1_1passpmrd
rename Canawomantraveloutsidethec gr1_2trvlctrymrd
rename Canawomantraveloutsideherh gr1_3trvlhmmrd
rename Canawomanchoosewheretoliv gr1_4whlivemrd
rename WORKPLACE  GR2_workplace
rename Canawomangetajobinthesam gr2_5profhmmrd
rename Doesthelawprohibitdiscrimina gr2_6nondiscempl
rename Istherelegislationonsexualh gr2_7sexhrssemp
rename Aretherecriminalpenaltiesor gr2_8sexcomb
rename PAY GR3_pay
rename Doesthelawmandateequalremun gr3_9eqremunval
rename Canwomenworkthesamenightho gr3_10nprgeqnight
rename Canwomenworkinjobsdeemedda gr3_11jobshazard
rename Arewomenabletoworkinthesa gr3_12industry
rename MARRIAGE GR4_marriage
rename Istherenolegalprovisionthat gr4_13obeymrd
rename Canawomanbeheadofhousehol gr4_14hhmrd
rename Istherelegislationspecificall gr4_15domleg
rename Canawomanobtainajudgmentof gr4_16dvrcjdgmnt
rename Doesawomanhavethesameright gr4_17equalremarr
rename PARENTHOOD GR5_parenthood
rename Ispaidleaveofatleast14wee gr5_18wpdleave14
rename Doesthegovernmentadminister1 gr5_19govleaveprov
rename Istherepaidleaveavailableto gr5_20patleave
rename Istherepaidparentalleave gr5_21paidprntl
rename Isdismissalofpregnantworkers gr5_22pregdism
rename ENTREPRENEURSHIP GR6_entrep
rename Canawomansignacontractint gr6_23cntrcthmmrd
rename Canawomanregisterabusiness gr6_24regbusmrd
rename Canawomanopenabankaccount gr6_25bnkaccmrd
rename AM gr6_26disgend
rename ASSETS GR7_assets
rename Domenandwomenhaveequalowne gr7_27prtyeqownmrdbth
rename Dosonsanddaughtershaveequal gr7_28prtyeqsondght
rename Dofemaleandmalesurvivingspo gr7_29prtyeqsuvrspse
rename Doesthelawgrantspousesequal gr7_30prtylegadmin
rename Doesthelawprovidefortheval gr7_31valnonmntry
rename PENSION GR8_pension
rename Aretheagesatwhichmenandwo gr8_32retagequal
rename AV gr8_33penagequal
rename Isthemandatoryretirementage gr8_34mandagequal
rename Areperiodsofabsencefromwork gr8_35carecredit

label var WBL_index "WBL INDEX"
label var GR1_mobility "MOBILITY"
label var gr1_1passpmrd "Can a woman apply for a passport in the same way as a man?"
label var gr1_2trvlctrymrd "Can a woman travel outside the country in the same way as a man?"
label var gr1_3trvlhmmrd "Can a woman travel outside her home in the same way as a man?"
label var gr1_4whlivemrd "Can a woman  choose where to live in the same way as a man?"
label var GR2_workplace "WORKPLACE"
label var gr2_5profhmmrd "Can a woman get a job in the same way as a man?"
label var gr2_6nondiscempl "Does the law prohibit discrimination based on gender in employment?"
label var gr2_7sexhrssemp "Is there legislation on sexual harassment in employment?"
label var gr2_8sexcomb "Are there criminal penalties or civil remedies for sexual harassment in employment?"
label var GR3_pay "PAY"
label var gr3_9eqremunval "Does the law mandate equal remuneration for work of equal value?"
label var gr3_10nprgeqnight "Can women work the same night hours as men?"
label var gr3_11jobshazard "Can women work in jobs deemed dangerous in the same way as men?"
label var gr3_12industry "Are women able to work in the same industries as men?"
label var GR4_marriage "MARRIAGE"
label var gr4_13obeymrd "Is there no legal provision that requires a married woman to obey her husband?"
label var gr4_14hhmrd "Can a woman be head of household or head of family in the same way as a man?"
label var gr4_15domleg "Is there legislation specifically addressing domestic violence?"
label var gr4_16dvrcjdgmnt "Can a woman obtain a judgment of divorce in the same way as a man?"
label var gr4_17equalremarr "Does a woman have the same rights to remarry as a man?"
label var GR5_parenthood "PARENTHOOD"
label var gr5_18wpdleave14 "Is paid leave of at least 14 weeks available to women?"
label var gr5_19govleaveprov "Does the government administer 100% of maternity leave benefits?"
label var gr5_20patleave "Is there paid leave available to fathers?"
label var gr5_21paidprntl "Is there paid parental leave?"
label var gr5_22pregdism "Is dismissal of pregnant workers prohibited?"
label var GR6_entrep "ENTREPRENEURSHIP"
label var gr6_23cntrcthmmrd "Can a woman sign a contract in the same way as a man?"
label var gr6_24regbusmrd "Can a woman register a business in the same way as a  man?"
label var gr6_25bnkaccmrd "Can a  woman open a bank account in the same way as a man?"
label var gr6_26disgend "Does the law prohibit discrimination based or gender in access to credit?"
label var GR7_assets "ASSETS"
label var gr7_27prtyeqownmrdbth "Do men and married women have equal ownership rights to property?"
label var gr7_28prtyeqsondght "Do sons and daughters have equal rights to inherit assets from their parents?"
label var gr7_29prtyeqsuvrspse "Do female and male surviving spouses have equal rights to inherit assets?"
label var gr7_30prtylegadmin "Does the law grant spouses equal administrative authority over assets during marriage?"
label var gr7_31valnonmntry "Does the law provide for the valuation of nonmonetary contributions?"
label var GR8_pension "PENSION"
label var gr8_32retagequal "Are the ages at which men and women can retire with full pension benefits equal?"
label var gr8_33penagequal "Are the ages at which men and women can retire with partial pension benefits equal?"
label var gr8_34mandagequal "Is the mandatory retirement age for men and women equal?"
label var gr8_35carecredit "Are periods of absence due to child care accounted for in pension benefits?"

**destring
local yn gr1_1passpmrd gr1_2trvlctrymrd gr1_3trvlhmmrd gr1_4whlivemrd gr2_5profhmmrd gr2_6nondiscempl gr2_7sexhrssemp gr2_8sexcomb gr3_9eqremunval gr3_10nprgeqnight gr3_11jobshazard gr3_12industry gr4_13obeymrd gr4_14hhmrd gr4_15domleg gr4_16dvrcjdgmnt gr4_17equalremarr gr5_18wpdleave14 gr5_19govleaveprov gr5_20patleave gr5_21paidprntl gr5_22pregdism gr6_23cntrcthmmrd gr6_24regbusmrd gr6_25bnkaccmrd gr6_26disgend gr7_27prtyeqownmrdbth gr7_28prtyeqsondght gr7_29prtyeqsuvrspse gr7_30prtylegadmin gr7_31valnonmntry gr8_32retagequal gr8_33penagequal gr8_34mandagequal gr8_35carecredit
foreach Z in `yn'{
	gen n`Z' = .
	replace n`Z' = 0 if `Z' == "No"
	replace n`Z' = 1 if `Z' == "Yes"
}
label define YN 1 "Yes" 0 "No"
foreach Z in `yn'{ 
	label values n`Z' YN 
	drop `Z'
	rename n`Z' `Z'
}

rename Code countrycode
rename Economy economy

replace countrycode = "PSE" if economy == "West Bank and Gaza"
replace countrycode = "XKX" if economy == "Kosovo"
replace countrycode = "ROU" if economy == "Romania"
replace countrycode = "COD" if economy == "Congo, Dem. Rep."
replace countrycode = "TLS" if economy == "Timor-Leste"


 replace economy = "Cote d'Ivoire" if economy == "Côte d'Ivoire"
 replace economy = "Sao Tome and Principe" if economy == "São Tomé and Príncipe"
 replace economy = "Puerto Rico" if economy == "Puerto Rico (U.S.)"
 replace economy = "Macedonia, FYR" if economy == "North Macedonia" // reverting to old name as this is what is used in all other datasets, to be renamed at the end of this do file

preserve
*************************************************************************
************** Data source 2: World Development Indicators **************
*************************************************************************
	import delimited "$dat\WDIData.csv", clear 
	dropmiss, force
	rename v1 CountryName
	rename v2 countrycode
	
keep if v4 == "SL.TLF.CACT.FE.ZS" | v4 == "SP.POP.TOTL" | ///
	v4 == "SL.AGR.EMPL.FE.ZS" | v4 =="SL.EMP.TOTL.SP.FE.ZS" | v4 == "SP.POP.1564.FE.IN" | ///
	v4 == "SP.POP.65UP.FE.IN" | v4 == "SL.TLF.CACT.FE.NE.ZS"
	
	local count = -1
	ds3, loc(variables)

	foreach var of local variables {
		if "`var'" == "v5" {
			local count = 0
		}
		if `count' >= 0 {
			local name = 1960 + `count'
			rename `var' _`name'
			destring _`name', replace
			local count = `count' + 1
		}
	}
	reshape long _, i(CountryName v3 v4) j(year)
	gen ind = 1 if v4 == "SL.TLF.CACT.FE.ZS"
	replace ind = 2 if v4 == "SP.POP.TOTL"
	replace ind = 3 if v4 == "SL.AGR.EMPL.FE.ZS"	
	replace ind = 4 if v4 == "SL.EMP.TOTL.SP.FE.ZS"
	replace ind = 5 if v4 == "SP.POP.1564.FE.IN"
	replace ind = 6 if v4 == "SP.POP.65UP.FE.IN"
	replace ind = 7 if v4 == "SL.TLF.CACT.FE.NE.ZS" 
	
	drop v4 v3
	
	reshape wide _, i(CountryName countrycode year) j(ind)
	
	rename _1 flfp_15p
	rename _2 population
	rename _3 agr_empl_fml
	rename _4 empl_pop_fml
	rename _5 pop_fml_1564
	rename _6 pop_fml_65p
	rename _7 flfp_15p_nat
		
	label var flfp_15p "Labor force participation rate, female (% of female population ages 15+) (modeled ILO estimate)"
	label var population "Population, total"
	label var agr_empl_fml "Employment in agriculture, female (% of female employment) (modeled ILO estimate)"
	label var empl_pop_fml "Employment to population ratio, 15+, female (%) (modeled ILO estimate)"
	label var pop_fml_1564 "Population ages 15-64, female"
	label var pop_fml_65p "Population ages 65 and above, female"
	label var flfp_15p_nat "Labor force participation rate, female (% of female population ages 15+) (national estimate)"
	
	rename CountryName economy
	replace economy = "Macedonia, FYR" if economy == "North Macedonia"
	replace economy = "North Korea" if economy == "Korea, Dem. Peopleâs Rep."
save "$dat\temp.dta", replace

restore

merge 1:1 economy year using "$dat\temp.dta"

gen not_in_WBL = 0
replace not_in_WBL = 1 if _merge == 2 & year >2008 & economy !="World"
	
drop if not_in_WBL == 1
drop not_in_WBL
drop _merge

preserve

*************************************************************************
************* Data sources 3 & 4: ILO & OECD WAGE GAP DATA **************
*************************************************************************
 
*ILO WAGE GAP DATA
 insheet using "$dat\ILO_wagegap.csv",  clear
 
 rename ref_arealabel economy 
 rename time year
 rename obs_value wagegapilo

 *Change some economy names so they match WBL and WDI data:
 replace economy = "Korea, Rep." if economy == "Korea, Republic of"
 replace economy = "Slovak Republic" if economy == "Slovakia"
 replace economy = "Vietnam" if economy == "Viet Nam"
 replace economy = "Venezuela, RB" if economy == "Venezuela, Bolivarian Republic of"
 replace economy = "Eswatini" if economy == "Swaziland"
 keep economy year wagegapilo
 save "$dat\temp.dta", replace
 
 *OECD WAGE GAP DATA
 import excel using "$dat\OECD_wagegap.xlsx", sheet("OECD.Stat export")  cellrange(A7)  firstrow clear
 drop B
 reshape long wagegapoecd, i(Country) j(year)
 
 rename Country economy
 replace wagegapoecd = "."  if wagegapoecd == ".."
 destring wagegapoecd , replace

 *Change some economy names so they match WBL and WDI data:
 replace economy = "Korea, Rep." if economy == "Korea"
 replace economy = "Eswatini" if economy == "Swaziland"
 drop if economy == "Data extracted on 15 Feb 2019 15:55 UTC (GMT) from OECD.Stat"
 
 merge 1:1 economy year using "$dat\temp.dta"
 
 *Where data from OECD and ILO overlap, take the OECD values (based on median; less sensitive to extreme values):
 gen wagegap = wagegapoecd
 replace wagegap = wagegapilo if wagegap==.
 drop wagegapilo wagegapoecd
 drop _merge
 save "$dat\temp.dta", replace
 
restore
 merge 1:1 economy year using "$dat\temp.dta"
 drop _merge
 erase "$dat\temp.dta"	
*Give correct name to North Macedonia:
replace economy = "North Macedonia" if economy == "Macedonia, FYR"

drop if year<1970

save "$dat\WBL_analysis.dta", replace
