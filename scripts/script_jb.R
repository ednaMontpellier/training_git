# Feature 1 
# Simple barplot of the rank 1 among votes

# List of 10 features to change in this script:
# 1) Change barplot colors by the provided palette 
# 2) Change x axis angle
# 3) Add contouring in barblot
# 4) Rename title to be more explicit: "Best ranked bird in New Zealand"
# 5) Add a caption: "Data source: Rtidytuesday' 
# 6) Change theme to classic
# 7) Add the number of observations on top on each bar
# 8) Change the caption font to italic
# 9) Change the order of birds by sorted abundance in x axis
# 10) Change title size to 18

# Lib
library(readr)
library(dplyr)
library(viridisLite)
library(devtools)
devtools::install_github("katiejolly/nationalparkcolors", force=TRUE)
library(nationalparkcolors)
library(ggplot2)

# Data for reading special characters:
# Sys.setlocale("LC_ALL", "German")
# options(encoding = "UTF-8")

# Set color palette for plots:
my_palette <- park_palette('GeneralGrant')

# Read in data:
# nz_bird <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-11-19/nz_bird.csv")
load("Rdata/get_data.Rdata")

# inspect data
str(nz_bird)
nz_bird$bird_breed <- as.factor(nz_bird$bird_breed)
levels(nz_bird$bird_breed)
# Remove NAs
nz_bird <- na.omit(nz_bird)

# Extract vote1
votes1 <- nz_bird %>%
  filter(vote_rank == 'vote_1') %>%
  group_by(bird_breed) %>%
  summarise(total = n())

# Inspect
str(votes1)
votes1 <- arrange(votes1, desc(total))
# Extract the first 8 ones
top_votes_1 <- votes1[1:8,]
str(top_votes)

# Plot first 8
votes_1_plot <- ggplot(top_votes_1, aes(x = bird_breed, y = total, fill = bird_breed))+
  geom_bar(stat = 'identity')+
  # scale_fill_manual(values = my_palette)+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = 'black'),
        axis.text.x = element_text(angle = 0, hjust = 1),
        legend.position = 'none')+
  scale_y_continuous(expand = c(0,0))+
  ggtitle('Vote Rank 1')+
  xlab('Bird Breed')+
  ylab('Number of Votes')
votes_1_plot

# Save the plot
ggsave(votes_1_plot, file="plots/script1.png", width=6, height=5)

