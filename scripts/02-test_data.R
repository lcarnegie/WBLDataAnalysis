#### Preamble ####
# Purpose: Runs various unit tests on wb_data_clean.csv
# Author: Luca Carnegie
# Date: February 18 2024
# Contact: luca.carnegie@mail.utoronto.ca


#### Workspace setup ####
library(tidyverse)
library(readr)

wb_data_clean <- read_csv("outputs/data/wb_data_clean.csv")

#### Run similar tests to simulated data  ####

# For the specified columns, we test...

# Does the year fall between 1971-2020?
wb_data_clean$Report_Year |> min() == 1971
wb_data_clean$Report_Year |> max() == 2020

# Does the WBL index stay at or higher than 0?
wb_data_clean$WBL_Index |> min() >= 0

# Do all the WBL index values fall between 0 and 100 (as spec'd in the paper)?

all (wb_data_clean$GR1_mobility >= 0 & wb_data_clean$GR1_mobility <= 100)
all (wb_data_clean$GR2_workplace >= 0 & wb_data_clean$GR2_workplace <= 100)
all (wb_data_clean$GR3_pay >= 0 & wb_data_clean$GR3_pay <= 100)
all (wb_data_clean$GR4_marriage >= 0 & wb_data_clean$GR4_marriage <= 100)
all (wb_data_clean$GR5_parenthood >= 0 & wb_data_clean$GR5_parenthood <= 100)
all (wb_data_clean$GR6_entrepreneurship >= 0 & wb_data_clean$GR6_entrepreneurship <= 100)
all (wb_data_clean$GR7_assets >= 0 & wb_data_clean$GR7_assets <= 100)
all (wb_data_clean$GR8_pension >= 0 & wb_data_clean$GR8_pension <= 100)

