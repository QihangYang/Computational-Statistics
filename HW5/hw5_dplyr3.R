# HW5: Dplyr
#'
# You are not allowed to use any `for`, `while` or `repeat` in this exercise.
#'
# 1. Load the `tidyr` and `dplyr` packages.
#    Load the `airquality` data set and save it into tibble `airquality`.
#    To do that, you can use `as_tibble` to transform the data frame into tibble.
#    The first 5 lines of `airquality` should look like:
#    # A tibble: 153 x 6
#      Ozone Solar.R  Wind  Temp Month   Day
#      <int>   <int> <dbl> <int> <int> <int>
#    1    41     190   7.4    67     5     1
#    2    36     118   8      72     5     2
#    3    12     149  12.6    74     5     3
#    4    18     313  11.5    62     5     4
#    5    NA      NA  14.3    56     5     5
## Do not modify this line!
library(tidyr)
library(dplyr)
airquality <- as_tibble(airquality)



# 2. Replace the NA values in `Ozone` column from `airquality` by the mean of the
#    non NA values and save the result into tibble `airquality_replace_na`.
#    To do that, you can use:
#      - `replace_na` to replace the NA values with `mean` to compute the mean
#      for the non NA values.
#    The first 5 lines of `airquality_replace_na` should look like:
#    # A tibble: 153 x 6
#      Ozone Solar.R  Wind  Temp Month   Day
#      <int>   <int> <dbl> <int> <int> <int>
#    1    41     190   7.4    67     5     1
#    2    36     118   8      72     5     2
#    3    12     149  12.6    74     5     3
#    4    18     313  11.5    62     5     4
#    5    42.1    NA  14.3    56     5     5
## Do not modify this line!
airquality_replace_na <- airquality %>%
  mutate(Ozone = replace_na(airquality$Ozone, mean(airquality$Ozone, na.rm = TRUE)))
airquality_replace_na

# 3. Remove the rows that contain NA value in `Solar.R` column from `airquality_replace_na`.
#    Save the result into `airquality_remove_na`.
#    To do that, you can use `drop_na`.
#    The first lines of `airquality_remove_na` should look like:
#    # A tibble: 146 x 6
#      Ozone Solar.R  Wind  Temp Month   Day
#      <dbl>   <int> <dbl> <int> <int> <int>
#    1    41     190   7.4    67     5     1
#    2    36     118   8      72     5     2
#    3    12     149  12.6    74     5     3
#    4    18     313  11.5    62     5     4
#    5    23     299   8.6    65     5     7
## Do not modify this line!
airquality_remove_na <- drop_na(airquality_replace_na)
airquality_remove_na



# 4. Select the columns `Wind`, `Temp`, `Month`, and `Day` from `airquality_remove_na`.
#    Save the selected data into `airquality_selected`.
#    To do that, you can use `select`.
#    The first lines of `airquality_selected` should look like:
#    # A tibble: 146 x 4
#        Wind  Temp Month   Day
#       <dbl> <int> <int> <int>
#    1   7.4    67     5     1
#    2   8      72     5     2
#    3  12.6    74     5     3
## Do not modify this line!
airquality_selected <- airquality_remove_na %>%
  select(Wind, Temp, Month, Day)
airquality_selected


# 5. Select rows that have values larger than 6 in `Month` column from `airquality_selected`.
#    Save the selected data into `airquality_filtered`.
#    To do that, you can use `filter`.
#    The first lines of `airquality_filtered` should look like:
#    # A tibble: 89 x 4
#        Wind  Temp Month   Day
#       <dbl> <int> <int> <int>
#    1   4.1    84     7     1
#    2   9.2    85     7     2
#    3   9.2    81     7     3
## Do not modify this line!
airquality_filtered <- airquality_selected %>%
  filter(Month > 6)
airquality_filtered


# 6. Modify `Wind` column from `airquality_filtered` so that
#    when the value is in `[1,9)`, the new value is `7.4`;
#    when the value is in `[9,20]`, the new value is `11.5`;
#    otherwise replace the value by `21`.
#    Save the result into `airquality_wind`.
#    To do that, you can combine:
#      - `mutate` to modify the `Wind` column,
#      - with `case_when` as a general vectorised if.
#    The first lines of `airquality_wind` should look like:
#    # A tibble: 89 x 4
#        Wind  Temp Month   Day
#       <dbl> <int> <int> <int>
#    1   7.4    84     7     1
#    2  11.5    85     7     2
#    3  11.5    81     7     3
## Do not modify this line!
airquality_wind <- airquality_filtered %>%
  mutate(Wind = 
    case_when(
      Wind >= 1 & Wind < 9 ~ 7.4,
      Wind >= 9 & Wind <=20 ~ 11.5,
      TRUE ~ 21
    )
  )
airquality_wind




# 7. Modify the `Temp` column from `airquality_wind` so that
#    the temperature is in Celsius instead of Fahrenheit.
#    Save the result into `airquality_temp`.
#    Note: The formula is (x - 32) * 5 / 9.
#    To do that, you can use `mutate`.
#    The first lines of `airquality_temp` should look like:
#    # A tibble: 89 x 4
#        Wind  Temp Month   Day
#       <dbl> <dbl> <int> <int>
#    1   7.4  28.9     7     1
#    2  11.5  29.4     7     2
#    3  11.5  27.2     7     3
## Do not modify this line!
airquality_temp <- airquality_wind %>%
  mutate(Temp = (Temp - 32) * 5 / 9)
airquality_temp


# 8. Compute the mean temperature for each month from `airquality_temp`.
#    Save the result into `airquality_mean_temp`.
#    The new column name should be `mean_temp`.
#    To do that, you can use:
#     - `group_by` to group by `month`,
#     - `summarize` and `mean` to compute mean values.
#    The first lines of `airquality_mean_temp` should look like:
#    # A tibble: 3 x 2
#        Month mean_temp
#        <int>     <dbl>
#    1     7      28.8
#    2     8      28.8
#    3     9      24.9
## Do not modify this line!
airquality_mean_temp <- airquality_temp %>%
  group_by(Month) %>%
  summarize(mean_temp = mean(Temp))
airquality_mean_temp


