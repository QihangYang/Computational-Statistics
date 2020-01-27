# HW5: more data manipulation
#'
# For this exercise, we will explore NYC airbnb dataset.
#'
# 1. Load the `data/Airbnb_NYC_2019.csv` dataset and assign it to a tibble `airbnb`.
#    To check your result, `airbnb` prints to:
#    # A tibble: 48,895 x 16
#    id name  host_id host_name neighbourhood_g… neighbourhood latitude longitude room_type price
#    <dbl> <chr>   <dbl> <chr>     <chr>            <chr>            <dbl>     <dbl> <chr>     <dbl>
#   1  2539 Clea…    2787 John      Brooklyn         Kensington        40.6     -74.0 Private …   149
#   2  2595 Skyl…    2845 Jennifer  Manhattan        Midtown           40.8     -74.0 Entire h…   225
#   3  3647 THE …    4632 Elisabeth Manhattan        Harlem            40.8     -73.9 Private …   150
#   4  3831 Cozy…    4869 LisaRoxa… Brooklyn         Clinton Hill      40.7     -74.0 Entire h…    89
#   5  5022 Enti…    7192 Laura     Manhattan        East Harlem       40.8     -73.9 Entire h…    80
#   6  5099 Larg…    7322 Chris     Manhattan        Murray Hill       40.7     -74.0 Entire h…   200
#   7  5121 Blis…    7356 Garon     Brooklyn         Bedford-Stuy…     40.7     -74.0 Private …    60
#   8  5178 Larg…    8967 Shunichi  Manhattan        Hell's Kitch…     40.8     -74.0 Private …    79
#   9  5203 Cozy…    7490 MaryEllen Manhattan        Upper West S…     40.8     -74.0 Private …    79
#   10  5238 Cute…    7549 Ben       Manhattan        Chinatown         40.7     -74.0 Entire h…   150
#    # … with 48,885 more rows, and 6 more variables: minimum_nights <dbl>, number_of_reviews <dbl>,
#   last_review <date>, reviews_per_month <dbl>, calculated_host_listings_count <dbl>,
#   availability_365 <dbl>
## Do not modify this line!
library(readr)
airbnb <- read_csv("data/Airbnb_NYC_2019.csv")




# 2. We want to find the most expensive neighbourhood of NYC. So we need to get
#    a report containing the following information:
#    (`neighbourhood`, `avg_price`, `price_rank`)
#    where `avg_price` is the average price of the apartments in that neighbourhood,
#    `price_rank` is the quantile of the average price of that neighbourhood, among
#    all neighbourhoods. E.g., if a neighbourhood is the second most expensive of 5
#    neighbourhoods, its percent rank will be 0.75.
#    To do that, you can use:
#        - `drop_na()` to remove the NAs,
#        - `group_by()` to group the apts by neighourhood,
#        - `summarise()` to calculate the average price of each neighbourhood.
#        - `mutate()` and `percent_rank()` to calculate the quantile of
#          each neighbourhood saved in column `price_rank`.
#    Save the result data frame to `nyc_price`.
#    To check your result, `nyc_price` prints to:
#    # A tibble: 218 x 3
#    neighbourhood              avg_price price_rank
#    <chr>                          <dbl>      <dbl>
#    1 Allerton                        90.6     0.438
#    2 Arden Heights                   67.2     0.0968
#    3 Arrochar                       118.      0.659
#    4 Arverne                        159.      0.802
#    5 Astoria                        116.      0.645
#    6 Bath Beach                      84.8     0.355
#    7 Battery Park City              182.      0.899
#    8 Bay Ridge                      105.      0.576
#    9 Bay Terrace                    119.      0.668
#    10 Bay Terrace, Staten Island     102.      0.562
#    # … with 208 more rows
## Do not modify this line!
library(dplyr)
library(tidyr)
nyc_price <- airbnb %>%
  drop_na %>%
  group_by(neighbourhood) %>%
  summarise(avg_price = mean(price)) %>%
  mutate(price_rank = percent_rank(avg_price)) 
nyc_price


# 3. Using `nyc_price`:
#    Find the top 10% most expensive neighbourhoods and
#    report them in alphabetical order.
#    Save the result tibble to `nyc_10percent`.
#    To do that, you can use:
#         - `filter()` function to filter the `price_rank`.
#         - `arrange()` to reorder the neighbourhoods.
#    To check your result, `nyc_10percent` prints to :
#   # A tibble: 22 x 3
#   neighbourhood      avg_price price_rank
#   <chr>                  <dbl>      <dbl>
#   1 Breezy Point            195       0.917
#   2 Brooklyn Heights        202.      0.922
#   3 Chelsea                 222.      0.940
#   4 Cobble Hill             193.      0.912
#   5 Financial District      219.      0.935
#   6 Flatiron District       291.      0.986
#   7 Gramercy                205.      0.926
#   8 Greenwich Village       239.      0.959
#   9 Hell's Kitchen          186.      0.903
#   10 Midtown                 268.      0.972
#   # … with 12 more rows
## Do not modify this line!
library(stats)
nyc_10percent <- nyc_price %>%
  filter(price_rank > quantile(price_rank, 0.9)) %>%
  arrange(neighbourhood)
nyc_10percent


# 4. Calculate the median price and median availability days of each room type.
#    Save the result tibble into `by_type`.
#    To do that, you can use:
#       - `group_by()` and `select()` to group the apartments and select columns.
#       - `summarize()` to calculate the median of each group.
#    To check your result, `by_type` prints to:
#    # A tibble: 3 x 3
#    room_type       price availability_365
#    <chr>           <dbl>            <dbl>
#    1 Entire home/apt   160               42
#    2 Private room       70               45
#    3 Shared room        45               90
## Do not modify this line!
by_type <- airbnb %>%
  group_by(room_type) %>%
  select(room_type, price, availability_365) %>%
  summarize(price = median(price), availability_365 = median(availability_365))
by_type



# 5. We want to know the room tyoes count and proportion in different neighbourhoods.
#    We need a report contanining the following information:
#    (neighbourhood, count, prop)
#    where `prop` is the proportion of each room type among all the rooms in that neighbourhood
#    and `count` is the total number of each room type in that neighbourhood.
#    Save the result tibble into `neighbourhood_room`.
#    To do that, you can use:
#       - `group_by()` to group the apartments.
#       - `count()` to count the number of apartments in each group.
#       - `sum()` to sum the number of apartments in each group.
#       - `mutate()` to calculate the proportion and add new columnn `prop`.
#    To check your result, `neighbourhood_room` prints to:
#    # A tibble: 15 x 4
#    # Groups:   neighbourhood_group [5]
#    neighbourhood_group room_type       count   prop
#    <chr>               <chr>           <int>  <dbl>
#    1 Bronx               Entire home/apt   379 0.347
#    2 Bronx               Private room      652 0.598
#    3 Bronx               Shared room        60 0.0550
#    4 Brooklyn            Entire home/apt  9559 0.475
#    5 Brooklyn            Private room    10132 0.504
#    6 Brooklyn            Shared room       413 0.0205
#    7 Manhattan           Entire home/apt 13199 0.609
#    8 Manhattan           Private room     7982 0.368
#    9 Manhattan           Shared room       480 0.0222
#    10 Queens              Entire home/apt  2096 0.370
#    11 Queens              Private room     3372 0.595
#    12 Queens              Shared room       198 0.0349
#    13 Staten Island       Entire home/apt   176 0.472
#    14 Staten Island       Private room      188 0.504
#    15 Staten Island       Shared room         9 0.0241
## Do not modify this line!
neighbourhood_room <- airbnb %>%
  group_by(neighbourhood_group) %>%
  count(room_type) %>%
  rename("count" = n) %>%
  mutate(prop = count/sum(count))
neighbourhood_room


# 6. We want to convert the above tibble to a different form, showing in three separate
#    columns the proportion of each room type within each neighbourhood.
#    Save the result tibble into `neighbourhood_room_wider`.
#    To do that, you can use:
#       - `select()` to select the `proportion` column
#       - `pivot_wider()` to append each room type proportion as a column to the original tibble.
#    To check your result, `` prints to:
#    # A tibble: 5 x 4
#    # Groups:   neighbourhood_group [5]
#    neighbourhood_group `Entire home/apt` `Private room` `Shared room`
#    <chr>                           <dbl>          <dbl>         <dbl>
#    1 Bronx                           0.347          0.598        0.0550
#    2 Brooklyn                        0.475          0.504        0.0205
#    3 Manhattan                       0.609          0.368        0.0222
#    4 Queens                          0.370          0.595        0.0349
#    5 Staten Island                   0.472          0.504        0.0241
## Do not modify this line!
neighbourhood_room_wider <- neighbourhood_room %>%
  select(-count) %>%
  pivot_wider(names_from = room_type, values_from = prop)
neighbourhood_room_wider



