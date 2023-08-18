library(ggplot2)
library(tidyverse)
library(maps)

per_hundred_thousand_1990_url <- "https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-jail-rates-1990.csv?raw=true"
per_hundred_thousand_1990 <- read.csv(per_hundred_thousand_1990_url, header = TRUE, stringsAsFactors = FALSE)

state_pop_filtered <- per_hundred_thousand_1990 %>%
  filter(!is.na(black_jail_pop_rate) & year == 2018) %>%
  group_by(state) %>%
  summarize(median_black_jail_pop_rate = median(black_jail_pop_rate))

abbr_to_full_state_name <- function(abbreviations) {
  state.abb <- toupper(state.abb)  
  state_names <- state.name[match(toupper(abbreviations), state.abb)]
  return(state_names)
}

state_pop_full_names <- data.frame(
  state = abbr_to_full_state_name(state_pop_filtered$state),
  median_black_jail_pop_rate = state_pop_filtered$median_black_jail_pop_rate)

state_pop_full_names$state[is.na(state_pop_full_names$state)] <- "District of Columbia"
state_pop_full_names$state <- tolower(state_pop_full_names$state)

state_shape <- map_data("state") %>%
  rename(state = region)

merged_data <- left_join(state_shape, state_pop_full_names, by = "state")

blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),        # remove axis lines
    axis.text = element_blank(),        # remove axis labels
    axis.ticks = element_blank(),       # remove axis ticks
    axis.title = element_blank(),       # remove axis titles
    plot.background = element_blank(),  # remove gray background
    panel.grid.major = element_blank(), # remove major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank()      # remove border around plot
  )

map_black_2018 <- ggplot(state_shape) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = merged_data$median_black_jail_pop_rate),
    color = "white", 
    linewidth = 0.1       
  ) +
  coord_map() +
  scale_fill_gradient(low = "#FFE1AC", high = "#691209",
                      breaks = c(min(merged_data$median_black_jail_pop_rate, na.rm = TRUE),
                                 max(merged_data$median_black_jail_pop_rate, na.rm = TRUE),
                                 (min(merged_data$median_black_jail_pop_rate, na.rm = TRUE) 
                                  + max(merged_data$median_black_jail_pop_rate, na.rm = TRUE)) / 2),
                      limits = c(min(merged_data$median_black_jail_pop_rate, na.rm = TRUE),
                                 max(merged_data$median_black_jail_pop_rate, na.rm = TRUE))) +
  labs(fill = "Median Black Jail Rate by State Per Hundred Thousand (2018)") +
  blank_theme
