# HW7: Strings and Dates
#'
# In this exercise, you will manipulate a dataset with strings and factors.
#'
# Throughout the exercise:
#    - Use `theme_light()` for the plots.
#    - Do not change the default position of the plot title.
#    - Do not print the plot.
#'
# In this exercise, you have to recreate the figures found at
# the left of the instructions.
# We suggest functions you can use to create the plots, but
# you are free to use the method you are the most comfortable with.
# Make sure that the figures look exactly like the ones you are supposed to create.
#'
# 1. Load the `tidyverse`, `rattle`,  `ggplot2` and `lubridate` packages.
#    Use `data(weather)` to read the dataset `weather` from the
#    `rattle` package.
#    Store it in a tibble `weather` using `as_tibble()`.
## Do not modify this line!
library(tidyverse)
library(rattle)
library(ggplot2)
library(lubridate)
data(weather)
weather = as_tibble(weather)



# 2. Create two tibbles `weather_9am` and `weather_3pm`.
#    `weather_9am` should contain all the variables which names end with
#    `"9am"` and the column `Date`. `"9am"` should be removed from the
#    names of its variables and the format of `Date`` should be changed as follow :
#    Instead of `"Y-M-D"`, add `"Y-M-D h:m:s AECT"` where `"AECT"` is the time zone
#    code for Australian Eastern Time and `h:m:s` is `09:00:00` (9 am).
#    For example, the Date column first value will be `"2007-11-01 09:00:00 AEDT"`.
#    `weather_3pm` should contain all the variables which names end with
#    `"3pm"` and the column `Date`. `"3pm"` should be removed from the
#    names of its variables and the format of `Date`` should be changed as follow :
#    Instead of `"Y-M-D"`, add `"Y-M-D h:m:s AECT"` where `"AECT"` is the time zone
#    code for Australian Eastern Time and `h:m:s` is `15:00:00` (3 pm).
#    For example, the Date column first value will be `"2007-11-01 15:00:00 AEDT"`.
#    To do so, you can use :
#       - `select()` and `ends_with()` to select the right columns
#       - `rename_all()` and `str_remove()` to rename the columns correctly
#       - `mutate()`, `ymd_hms()` and `paste()` to change the format of `Date`
#         Hint : If you use  `ymd_hms()`, set `tz` to `"Australia/Canberra"`
#    `weather_9am` should print to :
#    # A tibble: 366 x 7
#    Date                WindDir WindSpeed Humidity Pressure Cloud  Temp
#    <dttm>              <ord>       <dbl>    <int>    <dbl> <int> <dbl>
#    1 2007-11-01 09:00:00 SW              6       68    1020.     7  14.4
#    2 2007-11-02 09:00:00 E               4       80    1012.     5  17.5
#    3 2007-11-03 09:00:00 N               6       82    1010.     8  15.4
#    4 2007-11-04 09:00:00 WNW            30       62    1006.     2  13.5
#    5 2007-11-05 09:00:00 SSE            20       68    1018.     7  11.1
#    6 2007-11-06 09:00:00 SE             20       70    1024.     7  10.9
#    7 2007-11-07 09:00:00 SE             19       63    1025.     4  12.4
#    8 2007-11-08 09:00:00 SE             11       65    1026.     6  12.1
#    9 2007-11-09 09:00:00 E              19       70    1026.     7  14.1
#    10 2007-11-10 09:00:00 S               7       82    1024.     7  13.3
#    # … with 356 more rows
#'
## Do not modify this line!
weather_9am <- weather %>%
  select(Date, ends_with("9am")) %>%
  rename_all( ~str_remove(., "9am")) %>%
  mutate(Date = ymd_hms(paste(Date, "09:00:00", sep = " "), tz = "Australia/Canberra")) 
weather_9am

weather_3pm <- weather %>%
  select(Date, ends_with("3pm")) %>%
  rename_all( ~str_remove(., "3pm")) %>%
  mutate(Date = ymd_hms(paste(Date, "15:00:00", sep = " "), tz = "Australia/Canberra")) 
weather_3pm

# 3. Join the tibbles `weather_9am` and `weather_3pm` to create a tibble
#    `weather_arrange` that contains the data in both `weather_9am` and
#    `weather_3pm`. However, its `Date` should change to become the
#    corresponding day of the year, and be named `"Day of the year"`.
#    For example, `"2007-11-23 15:00:00 AEDT"` will become `23`.
#    Then, order the tibble from the earliest `Day of the year` to the latest.
#    To do so, you can use :
#       - `full_join()` to join the datasets
#       - `mutate()` and `yday()` to change the `Date`
#       - `rename()` to change the name of `Date`
#       - `arrange()` to reorder the tibble
#    `weather_arrange` should print to :
#    # A tibble: 732 x 7
#    `Day of the year` WindDir WindSpeed Humidity Pressure Cloud  Temp
#    <dbl> <ord>       <dbl>    <int>    <dbl> <int> <dbl>
#    1                 1 ESE             2       50    1016.     7  21.9
#    2                 1 W              11       20    1012.     6  31.8
#    3                 2 ESE             2       43    1013.     0  23
#    4                 2 WSW             9       14    1009.     1  33.6
#    5                 3 ESE            20       69    1017.     8  19.2
#    6                 3 ESE            24       55    1016.     7  22.3
#    7                 4 ESE            24       56    1016.     6  20.3
#    8                 4 ESE            26       45    1013      7  23.9
#    9                 5 SSE             7       69    1012.     7  18.6
#    10                 5 E              15       40    1007.     2  26.8
#    # … with 722 more rows
#'
## Do not modify this line!
weather_arrange <- weather_9am %>%
  full_join(weather_3pm) %>%
  mutate(Date = yday(Date)) %>%
  rename("Day of the year" = Date) %>%
  arrange(`Day of the year`)
weather_arrange


# 4. Plot both the smoothed temperature `Temp` multiplied by 3,
#    and `Humidity` as function of the date.
#    To do that, you can use :
#       - `ggplot()` to initialize a ggplot object. You can set its arguments
#         `data` and `mapping` to plot from `weather_arrange`, with
#         `Day of the year` as its x-axis
#       - `geom_smooth()` to plot the smoothed `Humidity`, with `col` set
#         to `green`, `method` set to 'loess', and `formula` to `'y ~ x'`
#         (These are the approximation methods for the smoothing process)
#       - `geom_smooth()` to plot the smoothed `3*Temp`, with `col` set
#         to `yellow`, `method` set to 'loess', and `formula` to `'y ~ x'`
#       - `labs()` to set :
#          - `title` to `"Temperature and Humidity are negatively correlated in Canberra"`
#          - `x` to `"Day of the year"`
#          - `y` to `"Humidity (in green) and rescaled Temperature (in yellow)"`
#       - `theme_light()`
#    Save the plot into `temp_humidity_plot`.
## Do not modify this line!
temp_humidity_plot <- ggplot(data = weather_arrange, mapping = aes(x = `Day of the year`)) +
  geom_smooth(aes(y = Humidity), col = "green", method = "loess", formula = "y ~ x") +
  geom_smooth(aes(y = 3 * Temp), col = "yellow", method = "loess", formula = "y ~ x") +
  labs(title = "Temperature and Humidity are negatively correlated in Canberra",
       x = "Day of the year",
       y = "Humidity (in green) and rescaled Temperature (in yellow)") +
  theme_light()
temp_humidity_plot


# 5. Create a tibble `weather_wind` that contains the wind direction `WindDir`,
#    the temperature `Temp`, and the main wind direction `WindMainDir`, for each
#    date and time (we have two recordings a day at 9am and 15pm.)
#    It should be ordered from lowest temperature to highest, and not contain
#    any `NA` value. `WindMainDir` should correspond to the first letter of
#    `WindDir` and be converted to `factor`. For example, `SW` main direction is `S`.
#    To do that, please create two tibbles `weather_wind_9am` and `weather_wind_3pm`
#    that contain the columns `WindDir` and `Temp` from `weather_9am` ans
#    `weather_wind_3pm`. You can use `select()`.
#    `weather_wind_9am` should print to :
#    # A tibble: 366 x 2
#    WindDir  Temp
#    <ord>   <dbl>
#    1 SW       14.4
#    2 E        17.5
#    3 N        15.4
#    4 WNW      13.5
#    5 SSE      11.1
#    6 SE       10.9
#    7 SE       12.4
#    8 SE       12.1
#    9 E        14.1
#    10 S        13.3
#    # … with 356 more rows
#    `weather_wind_3pm` has the same columns, but with different values.
#    Then, join these two tibbles into a tibble `weather_wind` using `full_join()`.
#    You can then :
#       - use `drop_na()` to drop the `NA` values
#       - use `mutate()`, `factor()` and `str_sub()` to create the column `WindMainDir`.
#       - use `arrange()` to reorder the dataset.
#    `weather_wind` should print to :
#    # A tibble: 667 x 3
#    WindDir  Temp WindMainDir
#    <ord>   <dbl> <fct>
#    1 N         0.1 N
#    2 E         0.8 E
#    3 SSE       1   S
#    4 SE        1.2 S
#    5 SE        1.4 S
#    6 NNW       1.4 N
#    7 NW        1.8 N
#    8 N         2.1 N
#    9 ESE       2.6 E
#    10 SE        2.7 S
#    # … with 657 more rows
## Do not modify this line!
weather_wind_9am <- weather_9am %>%
  select(WindDir, Temp) %>%
  drop_na() %>%
  mutate(WindMainDir = factor(str_sub(WindDir, 1, 1)))

weather_wind_3pm <- weather_3pm %>%
  select(WindDir, Temp) %>%
  drop_na() %>%
  mutate(WindMainDir = factor(str_sub(WindDir, 1, 1)))

weather_wind <- weather_wind_9am %>%
  full_join(weather_wind_3pm) %>%
  arrange(Temp)

weather_wind



# 6. Plot the facetted histogram of the temperature `Temp` for each main
#    wind direction `WindMainDir`. Add a vertical line for temperature
#    29 degrees Celsius to see what winds bring hot temperatures.
#    To do this, you can use :
#       - `ggplot()` to initialize a ggplot object. You can set its arguments
#         `data` and `mapping` to plot from `weather_arrange`, with
#         `Temp` as its x-axis
#       - `geom_histogram()` to create the histograms of `Temperature`, with
#         `color` set as `black`, `fill` as `orange` and `binwidth` as `0.5`.
#       - `geom_vline()` to draw the vertical line with `aes(xintercept = 29)`
#         and `color` set to `green`
#       - `facet_wrap()` to facet over `WindMainDir`
#       - `labs()` to set :
#          - `title` to `"The winds going west and north bring the highest temperatures"`
#          - `x` to `"Temperature (Celsius)"`
#       - `theme_light()`
#   Save this `ggplot` object to `wind_histogram`.
## Do not modify this line!
wind_histogram <- ggplot(data = weather_wind, mapping = aes(x = Temp)) +
  geom_histogram(fill = "orange", color = "black", binwidth = 0.5) +
  geom_vline(aes(xintercept = 29), color = "green") +
  facet_wrap(~WindMainDir) +
  labs(title = "The winds going west and north bring the highest temperatures",
       x = "Temperature (Celsius)",
       y = "") +
  theme_light()
wind_histogram
  
  



