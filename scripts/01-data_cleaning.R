#### Preamble ####
# Purpose: Cleans data for replication (translated from Stata written by Hyland et al.)
# Author:  Marie Hyland, Simeon Djankov, and Pinelopi Koujianou Goldberg* (translated from the Stata by Luca Carnegie)
# Date: 12 February 2023
# Contact: luca.carnegie@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R

#### Workspace setup ####
library(tidyverse)
library(haven)
library(readxl) 

#### Read in data from Excel file ####
wb_data <- read_excel("Replication Package/Data/WBL50YearPanelData.xlsx", sheet = "WBL1971-2020", range = "B2:AX9502", col_names = TRUE)

# Rename clunky col names 
wb_data <- wb_data |>
  rename(WBL_index = "WBL INDEX",
         
         GR1_mobility = "MOBILITY",
         gr1_1passpmrd = "Can a woman apply for a passport in the same way as a man?",
         gr1_2trvlctrymrd = "Can a woman travel outside the country in the same way as a man?",
         gr1_3trvlhmmrd = "Can a woman travel outside her home in the same way as a man?",
         gr1_4whlivemrd = "Can a woman choose where to live in the same way as a man?",
         
         GR2_workplace = "WORKPLACE",
         gr2_5profhmmrd = "Can a woman get a job in the same way as a man?",
         gr2_6nondiscempl = "Does the law prohibit discrimination in employment based on gender?",
         gr2_7sexhrssemp = "Is there legislation on sexual harassment in employment?",
         gr2_8sexcomb = "Are there criminal penalties or civil remedies for sexual harassment in employment?",
         
         GR3_pay = "PAY",
         gr3_9eqremunval = "Does the law mandate equal remuneration for work of equal value?",
         gr3_10nprgeqnight = "Can women work the same night hours as men?",
         gr3_11jobshazard = "Can women work in jobs deemed dangerous in the same way as men?",
         gr3_12industry = "Are women able to work in the same industries as men?",
         
         GR4_marriage = "MARRIAGE",
         gr4_13obeymrd = "Is there no legal provision that requires a married woman to obey her husband?",
         gr4_14hhmrd = "Can a woman be \"head of household\" or \"head of family\" in the same way as a man?",
         gr4_15domleg = "Is there legislation specifically addressing domestic violence?",
         gr4_16dvrcjdgmnt = "Can a woman obtain a judgment of divorce in the same way as a man?",
         gr4_17equalremarr = "Does a woman have the same rights to remarry as a man?",
         
         GR5_parenthood = "PARENTHOOD",
         gr5_18wpdleave14 = "Is paid leave of at least 14 weeks available to mothers?",
         gr5_19govleaveprov = "Does the government administer 100% of maternity leave benefits?",
         gr5_20patleave = "Is there paid leave available to fathers?",
         gr5_21paidprntl = "Is there paid parental leave?", 
         gr5_22pregdism = "Is dismissal of pregnant workers prohibited?",
         
         GR6_entrep = "ENTREPRENEURSHIP",
         gr6_23cntrcthmmrd = "Can a woman sign a contract in the same way as a man?",
         gr6_24regbusmrd = "Can a woman register a business in the same way as a man?",
         gr6_25bnkaccmrd = "Can a woman open a bank account in the same way as a man?",
         gr6_26disgend = "Does the law prohibit discrimination in access to credit based on gender?",
         
         GR7_assets = "ASSETS",
         gr7_27prtyeqownmrdbth = "Do men and women have equal ownership rights to immovable property?",
         gr7_28prtyeqsondght = "Do sons and daughters have equal rights to inherit assets from their parents?",
         gr7_29prtyeqsuvrspse = "Do female and male surviving spouses have equal rights to inherit assets?",
         gr7_30prtylegadmin = "Does the law grant spouses equal administrative authority over assets during marriage?",
         gr7_31valnonmntry = "Does the law provide for the valuation of nonmonetary contributions?",
         
         GR8_pension = "PENSION",
         gr8_32retagequal = "Are the ages at which men and women can retire with full pension benefits equal?",
         gr8_33penagequal = "Are the ages at which men and women can retire with partial pension benefits equal?",
         gr8_34mandagequal = "Is the mandatory retirement age for men and women equal?",
         gr8_35carecredit = "Are periods of absence from work due to childcare accounted for in pension benefits?"
      )



# destring 
yn <- c("gr1_1passpmrd", "gr1_2trvlctrymrd", "gr1_3trvlhmmrd", "gr1_4whlivemrd", "gr2_5profhmmrd",
        "gr2_6nondiscempl", "gr2_7sexhrssemp", "gr2_8sexcomb", "gr3_9eqremunval", "gr3_10nprgeqnight",
        "gr3_11jobshazard", "gr3_12industry", "gr4_13obeymrd", "gr4_14hhmrd", "gr4_15domleg",
        "gr4_16dvrcjdgmnt", "gr4_17equalremarr", "gr5_18wpdleave14", "gr5_19govleaveprov",
        "gr5_20patleave", "gr5_21paidprntl", "gr5_22pregdism", "gr6_23cntrcthmmrd", "gr6_24regbusmrd",
        "gr6_25bnkaccmrd", "gr6_26disgend", "gr7_27prtyeqownmrdbth", "gr7_28prtyeqsondght",
        "gr7_29prtyeqsuvrspse", "gr7_30prtylegadmin", "gr7_31valnonmntry", "gr8_32retagequal",
        "gr8_33penagequal", "gr8_34mandagequal", "gr8_35carecredit")

# Create new columns with binary values (0 for "No" and 1 for "Yes"
wb_data <- wb_data |> mutate(across(all_of(yn), ~ labelled(ifelse(. == "Yes", 1, 0), c("Yes" = 1, "No" = 0)), .names = "n{.col}"))

# Drop the original variables and keep the new ones
wb_data <- wb_data |> select(-all_of(yn))

# Rename the new variables to the original names
wb_data <- wb_data |> rename_with(~ str_remove(., "n"), starts_with("n"))

# Clean up some labels. 

wb_data <- wb_data |>
            rename(`economy` = `Economy`) |>
            rename(`countrycode` = `Code`)

wb_data$countrycode <- ifelse(wb_data$economy == "West Bank and Gaza", "PSE", wb_data$countrycode)
wb_data$countrycode <- ifelse(wb_data$economy == "Kosovo", "XKX", wb_data$countrycode)
wb_data$countrycode <- ifelse(wb_data$economy == "Romania", "ROU", wb_data$countrycode)
wb_data$countrycode <- ifelse(wb_data$economy == "Congo, Dem. Rep.", "COD", wb_data$countrycode)
wb_data$countrycode <- ifelse(wb_data$economy == "Timor-Leste", "TLS", wb_data$countrycode)

wb_data$economy <- ifelse(wb_data$economy == "Côte d'Ivoire", "Cote d'Ivoire", wb_data$economy)
wb_data$economy <- ifelse(wb_data$economy == "São Tomé and Príncipe", "Sao Tome and Principe", wb_data$economy)
wb_data$economy <- ifelse(wb_data$economy == "Puerto Rico (U.S.)", "Sao Tome and Principe", wb_data$economy)
wb_data$economy <- ifelse(wb_data$economy == "North Macedonia", "Macedonia, FYR", wb_data$economy)

write_csv(
  x = wb_data,
  file = "outputs/data/wb_data_clean.csv", 
)
