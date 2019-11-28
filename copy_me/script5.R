# Lib
library(ggrepel)
library(tidyverse)
library(emojifont)
library(grid)
library(ggpubr)
devtools::install_github("hadley/emo")
library(emo)

# Load data
# nz_bird <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-11-19/nz_bird.csv")
load('Rdata/get_data.Rdata')

# Features
# 1) remove the fill parameter causing a warning in plot1
# 2) assemble all plots in one


# --------------------------------------------------- # 
#               PLOT 1                                #
# --------------------------------------------------- # 

# data
df <- nz_bird%>%
  filter(vote_rank=='vote_1')%>%
  count(bird_breed)%>%
  top_n(5,n)

# NZ image
imgage <- png::readPNG('img/newzealand.png')
a <- grid::rasterGrob(imgage, interpolate = T) 

# Plot 1
g1 <- ggplot(df,aes(x=bird_breed,y=n,fill=bird_breed))+
  geom_col(position = 'dodge',color='#2a2a2a',
           show.legend = F)+
  geom_text(aes(label=n),
            position=position_dodge(width=0.9),
            vjust=-0.25,
            color='white',
            size=10 ) +
  annotation_custom(a, xmin =0, xmax = 3,
                    ymin=4000 ,ymax=7000) +
  ylim(0,7000)+
  theme_bw()+
  annotate("text",
           label = 'Bird of the Year',
           x = 3, y = 6000, size = 10,
           fill ='#fffeea',
           colour ="white")+
  theme(plot.background = element_rect(color='black',fill='black'),
        panel.background =  element_rect(color='black',fill='black'),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        axis.text.x = element_text(size=14,face = 'bold',
                                   color = 'white'))


g1

# --------------------------------------------------- # 
#               PLOT 2                                #
# --------------------------------------------------- # 

# Format data for plot
df_ye <- nz_bird %>% 
  filter(bird_breed=='Yellow-eyed penguin') %>%
  count(vote_rank) %>%
  mutate(emoji=emojifont::emoji('star'))

# Add measures
df_ye$percentage = 
  df_ye$n / sum(df_ye$n)* 100
df_ye = df_ye[rev(order(df_ye$percentage)), ]
df_ye$ymax = cumsum(df_ye$percentage)
df_ye$ymin = c(0, head(df_ye$ymax, n = -1))
df_ye

# Plot
g2 <- ggplot(df_ye,
             aes(fill = vote_rank, ymax = ymax, ymin = ymin, xmax = 100, xmin = 50)) +
  geom_rect(colour = "black",show.legend = F) +
  coord_polar(theta = "y")  +
  xlim(c(0, 100)) +
  geom_label_repel(
    aes(label = paste(vote_rank,"\n",round(percentage,2),"%"),
        x = 100,
        y = (ymin + ymax)/2),
    inherit.aes = F,
    show.legend = F, size = 4,
    fill ='#fffeea',
    box.padding = unit(0.35, "lines"),
    point.padding = unit(0.3, "lines"), fontface = 'bold',
    hjust=0, vjust=1, segment.size = 0) +
  annotate("text", x = 0, y = 0, size = 6,
           label = "Yellow Eyed \n penguin",color='white') +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        axis.text.y = element_blank(),
        axis.text.x =element_blank(),
        axis.ticks = element_blank(),
        panel.background = element_rect(color='black',fill='black'),
        plot.background = element_rect(color='black',fill='black'))

g2

# --------------------------------------------------- # 
#               PLOT 3                                #
# --------------------------------------------------- # 

imgage_b <- png::readPNG('img/yellow-eyed-penguin.png')

g3 <- ggplot()+
  annotation_custom(rasterGrob(imgage_b,
                               width = unit(1,"npc"),
                               height = unit(1,"npc")),
                    -Inf, Inf, -Inf, Inf) +
  theme(plot.background = element_rect(colour = 'black',fill='black'),
        panel.background = element_rect(colour =  'black',fill='black'),
        plot.caption = element_text(color = 'white',size=10)
  )

g3

# --------------------------------------------------- # 
#               PLOT ALL                              #
# --------------------------------------------------- # 


map <- ggplot()+
  geom_sf(data=spData::nz,color='black',fill='gray')+
  coord_sf() +
  theme_void()+
  theme(plot.background = element_rect(color='black',fill='black'),
        panel.background =  element_rect(color='black',fill='black'))


# Arrange all plots
all_plots <- ggarrange(g3,  g2,map,
          ncol = 3, nrow = 1,widths= c(.8,1.5,.7) )+
  labs(caption=paste0("Source: New Zealand Forest and Bird Orginization  | by @r0mymendez", emo::ji("heart")),
       subtitle = ' ',
       title='New Zealand Bird of the Year') +
  theme(plot.background = element_rect(fill='black',color ='#2a2a2a'),
        plot.caption = element_text(colour = 'white',size = 13,hjust = 1,
                                    face = 'bold'),
        plot.title  = element_text(colour = 'white',size = 40,hjust = 0.5,
                                   face = 'bold'),
        plot.margin = unit(c(1,0,0.1,1), "cm"))

all_plots

# Save
ggsave("plots/script5.png", all_plots, width = 12, height=8)


