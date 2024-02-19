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


# average out the index across regions
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

# isolate indicators 
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
                               )

#average them out
avg_values <- colMeans(average_indicator)

#put them in a table 
new_table <- data.frame(Column_Names = names(avg_values), Average_Values = avg_values)



# Plot in ggplot2

  ggplot(data = new_table, mapping = aes(x = Column_Names, y = Average_Values)) +
  geom_col() +
  labs(title="Indicator Averages, 2019", x="Indicator", y="WBL Indicator Score") +
  theme_minimal() +
  ylim (NA, 100) +
  theme(plot.title.position = "plot",
        plot.title = element_text(hjust = 0.5), 
        axis.text.x = element_text (angle = 45, vjust = 1, hjust=1))
  
  
## Replication of Figure 2:  Charting the Progress of Legal Gender Equality over Time
  

#construct tibble of yearly averages of regions.   
regional_avgs_byyear <- wb_data |> select(
                            `WBL Report Year`, 
                            Region, 
                            WBL_index
                        ) |> group_by(Region, `WBL Report Year`) |> 
                             summarise(avg_index = mean(`WBL_index`, na.rm = TRUE), .groups = "drop")

# Sling it into ggplot

regional_avgs_byyear |> 
  ggplot(aes(x=`WBL Report Year`, y=avg_index, group=Region, color=Region)) +
  geom_line() +
  labs(title="WBL Index Progression since 1971, by Region", x="Year", y="WBL Index") +
  scale_color_manual(values=c("red", "blue", "green", "orange", "purple", "turquoise", "black"), labels=c("East Asia/Pacific","Europe/Central Asia", "High Income Countries (OECD)", "Latin America/Caribbean", "Middle East/North Africa", "South Asia", "Sub-Saharan Africa")) +
  theme_minimal() +
  ylim (NA, 100) + 
  theme(plot.title.position = "plot",
        plot.title = element_text(hjust = 0.5))

                                            
  



  
  




