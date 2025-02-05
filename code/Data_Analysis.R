# Data Analysis

#load packages
library(tidyverse)
sample_data <- read_csv("data/sample_data.csv")
glimpse(sample_data)

#Summarize
summarise(sample_data, avg_cells = mean(cells_per_ml))

#diiferent way to do same as above
sample_data %>%
  #group data by env group
  group_by(env_group) %>%
  #calculate mean cells-ml
  summarise(avg_cells = mean(cells_per_ml))


