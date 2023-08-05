library(ggplot2)

race_prison_pop <- pop_per_hundred_thousand %>%
  select(year, aapi_prison_pop_rate, black_prison_pop_rate, latinx_prison_pop_rate,
         native_prison_pop_rate, white_prison_pop_rate) %>%
  na.omit()

chart1 <- ggplot(race_prison_pop, aes(x = year)) +
  geom_line(aes(y = aapi_prison_pop_rate, color = "AAPI")) +
  geom_line(aes(y = black_prison_pop_rate, color = "Black")) +
  geom_line(aes(y = latinx_prison_pop_rate, color = "Latinx")) +
  geom_line(aes(y = native_prison_pop_rate, color = "Native")) +
  geom_line(aes(y = white_prison_pop_rate, color = "White")) +
  labs(x = "Year", y = "Prison Population Rate", color = "Racial Group") +
  ggtitle("Prison Population Rate by Race Over Time") 
