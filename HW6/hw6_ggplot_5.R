# HW6: ggplot_nations
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
# 1. Load the package `tidyverse`.
#    Use `read_csv()` to read the dataset `nations.csv` (located in directory
#    `data/`) along with:
#       - `drop_na()` to drop all missing values.
#       - `mutate()` and `fct_reorder()` to make the column `region` sorted by
#         median of `life_expect`.
#    Store the corresponding dataframe into a tibble `nations`.
#    To check your result, `nation` prints to:
#    # A tibble: 4,635 x 11
#     iso2c iso3c country  year gdp_percap life_expect population birth_rate
#     <chr> <chr> <chr>   <int>      <dbl>       <dbl>      <int>      <dbl>
#     1 AE    ARE   United…  1994     71493.        72.7    2328686       21.3
#     2 AE    ARE   United…  2007     74698.        75.8    6044067       13
#     3 AE    ARE   United…  1996     75977.        73.2    2571020       19.2
#     4 AE    ARE   United…  1993     69085.        72.4    2207405       22.4
#     5 AE    ARE   United…  2005     82206.        75.4    4579562       14.0
#     6 AE    ARE   United…  1991     70642.        71.8    1970026       24.8
#     7 AE    ARE   United…  1992     70496.        72.1    2086639       23.6
#     8 AE    ARE   United…  1995     74045.        72.9    2448820       20.2
#     9 AE    ARE   United…  2004     85090.        75.2    4087931       14.5
#    10 AE    ARE   United…  2003     82571.        75.0    3741932       15.0
#    # … with 4,625 more rows, and 3 more variables: neonat_mortal_rate <dbl>,
#    #   region <fct>, income <chr>
#    We will explore how `life_expect` depends on (1) `region` in questions 2-3
#    and (2) `gdp_percap` in questions 4-6.
## Do not modify this line!
library(ggplot2)
library(tidyverse)
nations <- read_csv("data/nations.csv") %>%
  drop_na() %>%
  mutate(region = fct_reorder(region, life_expect, median))
nations



# 2. Draw multiple horizontal boxplots for `life_expect` by `region`.
#    To do this, you can use:
#       - `ggplot()` to initialize a ggplot object and specify the variables to plot.
#       - `geom_boxplot()` to draw multiple boxplots.
#       - `coord_filp()` to make the boxplots horizontal.
#       - `labs()` to format the labels such that:
#          - `title = "Life Expectancy by Region"`
#          - `x = "Region"`
#          - `y = "Life expectancy (years)"`
#    Store the plot into a `ggplot` object `g1`.
## Do not modify this line!
g1 <- ggplot(data = nations) +
  geom_boxplot(mapping = aes(x = region, y = life_expect)) +
  coord_flip() +
  labs(title = "Life Expectancy by Region",
       x = "Region",
       y = "Life expectancy (years)") +
  theme_light()

g1



# 3. Use `median()` to compute the overall median of `life_expect`.
#    Store the result into a variable `med`.
#    Add a line on top of `g1` in question 3 to show the overall median,
#    with a subtitle labelling the value of the overall median.
#    To do this, you can use:
#       - `geom_hline()` to add a red horizontal line for `med` on top of `g1`.
#       - `labs()` to format the labels such that:
#          - `subtitle = paste0("Overall median = ", round(med), " years (shown in red)")`
#    Store the plot into a `ggplot` object `g2`.
## Do not modify this line!
med = median(nations$life_expect)
g2 <- g1 +
  geom_hline(mapping = aes(yintercept = med), color = "red") +
  labs(subtitle = paste0("Overall median = ", round(med), " years (shown in red)"))
g2


# 4. Draw a scatterplot for `life_exp` vs. `gdp_percap`.
#    To do this, you can use:
#       - `ggplot()` to initialize a ggplot object and specify the variables to plot.
#       - `geom_point()` to draw a scatterplot.
#       - `labs()` to format the labels such that:
#          - `title = "Life Expectancy Increases with GDP Per Capita"`
#          - `x = "GDP per capita ($)"`
#          - `y = "Life expectancy (years)"`
#    Store the plot into a `ggplot` object `g3`.
## Do not modify this line!
g3 <- ggplot(data = nations) +
  geom_point(mapping = aes(x = gdp_percap, y = life_expect), alpha = 0.5, stroke = 0) +
  labs(title = "Life Expectancy Increases with GDP Per Capita",
       x = "GDP per capita ($)",
       y = "Life expectancy (years)") +
  theme_light()
g3


# 5. Observe from `g3` in question 4 that most of the countries were plotted in
#    tight cluster of points in the upper left corner of the graph.
#    For a better view, we will show a log-scale of `gdp_percap` and add a
#    smoothed conditional mean on top of `g3`.
#    To do this, you can use:
#       - `scale_x_log10()` to plot a log-scale of `gdp_percap` on top of `g3`.
#         (Note that this is better than applying direct transformation to
#         `gdp_percap`, as the axes would be labelled in original data scale
#         instead of a log-transformed scale, which is hard to interpret.)
#       - `geom_smooth()` to add a smoothed conditional mean
#         (set `se = FALSE`).
#    Store the plot into a `ggplot` object `g4`.
## Do not modify this line!
g4 <- g3 +
  scale_x_log10() +
  geom_smooth(mapping = aes(x = gdp_percap, y = life_expect),se = FALSE)
g4


# 6. To examine if the relationship between `life_exp` and `gdp_percap` differs
#    by `region`, use `facet_wrap()` to facet the scatterplot `g4` in question
#    5 by `region`.
#    Store the plot into a `ggplot` object `g5`.
## Do not modify this line!
g5 <- g4 +
  facet_wrap(~region)
g5



