# Lib 
library(readr)

# Import file 
nz_bird <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-11-19/nz_bird.csv")
boty <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-11-19/BOTY-votes-2019.csv")

# Save
save(nz_bird, boty, file="Rdata/get_data.Rdata")

