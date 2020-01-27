# HW6: ggplot wine
#'
# In this exercise, you will familiarize yourself 
# with Cleveland dot plot using ggplot.
# You may refer to `https://uc-r.github.io/cleveland-dot-plots` to 
# get a better idea of what Cleveland dot plot is.
# 
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
# 1. Load the `tidyverse`, `pgmm`, and `tidyr` packages.
#    Use function `data()` to load `wine` data set from `pgmm` package.
#    Then use `as_tibble()` to turn `wine` into a tibble .
## Do not modify this line!
library(tidyverse)
library(pgmm)
library(tidyr)
data(wine)
wine <- as_tibble(wine)



# 2. Create a tibble `mean_value` with column `Property` and `Value`.
#    Each row contains one property and its mean value.
#    Column `Property` should be factors and its levels should be 
#    ordered by `Value`. This will make the dots in plot ordered by `Value`.
#    To do that, you can use:
#    - `select()` to deselect the `Type` column.
#    - `dplyr::summarize_all()` to compute the mean value for each column.
#    - `pivot_longer()` to transform the result into long form.
#    - `dplyr::rename()` to rename the column name to `"Property"`
#      and `"Value"`.
#    - `dplyr::mutate()`, `fct_reorder()`, and `as.factor()`  
#      to turn `Property` column into factors.
#    The first few lines of `mean_value` should look like:
#    # A tibble: 27 x 2
#      Property                  Value
#      <chr>                     <dbl>
#    1 Alcohol                   13.0  
#    2 Sugar-free Extract        25.3  
#    3 Fixed Acidity             85.6  
#    4 Tartaric Acid             2.00 
#    5 Malic Acid                2.34 
#    6 Uronic Acids              0.915
#    7 pH                        3.30 
#    8 Ash                       2.37 
#    9 Alcalinity of Ash         19.5  
#   10 Potassium                 881.   
#    # … with 17 more rows
## Do not modify this line!
mean_value <- wine %>%
  select(-Type) %>%
  summarize_all(mean) %>%
  pivot_longer(everything(), names_to = "Property", values_to = "Value") %>%
  mutate("Property" = fct_reorder(as.factor(Property), Value))
mean_value


# 3. Create a Cleveland dot plot showing the mean value 
#    for each of the 27 chemical and physical properties of the wines
#    using `mean_value`.
#    The x axis is the value of the properties labelled as `"Value"`
#    with ticks `0`, `250`, `500`, `750`(default setting).
#    The y axis is the name of the properties labelled as `"Property"`
#    with ticks `"Potassium"`, `"Proline"`, ..., 
#    `"Non-flavanoid Phenols"` from top to bottom.
#    To do that, you can use:
#    - `ggplot()` to initialize a ggplot object.
#    - `geom_point()` to plot the box plot.
#    - `scale_x_log10()` to use the logarithm scale for x axis.
#    - `ggtitle()` to set title to `"Most properties have value below 100"`.
#    - `theme_light()` to set light theme.
#    Save the plot into `mean_value_plot`.
## Do not modify this line!
mean_value_plot <- ggplot(data = mean_value, mapping = aes(x = Value, y = Property)) +
  geom_point() +
  scale_x_log10() +
  ggtitle("Most properties have value below 100") +
  theme_light()
mean_value_plot




# 4. Create a tibble `mean_value_by_type` with column `Type`, `Property`, and `Value`.
#    For each type and property, it has one row that contains its mean value.
#    Column `Property` should be factors and its levels should be 
#    ordered by the maximum value of all types. 
#    This will make the dots in plot ordered by `Value`.
#    To do that, you can use :
#    - `group_by()` to group by `Type`.
#    - `dplyr::summarize_all()` to compute the mean value for each column.
#    - `pivot_longer()` to rename the column name.
#    - `fct_relevel()` to turn `Property` column into factors
#      and relevel the levels.
#    To use `fct_relevel()`, you need to pass it a vector containing
#    the properties in order of `Value` (the first `Property` in the vector 
#    should be the one that corresponds to the lowest `Value`). You may compute it
#    using  `group_by()` to group by `Property`, `summarize` and `max` to compute
#    the maximum value, `arrange()` to compute the order of the levels according 
#    to `Value`, `dplyr::select()` to get the column `Property` and `pull()` 
#    to extract the vector.
#    The first few lines of `mean_value_by_type` should look like:
#    # A tibble: 81 x 3
#      Type Property             Value
#      <dbl> <fct>                <dbl>
#    1     1 Alcohol              13.7  
#    2     1 Sugar-free Extract   26.8  
#    3     1 Fixed Acidity        76.7  
#    4     1 Tartaric Acid        1.64 
#    5     1 Malic Acid           2.01 
#    6     1 Uronic Acids         0.811
#    7     1 pH                   3.33 
#    8     1 Ash                  2.46 
#    9     1 Alcalinity of Ash    17.0  
#   10     1 Potassium            898.   
#    # … with 71 more rows
## Do not modify this line!

tmp <- wine %>%
  group_by(Type) %>%
  summarize_all(mean) %>%
  pivot_longer(-Type, names_to = "Property", values_to = "Value")

Property_leveled <- tmp%>%
  group_by(Property) %>%
  summarize("max" = max(Value)) %>%
  arrange(max) %>%
  select(Property) %>%
  pull()

mean_value_by_type <- tmp %>%
  mutate(Property = fct_relevel(as.factor(Property), Property_leveled))

mean_value_by_type



# 5. Create a Cleveland dot plot with multiple dots to 
#    show mean value of each of the 27 properties by Type 
#    using `mean_value_by_type`. 
#    That is, each property–such as Ash–should have three different 
#    colored dots, one for each Type. The color should be decided 
#    by parameters in `geom_point()` using default setting.
#    The tibble we just built in problem 4 enables the properties 
#    to be sorted (highest on top) by the maximum value of all types.
#    The x axis is the value of the properties labelled as `"Value"`
#    with ticks `0`, `250`, `500`, `750`(default setting).
#    The y axis is the name of the properties labelled as `"Property"`
#    with ticks `"Proline_mean"`, `"Potassium"`, ..., 
#    `"Non-flavanoid Phenols"` from top to bottom.
#    To do that, you can use:
#    - `ggplot()` to initialize a ggplot object.
#    - `geom_point()` to plot the box plot, setting 
#      `color` to `factor(Type)`.
#    - `scale_x_log10()` to use the logarithm scale for x axis.
#    - `labs()` to set the legend name to `"Type"`.
#    - `ggtitle()` to set title to `"Mean Proline values vary significantly among three types"`.
#    - `theme_light()` to set light theme.
#    Save the plot into `mean_value_plot2`.
## Do not modify this line!
mean_value_plot2 <- ggplot(data = mean_value_by_type, mapping = aes(x = Value, y = Property, color = factor(Type))) +
  geom_point() +
  scale_x_log10() +
  labs(color = "Type") +
  ggtitle("Mean Proline values vary significantly among three types") +
  theme_light()
mean_value_plot2



