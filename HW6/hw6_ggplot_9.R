# HW6: ggplot9
#'
# In this exercise, you have to recreate the figures found at 
# the left of the instructions, in the same order.
# We suggest functions you can use to create the plots, but 
# you are free to use the method you are the most comfortable with.
# Make sure that the figures look exactly like the ones you are supposed to create.
#'
# 1. Do the following:
#    - load the `readr` and `dplyr` package
#    - then load the `/course/data/employee.csv` file using `read_csv()`, containing
#    salary and overtime information aggregated over different organizational
#    groups.
#    - then, transform the `Year` column to a factor column.
#    Hint: you can use `mutate()` and `factor()` to do so.
#    - assign the resulting tibble to the variable `employee`
#    - use `head()` on `employee` to see the first lines and assign the output
#    tibble to `employee_head`
#    `employee_head` should look like:
#    # A tibble: 6 x 4
#      Year  organization                            Salaries Overtime
#      <fct> <chr>                                      <dbl>    <dbl>
#    1 2013  Public Protection                        123841.   76854.
#    2 2014  Public Works, Transportation & Commerce   61138.    7341.
#    3 2016  Public Works, Transportation & Commerce   41193.       0
#    4 2015  Public Works, Transportation & Commerce   66994.   26634.
#    5 2013  Public Works, Transportation & Commerce   74261.       0
#    6 2015  Public Works, Transportation & Commerce  141778.       0
## Do not modify this line!
library(readr)
library(dplyr)
employee <- read_csv("/course/data/employee.csv") %>%
  mutate(Year = factor(Year))
employee_head <- head(employee)



# 2. Load the `ggplot2` and `scales` packages. Generate a boxplot of salaries
#    per year and assign the plot to variable `salary_boxplots`.
#    To do so, you can:
#    - use `ggplot()`, `geom_boxplot()` to create the boxplot from `employee`
#    - then add `scale_y_continuous(label = comma)`
#      Note: `scale_y_continuous(label = comma)` makes the y-labels more
#      readable, forcing a comma notation for numbers (e.g. 5e+05 becomes
#      500,000)
#     - use `labs()` to format the labels such that:
#          - `title = "Salaries are getting a longer tail with time"`
#          - `y = "Yearly salaries (USD)"`
#    - finally add the light theme using `theme_light()`
#    (adding each element to the plot using `+`)
#    The x-axis name should be `Year` and the y-axis should be
#    `"Yearly salaries (USD)"`.
## Do not modify this line!
library(ggplot2)
library(scales)
salary_boxplots <- ggplot(data = employee, mapping = aes(x = Year, y = Salaries)) +
  geom_boxplot() +
  scale_y_continuous(label = comma) +
  labs(title = "Salaries are getting a longer tail with time",
       y = "Yearly salaries (USD)") +
  theme_light()
salary_boxplots


# 3. Change all salaries higher than `250,000` to `250,000` and assign the
#    transformed tibble to `employee_trunc`
#    Hint: you can use `mutate` and `ifelse` to do so
#    `employee_trunc` should look like:
#    # A tibble: 213,116 x 4
#       Year  organization                             Salaries Overtime
#       <fct> <chr>                                       <dbl>    <dbl>
#     1 2013  Public Protection                         123841.   76854.
#     2 2014  Public Works, Transportation & Commerce    61138.    7341.
#     3 2016  Public Works, Transportation & Commerce    41193.       0
#     4 2015  Public Works, Transportation & Commerce    66994.   26634.
#     5 2013  Public Works, Transportation & Commerce    74261.       0
#     6 2015  Public Works, Transportation & Commerce   141778.       0
#     7 2015  Public Works, Transportation & Commerce    51152.   25725.
#     8 2015  Public Protection                          27352.       0
#     9 2013  Human Welfare & Neighborhood Development   72115.       0
#    10 2015  General Administration & Finance             391.     323.
#    # … with 213,106 more rows
## Do not modify this line!
employee_trunc <- employee %>%
  mutate(Salaries = ifelse(Salaries > 250000, 250000, Salaries))
employee_trunc



# 4. Generate histograms of salaries faceted on years - ie. one histogram per
#    year - and assign the plot to variable `salary_histograms`.
#    To do so, you can:
#    - create the plot by calling `ggplot()` on `employee_trunc`
#    - adding `geom_histogram()` with a `binwidth` of `5,000`
#    - then faceting on years using `facet_wrap()`
#    - then forcing comma notation for both axes (as you did for the y-axis in
#      question 2.)
#     - `labs()` to format the labels such that:
#          - `title = "Salaries have a slowly changing bimodal distribution"`
#          - `x = "Yearly salaries (USD)"`
#          - `y = ""`
#    - then add the light theme using `theme_light()`
#    - finally add a layer to rotate the x-labels by 45 degrees to make them
#      easier to  read to the plot using `theme()`, setting `axis.text.x` to
#      `element_text(angle = 45, hjust = 1)`.
#      Setting the parameter `hjust` of `element_text()` to `1` lowers the
#      labels so that they don't overlap with the figure.
#    The x-axis should read `Yearly salaries (USD)` and the y-axis should have no name.
## Do not modify this line!
salary_histograms <- ggplot(data = employee_trunc, mapping = aes(x = Salaries)) +
  geom_histogram(binwidth = 5000) +
  facet_wrap(~Year) +
  scale_y_continuous(label = comma) + 
  scale_x_continuous(label = comma) +
  labs(title = "Salaries have a slowly changing bimodal distribution",
       x = "Yearly salaries (USD)",
       y = "") +
  theme_light() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
salary_histograms



# 5. Plot overlapping density curves of the salaries, one curve per year, on a
#    single set of axes. Assign the plot to the variable `salary_densities`.
#    Each curve should be a different color.
#    To do so, you can:
#    - use `ggplot()` setting with the `colour` parameter in the aesthetic to
#      `Year`
#    - add `geom_density()` to plot the densities of `Salaries`
#    - then force comma notation for the x-axis (as you did for the y-axis in
#      question 2.)
#     - `labs()` to format the labels such that:
#          - `title = "The salaries modes are becoming less acute with time"`
#          - `x = "Yearly salaries (USD)"`
#          - `y = "Densities for each year"`
#    - finally add the light theme using `theme_light()`
#    The x-axis should read `"Yearly salaries (USD)"` and the y-axis should be
#    titled `"Densities for each year"`. There should also be a colour legend
#    titled `Year`.
#    Note that the densities of the more recent years are plotted over the
#    older ones. (Both the legend and the order of plots correspond to default
#    setting if you use the suggested functions.)
## Do not modify this line!
salary_densities <- ggplot(data = employee_trunc, mapping = aes(x = Salaries, col = Year)) +
  geom_density() +
  scale_x_continuous(label = comma) +
  labs(title = "The salaries modes are becoming less acute with time",
       x = "Yearly salaries (USD)",
       y = "Densities for each year") +
  theme_light()
salary_densities


# 6. Keep only the employees in `Culture & Recreation` from `employee` with a
#    positive salary and assign the result to variable `employee_culture`.
#    Hint: you can use `filter()`
#    `employee_culture` should look like:
#    # A tibble: 19,569 x 4
#       Year  organization         Salaries Overtime
#       <fct> <chr>                   <dbl>    <dbl>
#     1 2014  Culture & Recreation   29282.       0
#     2 2015  Culture & Recreation   26871.       0
#     3 2014  Culture & Recreation   17744.       0
#     4 2013  Culture & Recreation   76945.     694.
#     5 2014  Culture & Recreation    9362.       0
#     6 2015  Culture & Recreation    8304.       0
#     7 2013  Culture & Recreation   12992        0
#     8 2013  Culture & Recreation   16208.       0
#     9 2013  Culture & Recreation   59124.       0
#    10 2017  Culture & Recreation    2164.       0
#    # … with 19,559 more rows
## Do not modify this line!
employee_culture <- employee %>%
  filter(organization == "Culture & Recreation" & Salaries > 0)
employee_culture




# 7. Plot a QQ plot for the logarithm of salaries of the `Culture & Recreation`
#    employees and assign the result to variable `log_salaries_qq`.
#    To do so, you can:
#    - create the plot from `employee_culture` using `ggplot()` and setting
#      `sample` (argument of the aesthetic) to the logarithms of `Salaries`
#      (using `log10()`)
#    - add `geom_qq()` to create the QQPlot
#    - add the line to the plot using `geom_qq_line()`
#     - `labs()` to format the labels such that:
#          - `title = "The log salaries severely diverge from a normal distribution"`
#          - `x = "Theoretical quantiles of log(salaries)"`
#          - `y = "Sample quantiles of log(salaries)"`
#    - finally add the light theme using `theme_light()`
## Do not modify this line!
log_salaries_qq <- ggplot(data = employee_culture, mapping = aes(sample = log10(Salaries))) +
  geom_qq() +
  geom_qq_line() +
  labs(title = "The log salaries severely diverge from a normal distribution",
       x = "Theoretical quantiles of log(salaries)",
       y = "Sample quantiles of log(salaries)") +
  theme_light()
log_salaries_qq




