library(shiny)
library(dplyr)
library(ggplot2)
#devtools::install_github('Mikata-Project/ggthemr')
library(ggthemr)


ggthemr('dust')
dusty <- "#b2a595"
dark_dust <- "#7a6752"
sherbet <- "#f2bc8f"
zinnia <- "#e39482"

backs <- "#faf7f2"

### Question 2: Often you are asked whether particular States are improving their 
# mortality rates (per cause) faster than, or slower than, the national average. 
# Create a visualization that lets your clients see this for themselves for one 
# cause of death at the time. Keep in mind that the national average should be 
# weighted by the national population.


mort <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA_608/master/module3/data/cleaned-cdc-mortality-1999-2010-2.csv", header = TRUE)

# collapse State rows 
mort_national <- mort %>%
  group_by(ICD.Chapter,Year) %>%
  summarize(tot_deaths = sum(Deaths), tot_pop = sum(Population))

# create national average crude rates by cause over the years
mort_national$national_crude_rate <- round((mort_national$tot_deaths / mort_national$tot_pop) * 100000, 4)

# columns we want to paste together in both dataframes
cols <- c( 'ICD.Chapter' , 'Year')

# create that new column in mort_national
mort_national$join <- apply( mort_national[ , cols] , 1 , paste , collapse = "-" )

# create that new column in mort
mort$join <- apply( mort[ , cols] , 1 , paste , collapse = "-" )

# join with state level data in new df
mort_comp <- left_join(mort, mort_national, by = "join")

# create column that shows pos/neg difference from national crude rate
mort_comp$nat_diff <- round(mort_comp$Crude.Rate - mort_comp$national_crude_rate, 4)

# create pos/neg for diverage bar chart
mort_comp$diff_type <- ifelse(mort_comp$nat_diff > 0, "above", "below")