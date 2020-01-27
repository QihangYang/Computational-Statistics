# HW5: Data manipulation
#'
# In this exercise, we will learn how to manipulate data using the dataset `mobility.csv`.
# You are not allowed to use any `for`, `while` or `repeat` in this exercise.
#'
# 1. Load the `tidyr`, `readr`, and `dplyr` packages.
#    Read the Mobility dataset from path `data/mobility.csv` using `read_csv()`
#    and save it into a tibble named `mobility`.
#    To check your solution, `mobility` prints to:
#    # A tibble: 729 x 6
#    Name             Mobility State Commute Longitude Latitude
#    <chr>               <dbl> <chr>   <dbl>     <dbl>    <dbl>
#    1 Johnson City       0.0622 TN      0.325     -82.4     36.5
#    2 Morristown         0.0537 TN      0.276     -83.4     36.1
#    3 Middlesborough     0.0726 TN      0.359     -83.5     36.6
#    4 Knoxville          0.0563 TN      0.269     -84.2     36.0
#    5 Winston-Salem      0.0448 NC      0.292     -80.5     36.1
#    6 Martinsville       0.0518 VA      0.313     -80.3     36.7
#    7 Greensboro         0.0474 NC      0.305     -79.8     36.3
#    8 North Wilkesboro   0.0517 NC      0.289     -81.3     36.3
#    9 Galax              0.0796 VA      0.325     -81.0     36.6
#    10 Spartanburg        0.0431 SC      0.299     -81.8     34.9
#    # … with 719 more rows
## Do not modify this line!
library(tidyr)
library(readr)
library(dplyr)
mobility <- read_csv("data/mobility.csv")



# 2. Compute the number of appearance of state names from column `State`.
#    Order the column in alphabetical order using `arrange`.
#    Store the result into a tibble `count_by_state`.
#    To do that, you can use:
#      - `group_by` to group by state,
#      - `count` to count values,
#      - `arrange` to the order the result.
#    To check your solution, `count_by_state` prints to:
#    # A tibble: 51 x 2
#    # Groups:   State [51]
#    State     n
#    <chr> <int>
#    1 AK       13
#    2 AL       14
#    3 AR       18
#    4 AZ        5
#    5 CA       18
#    6 CO       17
#    7 CT        1
#    8 DC        1
#    9 DE        2
#    10 FL       16
#    # … with 41 more rows
## Do not modify this line!
count_by_state <- mobility %>%
  group_by(State) %>%
  count(State) %>%
  arrange(State)
count_by_state


# 3. For each state, compute the column mean and standard deviation for column `Commute` and `Mobility`.
#    Store the result in tibble `stats_by_state`, where the five columns are `State`, `Commute_mean`,
#    `Mobility_mean`, `Commute_sd`, and `Mobility_sd`.
#    To do that, you can use:
#      - `group_by` to group by state,
#      - `summarize_at` to get the statistics for the `Commute` and `Mobility` columns,
#        along with `mean` to compute mean and `sd` to compute standard deviation.
#    To check your solution, `stats_by_state` prints to:
#    # A tibble: 51 x 5
#      State Commute_mean Mobility_mean Commute_sd Mobility_sd
#      <chr>        <dbl>         <dbl>      <dbl>       <dbl>
#    1 AK           0.726        0.110      0.183      0.0396
#    2 AL           0.328        0.0540     0.0514     0.0156
#    3 AR           0.415        0.0724     0.0553     0.0236
#    4 AZ           0.398        0.0758     0.125      0.0249
#    5 CA           0.403        0.101      0.133      0.0162
#    6 CO           0.516        0.127      0.130      0.0423
#    7 CT           0.308        0.0786    NA         NA
#    8 DC           0.16         0.110     NA         NA
#    9 DE           0.304        0.0642     0.0757     0.00221
#    10 FL           0.283        0.0581     0.0441     0.00734
#    # … with 41 more rows
## Do not modify this line!
stats_by_state <- mobility %>%
  group_by(State) %>%
  summarize_at(c("Commute", "Mobility"), c("mean" = mean, "sd" = sd))
stats_by_state


# 4. Transform the `stats_by_state` into long form
#    which contains columns `State`, `Variable`, `Stat`, and `Value`.
#    Store the result into tibble `stats_by_state_longer`.
#    To do that, you can use:
#      - `pivot_longer` to gather the column `Commute_mean`, `Mobility_mean`, `Commute_sd`, and `Mobility_sd`,
#      - `separate` to separate the variable name column from the result of `pivot_longer`.
#    To check your solution, `stats_by_state_longer` prints to:
#    # A tibble: 204 x 4
#      State Variable Stat   Value
#      <chr> <chr>    <chr>  <dbl>
#    1 AK    Commute  mean  0.726
#    2 AK    Mobility mean  0.110
#    3 AK    Commute  sd    0.183
#    4 AK    Mobility sd    0.0396
#    5 AL    Commute  mean  0.328
#    6 AL    Mobility mean  0.0540
#    7 AL    Commute  sd    0.0514
#    8 AL    Mobility sd    0.0156
#    9 AR    Commute  mean  0.415
#    10 AR    Mobility mean  0.0724
#    # … with 194 more rows
## Do not modify this line!
stats_by_state_longer <- stats_by_state %>%
  pivot_longer(-State, names_to = "Variable_Stat", values_to = "Value") %>%
  separate(Variable_Stat, into = c("Variable", "Stat"))
stats_by_state_longer


# 5. Transform the `stats_by_state_longer` into a tibble `stats_by_state_ranked`
#    which contains columns `State`, `Commute`, and `Mobility`.
#    The column `Commute` contains the percentage rank of the mean of the `Commute` for each state,
#    and the column `Mobility` contains the percentage rank of the mean of the `Mobility` for each state.
#    Please order the result by descending `Commute`, and then descending `Mobility` to break ties
#    if two `Commute` ranks are equal.
#    To do that, you can use:
#      - `filter` to select the rows that contain mean values,
#      - `select` to remove the `Stat` column,
#      - `group_by` to group by `Commute` and `Mobility`,
#      - `mutate` and `percent_rank` to get the percentage rank,
#      - `pivot_wider` to spread the result into wide form,
#      - `arrange` to order the result.
#      - `percent_rank`to get the percentage rank.
#    To check your solution, `stats_by_state_ranked` prints to:
#    # A tibble: 51 x 3
#      State Commute Mobility
#      <chr>   <dbl>    <dbl>
#     1 AK       1.       0.66
#     2 MT       0.98     0.92
#     3 ND       0.96     1.
#     4 SD       0.94     0.9
#     5 WY       0.92     0.98
#     6 KS       0.9      0.84
#     7 NE       0.88     0.96
#     8 UT       0.86     0.94
#     9 NM       0.84     0.52
#     10 IA       0.82     0.86
#     # … with 41 more rows
## Do not modify this line!
stats_by_state_ranked <- stats_by_state_longer %>%
  filter(Stat == "mean") %>%
  select(-Stat) %>%
  group_by(Variable) %>%
  mutate(perc_rank = percent_rank(Value)) %>%
  select(-Value) %>%
  pivot_wider(names_from = Variable, values_from = perc_rank) %>%
  arrange(desc(Commute), desc(Mobility))
stats_by_state_ranked
  



# 6. Concatenate the mean `Latitude` and mean `Longitude` for each state by `_`
#    and save the result into tibble `coordinates`. Before concatenating, round
#    the mean `Latitude` to 3 digits and mean `Longitude` to 2 digits.
#    To do that, you can use:
#      - `group_by` to group by `State`,
#      - `summarize` and `mean `to get mean values,
#      - `round` to round the mean values,
#      - `unite` to paste the columns together.
#    To check your solution, `coordinates` prints to:
#    # A tibble: 51 x 2
#      State Coordinates
#      <chr> <chr>
#    1 AK    60.749_-150.9
#    2 AL    32.911_-86.74
#    3 AR    35.003_-92.3
#    4 AZ    33.924_-110.66
#    5 CA    37.696_-120.34
#    6 CO    38.831_-105.47
#    7 CT    41.628_-72.61
#    8 DC    38.926_-77.43
#    9 DE    39.055_-75.64
#     10 FL    28.669_-82.47
#    # … with 41 more rows
## Do not modify this line!
coordinates <- mobility %>%
  group_by(State) %>%
  summarize(Longitude_mean = round(mean(Longitude), digits = 2), Latitude_mean = round(mean(Latitude), digits = 3)) %>%
  unite("Coordinates", c(Latitude_mean, Longitude_mean))
coordinates



