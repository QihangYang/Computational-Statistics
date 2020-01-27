# HW6: ggplot FIFA
#'
# In this exercise, you will familiarize yourself with data visualization
# using ggplot. To be specific, you will expore the FIFA data set.
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
# 1. Load the `tidyverse`, `readr`, and `scales` packages.
#    Use the function `read_csv()` to read the dataset `data/fifa.csv`.
#    Store the corresponding dataframe into a dataset `fifa`.
#    The dimension should be 17,955 x 62.
## Do not modify this line!
library(tidyverse)
library(readr)
library(scales)
fifa <- read_csv("data/fifa.csv")



# 2. Plot the density histogram and density curve for `Age` column.
#    The x axis should be the value of age labelled as `"Age"` 
#    with ticks 20, 30, 40 (default setting).
#    The y axis should be density labelled as `"Density"`
#    with ticks 0.00, 0.02, ..., 0.08 (default setting).
#    To do that, use:
#    - `ggplot()` to initialize a ggplot object. You can set its arguments 
#      `data` and `mapping` to plot the `Age` column of the dataset. 
#      Use `aes` to set parameters `mapping`.
#    - `geom_histogram()` to plot the density histogram.
#      Please set the bin wigth to 2 (you can use `binwidth`) and color to `"white"`.
#      Hint : Set `y=..density..` to draw the density instead of count.
#    - `geom_density()` to plot the density curve.
#      Please set color to `"blue"`.
#    - `labs()` to format the labels such that:
#      - `title = "The majority of players are 20 to 30 years old"`
#      - `y = "Density"`
#    - `theme_light()` to set light theme (i.e. a light backgroung).
#    Save the plot into `age_plot`.
#    Please note that the density curve should be above the histogram.
#    The order of your commands matters.
## Do not modify this line!
age_plot <- ggplot(data = fifa, mapping = aes(x = Age, y = ..density..)) +
  geom_histogram(binwidth = 2, color = "white") +
  geom_density(color = "blue") +
  labs(title = "The majority of players are 20 to 30 years old",
       y = "Density") +
  theme_light()
age_plot


# 3. Filter the `fifa` dataset to select players that belong to club
#    `"FC Barcelona"`, `"Juventus"`, `"Manchester City"`, `"Real Madrid"`, 
#    or `"Manchester United"`. Convert `Club` column into factors and
#    order the levels by `Wage`. Store the result into tibble `club_wage`.
#    You can use : 
#      - `filter()` to get the players in the 5 correpsondinng clubs
#      - `mutate()` and `fct_reorder()` so that the players in each clubs 
#        are ordered in decreasing `Wage`.
#    The first rows of its print should be : 
#    # A tibble: 157 x 62
#    ID Name    Age Photo Nationality Flag  Overall Potential Club 
#    <dbl> <chr> <dbl> <chr> <chr>       <chr>   <dbl>     <dbl> <fct>
#    1 158023 L. M…    31 http… Argentina   http…      94        94 FC B…
#    2  20801 Cris…    33 http… Portugal    http…      94        94 Juve…
#    3 193080 De G…    27 http… Spain       http…      91        93 Manc…
#    4 192985 K. D…    27 http… Belgium     http…      91        92 Manc…
#    5 177003 L. M…    32 http… Croatia     http…      91        91 Real…
#    6 176580 L. S…    31 http… Uruguay     http…      91        91 FC B…
#    7 155862 Serg…    32 http… Spain       http…      91        91 Real…
#    8 182521 T. K…    28 http… Germany     http…      90        90 Real…
#    9 168542 Davi…    32 http… Spain       http…      90        90 Manc…
#    10 211110 P. D…    24 http… Argentina   http…      89        94 Juve…
#    # … with 147 more rows, and 53 more variables: `Club Logo` <chr>,
## Do not modify this line!
club_wage <- fifa %>%
  filter(Club %in% c("FC Barcelona", "Juventus", "Manchester City", "Real Madrid", "Manchester United")) %>%
  mutate(Club = fct_reorder(Club, Wage))


# 4. Plot the boxplot of `Wage` by `Club` using dataset `club_wage`.
#    The boxplots should be horizontal and ordered by median wage
#    from highest (on top of the figure) to lowest.
#    The x axis should be `"Wage"` without label 
#    with ticks `"€0"`, `"€200,000"`, `"€400,000"`. 
#    The y axis should be the name of clubs
#    with ticks `"Juventus"`, `"FC Barcelona"`, `"Real Madrid"`,
#    `"Manchester City"`, `"Manchester United"` from top to bottom.
#    To do that, use:
#    - `ggplot()` to initialize a ggplot object.
#      Set the `mapping` parameter correctly.
#    - `geom_boxplot()` to plot the box plot.
#    - `scale_y_continuous()` and `dollar_format` to add the Euro sign prefix
#      and thousands comma to wage.
#    - `labs()` to format the labels such that:
#      - `title = "Top 5 highest median wage clubs"`
#      `subtitle = "The medians are remarkably similar, 
#      but the higher quantiles show more variation."`
#      - `y = "Wage"`
#      - `x = ""`
#    - `theme_light()` to set light theme.
#    - `coord_flip()` to flip the coordinate. 
#    After the flip, the x-axis should now be `"Wage"`.
#    Save the plot into `wage_plot`.
## Do not modify this line!
wage_plot <- ggplot(club_wage, mapping = aes(x = Club, y = Wage)) +
  geom_boxplot() +
  scale_y_continuous(labels =  dollar_format(prefix = "€", big.mark = ",")) +
  labs(title = "Top 5 highest median wage clubs",
       subtitle = "The medians are remarkably similar, but the higher quantiles show more variation.",
       y = "Wage",
       x = "") +
  theme_light() +
  coord_flip()
wage_plot 


# 5. Create a tibble `fifa_height_weight` that contains all players whose 
#    position is either `"GK"` or `"CM"`. 
#    You can use `filter()` to filter the dataset given the two positions.
#    It should print to :
#    # A tibble: 3,366 x 62
#    ID Name    Age Photo Nationality Flag  Overall Potential Club  `Club Logo`  Value   Wage
#    <dbl> <chr> <dbl> <chr> <chr>       <chr>   <dbl>     <dbl> <chr> <chr>        <dbl>  <dbl>
#    1 193080 De G…    27 http… Spain       http…      91        93 Manc… https://cd… 7.20e7 260000
#    2 200389 J. O…    25 http… Slovenia    http…      90        93 Atlé… https://cd… 6.80e7  94000
#    3 192448 M. t…    26 http… Germany     http…      89        92 FC B… https://cd… 5.80e7 240000
# 
## Do not modify this line!
fifa_height_weight <- fifa %>%
  filter(Position %in% c("GK", "CM")) 
fifa_height_weight


# 6. Create a scatter plot of `Weight_kg` against `Height_m` in 
#    `fifa_height_weight` colored by `Position` (either `"GK"` or `"CM"`).
#    The x axis should be the height labelled as `Height (m)`
#    with ticks `1.6`, `1.7`, `1.8`, `1.9`, `2.0` (default setting).
#    The y axis should be the weight labelled as `Weight (kg)`
#    with ticks `"60"`, `"70"`, `"80"`, `"90"`, `"100"` (default setting).
#    To do that, use :
#    - `ggplot()` to initialize a ggplot object.
#    - `geom_point()` to plot the scatter plot.
#       You can set `mapping` correctly to plot `Weight_kg` against `Height_m`
#       and set `col` to `Position` to get the right colors. 
#       The two colors should be salmon and turquoise.
#       Set `alpha` to `0.8`.
#    - `labs()` to format the labels such that:
#      - `title = "Goalkeepers tend to be heavier and taller"`
#      - `y = "Weight (kg)"`
#      - `x = "Height (m)"`
#    - `theme_light()` to set light theme.
#    Save the plot into `height_weight_plot`.
## Do not modify this line!
height_weight_plot <- ggplot(data = fifa_height_weight, mapping = aes(x = Height_m, y = Weight_kg, col = Position)) +
  geom_point(alpha = 0.8) +
  labs(title = "GK tends to be heavier and taller",
       y = "Weight (kg)",
       x = "Height (m)") +
  theme_light()
height_weight_plot


# 7. Create a tibble `agility` containing the players whose 
#    `Preferred Foot` is either in `"Left"` or `"Right"`. You can use
#    `filter()` to filter given the two `Preferred Foot`.
#    It should print to : 
#    # A tibble: 17,907 x 62
#    ID Name    Age Photo Nationality Flag  Overall Potential Club  `Club Logo`  Value   Wage
#    <dbl> <chr> <dbl> <chr> <chr>       <chr>   <dbl>     <dbl> <chr> <chr>        <dbl>  <dbl>
#    1 158023 L. M…    31 http… Argentina   http…      94        94 FC B… https://cd… 1.10e8 565000
#    2  20801 Cris…    33 http… Portugal    http…      94        94 Juve… https://cd… 7.70e7 405000
#    3 190871 Neym…    26 http… Brazil      http…      92        93 Pari… https://cd… 1.18e8 290000
#    
## Do not modify this line!
agility <- fifa %>%
  filter(`Preferred Foot` %in% c("Left", "Right"))
agility


# 8. Plot the histogram of `Agility` facted by `Preferred Foot`.
#    There should be 2 subplots `Left` (on the left of the figure) 
#    and `Right` (on the right)..
#    The x axis should be `Agility` labelled as `"Agility"`
#    with ticks `"25"`, `"50"`, `"75"`, `"100"` for both 
#    subplots (default setting).
#    The y axis should be frequency labelled as `"Count (n)"`
#    with ticks `"0"`, `"200"`, `"400"` for `Left` subplot and
#    `"0"`, `"500"`, `"1000"`, `"1500"`, `"2000"` for `Right` subplot.
#    (There are much more right footed players than left footed)
#    To do that, use:
#    - `ggplot()` to initialize a ggplot object.
#    - `geom_histogram()` to plot the histogram plot.
#      You can use `mapping` to draw the correct variables, 
#      and set `bins` (number of bins) to `20`.
#      Set color to `#FFFFFF` i.e. white.
#    - `facet_wrap()` to facet by `Preferred Foot`
#      and set `scales` to `free` so that
#      we can compare the shape of the two distributions.
#    - `labs()` to format the labels such that:
#      - `title = "Distribution of agility is similar regardless of preferred foot"`
#      - `y = "Count (n)"`
#    - `theme_light()` to set light theme.
#    Save the plot into `agility_plot`.
## Do not modify this line!
agility_plot <- ggplot(data = agility, mapping = aes(x = Agility)) +
  geom_histogram(bins = 20, color = "#FFFFFF") +
  facet_wrap(~`Preferred Foot`, scales = "free") +
  labs(title = "Distribution of agility is similar regardless of preferred foot",
       y = "Count (n)") +
  theme_light()
agility_plot



