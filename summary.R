library(tidyverse)
prison_pop_url <- "https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true"
prison_pop <- read.csv(prison_pop_url, header = TRUE, stringsAsFactors = FALSE)

jail_pop_url <- "https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-jail-pop.csv?raw=true"
jail_pop <- read.csv(jail_pop_url, header = TRUE, stringsAsFactors = FALSE)

pop_per_hundred_thousand_url <- "https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-jail-rates.csv?raw=true"
pop_per_hundred_thousand <- read.csv(pop_per_hundred_thousand_url, header = TRUE, stringsAsFactors = FALSE)

per_hundred_thousand_1990_url <- "https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-jail-rates-1990.csv?raw=true"
per_hundred_thousand_1990 <- read.csv(per_hundred_thousand_1990_url, header = TRUE, stringsAsFactors = FALSE)

per_hundred_thousand_1990_wa_url <- "https://github.com/melaniewalsh/Neat-Datasets/raw/main/us-prison-jail-rates-1990-WA.csv"
per_hundred_thousand_1990_wa <- read.csv(per_hundred_thousand_1990_wa_url, header = TRUE, stringsAsFactors = FALSE)

# Values 1 and 2: county/state with lowest & highest prison pop in most recent yr
most_recent_year <- max(prison_pop$year)
recent_year_data <- prison_pop %>%
  filter(year == most_recent_year)

highest_prison_pop_data <- recent_year_data %>%
  slice_max(order_by = total_pop_15to64, n = 1)

lowest_prison_pop_data <- recent_year_data %>%
  slice_min(order_by = total_pop_15to64, n = 1)

highest_prison_pop_info <- paste(
  highest_prison_pop_data$county_name, highest_prison_pop_data$state,
  highest_prison_pop_data$urbanicity, sep = ", "
  )
lowest_prison_pop_info <- paste(
  lowest_prison_pop_data$county_name, lowest_prison_pop_data$state,
  lowest_prison_pop_data$urbanicity, sep = ", "
  )

# Value 3: Finding percent change in incarceration rates of Black
# individuals over entire time frame in King County
wa_black_prison_pop <- per_hundred_thousand_1990_wa %>%
  filter(county_name == "King County", !is.na(black_prison_pop_rate))

earliest_prison_pop_king_county <- wa_black_prison_pop %>%
  filter(!is.na(black_prison_pop_rate)) %>%
  filter(year == min(year)) %>%
  pull(black_prison_pop_rate)

latest_prison_pop_king_county <- wa_black_prison_pop %>%
  filter(!is.na(black_prison_pop_rate)) %>%
  filter(year == max(year)) %>%
  pull(black_prison_pop_rate)


incarceration_difference_king_county <- latest_prison_pop_king_county -
  earliest_prison_pop_king_county

# Values 4 and 5:  The fourth and fifth value will be the maximum jail 
# population rate for both white and Black individuals
max_white_jail_pop <- jail_pop %>%
  pull(white_jail_pop) %>%
  max(na.rm = TRUE)

max_black_jail_pop <- jail_pop %>%
  pull(black_jail_pop) %>%
  max(na.rm = TRUE)

# Value 6: Extracting info for values 4 and 5 (happen to be same year and county)
year_of_values_4_5 <- jail_pop %>%
  filter(white_jail_pop==max_white_jail_pop) %>%
  pull(year)

county_of_values_4_5 <- jail_pop %>%
  filter(white_jail_pop==max_white_jail_pop) %>%
  pull(county_name)

state_of_values_4_5 <- jail_pop %>%
  filter(white_jail_pop==max_white_jail_pop) %>%
  pull(state)

value_4_5_info <- paste(county_of_values_4_5, state_of_values_4_5,
                        year_of_values_4_5, sep = ", ")





