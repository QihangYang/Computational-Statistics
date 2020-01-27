# HW6: ggplot_iris
#'
# In this exercise, you have to recreate the figures found at
# the left of the instructions.
# We suggest functions you can use to create the plots, but
# you are free to use the method you are the most comfortable with.
# Make sure that the figures look exactly like the ones you are supposed to create.
#'
# The purpose of this task is to construct a complex plot using ggplot.
# Throughout the exercise:
#    - Use `theme_light()` for the plots.
#    - Do not print the plot.
# Let's consider `iris` dataset in the R base environment.
#'
# 1. Load the `ggplot2` package.
#    Plot Petal Length versus Sepal Length split by Species, i.e. different
#    colors representing different Species.
#    To do that, use:
#    - `ggplot()` to initialize a ggplot object. Set its argument `data`.
#    - `geom_point()` to generate the scatter plot. Set its arguments
#    `mapping` and 'color' to plot Petal Length versus Sepal Length split by Species.
#    - `labs()` to format the labels such that:
#      - `title = "Sepal length by petal length"`
#      - `x = "Sepal Length (cm)"`
#      - `y = "Petal Length (cm)"`
#    Store the plot into a variable `g1`.
## Do not modify this line!
library(ggplot2)
g1 <- ggplot(data = iris, mapping = aes(x = Sepal.Length, y = Petal.Length, color = iris$Species)) +
  geom_point() +
  labs(title = "Sepal length by petal length",
       x = "Sepal Length (cm)",
       y = "Petal Length (cm)") +
  theme_light()
g1

# 2. We can see that the instead of in the middle of the plot, the title is
#    on the left corner, and the title of the label is `iris$Species`
#    instead of `Sepecies`.
#    Change the title to the middle of the plot and change the title of the label.
#    To do that, use:
#    - `theme()` to change the title to the middle of the plot. Set its argument
#    `plot.title` using `element_text()`
#    - `scale_color_hue()` to change the title of the label.
#    All the changes are made to `g1`.
#    Store your new plot into a variable `g2`.
## Do not modify this line!
g2 <- g1 +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_color_hue(name = "Species")
g2



# 3. Now we want to see the linear relationship between Sepal length and
#    Petal length.
#    To do that, use:
#    - `geom_smooth()` to add to `g2` a linear regression
#    line between Petal length and Sepal length for different Sepecies, such that
#      - `method = "lm"`, to add a linear regression line
#      - `se = FALSE`, to not include the confidence interval for the regression line
#      - `fullrange = TRUE`, to lot the regression line on full range of x-axis.
#    - `labs()` to format the labels such that:
#      - `title = "Petal length is increasing in sepal length"`
#      - `subtitle="Except for the setosa species"`
#    - `theme()` to change the subtitle to the middle of the plot as well. Set its argument
#    `plot.subtitle` using `element_text()`
#    Store your new plot into a variable `g3`.
## Do not modify this line!
g3 <- g2 +
  geom_smooth(method = "lm", se = FALSE, fullrange = TRUE) +
  labs(title = "Petal length is increasing in sepal length",
       subtitle="Except for the setosa species") +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5)) 
g3


# 4. Let's say we want to emphasize a point, say the 15th point in the iris
#    dataset.
#    To do that, use:
#    - `geom_point()` to add this point to your `g3`,
#      - `pch = 17` , to plot the points as a triangle
#      - `col = "black"`, to change the color into black
#      - `cex = 3`, to change the point size to 3
#    Store your new plot into a variable `g4`.
## Do not modify this line!
g4 <- g3 +
  geom_point(data = iris[15, ], pch = 17, col = "black", cex = 3)
g4


# 5. We want to add a text to annotate the previous point.
#    To do that, use:
#    - `geom_text()` to add the coordinates for the previouly drawn point
#    in question4 onto your `g4`, such that
#    - `label = "This is the iris with the longest sepal\n among the setosa species.")`, to change the output of the text
#    - `col = "black"`, to change the color into black
#    - `nudge_x = 1` to make the  x position is 1 greater than the original point
#    Store your new plot into a variable `g5`.
#'
## Do not modify this line!
g5 <- g4 +
  geom_text(mapping = aes(x = Sepal.Length[15], y = Petal.Length[15], label = "This is the iris with the longest sepal\n among the setosa species."), 
            col = "black", nudge_x = 1)
g5




