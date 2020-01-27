# HW5: Tidying Data
#'
# 1. Load the `tidyr`, `readr` and `dplyr` package and use its function `read_csv()`
#    to read the dataset `warpbreaks.csv` (located in directory `data/`).
#    Store the corresponding dataframe into a variable `warpbreaks`.
#    For the following exercises, use the pipe operator `%>%` as much as you can.
## Do not modify this line!
library(tidyr)
library(readr)
library(dplyr)
warpbreaks <- read_csv("data/warpbreaks.csv")



# 2. Now let's clean the data, we can see a lot of missing values or values which don't make any sense
#    in all of the three columns.
#    Filter out all the `NA` values, as well as the values in `wool` column which does not have
#    values in `A` or `B`, the values in `tension` column which does not have
#    values in `L` or `M` or `H` and the rows which has negative or extreme values(>100) in `breaks` column.
#    Then change the columns order into `wool`, `tension`, `breaks`.
#    To complete this, you can use:
#      - `filter_all` to filter out all the `NA` values.
#      - `filter` and `startsWith`.
#      - `select` to change the columns order into `wool`, `tension`, `breaks`.
#    Save your answer into a tibble `t1` which has 49 rows and 3 columns.
#    To check your solution, it should print to:
#    # A tibble: 49 x 3
#     wool  tension breaks
#     <chr> <chr>    <dbl>
#    1 A     L           26
#    2 A     L           30
#    3 A     L           25
#    4 A     L           70
#    5 A     L           52
#    6 A     L           51
#    7 A     L           26
#    8 A     L           67
#    9 A     M           18
#    10 A     M           29
#    # ... with 39 more rows
## Do not modify this line!
t1 <- warpbreaks %>%
  filter_all(all_vars(!is.na(.))) %>%
  filter(wool == "A" | wool == "B") %>%
  filter(tension == "L" | tension == "M" | tension == "H") %>%
  filter(breaks >= 0 & breaks <= 100) %>%
  select(wool, tension, breaks)
t1
           


# 3. Use `count` to count the number of rows for each combination of (`wool`,`tension`).
#    Save the result dataframe into `t2` which should include 6 rows and 3 columns: `wool`, `tension` and `n`
#    To check your solution, it should print to:
#    # A tibble: 6 x 3
#     wool  tension     n
#     <chr> <chr>   <int>
#    1 A     H           8
#    2 A     L           8
#    3 A     M           8
#    # ... with 3 more rows
## Do not modify this line!
t2 <- t1 %>%
  group_by(wool, tension) %>%
  count
t2


# 4. Use `pivot_wider` to `t1` to tranform the column `tension` into multiple columns `L`, `M` and `H`,
#    fill in the values with the sum of `breaks` for each combination of (`wool`,`tension`).
#    Hint: you can use the argument `values_fn = list(breaks = sum)`.
#    Save the result dataframe into `t3`.
#    Your result should look like this:
#    # A tibble: 2 x 4
#     wool      L     M     H
#     <chr> <dbl> <dbl> <dbl>
#    1 A       347   195   197
#    # ... with 1 more rows
## Do not modify this line!
t3 <- t1 %>%
  group_by(wool, tension) %>%
  pivot_wider(names_from = tension, values_from = breaks, values_fn = list(breaks = sum))
t3



# 5. Use `pivot_longer` to transfomr your `t3` into a tibble of 6 rows with columns `wool`, `tension`
#    and `sum_of_breaks`. Save your result into `t4` which includes 6 rows and 3 columns.
#    To check your solution, it should print to:
#    # A tibble: 6 x 3
#     wool  tension sum_of_breaks
#     <chr> <chr>           <dbl>
#    1 A     L                 347
#    2 A     M                 195
#    3 A     H                 197
#    # ... with 3 more rows
## Do not modify this line!
t4 <- t3 %>%
  pivot_longer(-wool,
               names_to = "tension",
               values_to = "sum_of_breaks")
t4



