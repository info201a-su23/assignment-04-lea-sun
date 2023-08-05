library(ggplot2)
library(maps)
library(mapproj)

prison_pop_black <- prison_pop %>%
  pull(black_prison_pop) %>%
  na.omit()

map <- map_data("usa")

ggplot() +
  geom_polygon(data = map, aes(x = long, y = lat, group = group), fill = "lightgray") +
  geom_point(data = prison_pop, aes(x = Longitude, y = Latitude, size = prison_pop_black)) +
  scale_size_continuous(name = "Black Prison Population") +
  theme_minimal()

black_jail_pop_filter <- pop_per_hundred_thousand %>%
  select(county_name, state, black_prison_pop_rate)

black_prison_pop_filter <- black_prison_pop_filter[!duplicated(
  black_prison_pop_filter$county_name), ]

county_map <- map_data("county")

black_prison_pop_filter <- black_prison_pop_filter %>%
  rename(subregion = county_name)

black_prison_pop_filter <- black_prison_pop_filter[
  !is.na(black_prison_pop_filter$black_prison_pop_rate), ]

map_data <- merge(county_map, black_prison_pop_filter, by = "subregion", 
                  all.x = TRUE)

map <- ggplot() +
  geom_polygon(data = map_data, aes(x = long, y = lat, group = group, fill = black_prison_pop_rate)) +
  coord_map() +
  theme_minimal() +
  labs(title = "Distribution of Incarcerated Black Individuals Across Counties",
       fill = "Black Prison Population Rate") +
  theme(legend.position = "right")

