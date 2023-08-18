library(ggplot2)
library(dplyr)

per_hundred_thousand_1990_wa_url <- "https://github.com/melaniewalsh/Neat-Datasets/raw/main/us-prison-jail-rates-1990-WA.csv"
per_hundred_thousand_1990_wa <- read.csv(per_hundred_thousand_1990_wa_url, header = TRUE, stringsAsFactors = FALSE)

filtered_data <- per_hundred_thousand_1990_wa %>%
  filter(county_name == "King County" & year >= 1990 & 
           year <= 2018 & !is.na(black_jail_pop_rate)) %>%
  select(year, black_jail_pop_rate)

chart2 <- ggplot(filtered_data, aes(x = year, y = black_jail_pop_rate)) +
  geom_point() +
  labs(title = "Black Jail Population Rate in King County, WA",
       x = "Year (1990-2018)",
       y = "Black Jail Population Rate (per hundred thousand)")