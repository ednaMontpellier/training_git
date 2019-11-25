# Lib 
library(readr)

# Import file 
nz_bird <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-11-19/nz_bird.csv")

# Save
save(nz_bird, file="Rdata/get_data.Rdata")

