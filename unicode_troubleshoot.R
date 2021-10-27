# Unicode troubleshoot
# I am not able to add Indian rupee symbol ₹ to ggplot title

# dummy data
dat <- data.frame(x = c(1,2,3,4,5),
                  y = c(1,2,3,4,5))
# loading libraries
library(tidyverse)

ggplot(dat, aes(x, y)) +
  geom_point(shape= "\u20b9", size = 8)

ggsave("greek.png")

# printing to console
a <- "\U1F418"
cat(a)

