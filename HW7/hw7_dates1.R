# HW7: Dates Manipulation on CitiBike data
#'
# 1. Load the packages `readr`.
#    Use `read_csv()` to create a `tibble` from the csv file at
#    `/course/data/citybike.csv` taken from sampled data from
#    [Citibike usage data](https://www.citibikenyc.com/system-data) and
#    assign it to variable `trips`. The file contains data corresponding to
#    every bike trip taken by users in August 2016.
#    Peek at the first rows of `trips` using `head()` to get a feel of
#    what your data is like and assign the result to tibble `head_trips`.
#    `head_trips` should print to something like
#   # A tibble: 6 x 15
#     tripduration starttime stoptime `start station … `start station …
#            <dbl> <chr>     <chr>               <dbl> <chr>
#   1         5945 8/5/2016… 8/5/201…              228 E 48 St & 3 Ave
#   2         1494 8/3/2016… 8/3/201…              460 S 4 St & Wythe …
#   3          826 8/30/201… 8/30/20…             3301 Columbus Ave & …
#   4          278 8/15/201… 8/15/20…             3256 Pier 40 - Hudso…
#   5          729 8/8/2016… 8/8/201…              347 Greenwich St & …
#   6          502 8/22/201… 8/22/20…              382 University Pl &…
#   # … with 10 more variables: `start station latitude` <dbl>, `start station
#   #   longitude` <dbl>, `end station id` <dbl>, `end station name` <chr>,
#   #   `end station latitude` <dbl>, `end station longitude` <dbl>,
#   #   bikeid <dbl>, usertype <chr>, `birth year` <dbl>, gender <dbl>
## Do not modify this line!
library(readr)
trips <- read_csv("/course/data/citybike.csv")
head_trips <- head(trips)



# 2. Load the `dplyr` package.
#    Modify the `gender` column to a factor column with levels ordered from 0
#    to 1 and the labels (`"Unknown"` for 0, `"Male"` for 1, `"Female"` for 2).
#    Assign the resulting tibble to `trips_with_genders`.
#    Hint: you can use `mutate()` and `factor()`, and judiciously use the
#    `levels` and `labels` arguments of `factor()`.
#    The `gender` column of `trips_with_genders` should print to:
#    # A tibble: 100,000 x 1
#       gender
#       <fct>
#     1 Male
#     2 Male
#     3 Male
#     4 Female
#     5 Female
#     6 Male
#     7 Male
#     8 Male
#     9 Male
#    10 Male
#    # … with 99,990 more rows
#    And the rest of the tibble should be the same as in question 1.
## Do not modify this line!
library(dplyr)
trips_with_genders <- trips %>%
  mutate(gender = factor(gender, levels = c(0,1,2), labels = c("Unknown", "Male", "Female"))) 
trips_with_genders

# 3. Load the `lubridate` package.
#    Starting with `trips`, modify the `starttime` and `stoptime` columns to
#    contain dates in the format month-day-year_hour-minute-second.
#    Assign the resulting tibble to `trips_with_dates`.
#    Hint: you can use `mutate()` and `mdy_hms()`.
#    The `starttime` and `stoptime` columns of `trips_with_dates` should print
#    to:
#    # A tibble: 100,000 x 2
#       starttime           stoptime
#       <dttm>              <dttm>
#     1 2016-08-05 14:15:11 2016-08-05 15:54:16
#     2 2016-08-03 22:56:34 2016-08-03 23:21:28
#     3 2016-08-30 07:41:07 2016-08-30 07:54:54
#     4 2016-08-15 20:39:47 2016-08-15 20:44:26
#     5 2016-08-08 17:40:31 2016-08-08 17:52:40
#     6 2016-08-22 07:26:03 2016-08-22 07:34:26
#     7 2016-08-31 16:32:42 2016-08-31 16:40:08
#     8 2016-08-10 19:40:36 2016-08-10 19:59:15
#     9 2016-08-24 11:29:54 2016-08-24 11:32:12
#    10 2016-08-30 12:16:21 2016-08-30 12:21:09
#    # … with 99,990 more rows
#    And the rest of the tibble should be the same as in question 1.
## Do not modify this line!
library(lubridate)
trips_with_dates <- trips %>% 
  mutate(starttime = mdy_hms(starttime), stoptime = mdy_hms(stoptime))
trips_with_dates
  


# 4. Create a tibble containing the `starttime` column from `trips_with_dates`
#    as well as two additional columns `start_ymd` and `start_hour` containing
#    the starting time day and hour of each trip.
#    To do so, you need to:
#    - starting with `trips_with_dates`, keep only the `starttime` column,
#      (you can use `select()` for this)
#    - then create the two columns from `starttime`, (you can use `mutate()`
#      along with `floor_date()` and `hour()` for this)
#    - assign the result to tibble `trips_start_times`
#    # A tibble: 100,000 x 3
#       starttime           start_ymd           start_hour
#       <dttm>              <dttm>                   <int>
#     1 2016-08-05 14:15:11 2016-08-05 00:00:00         14
#     2 2016-08-03 22:56:34 2016-08-03 00:00:00         22
#     3 2016-08-30 07:41:07 2016-08-30 00:00:00          7
#     4 2016-08-15 20:39:47 2016-08-15 00:00:00         20
#     5 2016-08-08 17:40:31 2016-08-08 00:00:00         17
#     6 2016-08-22 07:26:03 2016-08-22 00:00:00          7
#     7 2016-08-31 16:32:42 2016-08-31 00:00:00         16
#     8 2016-08-10 19:40:36 2016-08-10 00:00:00         19
#     9 2016-08-24 11:29:54 2016-08-24 00:00:00         11
#    10 2016-08-30 12:16:21 2016-08-30 00:00:00         12
#    # … with 99,990 more rows
## Do not modify this line!
trips_start_times <- trips_with_dates %>%
  select(starttime) %>%
  mutate(start_ymd = floor_date(starttime, "day"), start_hour = hour(starttime)) 
trips_start_times



# 5. Compute 1) the total number of trips, 2) the number of days in which there
#    was at least one trip and 3) the average number of trips that started
#    for each hour of the day over the whole month. Assign the resulting
#    tibble to `trips_per_hour`.
#    To do so, you need to:
#    - starting with `trips_start_times`, group by the hour of the day, (you
#      can use `group_by()` for this)
#    - then compute the three statistics listed above (you can use
#      `summarize()` for this)
#    Hint:  The function `n()` returns the number of rows, and
#    `n_distinct(column)` returns the number of distinct values in `column`.
#    `trips_per_hour` should print to:
#    # A tibble: 24 x 4
#       start_hour num_trips num_days mean_trips
#            <int>     <int>    <int>      <dbl>
#     1          0       986       31      31.8
#     2          1       506       31      16.3
#     3          2       322       31      10.4
#     4          3       193       30       6.43
#     5          4       195       31       6.29
#     6          5       587       31      18.9
#     7          6      2262       31      73.0
#     8          7      4784       31     154.
#     9          8      7958       31     257.
#    10          9      6528       31     211.
#    # … with 14 more rows
## Do not modify this line!
trips_per_hour <- trips_start_times %>%
  group_by(start_hour = hour(starttime)) %>%
  summarize(num_trips = n(), num_days = n_distinct(start_ymd)) %>%
  mutate(mean_trips = num_trips / num_days)
trips_per_hour

