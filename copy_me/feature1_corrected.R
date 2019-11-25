# Feature 1 - correction
# Simple barplot of the rank 1 among votes

# All 10 features have been taken into account

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
str(top_votes_1)

# Plot first 8
votes_1_plot <- ggplot(top_votes_1, aes(x = reorder(bird_breed, -total), y = total, fill = bird_breed)) +
  geom_bar(stat = 'identity', col="black") +
  geom_text(aes(label=total), vjust=-1) + 
  scale_fill_manual(values = my_palette)+
  theme_classic()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = 'black'),
        plot.title = element_text(size=18),
        axis.text.x = element_text(angle = 45, hjust = 1),
        plot.caption = element_text(face = "italic"),
        legend.position = 'none')+
  scale_y_continuous(expand = c(0,350))+
  labs(title="Best ranked birds in New Zealand",
    caption = "Data source: Rtidytuesday") +
  xlab('Bird Breed')+
  ylab('Number of Votes')

votes_1_plot

# Save the plot
ggsave(votes_1_plot, file="plots/feature1_correction.png", width=9, height=7)

