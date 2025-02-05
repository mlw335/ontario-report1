#Plotting Lake Ontario Microbial Cell Abundances
#By Mark Watson
#Date January 29th, 2025

#First install packages
install.packages("tidyverse")
 
library(tidyverse)

#loading in the data
buoy_data <- read_csv("buoy_data.csv")

sample_data <- read_csv(file = "sample_data.csv")

#Some commands don't need input
Sys.date() # what is the date
sys.time() # what is the time
getwd()    # what is the working directory

#others need arguments
sum(2,3)
round(3.14) #gives output 3
round(3.14, 1) #gives output 3.1

#what does our data look like?
view(sample_data)
str(sample_data)

# PLOTTING
ggplot(data = sample_data) +
  aes(x = temperature) +
  labs(x = "Temperature (C)") +
  aes(y = cells_per_ml) +
  labs(y = "Cell Abundance (Cells/mL)")+
  geom_point() +
  labs(title = "Does temperature affect microbial abundance?") +
  aes(color = env_group) +
  aes(size = chlorophyll) +
  labs(color = "Environmental Group", size = "Chlorophyll (ug/L)")

#OR (these two are the same thing)

ggplot(data = sample_data)+
  aes(x = temperature, y = cells_per_ml/1000000, color = env_group, size = chlorophyll) +
  labs(x = "Temperature (C)", y = "Cell Abundance (millions/mL)", 
       color = "Environmental Group", size = "Chlorophyll",
       title = "Does temperature affect microbial abundance?") +
  geom_point()

#Read in Buoy Data
buoy_data <- read_csv("buoy_data.csv")
glimpse(buoy_data)
dim(buoy_data)
length(unique(buoy_data$sensor)) # returns "8" the "length" of how many unique entries for buoy_data$sensor

#Plot the buoy data
ggplot(data = buoy_data) +
  aes(x = day_of_year, y = temperature, color = depth) +
  labs(x = "Day of Year", y = "Temperature (C)", color = "Depth") +
  geom_point()

ggplot(data = buoy_data) +
  aes(x = day_of_year, y = temperature, color = depth, group = sensor) +
  labs(x = "Day of Year", y = "Temperature (C)", color = "Depth") +
  geom_line()

#Facet GRID Plot
ggplot(data = buoy_data) +
  aes(x = day_of_year, y = temperature, color = depth, group = sensor) +
  labs(x = "Day of Year", y = "Temperature (C)", color = "Depth") +
  facet_grid(rows = vars(buoy)) +
  geom_line()

#Facet Wrap
ggplot(data = buoy_data) +
  aes(x = day_of_year, y = temperature, color = depth, group = sensor) +
  labs(x = "Day of Year", y = "Temperature (C)", color = "Depth") +
  facet_wrap(~buoy) +
  geom_line()

#Cell abundances by environmental group (boxplot)
ggplot(data = sample_data) +
  aes(x = env_group, y = cells_per_ml, color = env_group, fill = env_group) +
  geom_boxplot(alpha = 0.3, outliers = FALSE) +
  geom_jitter(aes(size = chlorophyll)) 

?ggsave

#Briefwork Graphs
ggplot(data= sample_data) +
  aes(x = total_nitrogen, y = cells_per_ml/1000000) +
  geom_point(aes(size = temperature, color = env_group))+
  labs(x =  "Total Nitrogen", y = "Million Cells/mL", 
       size = "Temperature (C)", color = "Environmental Group",
       title = "Does the level of total nitrogen affect cell abundance?") +
  geom_smooth(method=lm, level = 0.99)+
  theme_minimal()

ggsave("NitrogenAbundancePlot.png", last_plot())

ggplot(data= sample_data) +
  aes(x = total_phosphorus, y = cells_per_ml/1000000, color = env_group) +
  geom_point(aes(size = temperature))+
  labs(x =  "Total Phosphorous", y = "Million Cells/mL", 
       size = "Temperature (C)", color = "Environmental Group",
       title = "Does the level of total phosphorous affect cell abundance?") +
  geom_smooth(method=lm, level = 0.99)
ggsave("PhosphorousAbundancePlot.png", last_plot())
