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

#Filter command:subsets data by rows on some value
sample_data %>% 
  #subset samples only from DEEP
  filter(env_group == "Deep") %>%
  #Calculate mean cell abundances
  summarise(avg_cells = mean(cells_per_ml))

#create a new column using mutate()
sample_data %>%
  #calculate new column w/ Total N : Total P ratio
  mutate(tn_tp_ratio = total_nitrogen / total_phosphorus) %>%
  #visualize data 
  view()

#subset by entire columns using select()
sample_data %>%
  #pick specific columns
  select(sample_id, depth) 
  # select(sample_id:depth)
  # select(-sample_id)

# cleaning up data
read_csv()
