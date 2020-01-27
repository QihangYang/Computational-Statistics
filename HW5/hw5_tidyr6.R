# HW5: football result dataset
# In this problem, we will deal with a dataset of national football game results from
# 1870s to now. You are not allowed to use loops `for`, `while`, and functions `sort`
# or `repeat` in this exercise.
#'
# 1. Load the file `data/football.csv` and save it into tibble `fu`.
#    It should have dimensions: `40,945 x 9` and looks like the following:
#    # A tibble: 40,945 x 9
#    date       home_team away_team home_score away_score tournament city    country  neutral
#    <date>     <chr>     <chr>          <dbl>      <dbl> <chr>      <chr>   <chr>    <lgl>
#  1 1872-11-30 Scotland  England            0          0 Friendly   Glasgow Scotland FALSE
#  2 1873-03-08 England   Scotland           4          2 Friendly   London  England  FALSE
#  3 1874-03-07 Scotland  England            2          1 Friendly   Glasgow Scotland FALSE
#  4 1875-03-06 England   Scotland           2          2 Friendly   London  England  FALSE
#  5 1876-03-04 Scotland  England            3          0 Friendly   Glasgow Scotland FALSE
#  6 1876-03-25 Scotland  Wales              4          0 Friendly   Glasgow Scotland FALSE
#  7 1877-03-03 England   Scotland           1          3 Friendly   London  England  FALSE
#  8 1877-03-05 Wales     Scotland           0          2 Friendly   Wrexham Wales    FALSE
#  9 1878-03-02 Scotland  England            7          2 Friendly   Glasgow Scotland FALSE
#  10 1878-03-23 Scotland  Wales              9          0 Friendly   Glasgow Scotland FALSE
#    # … with 40,935 more rows
## Do not modify this line!
library(readr)
library(dplyr)
library(tidyr)
fu <- read_csv("data/football.csv")


#  2. Sometimes, we want to know the year of a game happening instead of
#    the exact dates. So now we want to split the dates into three columns:
#    (`year`, `mon`, `day`) and save the result tibble to `fu_separated`.
#    To do that, you can use:
#       - `separate` to separate the first column `date`
#    (Hint : Use `sep = "[-]+"` in `separate`.)
#    To check your solution, `fu_separated` prints to:
#    # A tibble: 40,945 x 11
#    year  mon   day   home_team away_team home_score away_score tournament city    country  neutral
#    <chr> <chr> <chr> <chr>     <chr>          <dbl>      <dbl> <chr>      <chr>   <chr>    <lgl>
#    1 1872  11    30    Scotland  England            0          0 Friendly   Glasgow Scotland FALSE
#    2 1873  03    08    England   Scotland           4          2 Friendly   London  England  FALSE
#    3 1874  03    07    Scotland  England            2          1 Friendly   Glasgow Scotland FALSE
#    4 1875  03    06    England   Scotland           2          2 Friendly   London  England  FALSE
#    5 1876  03    04    Scotland  England            3          0 Friendly   Glasgow Scotland FALSE
#    6 1876  03    25    Scotland  Wales              4          0 Friendly   Glasgow Scotland FALSE
#    7 1877  03    03    England   Scotland           1          3 Friendly   London  England  FALSE
#    8 1877  03    05    Wales     Scotland           0          2 Friendly   Wrexham Wales    FALSE
#    9 1878  03    02    Scotland  England            7          2 Friendly   Glasgow Scotland FALSE
#    10 1878  03    23    Scotland  Wales              9          0 Friendly   Glasgow Scotland FALSE
#    # … with 40,935 more rows
## Do not modify this line!
fu_separated <- fu %>%
  separate(date, into = c("year", "mon", "day"), sep = "-")
fu_separated



# 3. Notice that the data is recorded per game instead of per team. But we also want
#    to have a list to record the game data per team with the following information:
#    `year`, `mon`, `day`, `home_score`, `away_score`, `tournament`, `city`, `country`,
#    `neutral`, `team_type`, `team`.
#    To do that, we need to list all the games each team played.
#    (so the same game will be recorded twice, one for home team and one for away team)
#    To do that, you can use:
#         - `pivot_longer to transform the `home_team` and `away_team` columns to
#          new columns `team` and `team_type` recording whether this team is `home_team`
#          or `away_team` in this game.
#    and save the result tibble into the tibble `fu_tidy`.
#    (Note: to use the correct version of `select`, write `select <- dplyr::select` beforehand).
#    To check your solution, `fu_tidy` prints to:
#    # A tibble: 81,890 x 11
#    year  mon   day   home_score away_score tournament city    country  neutral team_type team
#    <chr> <chr> <chr>      <dbl>      <dbl> <chr>      <chr>   <chr>    <lgl>   <chr>     <chr>
#    1 1872  11    30             0          0 Friendly   Glasgow Scotland FALSE   home_team Scotland
#    2 1872  11    30             0          0 Friendly   Glasgow Scotland FALSE   away_team England
#    3 1873  03    08             4          2 Friendly   London  England  FALSE   home_team England
#    4 1873  03    08             4          2 Friendly   London  England  FALSE   away_team Scotland
#    5 1874  03    07             2          1 Friendly   Glasgow Scotland FALSE   home_team Scotland
#    6 1874  03    07             2          1 Friendly   Glasgow Scotland FALSE   away_team England
#    7 1875  03    06             2          2 Friendly   London  England  FALSE   home_team England
#    8 1875  03    06             2          2 Friendly   London  England  FALSE   away_team Scotland
#    9 1876  03    04             3          0 Friendly   Glasgow Scotland FALSE   home_team Scotland
#    10 1876  03    04             3          0 Friendly   Glasgow Scotland FALSE   away_team England
#    # … with 81,880 more rows
## Do not modify this line!
fu_tidy <- fu_separated %>%
  pivot_longer(c(home_team, away_team), 
               names_to = "team_type",
               values_to = "team"
               )
fu_tidy


# 4. Now the two columns `home_score` and `away_score` are redundant for each team.
#    We just want the score of the team, not the scores of the two teams.
#    Namely, we want a tibble with the following information:
#    `year`, `mon`, `day`, `tournament`, `city`, `country`, `neutral`, `team`, `score`
#    To do that, you can use:
#         - `mutate` and `if_else` to record the `score` of that team
#         - `select` to extract all columns except `(team_type, home_score, away_score)`
#    Save the resulting tibble into `fu_team`.
#    To check your solution, `fu_team` prints to:
#    # A tibble: 81,890 x 9
#    year  mon   day   tournament city    country  neutral team     score
#    <chr> <chr> <chr> <chr>      <chr>   <chr>    <lgl>   <chr>    <dbl>
#    1 1872  11    30    Friendly   Glasgow Scotland FALSE   Scotland     0
#    2 1872  11    30    Friendly   Glasgow Scotland FALSE   England      0
#    3 1873  03    08    Friendly   London  England  FALSE   England      4
#    4 1873  03    08    Friendly   London  England  FALSE   Scotland     2
#    5 1874  03    07    Friendly   Glasgow Scotland FALSE   Scotland     2
#    6 1874  03    07    Friendly   Glasgow Scotland FALSE   England      1
#    7 1875  03    06    Friendly   London  England  FALSE   England      2
#    8 1875  03    06    Friendly   London  England  FALSE   Scotland     2
#    9 1876  03    04    Friendly   Glasgow Scotland FALSE   Scotland     3
#    10 1876  03    04    Friendly   Glasgow Scotland FALSE   England      0
#    # … with 81,880 more rows
## Do not modify this line!
fu_team <- fu_tidy %>%
  mutate(score = if_else(team_type == "home_team", home_score, away_score)) %>%
  select(-c(team_type, home_score, away_score))
fu_team



# 5. The `city` and `country` column represents where the game was held.
#    We want to concatenate the city and country information into one column
#    called `place` based on our team table `fu_team`.
#    To do that, you can use:
#          - `unite` to combine `city` and `country`
#    Save the result tibble to `fu_city`.
#    To check your solution, `fu_city` prints to:
#    # A tibble: 81,890 x 8
#    year  mon   day   tournament place            neutral team     score
#    <chr> <chr> <chr> <chr>      <chr>            <lgl>   <chr>    <dbl>
#    1 1872  11    30    Friendly   Glasgow_Scotland FALSE   Scotland     0
#    2 1872  11    30    Friendly   Glasgow_Scotland FALSE   England      0
#    3 1873  03    08    Friendly   London_England   FALSE   England      4
#    4 1873  03    08    Friendly   London_England   FALSE   Scotland     2
#    5 1874  03    07    Friendly   Glasgow_Scotland FALSE   Scotland     2
#    6 1874  03    07    Friendly   Glasgow_Scotland FALSE   England      1
#    7 1875  03    06    Friendly   London_England   FALSE   England      2
#    8 1875  03    06    Friendly   London_England   FALSE   Scotland     2
#    9 1876  03    04    Friendly   Glasgow_Scotland FALSE   Scotland     3
#    10 1876  03    04    Friendly   Glasgow_Scotland FALSE   England      0
#    # … with 81,880 more rows
## Do not modify this line!
fu_city <- fu_team %>%
  unite("place", c(city, country), sep = "_") 
fu_city


# 6. We want to see how the annual average goal number of the english team
#    changes over the years.
#    To do that, you can use:
#      - `filter()` to select the England team
#      - `group_by()` and `summarize()` to calculate the annual
#    average goal number(store in a column called `avg_goal`)
#    Save the result tibble into `fu_england`
#    To check your solution, `fu_england` prints to:
#    # A tibble: 139 x 2
#    year  avg_goal
#    <chr>    <dbl>
#    1 1872       0
#    2 1873       4
#    3 1874       1
#    4 1875       2
#    5 1876       0
#    6 1877       1
#    7 1878       2
#    8 1879       3.5
#    9 1880       3.5
#    10 1881       0.5
#    # … with 129 more rows
## Do not modify this line!
fu_england <- fu_city %>%
  filter(team == "England") %>%
  group_by(year) %>%
  summarize(avg_goal = mean(score))
fu_england




