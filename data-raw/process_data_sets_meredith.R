library(tidyverse)
library(stringr)
library(lubridate)
library(janitor)
library(usethis)


# ahca_polls ----------------------------------------------------------------------
ahca_polls <- read_csv("data-raw/ahca-polls/ahca_polls.csv") %>%
  clean_names() %>%
  mutate(
    start = as.Date(start, "%m/%d/%y"),
    end = as.Date(end, "%m/%d/%y"),
    pollster = as.factor(pollster)
  )
usethis::use_data(ahca_polls, overwrite = TRUE)



# bachelorette ---------------------------------------------------------------------
bachelorette <- read_csv("data-raw/bachelorette/bachelorette.csv") %>%
  clean_names() %>%
  mutate_at(vars(starts_with("elimination")), as.factor) %>%
  mutate_at(vars(starts_with("elimination")), funs(ifelse(. == "<NA>", NA, .))) %>%
  mutate_at(vars(starts_with("dates")), as.factor) %>%
  mutate_at(vars(starts_with("dates")), funs(ifelse(. == "<NA>", NA, .))) %>%
  mutate(season = as.integer(season)) %>%
  filter(season != "SEASON")
usethis::use_data(bachelorette, overwrite = TRUE)



# candy-power-rankings -------------------------------------------------------------
candy_rankings <- read_csv("data-raw/candy-power-ranking/candy-data.csv") %>%
  clean_names() %>%
  mutate(
    chocolate = as.logical(chocolate),
    fruity = as.logical(fruity),
    caramel = as.logical(caramel),
    peanutyalmondy = as.logical(peanutyalmondy),
    nougat = as.logical(nougat),
    crispedricewafer = as.logical(crispedricewafer),
    hard = as.logical(hard),
    bar = as.logical(bar),
    pluribus = as.logical(pluribus)
  ) %>%
  mutate(win)
  mutate_at(vars(competitorname), funs(gsub("Õ", "'", .)))
usethis::use_data(candy_rankings, overwrite = TRUE)



# chess-transfers ----------------------------------------------------------------
chess_transfers <- read_csv("data-raw/chess-transfers/transfers.csv") %>%
  clean_names() %>%
  mutate(
    transfer_date = as.Date(transfer_date, "%m/%d/%y"),
    id = as.character(id)
  )
usethis::use_data(chess_transfers, overwrite = TRUE)



# congress-generic-ballot --------------------------------------------------------
# generic_polllist
generic_polllist <-
  read_csv("https://projects.fivethirtyeight.com/generic-ballot-data/generic_polllist.csv") %>%
  clean_names() %>%
  mutate(
    modeldate = as.Date(modeldate, "%m/%d/%Y"),
    startdate = as.Date(startdate, "%m/%d/%Y"),
    enddate = as.Date(enddate, "%m/%d/%Y"),
    createddate = as.Date(createddate, "%m/%d/%Y"),
    timestamp = parse_date_time(timestamp, "HMS dmY"),
    subgroup = as.factor(subgroup),
    pollster = as.factor(pollster),
    grade = factor(grade, levels = rev(c("A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-")), ordered = TRUE),
    population = as.factor(population),
    poll_id = as.character(poll_id),
    question_id = as.character(question_id)
  ) %>%
  mutate_at(vars(multiversions), funs(ifelse(. == "<NA>", NA, .)))
usethis::use_data(generic_polllist, overwrite = TRUE)


# generic_topline
generic_topline <-
  read_csv("https://projects.fivethirtyeight.com/generic-ballot-data/generic_topline.csv") %>%
  clean_names() %>%
  mutate(
    modeldate = as.Date(modeldate, "%m/%d/%Y"),
    timestamp = parse_date_time(timestamp, "HMS dmY"),
    subgroup = as.factor(subgroup)
  )
usethis::use_data(generic_topline, overwrite = TRUE)



# inconvenient-sequel ----------------------------------------------------------
ratings <- read_csv("data-raw/inconvenient-sequel/ratings.csv") %>%
  mutate(category = as.factor(category)) %>% 
  rename(
    votes_1 = `1_votes`, votes_2 = `2_votes`, votes_3 = `3_votes`, 
    votes_4 = `4_votes`, votes_5 = `5_votes`, votes_6 = `6_votes`,
    votes_7 = `7_votes`, votes_8 = `8_votes`, votes_9 = `9_votes`,
    votes_10 = `10_votes`,
    pct_1 = `1_pct`, pct_2 = `2_pct`, pct_3 = `3_pct`, pct_4 = `4_pct`,
    pct_5 = `5_pct`, pct_6 = `6_pct`, pct_7 = `7_pct`, pct_8 = `8_pct`,
    pct_9 = `9_pct`, pct_10 = `10_pct`
  ) %>% 
  # Given that data frame is large, only include preview of data in package:
  slice(1:10)
usethis::use_data(ratings, overwrite = TRUE)



# mayweather-mcgregor ---------------------------------------------------------------
mayweather_mcgregor_tweets <- read_csv("data-raw/mayweather-mcgregor/tweets.csv") %>%
  mutate(
    emojis = as.logical(emojis),
    retweeted = as.logical(retweeted),
    id = as.character(id)
  ) %>% 
  slice(1:10)
usethis::use_data(mayweather_mcgregor_tweets, overwrite = TRUE)



# mlb-elo ---------------------------------------------------------------------------
mlb_elo <- read_csv("https://projects.fivethirtyeight.com/mlb-api/mlb_elo.csv") %>%
  mutate(
    playoff = as.factor(playoff),
    playoff = ifelse(playoff == "<NA>", NA, playoff),
    neutral = as.logical(neutral)
  ) %>%
  slice(1:100)
usethis::use_data(mlb_elo, overwrite = TRUE)



# soccer-spi ------------------------------------------------------------------------
# spi_matches
spi_matches <- 
  "https://projects.fivethirtyeight.com/soccer-api/club/spi_matches.csv" %>% 
  read_csv() %>% 
  # Given that data frame is large, only include preview of data in package:
  slice(1:10)
usethis::use_data(spi_matches, overwrite = TRUE)

#spi_global_rankings
spi_global_rankings <-
  read_csv("https://projects.fivethirtyeight.com/soccer-api/club/spi_global_rankings.csv")
usethis::use_data(spi_global_rankings, overwrite = TRUE)
