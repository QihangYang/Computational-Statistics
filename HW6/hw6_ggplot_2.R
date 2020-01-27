# HW6: ggplot2
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
# 1. Load the `ggplot2`, `dplyr`, `purrr`, `ggrepel` and `readr` packages.
#    Use `read_csv()` to load the `autompg.csv` data set from `data` folder and
#    assign it to a tibble `autompg`.
#    Create a tibble `efficiency_by_manufacturer` of dimension 398 x 11 on the base of `autompg`.
#    The dataset should transfer the `model_year` into a factor variable. It should also
#    Create a new column called `car_made` that extracts the car manufacturer from `car_name`.
#    The dataset should Create a new column called `efficiency`.
#    The formula of `efficiency` is `mpg / weight`.
#    To do that, you can use:
#    - `mutate()` and `as.factor()` to transfer the `model_year` into a factor variable.
#    - `map_chr()` and `strsplit` to extract the car manufacturer from `car_name`.
#    - `mutate()` to create a new column called `car_made` and store the list of car manufacturer names.
#    - `mutate()` to build a new column called `efficiency` and use the formula above to assign values.
#    To check your solution, `efficiency_by_manufacturer` prints to:
#    # A tibble: 398 x 11
#    mpg cylinders displacement horsepower weight acceleration model_year origin car_name
#    <dbl>     <dbl>        <dbl> <chr>       <dbl>        <dbl> <fct>       <dbl> <chr>
#    1    18         8          307 130          3504         12   70              1 chevrol…
#    2    15         8          350 165          3693         11.5 70              1 buick s…
#    3    18         8          318 150          3436         11   70              1 plymout…
#    4    16         8          304 150          3433         12   70              1 amc reb…
#    5    17         8          302 140          3449         10.5 70              1 ford to…
#    6    15         8          429 198          4341         10   70              1 ford ga…
#    7    14         8          454 220          4354          9   70              1 chevrol…
#    8    14         8          440 215          4312          8.5 70              1 plymout…
#    9    14         8          455 225          4425         10   70              1 pontiac…
#    10    15         8          390 190          3850          8.5 70              1 amc amb…
#    # … with 388 more rows, and 2 more variables: car_made <chr>, efficiency <dbl>
## Do not modify this line!
library(ggplot2)
library(dplyr)
library(purrr)
library(ggrepel)
library(readr)
autompg <- read_csv("data/autompg.csv")
efficiency_by_manufacturer <- autompg %>%
  mutate(model_year = as.factor(model_year)) %>%
  mutate(car_made = map_chr(strsplit(car_name, " "), head, 1)) %>%
  mutate(efficiency = mpg / weight)
efficiency_by_manufacturer


# 2. Draw a horizontal boxplot of `efficiency` vs. `car_made`. The ordering of boxes from top to bottom
#    should be in descending order of median of `efficiency`.
#    To do this, you can use:
#    - `geom_boxplot()` to draw a boxplot of `efficiency` vs. `car_made`(hint: use `reorder` to
#    organize the order on the x-axis).
#    - `labs()` to name the title as:
#    `"Cars made by European and Japanese manufacturers are generally more efficient"`,
#    subtitle as:
#    `"Cars made by American manufacturers are less efficient"`,
#    name the x-axis as `"Car manufacturer"`,
#    name the y-axis as `"Efficiency (mpg / kg)"`.
#    - `coord_flip()` to flip x and y.
#    Store the plot into a variable `g1`.
## Do not modify this line!
g1 <- ggplot(data =  efficiency_by_manufacturer) +
  geom_boxplot(mapping = aes(x = reorder(car_made, efficiency, FUN = median), y = efficiency)) +
  labs(title = "Cars made by European and Japanese manufacturers are generally more efficient",
       subtitle = "Cars made by American manufacturers are less efficient",
       x = "Car manufacturer",
       y = "Efficiency (mpg / kg)") +
  coord_flip() +
  theme_light() +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
g1


# 3. Draw a point plot of `mpg` vs. `weight`, colored by `model_year`.
#    To do this, you can use:
#    - `geom_point()` to draw a point plot of `diameter` vs. `rings` with colored by `model_year`.
#    Set `size` as 2, `shape` as 1 and `stroke` as 1.25,
#    - `labs()` to name the x-axis as `"Weight of a car (kg)"`,
#    name the y-axis as `"Miles per gallon"`.
#    - `scale_color_discrete()` to name the legend as `"Model year of a car \n(1970 - 1982)"`.
#    Store the plot into a variable `g2`.
## Do not modify this line!
g2 <- ggplot(data =  efficiency_by_manufacturer, mapping = aes(x = weight, y = mpg, color = model_year)) +
  geom_point(size = 2, shape = 1, stroke = 1.25) +
  labs(x = "Weight of a car (kg)",
       y = "Miles per gallon") + 
  scale_color_discrete(name = "Model year of a car 
(1970 - 1982)") +
  theme_light() +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
g2


# 4. Draw a smooth curve on the `g2` using `loess` funnction.
#    To do this, you can use:
#    - `geom_smooth()` to draw a smooth curve with `linetype` as `r2`. Set method as `loess`,
#    `se` as `TRUE` and `color` as `red`.
#    - `guides()` to remove the legend of `linetype`.
#    Store the plot into a variable `g3`.
## Do not modify this line!
g3 <- g2 +
  geom_smooth(mapping = aes(linetype = "r2"), color = "red", method = loess, se = TRUE) +
  guides(linetype = "none")
g3 


# 5. Build a tibble `best_efficiency_by_manufacturer` of dimension 37 x 11.
#    The dataset extracts the largest `efficiency` of each manufacturer from `efficiency_by_manufacturer`.
#    To do this, you can use:
#    - `group_by()` to group the `car_made`
#    - `filter()` to filter out the rows with max `efficiency` of each car manufacturer.
#    To check your solution, `best_efficiency_by_manufacturer` prints to:
#    # A tibble: 37 x 11
#    # Groups:   car_made [37]
#    mpg cylinders displacement horsepower weight acceleration model_year origin car_name
#    <dbl>     <dbl>        <dbl> <chr>       <dbl>        <dbl> <fct>       <dbl> <chr>
#    1    25         4          104 95           2375         17.5 70              2 saab 99e
#    2    26         4          121 113          2234         12.5 70              2 bmw 2002
#    3     9         8          304 193          4732         18.5 70              1 hi 1200d
#    4    28         4          116 90           2123         14   71              2 opel 19…
#    5    30         4           79 70           2074         19.5 71              2 peugeot…
#    6    35         4           72 69           1613         18   71              3 datsun …
#    7    23         4          120 97           2506         14.5 72              3 toyouta…
#    8    16         6          250 105          3897         18.5 75              1 chevroe…
#    9    25         4          140 92           2572         14.9 76              1 capri ii
#    10    30         4          111 80           2155         14.8 77              1 buick o…
#    # … with 27 more rows, and 2 more variables: car_made <chr>, efficiency <dbl>
## Do not modify this line!
best_efficiency_by_manufacturer <- efficiency_by_manufacturer %>%
  group_by(car_made) %>%
  filter(efficiency == max(efficiency))
best_efficiency_by_manufacturer


# 6. Draw manufacturer names onto `g3` and
#    - add a title onto the graph and name title as:
#    `"Mpg is decreasing in weights"`.
#    - name the subtitle as:
#    `"How are cars performing in best efficiency by different car manufacturers?"`.
#    - move all the legends on the top in one row.
#    To do this, you can use:
#    - `geom_text_repel()` to draw every `car_made` name onto the graph from `best_efficiency_by_manufacturer`.
#    - `labs()` to name the title as:
#    `"Mpg is decreasing in weights"`, subtitle as:
#    `"How are cars performing in best efficiency by different car manufacturers?"`.
#    - `guides()` and `guide_legend()` to make all legend in one row.
#    - `theme()` to set `legend.position` as `top`, `legend.direction` as `horizontal` and
#    `legend.justification` as 0.1.
#'
## Do not modify this line!
g4 <- g3 +
  ggrepel::geom_text_repel(aes(label = car_made), color = "black", data = best_efficiency_by_manufacturer) +
  labs(title = "Mpg is decreasing in weights",
       subtitle = "How are cars performing in best efficiency by different car manufacturers?") +
  guides(col = guide_legend(nrow = 1)) +
  theme_light() +
  theme(legend.position = "top", legend.direction = "horizontal", legend.justification = 0.1) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
g4
  


