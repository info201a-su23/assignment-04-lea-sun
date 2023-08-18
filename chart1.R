library(tidyverse)
library(ggplot2)

pop_per_hundred_thousand_url <- "https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-jail-rates.csv?raw=true"
pop_per_hundred_thousand <- read.csv(pop_per_hundred_thousand_url, header = TRUE, stringsAsFactors = FALSE)

mean_race_jail_pop <- pop_per_hundred_thousand %>%
  group_by(year) %>%
  summarize(
    mean_aapi_jail_pop = mean(aapi_jail_pop_rate, na.rm = TRUE),
    mean_black_jail_pop = mean(black_jail_pop_rate, na.rm = TRUE),
    mean_latinx_jail_pop = mean(latinx_jail_pop_rate, na.rm = TRUE),
    mean_native_jail_pop = mean(native_jail_pop_rate, na.rm = TRUE),
    mean_white_jail_pop = mean(white_jail_pop_rate, na.rm = TRUE)
  )

chart1 <- ggplot(mean_race_jail_pop, aes(x = year)) +
  geom_line(aes(y = mean_aapi_jail_pop, color = "AAPI"), na.rm = TRUE) +
  geom_line(aes(y = mean_black_jail_pop, color = "Black"), na.rm = TRUE) +
  geom_line(aes(y = mean_latinx_jail_pop, color = "Latinx"), na.rm = TRUE) +
  geom_line(aes(y = mean_native_jail_pop, color = "Native"), na.rm = TRUE) +
  geom_line(aes(y = mean_white_jail_pop, color = "White"), na.rm = TRUE) +
  labs(x = "Year (1990 to 2018)", y = "Mean Population Rate (per hundred thousand)", 
       color = "Racial Group") +
  ggtitle("Mean Jail Population Rate by Race Over Time") +
  scale_x_continuous(limits = c(1990, max(mean_race_jail_pop$year)), 
                     breaks = seq(1990, max(mean_race_jail_pop$year), by = 5))
