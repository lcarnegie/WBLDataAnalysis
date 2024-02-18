#### Preamble ####
# Purpose: Rough code-sketches of replications, etc.
# Author: Luca Carnegie
# Date: February 18 2024
# Contact: luca.carnegie@mail.utoronto.ca


#### Workspace setup ####
library(tidyverse)
library(readr)

wb_data <- read_csv("outputs/data/wb_data_clean.csv")


## Replication of Figure 1A: Avg. WBL Index in 2019

region_avg_index <- wb_data |> group_by(Region) |> filter(`WBL Report Year` == 2019) |>
                    summarise(avg_index = mean(`WBL_index`, na.rm = TRUE), .groups = "drop")


# Plot in ggplot2

  ggplot(data = region_avg_index, mapping = aes(x = Region, y = avg_index)) +
  geom_col() +
  labs(title="Average WBL Index by World Region, 2019", x="Region", y="WBL Index") +
  theme_minimal() +
  ylim (NA, 100) +
  theme(plot.title.position = "plot",
        plot.title = element_text(hjust = 0.5), 
        axis.text.x = element_text (angle = 45, vjust = 1, hjust=1))
  
## Replication of Figure 1B: Indicator variables averages 2019

average_indicator <- wb_data |> 
                        rename(
                          Mobility = GR1_mobility, 
                          Workplace = GR2_workplace, 
                          Pay = GR3_pay, 
                          Marriage = GR4_marriage, 
                          Parenthood = GR5_parenthood, 
                          Entrepreneurship = GR6_entrep, 
                          Assets = GR7_assets, 
                          Pension = GR8_pension
                        ) |>
                        filter(`WBL Report Year` == 2019) |>
                        select(Mobility, 
                               Workplace, 
                               Pay, 
                               Marriage, 
                               Parenthood, 
                               Entrepreneurship, 
                               Assets, 
                               Pension
                               ) |>
                        colMeans()

setNames(cbind(rownames(average_indicator), average_indicator, row.names = NULL), 
         c("Indicator", "Average WBL Index"))

# Plot in ggplot2

ggplot(data = average_indicator, mapping = aes(x = Region, y = avg_index)) +
  geom_col() +
  labs(title="Average WBL Index by World Region, 2019", x="Region", y="WBL Index") +
  theme_minimal() +
  ylim (NA, 100) +
  theme(plot.title.position = "plot",
        plot.title = element_text(hjust = 0.5), 
        axis.text.x = element_text (angle = 45, vjust = 1, hjust=1))



  
  




