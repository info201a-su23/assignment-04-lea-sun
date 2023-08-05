library(ggplot2)


jail_pop_data <- jail_pop %>%
  select(county_name, state, total_pop, total_pop_15to64) %>%
  na.omit()

chart2 <- ggplot(jail_pop_data, aes(x = total_pop, y = total_pop_15to64)) +
  geom_point() +
  labs(x = "Total Population", y = "15-64 Jail Population Rate", 
       title = "Relationship between Jail Population Rate and Total Population") 