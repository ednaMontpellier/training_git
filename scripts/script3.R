# Lib
library(tidyverse)
library(lubridate)
library(tidyr)

# Features:
# 1) Change colors of birds names to the color of the line 
# 1 bis) pretty legend
# 2) Change point shape to triangle

# Import data

# nz_bird <- readr::read_csv(str_c(
#   "https://raw.githubusercontent.com/",
#   "rfordatascience/tidytuesday/master/",
#   "data/2019/2019-11-19/nz_bird.csv"))

load("Rdata/get_data.Rdata")

# Format
vote_scores <- tibble(vote_rank = 
                        c("vote_1", "vote_2", "vote_3", "vote_4", "vote_5"),
                      vote_score =
                        c(5:1)
)

# Format date
nz_bird$date <- ymd(nz_bird$date)

# Format data
dates <- tibble(date = unique(nz_bird$date))
birds <- tibble(bird_breed = sort(unique(nz_bird$bird_breed[!is.na(nz_bird$bird_breed)])))
matrix <- expand_grid(dates,birds)

# join data
bird_matrix <- matrix %>%
  left_join(nz_bird)

# Format data
bird_scores <- bird_matrix %>%
  left_join(vote_scores) %>%
  select(date,bird_breed, vote_score) %>%
  group_by(date, bird_breed) %>%
  summarize(daily_score= sum(vote_score), daily_votes = n(), 
            daily_avg = daily_score/daily_votes) %>% 
  ungroup() %>% 
  select(date, bird_breed, daily_score, daily_votes) %>% 
  group_by(bird_breed) %>% 
  mutate(cum_score = cumsum(daily_score), cum_votes = cumsum(daily_votes)) %>% 
  ungroup()

# Format ranked data
ranked <- bird_scores %>%
  group_by(date) %>% 
  arrange(desc(cum_score)) %>% 
  mutate(rank = row_number()) %>%
  ungroup() %>%
  arrange(date, bird_breed) %>% 
  filter(rank <= 10)

# Plot 
ggplot(ranked, aes(x=date, y=rank)) +
  geom_point(aes(color = bird_breed)) +
  geom_line(aes(color = bird_breed)) +
  geom_text(data = subset(ranked, ranked$date == min(ranked$date)), 
            aes(date, rank, label = bird_breed, color = bird_breed), size = 2,
            nudge_y = 0.2, nudge_x = 0.5) +
  geom_text(data = subset(ranked, ranked$date == max(ranked$date)), 
            aes(date, rank, label = bird_breed, color = bird_breed), size = 2,
            nudge_y = 0.2, nudge_x = -0.5) +
  scale_y_reverse(breaks = 1:10, labels = c("1st", "2nd", "3rd", str_c(4:10,"th"))) +
  scale_x_date(breaks = seq(from = min(ranked$date), to = max(ranked$date), by = "day"),
               labels = c("First Day", rep("",(length(unique(ranked$date))-2)), "Final Day")) +
  labs(title = "New Zealand Bird of the Year", 
       subtitle = "Daily Progression of Top 10 Rankings",
       y = "", x = "Voting Period",
       color = "Bird Breed") +
  theme(legend.key = element_rect(fill = NA),
        panel.background=element_rect(fill = NA), axis.ticks.y = element_line(size = NA))

# Save
ggsave('plots/script3_EB.png', width=10, height=8)
