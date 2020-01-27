# HW6: ggplot_taxi
#'
# In this exercise, you have to recreate the figures found at
# the left of the instructions.
# We suggest functions you can use to create the plots, but
# you are free to use the method you are the most comfortable with.
# Make sure that the figures look exactly like the ones you are supposed to create.
#'
# In this exercise, you will familiarize yourself with data visualization using
# ggplot.
#'
# Throughout the exercise:
#    - Use `theme_light()` for the plots.
#    - Set `alpha = 0.5` and `stoke = 0` for `geom_point()` to avoid overplotting.
#    - For good practice, make sure every graph is complete. Follow the
#      instructions for labelling exactly to get the correct answer.
#    - Do NOT use `for`, `while` or `repeat` loops.
#    - Use `%>%` to structure your operations.
#'
# 1. Load the packages `tidyverse` and `viridis`.
#    Use `read_csv()` to read the dataset `nyc_taxi` (located in directory `data/`).
#    Store the corresponding dataframe into a tibble `taxi`.
#    In the following exercises, we will explore how `tip_amount` depends on
#    other features.
## Do not modify this line!
library(tidyverse)
library(viridis)
taxi <- read_csv("data/nyc_taxi.csv")



# 2. Draw a scatterplot for `tip_amount` vs. `fare_amount`.
#    For a better view, we will remove the nagative fare values and some outliers
#    by zooming in. You can use any of the three methods discussed in class.
#    To do this, you can use:
#       - `ggplot()` to initialize a ggplot object and specify the variables to plot.
#       - `geom_point()` to draw the scatterplot.
#       - `coord_cartesian()` with `xlim = c(0, 60)` and `ylim = c(0, 15)` to
#         keep `fare_amount` in [0, 60] and `tip_amount` in [0, 15].
#       - `labs()` to format the labels such that:
#          - `title = "Tip Amount Increases with Fare Amount Generally"`
#          - `subtitle = "Some people gave fixed tips regardless of fares."`
#          - `x = "Fare amount ($)"`
#          - `y = "Tip amount ($)"`
#    Store the plot into a `ggplot` object `g1`.
#    Some explanations for the pattern:
#       - Prominent diagonal lines: tip amount increases with fare amount.
#         People generally tip at a certain percentage of the fare, which is
#         very likely due to the tip choices provided when people pay with
#         credit card.
#       - Prominent horizontal lines: a group of people give fixed tips
#         regardless of fares.
#       - Vertical line at $52 fare: tip choices vary a lot at this fare.
## Do not modify this line!
g1 <- ggplot(data = taxi, mapping = aes(x = fare_amount, y = tip_amount)) +
  geom_point(alpha = 0.5, stroke = 0) + 
  coord_cartesian(xlim = c(0,60), ylim = c(0, 15)) +
  labs(title = "Tip Amount Increases with Fare Amount Generally",
       subtitle = "Some people gave fixed tips regardless of fares.",
       x = "Fare amount ($)",
       y = "Tip amount ($)") +
  theme_light()
g1


# 3. Heatmaps are useful for visualizing frequency counts and identifying clusters.
#    Draw a square heatmap for `tip_amount` vs. `fare_amount`, using `viridis`
#    for a perceptually uniform colormap.
#    To do this, you can use:
#       - `ggplot()` to initialize a ggplot object and specify the variables to plot.
#       - `geom_bin2d()` to draw a square heatmap (set `binwidth = c(2, 1)`).
#       - `coord_cartesian()` with `xlim = c(0, 60)` and `ylim = c(0, 15)` to
#         zoom in the figure as previous.
#       - `scale_fill_viridis()` to set `viridis` as the colormap.
#       - `labs()` to format the labels such that:
#          - `title = "Tip Amount Increases with Fare Amount Generally"`
#          - `subtitle = "Most commonly, trips had fares under $10 and tips around $2."``
#          - `x = "Fare amount ($)"`
#          - `y = "Tip amount ($)"`
#    Store the plot into a `ggplot` object `g2`.
## Do not modify this line!
g2 <- ggplot(data = taxi, mapping = aes(x = fare_amount, y = tip_amount)) +
  geom_bin2d(binwidth = c(2,1)) +
  coord_cartesian(xlim = c(0, 60), ylim = c(0, 15)) +
  scale_fill_viridis() +
  labs(title = "Tip Amount Increases with Fare Amount Generally",
       subtitle = "Most commonly, trips had fares under $10 and tips around $2.",
       x = "Fare amount ($)",
       y = "Tip amount ($)") +
  theme_light()
g2


# 4. Draw a scatterplot for `tip_amount` vs. `trip_distance`, with points
#    colored by `payment_type`.
#    To do this, you can use:
#       - `ggplot()` to initialize a ggplot object and specify the variables to plot.
#       - `geom_point()` to draw a scatterplot colored by `payment_type`.
#       - `coord_cartesian()` with `xlim = c(0, 25)` and `ylim = c(0, 15)` to
#         zoom in the figure as previous.
#       - `labs()` to format the labels such that:
#          - `title = "Tip Amount Increases with Trip Distance Generally"`
#          - `subtitle = paste("Trips with tips were almost always paid in card.",
#                              "Trips paid in cash were rarely tipped.", sep="\n")`
#          - `x = "Trip distance (mile)"`
#          - `y = "Tip amount ($)"`
#       - `theme()` to place the legend at the bottom of the figure.
#         (Note that this should be done AFTER setting `theme_light()` to
#         override the legend settings in the theme).
#    Store the plot into a `ggplot` object `g3`.
## Do not modify this line!
g3 <- ggplot(data = taxi, mapping = aes(x = trip_distance, y = tip_amount)) +
  geom_point(mapping = aes(color = payment_type), alpha = 0.5, stroke = 0) +
  coord_cartesian(xlim = c(0, 25), ylim = c(0, 15)) +
  labs(title = "Tip Amount Increases with Trip Distance Generally",
       subtitle = paste("Trips with tips were almost always paid in card.",
                        "Trips paid in cash were rarely tipped.", sep="\n"),
       x = "Trip distance (mile)",
       y = "Tip amount ($)") +
  theme_light() +
  theme(legend.position = "bottom")
g3


# 5. Make a new tibble `taxi_new` of size 10,000 x 2 with two columns,
#    `tip_amount` and `pickup_time`. `pickup_time` is a new column indicating
#    when a ride starts in hour.
#    To do this, you can use:
#       - `mutate()` with `format()` to take the hour component from
#         `tpep_pickup_datetime`.
#       - `dplyr::select()` to select the two columns of interest.
#         (Note: we need to enforce the use of `dplyr` to resolve function
#         conflicts with other packages such as `MASS`.)
#    To check your result, the tibble `taxi_new` prints to:
#    # A tibble: 10,000 x 2
#       tip_amount pickup_time
#            <dbl> <chr>
#     1       2.66 10
#     2       3.85 11
#     3       5    07
#     4       0    08
#     5       1.7  08
#     6       3.32 01
#     7       2.15 07
#     8       2.16 00
#     9       2.16 12
#    10       3.25 02
#    # … with 9,990 more rows
## Do not modify this line!
taxi_new <- taxi %>%
  mutate(pickup_time = format(tpep_pickup_datetime, "%H")) %>%
  select(tip_amount, pickup_time)
taxi_new


# 6. Draw a summary statistic plot for minimum, maximum and median of `tip_amount`
#    by `pickup_time`.
#    To do this, you can use:
#       - `ggplot()` to initialize a ggplot object and specify the variables to plot.
#       - `stat_summary()` to plot the `min`, `max` and `median` of `tip_amount`.
#       - `coord_cartesian()` with `ylim = c(0, 50)` to zoom in the figure as previous.
#       - `labs()` to format the labels such that:
#          - `title = "Min/Max/Median Tip Amount by Pickup Time"`
#          - `subtitle = paste("The highest tip was paid to a trip at 4AM.",
#          "9PM had the highest median tip whereas 8PM/10PM had the lowest.",
#          sep="\n")`
#          - `x = "Pickup Time (hour)"`
#          - `y = "Tip amount ($)"`
#    Store the plot a `ggplot` object `g4`.
## Do not modify this line!
g4 <- ggplot(taxi_new, mapping = aes(x = pickup_time, y = tip_amount)) +
  stat_summary(fun.y = median, fun.ymin = min, fun.ymax = max) +
  coord_cartesian(ylim = c(0, 50)) +
  labs(title = "Min/Max/Median Tip Amount by Pickup Time",
       subtitle = paste("The highest tip was paid to a trip at 4AM.", 
                        "9PM had the highest median tip whereas 8PM/10PM had the lowest.",
                        sep="\n"),
       x = "Pickup Time (hour)",
       y = "Tip amount ($)") +
  theme_light()
g4



