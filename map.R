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
  scale_size_continuous(name = "Black Prison Population Across Country") +
  theme_minimal()

