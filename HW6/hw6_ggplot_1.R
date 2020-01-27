# HW6: ggplot1
#'
# In this exercise, you have to recreate the figures found at
# the left of the instructions.
# We suggest functions you can use to create the plots, but
# you are free to use the method you are the most comfortable with.
# Make sure that the figures look exactly like the ones you are supposed to create.
#'
# The purpose of this task is to get familiar with ggplot.
# Throughout the exercise, please use `theme_light()` as your base theme.
# For graphs with titles, make the format as
# `theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))`.
#'
# 1. Load the `ggplot2`, `readr` and `tidyr` packages.
#    Use `read_csv` to load the `abalone.csv` data set from `data` folder and
#    use `drop_na()` to drop NAs, then assign it to a tibble `abalone`.
#    To check your solution, `abalone` prints to:
#    # A tibble: 4,077 x 9
#    sex   length diameter height whole_weight shucked_weight viscera_weight shell_weight
#    <chr>  <dbl>    <dbl>  <dbl>        <dbl>          <dbl>          <dbl>        <dbl>
#    1 M      0.455    0.365  0.095        0.514         0.224          0.101         0.15
#    2 M      0.35     0.265  0.09         0.226         0.0995         0.0485        0.07
#    3 F      0.53     0.42   0.135        0.677         0.256          0.142         0.21
#    4 M      0.44     0.365  0.125        0.516         0.216          0.114         0.155
#    5 I      0.33     0.255  0.08         0.205         0.0895         0.0395        0.055
#    6 I      0.425    0.3    0.095        0.352         0.141          0.0775        0.12
#    7 F      0.53     0.415  0.15         0.778         0.237          0.142         0.33
#    8 F      0.545    0.425  0.125        0.768         0.294          0.150         0.26
#    9 M      0.475    0.37   0.125        0.509         0.216          0.112         0.165
#    10 F      0.55     0.44   0.15         0.894         0.314          0.151         0.32
#    # … with 4,067 more rows, and 1 more variable: rings <dbl>
#'
## Do not modify this line!
library(ggplot2)
library(readr)
library(tidyr)
abalone <- read_csv("data/abalone.csv")
drop_na(abalone)


# 2. Draw a density plot of `rings`, colored by `sex`.
#    To do this, you can use:
#    - `stat_density()` to draw a bar plot of `rings` and set `color` as `sex`. Set `geom` as `line`
#    and `position` as `identity`.
#    - `labs()` to name the title as:
#    `Male and female abalone have similar modes in rings around 10,\n`
#    `while infant abalone have lower mode in rings around 8`,
#    name the x-axis as: `"Number of rings"`,
#    name the y-axis as: `"Density"`.
#    - `scale_color_discrete` to name the legend as `"Sex"`.
#    Store the plot into a variable `g1`.
## Do not modify this line!
g1 <- ggplot(data = abalone) +
  stat_density(mapping = aes(x = rings, color = sex), geom = "line", position = "identity") + 
  labs(title = "Male and female abalone have similar modes in rings around 10,\nwhile infant abalone have lower mode in rings around 8",
       x = "Number of rings",
       y = "Density") + 
  scale_color_discrete(name = "Sex") +
  theme_light()+
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
g1



# 3. Draw a histogram of `diameter` with `binwidth` = 0.05,
#    filled by `sex` and also faceted by `sex` in grids.
#    To do this, you can use:
#    - `geom_histogram()` to draw a histogram of `diameter` with `binwidth` as 0.05,
#     and set `fill` also as `sex`.
#    - `facet_grid()` to facet the graph by `sex`.
#    - `labs()` to name the title as:
#    `"Female and male abalone tend to have more left skewed distributions of diameter,\n`
#    `while the infant abalone\'s diameter distribution looks more normal"`,
#    name the x-axis as `"Diameter of abalone (mm)"`,
#    name the y-axis as `"Count of abalone"`.
#    - `scale_fill_discrete()` to name the legend as `"Sex"`.
#    Store the plot into a variable `g2`.
## Do not modify this line!
g2 <- ggplot(data = abalone) + 
  geom_histogram(mapping = aes(x = diameter, fill = sex), binwidth = 0.05) +
  facet_grid(. ~ sex) +
  labs(title = "Female and male abalone tend to have more left skewed distributions of diameter,\nwhile the infant abalone\'s diameter distribution looks more normal",
       x = "Diameter of abalone (mm)",
       y = "Count of abalone") +
  scale_fill_discrete(name = "Sex") +
  theme_light()+
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
g2



# 4. Draw a boxplot of `diameter` vs. `sex`. The ordering of boxes from left to right
#    should be in descending order of median of `diameter`.
#    To do this, you can use:
#    - `geom_boxplot()` to draw a boxplot of `diameter` vs. `sex`(hint: use `reorder` to
#    organize the order on the x-axis).
#    - `labs()` to name the title as:
#    `"Male and female abalone have similar median,\n`
#    `while infant abalone have smaller median"`,
#    name the x-axis as `"Sex"`,
#    name the y-axis as `"Diameter of abalone (mm)"`.
#    Store the plot into a variable `g3`.
## Do not modify this line!
g3 <- ggplot(data = abalone, mapping = aes(x = reorder(sex, -diameter), y = diameter)) +
  geom_boxplot() +
  labs(title = "Male and female abalone have similar median,\nwhile infant abalone have smaller median", 
       x = "Sex",
       y = "Diameter of abalone (mm)") +
  theme_light()+
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
g3



# 5. Draw a point plot of `diameter` vs. `rings`, faceted by `sex` into wraps.
#    Draw a smooth curve that passes through points using `loess` method.
#    Name the title as `"Diameter is increasing in rings"`,
#    subtitle as `"But the increase mostly stops around 10 rings"`.
#    To do this, you can use:
#    - `geom_point()` to draw a point plot of `diameter` vs. `rings`.
#    - `geom_smooth()` to draw a smooth curve using method as `loess`.
#    - `facet_wrap()` to facet the graph by `sex`.
#    - `labs()` to name the title as `"Diameter is increasing in rings"`, subtitle as
#    `"But the increase mostly stops around 10 rings"`,
#    name the x-axis as `"Number of rings"`,
#    name the y-axis as `"Diameter of abalone (mm)"`.
#    Store the plot into a variable `g4`.
## Do not modify this line!
g4 <- ggplot(data = abalone, mapping =  aes(x = rings, y = diameter)) +
  geom_point() +
  geom_smooth(method = "loess", color = "red") +
  facet_wrap(~ sex) +
  labs(title = "Diameter is increasing in rings",
       subtitle = "But the increase mostly stops around 10 rings",
       x = "Number of rings",
       y = "Diameter of abalone (mm)") +
  theme_light()+
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
g4


# 6. Draw a violin plot of `whole_weight` vs. `length`, faceted by `sex` in grids.
#    To do this, you can use:
#    - `geom_violin()` to draw a violin plot of `whole_weight` vs. `length`.
#    - `facet_grid()` to facet the graph by `sex`.
#    - `labs()` to name the title as:
#    `"Male and female abalone have similar distribution in whole weight and length,\n`
#    `while infant ablone's distribution skew to the higher weights"`,
#    name the x-axis as `"Length of abalone (mm)"`,
#    name the y-axis as `"Whole weight of abalone (grams)"`.
#    Store the plot into a variable `g5`.
#'
#'
## Do not modify this line!
g5 <- ggplot(data = abalone, mapping = aes(x = length, y = whole_weight)) +
  geom_violin() +
  facet_wrap(~ sex) +
  labs(title = "Male and female abalone have similar distribution in whole weight and length,\n       while infant ablone's distribution skew to the higher weights",
       x = "Length of abalone (mm)",
       y = "Whole weight of abalone (grams)") +
  theme_light()+
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
g5


