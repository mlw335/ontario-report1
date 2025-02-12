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
taxon_dirty <- read_csv("data/taxon_abundance.csv", skip = 2) 

#only pick until the cyanobacteria column
taxon_clean <-
  taxon_dirty %>%
  select(sample_id:Cyanobacteria) %>%
  view()

#wide format to long format
dim(taxon_clean)
taxon_long <- 
  taxon_clean %>%
  pivot_longer(cols = Proteobacteria:Cyanobacteria,
               names_to = "Phylum",
               values_to = "Abundance")
#check new dim
dim(taxon_long)

taxon_long %>%
  group_by(Phylum) %>% 
  summarise(avg_abundance = mean(Abundance))

#plot our relative abundance data
taxon_long %>%
  ggplot(
    aes(x = sample_id,
        y = Abundance, 
        fill = Phylum)) +
  geom_col() +
  theme(
    axis.text.x = element_text(angle = 90))

#joining dataframes
sample_data %>%
  head(6)
taxon_clean %>%
  head(6)

#inner join
sample_data%>%
  inner_join(., taxon_clean, by = "sample_id")

#intuition check for the join
length(unique(taxon_clean$sample_id))
length(unique(sample_data$sample_id))

#antijoin
sample_data %>%
  anti_join(., taxon_clean, by = "sample_id")

#replace sample_id colimn w. fixed names (september)
taxon_clean_good_sep <-
  taxon_clean %>%
  mutate(sample_id = str_replace(sample_id, pattern = "Sep", replacement = "September"))

#inner join w fixed
sample_and_taxon <-
  sample_data %>% 
  inner_join(., taxon_clean_good_sep, by = "sample_id")

dim(sample_and_taxon)

#test
stopifnot(nrow(sample_and_taxon) == nrow(sample_data))

#write clean data to new file 
write_csv(sample_and_taxon, "data/sample_and_taxon.csv")

#plotting sample_and_data chloroflexi
sample_and_taxon %>%
  ggplot(
    aes(x = depth,
        y = Chloroflexi)) +
  geom_point() +
  #add statistical model
  geom_smooth()
  
