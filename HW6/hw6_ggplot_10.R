# HW6: ggplot10
#'
# In this exercise, you have to recreate the figures found at 
# the left of the instructions.
# We suggest functions you can use to create the plots, but 
# you are free to use the method you are the most comfortable with.
# Make sure that the figures look exactly like the ones you are supposed to create.
#'
# 1. Do the following:
#    - load the `readr` and `dplyr` package
#    - then load the `data/taxi.csv` file using `read_csv()`, containing some
#    fare and tip amounts of NYC yellow cab rides in June 2018, Assign it to
#    the variable `taxi`
#    - then keep only the rows corresponding to trips with `tip_amount < 15`
#    and `0 <= fare_amount <= 50`
#    Hint: you can use `filter()` and `between()` to do so.
#    - assign the resulting tibble of the last two steps to variable `taxi`
#    - use `head()` to see the first lines and assign the resulting tibble to
#    `taxi_head`.
#    `taxi_head` should look like:
#    # A tibble: 6 x 3
#           X1 fare_amount tip_amount
#        <dbl>       <dbl>      <dbl>
#    1 7832414         7         1.65
#    2 3247452        10.5       2.36
#    3 1026979         5         0.87
#    4 2003753        18.5       4.05
#    5 5884122         6         2
#    6 2373845         3.5       0.96
## Do not modify this line!
library(readr)
library(dplyr)
taxi <- read_csv("data/taxi.csv") %>%
  filter(tip_amount < 15 & between(fare_amount, 0, 50))
taxi
taxi_head <- taxi %>%
  head
taxi_head


# 2. Load the `scales` and `ggplot2`package. Plot a histogram of the tip
#    amounts and assign the plot to `tip_histogram`.
#    To do so, you can:
#    - call `ggplot()` and `geom_histogram()` setting the `binwidth` to `1`
#    - add `scale_y_continuous(label = comma)` to make the plot more
#    reader-friendly
#    Note: `scale_y_continuous(label = comma)` makes the y-labels more
#    readable, forcing a comma notation for numbers (e.g. 5e+05 becomes
#    500,000)
#    - use `labs()` to format the labels such that:
#          - `title = "The tip amounts are skewed to the right"`
#          - `x = "Tip Amount (USD)"`
#          - `y = ""`
#    - finally add the light theme using `theme_light()`
#    The x-axis should read `Tip Amount (USD)` and the y-axis should have no
#    name
## Do not modify this line!
library(scales)
library(ggplot2)
tip_histogram <- ggplot(data = taxi, mapping = aes(x = tip_amount)) +
  geom_histogram(binwidth = 1) +
  scale_y_continuous(label = comma) +
  labs(title = "The tip amounts are skewed to the right",
       x = "Tip Amount (USD)",
       y = "") +
  theme_light()
tip_histogram


# 3. Create a `fare_bins` column in `taxi` mapping each `fare_amount` to one of
#    `("0-10", "11-20", "21-30", "31-40", "41-50")` depending on which interval
#    the fare amounts falls in and assign the transformed tibble to variable
#    `taxi_binned`.
#    Hint: you can use `mutate()`,`cut()` with 5 breaks.
#    `taxi_binned` should look like:
#    # A tibble: 96,469 x 4
#           X1 fare_amount tip_amount fare_bins
#        <dbl>       <dbl>      <dbl> <fct>
#    1 7832414         7         1.65 0-10
#    2 3247452        10.5       2.36 11-20
#    3 1026979         5         0.87 0-10
#    4 2003753        18.5       4.05 11-20
#    5 5884122         6         2    0-10
#    6 2373845         3.5       0.96 0-10
#    7 3418614        13         2.96 11-20
#    8  603784         6         2.19 0-10
#    9  404232         6         0    0-10
#    10 1381237        17.5       5.79 11-20
#    # … with 96,459 more rows
## Do not modify this line!
taxi_binned <- taxi %>% 
  mutate(fare_bins = cut(fare_amount, breaks = 5, labels = c("0-10", "11-20", "21-30", "31-40", "41-50")))
taxi_binned


# 4. Plot tip histograms faceted on 10 dollar bins of fare amounts and assign
#    the plot to `tip_facet_hist`.
#    To do so, you can:
#    - create the plot from `taxi_binned` with `ggplot()`
#    - then add  `geom_histogram()` with a `binwidth`` of `1`
#    - then forcing comma notation for the y-axis (as you did in question 2.)
#    - and after that, faceting on the bins using `facet_grid()`
#    - use `labs()` to format the labels such that:
#          - `title = "The tip skew becomes less severe as fares increase"`
#          - `x = "Tip Amount (USD)"`
#          - `y = ""`
#    - finally add the light theme using `theme_light()`
#    The x-axis should read `Tip Amount (USD)` and the y-axis should have no
#    name
## Do not modify this line!
tip_facet_hist <- ggplot(data = taxi_binned, mapping = aes(x = tip_amount)) +
  geom_histogram(binwidth = 1) +
  scale_y_continuous(labels = comma) +
  facet_grid(~fare_bins) +
  labs(title = "The tip skew becomes less severe as fares increase",
       x = "Tip Amount (USD)",
       y = "") +
  theme_light()
tip_facet_hist


# 5. Generate a hexagonal heatmap of the scatter plot and assign the plot to
#    variable `hex_heatmap`.
#    To do so:
#    - create the plot using `ggplot()` (fares on the x-axis and tips on the
#      y-axis)
#    - add a `geom_hex()` with `binwidth`` of `2.5` of fare amounts and `0.5` of
#      tip amounts
#    - then change the colours of the bins using `scale_fill_gradient`. The
#      colours should range from `"yellow"` (`low`) to `"darkgreen"` (`high`)
#      and the gradients should follow a `log10` transformation
#      (`trans = log10`)
#    - use `labs()` to format the labels such that:
#          - `title = "There is a preference of tipping proportionately to the fare"`
#          - `x = "Fare Amount (USD)"`
#          - `y = "Tip Amount (USD)"`
#    - finally add the light theme using `theme_light()`
#    The x-axis should read `"Fare Amount (USD)"` and the y-axis should be named
#    `"Tip Amount (USD)"`.
## Do not modify this line!
hex_heatmap <- ggplot(data = taxi, mapping = aes(x = fare_amount, y = tip_amount)) +
  geom_hex(binwidth = c(2.5, 0.5)) +
  scale_fill_gradient(low = "yellow", high = "darkgreen", trans = "log10") +
  labs(title = "There is a preference of tipping proportionately to the fare",
       x = "Fare Amount (USD)",
       y = "Tip Amount (USD)") +
  theme_light()
hex_heatmap



