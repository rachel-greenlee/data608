library(shiny)
library(dplyr)
library(ggplot2)
#devtools::install_github('Mikata-Project/ggthemr')
library(ggthemr)


ggthemr('dust')
dusty <- "#b2a595"
sherbet <- "#f2bc8f"
zinnia <- "#e39482"
backs <- "#faf7f2"



### ### As a researcher, you frequently compare mortality rates from particular 
# causes across different States. You need a visualization that will let you see 
# (for 2010 only) the crude mortality rate, across all States, from one cause 
# (for example, Neoplasms, which are effectively cancers). Create a visualization 
# that allows you to rank States by crude mortality for each cause of death.

mort <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA_608/master/module3/data/cleaned-cdc-mortality-1999-2010-2.csv", header = TRUE)

# create subset with just 2010 data
mort_2010 <- subset(mort, Year == "2010")

# group by state and disease, with new variables showing the sum of deaths & pop in that grouping
mort_2010 <- mort_2010 %>%
  group_by(State, ICD.Chapter) %>%
  summarize(tot_deaths = sum(Deaths), tot_pop = sum(Population))

# create new variable crude_rate to recalculate the crude rate at this grouping level
mort_2010$crude_rate <- round((mort_2010$tot_deaths / mort_2010$tot_pop) * 100000, 4)