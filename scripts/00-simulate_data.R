#### Preamble ####
# Purpose: Simulates a table with Canada's WBL scores across 8 indicators and 10 years (2013-2023)
# Author: Luca Carnegie and Sehar Bajwa
# Date: 13 February 2024 
# Contact: luca.carnegie@mail.utoronto.ca
#           sehar.bajwa@mail.utoronto.ca          
# License: MIT
# Pre-requisites: 
# Any other information needed 


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
# Creating a simulated database for Canada scores in WBL
set.seed(123)  # Setting seed for reproducibility

# Generating report years from 2010 to 2020
report_years <- 2010:2020

# Generating random scores for the specified columns 
# Note: Can only be 0, 25, 50, 75, 100 due to nature of survey
scores <- sample(c(0, 25, 50, 75, 100), length(report_years), replace = TRUE)

# Creating the data frame
simulated_data <- tibble(
  Economy = rep("Canada", length(report_years)),
  Region = rep("High income: OECD", length(report_years)),
  Report_Year = report_years,
  WBL_Index = scores,
  Mobility = scores,
  Workplace = scores,
  Pay = scores,
  Marriage = scores,
  Parenthood = scores,
  Entrepreneurship = scores,
  Assets = scores,
  Pension = scores
)

# Testing simulated data

simulated_data$Report_Year |> min() == 2010
simulated_data$Report_Year |> max() == 2020
simulated_data$WBL_Index |> min() == 0

simulated_data$Mobility %in% c(0, 25, 50, 75, 100)
simulated_data$Workplace %in% c(0, 25, 50, 75, 100)
simulated_data$Pay %in% c(0, 25, 50, 75, 100)
simulated_data$Marriage %in% c(0, 25, 50, 75, 100)
simulated_data$Parenthood %in% c(0, 25, 50, 75, 100)
simulated_data$Entrepreneurship %in% c(0, 25, 50, 75, 100)
simulated_data$Assets %in% c(0, 25, 50, 75, 100)
simulated_data$Pension %in% c(0, 25, 50, 75, 100)


