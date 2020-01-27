# HW6: Wine
#'
# In this problem, we will investigate the quality of red wine.
#'
# In this exercise, you have to recreate the figures found at 
# the left of the instructions.
# We suggest functions you can use to create the plots, but 
# you are free to use the method you are the most comfortable with.
# Make sure that the figures look exactly like the ones you are supposed to create.
#'
# 1. Load necessary packages : `ggplot2`, `viridis`, `lubridate` and
#    `tidyverse`. Load the file `data/winequalityN.csv` and save it
#    into tibble `wine`. Filter out the na values using `drop_na()`.
#    The tibble `wine` should print to:
#    # A tibble: 6,463 x 13
#    type  `fixed acidity` `volatile acidi… `citric acid`
#    <chr>           <dbl>            <dbl>         <dbl>
#    1 white             7               0.27          0.36
#    2 white             6.3             0.3           0.34
#    3 white             8.1             0.28          0.4
#    4 white             7.2             0.23          0.32
#    5 white             7.2             0.23          0.32
#    6 white             8.1             0.28          0.4
#    7 white             6.2             0.32          0.16
#    8 white             7               0.27          0.36
#    9 white             6.3             0.3           0.34
#    10 white             8.1             0.22          0.43
#    # … with 6,453 more rows, and 9 more variables: `residual
#    #   sugar` <dbl>, chlorides <dbl>, `free sulfur dioxide` <dbl>,
#    #   `total sulfur dioxide` <dbl>, density <dbl>, pH <dbl>,
#    #   sulphates <dbl>, alcohol <dbl>, quality <dbl>
## Do not modify this line!
library(ggplot2)
library(viridis)
library(lubridate)
library(tidyverse)
wine <- read_csv("data/winequalityN.csv") %>% drop_na()


# 2. Set random seed to 0 and save the random seed vector to variable `seed`.
#    (Hint: use the command `seed <- .Random.seed`)
#    Draw the scatter plot of wine quality and fixed acidity.
#    To do that, use:
#     - `ggplot` to initialize the plot object with
#        `aes(x = `fixed acidity`, y = quality)`
#        to select the variables interested.
#     - `geom_point` to draw the scatter plot.
#     - `labs()` to format the labels such that:
#          - `title = "The quality does not seem to be correlated with acidity"`
#          - `x = "Fixed Acidity"`
#          - `y = "Quality"`
#    Save this plot to `plot1_1`. You will find the scattered plots to be mostly
#    horizontal lines because the wine quality are all integers.
#    We can draw a plot to see how fixed acidity will change if the
#    quality is not integer by adding jitter to the above plot.
#    To do that, use:
#     - `ggplot` to initialize the plot object with
#        `aes(x = `fixed acidity`, y = quality)`
#        to select the variables interested.
#     - `geom_point` to draw the scatter plot.
#     -  set argument `position = position_jitter()` in `geom_point`.
#     - `labs()` to format the labels such that:
#          - `title = "The pattern is easier to interpret with jitter"`
#          - `x = "Fixed Acidity"`
#          - `y = "Quality"`
#    Save the new plot as `plot1_2`.
## Do not modify this line!
set.seed(0)
seed <- .Random.seed  
plot1_1 <- ggplot(data = wine, mapping = aes(x = `fixed acidity`, y = quality)) +
  geom_point() +
  labs(title = "The quality does not seem to be correlated with acidity",
       x = "Fixed Acidity",
       y = "Quality")
plot1_1
plot1_2 <- ggplot(data = wine, mapping = aes(x = `fixed acidity`, y = quality)) +
  geom_point(position = position_jitter()) +
  labs(title = "The pattern is easier to interpret with jitter",
       x = "Fixed Acidity",
       y = "Quality")
plot1_2


# 3. We found from previous figure that most wines have fixed acidity
#    between 6 and 8, especially the high quality ones. To check that,
#    we can draw a histogram of fixed acidity for each quality level.
#    (7 histograms in total, as `quality` goes from 3 to 9)
#    To draw the plot, use:
#     - `ggplot()` to initialize the plot object with `aes(x = `fixed acidity`)`
#        to specify the relevant variables.
#     - `geom_histogram()` to plot histogram, please set argument `color` to `black`,
#       `fill` to `orange`, and `binwidth` to 0.5.
#     - `facet_wrap()` to generate plots for each quality level.
#     - `labs()` to format the labels such that:
#        - `title = "Fixed acidity distribution for different quality levels"`
#        - `x = "Fixed Acidity"`
#        - `y = "Count (n)"`
#    Please save the `ggplot` object to `plot2`.
## Do not modify this line!
plot2 <- ggplot(data = wine, mapping = aes(x = `fixed acidity`)) +
  geom_histogram(color = "black", fill = "orange", binwidth = 0.5) +
  facet_wrap(~quality) +
  labs(title = "Fixed acidity distribution for different quality levels",
       x = "Fixed Acidity",
       y = "Count (n)")
plot2


# 4. Load package `GGally`.
#    Draw pair plot of columns "density", "volatile acidity", "citric acid"
#    to investigate pairwise correlations of these variables
#    in two different type of wines respectively.
#    (This will generate a 3 x 3 plot matrix).
#    To do that, use:
#    - `ggpairs()` to draw, please set the following parameters :
#     - `mapping` to `aes(color = type)` to set
#        different colors to different type of wines.
#     - `columns=c("density", "volatile acidity", "citric acid")`
#       to select the columns.
#     - `lower=list(continuous=wrap())` to set the lower triangle
#       plots we want to see about pairwise variables.
#       In this case, we want to see a scatter plot with a smooth regression line.
#       To do that, specify the plot inside the `wrap` function:
#        - Set `"smooth"` to be the first argument of `wrap`.
#        - Set transparency parameter `alpha = 0.3`.
#        - Set point size `size = 0.1`.
#     - `upper = list(combo = "box")` to display the correlation of pairwise
#       variables shown in upper triangle.
#     - `diag` to `list(continuous = wrap())` to set the plot on diagonals.
#       In this case, we want the density distribution of these variables.
#       To do that, specify the plot inside the `wrap` function:
#        - Set `"densityDiag"` to be the first argument of `wrap`
#        - Set `alpha = 0.7`.
#     - Set `axisLabel` to `"show"`.
#    - `theme_bw()` to use the black and white theme with argument
#      `base_size` set to 0.5 (it is the font size).
#    Save the `ggplot` object to `plot3`.
## Do not modify this line!
library(GGally)
plot3 <- ggpairs(data = wine, mapping = aes(color = type),
                 columns = c("density", "volatile acidity", "citric acid"),
                 lower = list(continuous = wrap("smooth", alpha = 0.3, size = 0.1)),
                 upper = list(combo = "box"),
                 diag = list(continuous = wrap("densityDiag", alpha = 0.7)),
                 axisLabels = "show",
) +
  theme_bw(base_size = 0.5)
plot3



# 5. Load the package `plyr`.
#    From `plot3`, we can see there is an obvious positive correlation between
#    `"density"` and `"citric acid"` in red wine.
#    We want to fit the linear relationship between "density" and "citric acid"
#    in red wines at different quality levels separately.
#    To do that, please first do data manipulations as follows:
#    Divide the wine quality into three ranges: "bad" (2~5), "average" (5~7)
#    and "good" (7~8), and store these results in column `quality_label`.
#    To do that, you can use:
#     - `filter()` to select all the red wines.
#     - `cut()` and `mutate()` to add a column called `quality_label` which
#        represents the quality range of this wine ((2,5] (5,7] (7,10]).
#     - `mutate()` and `plyr::revalue()`to reset the level
#        of column `quality_label` to c("bad", "average", "good").
#        (set `(2,5]` to `"bad"`, `(5,7]` to `"average"`
#        and `(7,10]` to `"good"`)
#    Save the new tibble into `red`. `red` should look like the following:
#    # A tibble: 1,593 x 14
#    type  `fixed acidity` `volatile acidi… `citric acid`
#    <chr>           <dbl>            <dbl>         <dbl>
#    1 red               7.4            0.7            0
#    2 red               7.8            0.88           0
#    3 red               7.8            0.76           0.04
#    4 red              11.2            0.28           0.56
#    5 red               7.4            0.7            0
#    6 red               7.4            0.66           0
#    7 red               7.9            0.6            0.06
#    8 red               7.3            0.65           0
#    9 red               7.8            0.580          0.02
#    10 red               7.5            0.5            0.36
#    # … with 1,583 more rows, and 10 more variables: `residual
#    #   sugar` <dbl>, chlorides <dbl>, `free sulfur dioxide` <dbl>,
#    #   `total sulfur dioxide` <dbl>, density <dbl>, pH <dbl>,
#    #   sulphates <dbl>, alcohol <dbl>, quality <dbl>,
#    #   quality_label <fct>
## Do not modify this line!
library(plyr)
red <- wine %>%
  filter(type =="red") %>%
  mutate(quality_label = cut(quality, breaks = c(2, 5, 7, 10), labels = c("(2,5]", "(5,7]", "(7,10]"))) %>%
  mutate(quality_label = revalue(quality_label, c("(2,5]" = "bad", "(5,7]" = "average", "(7,10]" = "good")))
red


# 6. Then draw a scatter plot with smooth regression line of `"density"`
#    against `"citric acid"` of the `red` tibble just created. In this plot, you have
#    to show the fit line and the scattered points labeled in different colors
#    according to their quality labels (good, bad, or average).
#    To do that, use:
#      - `ggplot()` to initialize a ggplot object and specify the variables to plot.
#      - `geom_smooth()` to fit the relationship and set `method` argument to `lm`.
#      - `geom_point()` with argument `aes(color = quality_label)` to add data points
#         colored in their quality labels.
#      - `scale_color_brewer()` with argument `type` set to `qual` to scale the color
#            according to the value of quality.
#     - `labs()` to format the labels such that:
#        - `title = "Positive correlation of Density and Fixed Acidity"`
#        - `x = "Fixed Acidity"`
#        - `y = "Density"`
#    Save the `ggplot` object to `plot4`.
## Do not modify this line!
plot4 <- ggplot(data = red, mapping = aes(x = `citric acid`, y = density)) +
  geom_smooth(method = "lm") +
  geom_point(mapping = aes(color = quality_label)) +
  scale_color_brewer(type = "qual") +
  labs(title = "Positive correlation of Density and Fixed Acidity",
       x = "Fixed Acidity",
       y = "Density")
plot4




