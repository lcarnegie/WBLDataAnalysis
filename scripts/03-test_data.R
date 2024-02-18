#### Preamble ####
# Purpose: Tests... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(readr)

wb_data_clean <- read_csv("outputs/data/wb_data_clean.csv")

#### Run similar tests to simulated data  ####

# Does the year fall between 1971-2020?
wb_data_clean$Report_Year |> min() == 1971
wb_data_clean$Report_Year |> max() == 2020

#Does the WBL index stay at or higher than 0?
wb_data_clean$WBL_Index |> min() == 0

# Do all the index values fall between 0 and 100 (as spec'd in the paper)?

#TODO: fix the c() so that it is a range(0-100)

wb_data_clean$GR1_mobility %in% c(0, 25, 50, 75, 100) 
wb_data_clean$GR2_workplace %in% c(0, 25, 50, 75, 100)
wb_data_clean$GR3_pay %in% c(0, 25, 50, 75, 100)
wb_data_clean$GR4_marriage %in% c(0, 25, 50, 75, 100)
wb_data_clean$GR5_parenthood %in% c(0, 25, 50, 75, 100)
wb_data_clean$GR6_entrepreneurship %in% c(0, 25, 50, 75, 100)
wb_data_clean$GR7_assets %in% c(0, 25, 50, 75, 100)
wb_data_clean$GR8_pension %in% c(0, 25, 50, 75, 100)
