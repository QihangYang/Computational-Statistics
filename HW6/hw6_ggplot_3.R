# HW6: ggplot_iris
#'
# In this exercise, you have to recreate the figures found at
# the left of the instructions.
# We suggest functions you can use to create the plots, but
# you are free to use the method you are the most comfortable with.
# Make sure that the figures look exactly like the ones you are supposed to create.
#'
# The purpose of this task is to get familiar with ggplot.
# Throughout the exercise:
#    - Use `theme_light()` for the plots.
#    - Do not print the plot.
# Let's consider `diamonds` dataset in the R base environment.
#'
# 1. Load the `ggplot2` and `scales` package.
#    Plot a stacking histogram for Price. Fill in the histogram with `cut` i.e.
#    each cut reprent a different color in the histogram.
#    To do that, use:
#    - `ggplot()` to initialize a ggplot object. Set its arguments `data` and `mapping`
#    - `geom_histogram()` to plot a histogram for Price, such that
#      - `binwidth = 500` to set the binwidth
#    - `scale_x_continuous(label=comma)` to change x-axis scale
#    - `scale_y_continuous(label=comma)` to change y-axis scale
#    - `labs()` to format the labels such that:
#      - `title = "Counts go down as price goes up"`
#      - `subtitle = "Ideal cuts account for nearly half of the diamonds"`
#      - `x = "Price (USD)"`
#      - `y = "Count (n)"`
#    Store the plot into a variable `g1`.
## Do not modify this line!
library(ggplot2)
library(scales)
g1 <- ggplot(data = diamonds, mapping = aes(x = price, fill = cut)) +
  geom_histogram(binwidth = 500) +
  scale_x_continuous(label = comma) +
  scale_y_continuous(label = comma) +
  labs(title = "Counts go down as price goes up",
       subtitle = "Ideal cuts account for nearly half of the diamonds",
       x = "Price (USD)",
       y = "Count (n)") +
  theme_light()
g1


# 2. We can see that if we plot the count using different colors in the same
#    bin, it is hard to compare between different color groups(i.e. cut).
#    To do that, use:
#    - `ggplot()` to initialize a ggplot object. Set its arguments `data` and `mapping`
#    - `geom_freqpoly()` to generate the frequency polygons for price
#    split by different cuts(split in color as well)
#      -`binwidth = 500` to set the binwidth
#    - `labs()` to format the labels such that:
#      - `title = "Max count is reached when price is around 1000 USD"`
#      - `x = "Price (USD)"`
#      - `y = "Count (n)"`
#    Store the plot into a variable `g2`.
## Do not modify this line!
g2 <- ggplot(data = diamonds, mapping = aes(x = price, color = cut)) +
  geom_freqpoly(binwidth = 500) +
  labs(title = "Max count is reached when price is around 1000 USD",
       x = "Price (USD)",
       y = "Count (n)") +
  theme_light()
g2


# 3. Generate a scatter plot of Price versus Carat,
#    split by Cut (each color represents one cut).
#    Add smoothing curve to the plot for each cut category.
#    Do not include the confidence interval.
#    To do that, use:
#    - `ggplot()` to initialize a ggplot object. Set its arguments `data` and `mapping`
#    - `geom_point()` to add scatter plot
#    - `geom_smooth()` to add a smoothing regression curve such that
#      - `se = FALSE`, to not include the confidence interval
#    - `labs()` to format the labels such that:
#      - `title = "In general price go up as carat goes up"`
#      - `subtitle = "Ideal cuts have highest increasing rate"`
#      - `x = "Carat"`
#      - `y = "Price (USD)"`
#    Store the plot into a variable `g3`.
## Do not modify this line!
g3 <- ggplot(data = diamonds, mapping = aes(x = carat, y = price, color = cut)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  labs(title = "In general price go up as carat goes up",
       subtitle = "Ideal cuts have highest increasing rate",
       x = "Carat",
       y = "Price (USD)") +
  theme_light()
g3  


# 4. Create a grid of plots using, Clarity on x-axis and Color
#    on y-axis for the entire grid.
#    For each plot in the grid, plot Price versus
#    Carat and split by Cut, with each color representing one cut.
#    To do that, use:
#    - `ggplot()` to initialize a ggplot object. Set its arguments `data` and `mapping`
#    - `geom_point()` to add scatter plot
#    - `facet_grid()` to create the grid
#    - `labs()` to format the labels such that:
#      - `title = "In general price go up as carat goes up"`
#      - `subtitle = "I1 clarity seems to have the lowest increasing rate"`
#      - `x = "Carat"`
#      - `y = "Price (USD)"`
#    Store your new plot into a variable `g4`.
## Do not modify this line!
g4 <- ggplot(data = diamonds, mapping = aes(x = carat, y = price, color = cut)) +
  geom_point() +
  facet_grid(color ~ clarity) +
  labs(title = "In general price go up as carat goes up",
       subtitle = "I1 clarity seems to have the lowest increasing rate",
       x = "Carat",
       y = "Price (USD)") +
  theme_light()
g4  


# 5. Generate a boxplot for price for each color,
#    i.e. color on x-axis, then generate boxplot for price within each color.
#    scale the y axis to log10 scale.
#    To do that, use:
#    - `ggplot()` to initialize a ggplot object. Set its arguments `data` and `mapping`
#    - `geom_boxplot()` to add box plot for price within each color group
#    - `scale_y_log10()` to rescale the y-axis
#    - `labs()` to format the labels such that:
#      - `title = "Color J has the highest price"`
#      - `x = "Color"`
#      - `y = "Price (USD)"`
#    Store your new plot into a variable `g5`.
## Do not modify this line!
g5 <- ggplot(data = diamonds, mapping = aes(x = color, y = price)) +
  geom_boxplot() +
  scale_y_log10() +
  labs(title = "Color J has the highest price",
       x = "Color",
       y = "Price (USD)") +
  theme_light()
g5  



# 6. Now generate a similar plot with price against color, but change the box
#    plot into a violin plot. This time, also generate a facet grid split by Clarity.
#    To do that, use:
#    - `ggplot()` to initialize a ggplot object. Set its arguments `data` and `mapping`
#    - `geom_violin()` to add violin plot
#    - `scale_y_log10()` to rescale the y-axis
#    - `facet_wrap()` to generate the grid for each clarity
#    - `labs()` to format the labels such that:
#      - `title = "Diffrent clarities and colors show various distribution in price"`
#      - `x = "Color"`
#      - `y = "Price (USD)"`
#    Store your new plot into a variable `g6`.
#'
## Do not modify this line!
g6 <- ggplot(data = diamonds, mapping = aes(x = color, y = price)) +
  geom_violin() +
  scale_y_log10() +
  facet_wrap(~clarity) +
  labs(title = "Diffrent clarities and colors show various distribution in price",
       x = "Color",
       y = "Price (USD)") +
  theme_light()
g6



