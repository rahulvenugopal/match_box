# matchbox price viz
# author @ Rahul Venugopal
# this dataviz is inspired by the twitter post from "India in pixels"
# many thanks to Sarah 145 which inspired the viz
# thanks to 30 days chart challenge in twitter too

library(ggtext)
library(tidyverse)
library(ggthemes)

sysfonts::font_add_google(name = "Roboto Mono")
sysfonts::font_add_google(name = "Roboto", regular.wt = 100)
showtext::showtext_auto()
sym <- "<img src='matchbox.png' width='7.5'/>"

# create dataframe - data from @COVID19DataIE on Twitter
df <- tribble(
  ~year, ~number,
  "1950", 40,
  "1960", 20,
  "1970", 13,
  "1980", 8,
  "1994", 4,
  "2007", 2,
  "2021", 1
)

      plot_df <- df %>% 
        mutate(n_sym = number) %>% 
        group_by(year) %>%
        expand(year, 1:n_sym) %>%
        rename(n_sym = `1:n_sym`)
      
      ggplot(plot_df, aes(y= n_sym, x = year, label = sym)) +
        geom_richtext(fill = NA, color = 'black', label.color = NA, label.padding = grid::unit(rep(0, 4), "pt")) +
        
        geom_text(data = data.frame(x=df$year, 
                                    y=df$number,
                                    label=prettyNum(df$number,
                                                    big.mark = ',')),
                  aes(x=x,y=y+1.8,label=label),
                  family = 'Roboto Mono',
                  size = 4.5, vjust = 0.4,
                  color = '#a01f00') +
        
        labs(title = 'How many matchboxes can we buy<br> if we time travel with 2 rupees', 
             subtitle = 'After 14 years, the All India Chamber of Matches<br> in Sivakasi decided to change the matchbox price<br> from 1 to 2 rupees because of rising costs and inflation',
             x = NULL, y = NULL,
             caption = '**Visualisation:** Rahul Venugopal') +
        theme_tufte() +
        theme(axis.ticks.x = element_blank(),
              axis.text.y = element_text(family = "Roboto Mono", size = 10,
                                         color = '#a01f00', hjust = 0.5),
              axis.text.x = element_blank(),
              plot.title = element_markdown(family = "Roboto Mono", color = '#d1111a', size = 18),
              plot.subtitle = element_markdown(family = "Roboto Mono", color = '#746572', size = 10, lineheight = 1),
              plot.title.position = 'plot',
              plot.caption = element_markdown(family = "Roboto", size = 8,
                                              color = 'black', hjust = 1),
              plot.margin = margin(t = 20, b = 20, l = 20, r = 20)) +
        coord_flip(clip = 'off') 
      
      ggsave('02-pictogram.pdf',
      width = 6, height = 4,
      dpi = 300,
      device = cairo_pdf)