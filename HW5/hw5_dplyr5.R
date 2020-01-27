# HW5: Data Manipulation on CitiBike data
#'
# Refrain from using any loops (`for`, `while`) and `repeat` for this exercise.
#'
# 1. Load the packages `readr`.
# Use `read_csv()` to create a `tibble` from the
# csv file `/course/data/citybike.csv` taken from sampled data
# from [Citibike usage data](https://www.citibikenyc.com/system-data) and
# assign it to variable `trips`. The file contains data corresponding to
# every bike trip taken by users in August 2016.
# Peek at the first rows of `trips` using `head()` to get a feel of
# what your data is like and assign the result to tibble `head_trips`.
# Looking up `head_trips` will now give a quick overview of the dataset.
# (dimensions should be `trips (100,000x15)`, `head_trips (6x15)`)
#'
## Do not modify this line!
library(readr)
trips <- read_csv("/course/data/citybike.csv")
head_trips <- head(trips)



# 2. Load the `stringr` package. Use `names` and `str_replace_all` to replace
# the spaces in column names with underscores `_`. This will make it easier to
# manipulate those columns. Do not change the order of columns when doing so.
#'
## Do not modify this line!
library(stringr)
names(trips) <- str_replace_all(names(trips), " ", "_")


# 3. Load the package `dplyr`.
# Find the largest and smallest birth year of people that took trips in August
# 2016. Assign the result to a tibble `years` with only two columns
# `min_birth_year` and `max_birth_year` (in this order), and only one row.
# You can use:
#   - `summarize()`, `min()` and `max()` - make sure you use the
#   `na.rm` argument of `min()` and `max()` wisely.
# (dimensions should be `years (1x2)`)
# To check your solution, `years` prints to:
# # A tibble: 1 x 2
# min_birth_year max_birth_year
# <dbl>          <dbl>
# 1           1885           2000
#'
## Do not modify this line!
library(dplyr)
years <- trips %>%
  summarize(min_birth_year = min(birth_year, na.rm = TRUE), max_birth_year = max(birth_year, na.rm = TRUE))
years

# 4. Find all trips that started and ended on Broadway. Assign the result to
# tibble `broadway`. `broadway` should be similar to `trips`, but only contain
# the trips that started and ended on Broadway.
# You can use:
#   - `filter()` and `str_detect()` (and `|` in the `str_detect()` call).
# (dimensions should be `broadway (18,603x15)`)
# To check your solution, `broadway` prints to:
# # A tibble: 18,603 x 15
# tripduration starttime stoptime start_station_id start_station_n… start_station_l… start_station_l…
# <dbl> <chr>     <chr>               <dbl> <chr>                       <dbl>            <dbl>
#  1          826 8/30/201… 8/30/20…             3301 Columbus Ave & …             40.8            -74.0
#  2         2440 8/28/201… 8/28/20…             3147 E 85 St & 3 Ave              40.8            -74.0
#  3          660 8/16/201… 8/16/20…              362 Broadway & W 37…             40.8            -74.0
#  4         1458 8/1/2016… 8/1/201…              321 Cadman Plaza E …             40.7            -74.0
#  5          534 8/6/2016… 8/6/201…              536 1 Ave & E 30 St              40.7            -74.0
#  6          356 8/6/2016… 8/6/201…              257 Lispenard St & …             40.7            -74.0
#  7          804 8/26/201… 8/26/20…              369 Washington Pl &…             40.7            -74.0
#  8          555 8/5/2016… 8/5/201…              469 Broadway & W 53…             40.8            -74.0
#  9          493 8/18/201… 8/18/20…              285 Broadway & E 14…             40.7            -74.0
#  10          396 8/13/201… 8/13/20…             3063 Nostrand Ave & …             40.7            -74.0
# … with 18,593 more rows, and 8 more variables: end_station_id <dbl>, end_station_name <chr>,
#   end_station_latitude <dbl>, end_station_longitude <dbl>, bikeid <dbl>, usertype <chr>, birth_year <dbl>,
#   gender <dbl>
#'
## Do not modify this line!
broadway <- trips %>%
  filter(str_detect(start_station_name, "Broadway") | str_detect(end_station_name, "Broadway")) 
broadway



# 5. Create a `trips_counts` tibble that contains the counts of each
# possible trip (one possible trip = one starting station and one ending
# station).
# You can use:
#  - `group_by()` to group by `start_station_name` and `end_station_name`,
#  - `summarize()` along with `n()` to compute the counts across groups
# (dimensions should be `trips_counts (46,115x3)`)
# To check your solution, `trips_counts` prints to:
# # A tibble: 46,115 x 3
# # Groups:   start_station_name [564]
# start_station_name end_station_name  count
# <chr>              <chr>             <int>
#  1 1 Ave & E 16 St    1 Ave & E 16 St       3
#  2 1 Ave & E 16 St    1 Ave & E 18 St       4
#  3 1 Ave & E 16 St    1 Ave & E 30 St       9
#  4 1 Ave & E 16 St    1 Ave & E 44 St       1
#  5 1 Ave & E 16 St    1 Ave & E 68 St       2
#  6 1 Ave & E 16 St    1 Ave & E 78 St       2
#  7 1 Ave & E 16 St    2 Ave & E 31 St       2
#  8 1 Ave & E 16 St    5 Ave & E 29 St       2
#  9 1 Ave & E 16 St    6 Ave & Broome St     1
#  10 1 Ave & E 16 St    6 Ave & Canal St      4
# … with 46,105 more rows
#'
## Do not modify this line!
trips_counts <- trips %>%
  group_by(start_station_name, end_station_name) %>%
  summarize(count = n())
trips_counts


# 6. Create a tibble `frequent_trips` containing the 10 most frequent
# station-to-station trips (it should contain three columns -
# `start_station_name`, `end_station_name` and `count` (in this order)).
# To do so you can:
#  - start with `trips_counts`,
#  - re-order it in descending order of `count` (using `arrange()`
#  and `desc()`),
#  - use `head()` to retain only the 10 first elements.
# (dimensions should be `frequent_trips (10x3)`)
# To check your solution, the first three lines of  `frequent_trips` print to:
# # A tibble: 10 x 3
# # Groups:   start_station_name [6]
# start_station_name      end_station_name        count
# <chr>                   <chr>                   <int>
#  1 Central Park S & 6 Ave  Central Park S & 6 Ave     73
#  2 Central Park S & 6 Ave  5 Ave & E 88 St            62
#  3 E 7 St & Avenue A       Cooper Square & E 7 St     48
#'
## Do not modify this line!
frequent_trips <- trips_counts %>%
  arrange(desc(count)) %>%
  head(10)
frequent_trips



