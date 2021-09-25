library(shiny)
library(dplyr)
library(ggplot2)

mort <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA_608/master/module3/data/cleaned-cdc-mortality-1999-2010-2.csv", header = TRUE)

# create subset with just 2010 data
mort_2010 <- subset(mort, Year == "2010")

# group by state and disease, with new variables showing the sum of deaths & pop in that grouping
mort_2010 <- mort_2010 %>%
  group_by(State, ICD.Chapter) %>%
  summarize(tot_deaths = sum(Deaths), tot_pop = sum(Population))

# create new variable crude_rate to recalculate the crude rate at this grouping level
mort_2010$crude_rate <- round((mort_2010$tot_deaths / mort_2010$tot_pop) * 100000, 4)