# HW5: Data Manipulation and Tidying on the Iris dataset
#
#  Refrain from using any loops (`for`, `while`) and `repeat` for this exercise.
#
#  Also feel free to use `gather()` and `spread()` instead of `pivot_wider()`
#  and `pivot_longer()` if you feel more comfortable with the former in the
#  exercise.
#
#  1. Load the `dplyr` and `tibble` packages. Load the `iris` dataset in the
#   namespace using `data(iris)` and transform it into a tibble of the same name
#   using `as_tibble()`. Inspect the first rows of the tibble using `head()` to
#   get an idea of the data at hand. Assign the result to the `head_iris` tibble.
#   (dimensions should be: `iris (150x5)`, `head_iris (6x5)`)
#   To check your solution, the first three lines of `head_iris` print to:
#   # A tibble: 6 x 5
#   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#   <dbl>       <dbl>        <dbl>       <dbl> <fct>
#    1          5.1         3.5          1.4         0.2 setosa
#    2          4.9         3            1.4         0.2 setosa
#    3          4.7         3.2          1.3         0.2 setosa
## Do not modify this line!
library(dplyr)
library(tibble)
data(iris)
iris <- as_tibble(iris)
head_iris <- head(iris)



#  2. Use `summary()` to print statistical summaries for each of the variable
#   in `iris`. Assign the result to variable `summary_iris`.
#   We'll try to reproduce the content of this summary breaking it down in
#   several steps.
## Do not modify this line!
summary_iris <- summary(iris)


#  3. First, let's compute the column that contains the counts across the
#   different species of iris.
#   To do so, you can use `count()`.
#   Assign the resulting tibble to variable `species_count`. It should contain
#   two colums `Species` and `num`, representing each specie of iris and how many
#   of each specie are found in the dataset.
#   (dimensions should be: `species_count (3x2)`)
#   To check your solution, the first line of `species_count` prints to:
#   # A tibble: 3 x 2
#   Species      num
#   <fct>      <int>
#    1 setosa        50
#
#   Now let's focus on the numerical variables.
## Do not modify this line!
species_count <- iris %>%
  group_by(Species) %>%
  count() %>%
  rename("num" = n)
species_count


#  4. Before going forward, we will make sure the `select()` function that you
#    might use in the next questions is the one we need : write
#   `select <- dplyr::select` to make sure calling `select()` will call the
#   `dyplr` function (the `MASS` package also has one and there might be some
#   collusion based on your environment if this precaution is not taken). You can
#   now use `select()` as in `df %>% select()` as you learned how to.
#   You might not use `select` in the next questions, but if you do you'll now
#   be sure it is the right function.
## Do not modify this line!
select <- dplyr::select



#  5. Load the `stats` package. Select all columns except for `Species` (you
#   might use `select()`) and piping the result, compute their min,
#   first quantile, median, mean, third quantile and max.
#   To do so, you can use:
#   - `summarize_if` in conjunction with `is.numeric`,
#   - and built-in `min`, `median`, `mean`, `max`,
#   - as well as `stats::quantile` (be careful to transform it into a function
#     of only one variable to use within `summarize_if`).
#   Make sure you name your functions inside the `summarize_if` call. Their
#   names should be `Min.`, `1st Qu.`, `Median`, `Mean`, `3rd Qu.` and `Max.`
#   (similar to the names in `summary(iris)`, make sure you don't modify them!).
#   Store the resulting tibble in the variable `summary_stats`.
#   Its dimensions should be `(1x24)`. The names of its 24 columns should be
#   `Sepal.Width_Min.`, `Sepal.Length_Min.`, `Sepal.Length_1st Qu.` etc..
#   To check your solution, `summary_stats` prints to:
#   # A tibble: 1 x 24
#   Sepal.Length_Mi… Sepal.Width_Min. Petal.Length_Mi… Petal.Width_Min.
#   <dbl>            <dbl>            <dbl>            <dbl>
#     1              4.3                2                1              0.1
#   # … with 20 more variables: `Sepal.Length_1st Qu.` <dbl>, `Sepal.Width_1st
#   #   Qu.` <dbl>, `Petal.Length_1st Qu.` <dbl>, `Petal.Width_1st Qu.` <dbl>,
#   #   Sepal.Length_Median <dbl>, Sepal.Width_Median <dbl>,
#   #   Petal.Length_Median <dbl>, Petal.Width_Median <dbl>,
#   #   Sepal.Length_Mean <dbl>, Sepal.Width_Mean <dbl>, Petal.Length_Mean <dbl>,
#   #   Petal.Width_Mean <dbl>, `Sepal.Length_3rd Qu.` <dbl>, `Sepal.Width_3rd
#   #   Qu.` <dbl>, `Petal.Length_3rd Qu.` <dbl>, `Petal.Width_3rd Qu.` <dbl>,
#   #   Sepal.Length_Max. <dbl>, Sepal.Width_Max. <dbl>, Petal.Length_Max. <dbl>,
#   #   Petal.Width_Max. <dbl>
#
#   Let's tidy this tibble to get a result that is easier to understand. We
#   want to transform this one-row tibble into one where each row is a variable
#   (one of `Petal.Length`, `Petal.Width`, `Sepal.Length` and `Sepal.Width`) and
#   each column is a summary stat computed for each variable.
## Do not modify this line!
library(stats)
qtu1 <- function(x){
  stats::quantile(x, probs = 0.25)
}
qtu3 <- function(x){
  stats::quantile(x, probs = 0.75)
}
summary_stats <- iris %>%
  summarize_if(is.numeric, c("Min." = min, 
                             "1st Qu." = qtu1, 
                             "Median" = median, 
                             "Mean" = mean, 
                             "3rd Qu." = qtu3,
                             "Max." = max))
summary_stats


#  6. Load the `tidyr` package. First we will transform our one-row tibble into
#   a tibble with three columns:
#   - column `variable` containing the variable name (e.g. `Sepal.Length`)
#   - column `stat` containing the summary statistic computed on the `variable`
#   of the same row (e.g. `1st Qu.`)
#   - column `value` containing the value of the `stat` (e.g. `5.1`)
#   One possible way to do it is by piping your operations:
#    - take in `summary_stats`,
#    - use `pivot_longer()` to effectively transpose your data with one column
#    (`key`) containing the old column names (e.g. `Petal.Length_Min.`) and the
#    other column containing the corresponding values (`value`),
#    - call `separate()` to break the `key` column into the two columns
#    (`variable` and `stat`).
#   Hint: use `everything()` in `pivot_longer()`.
#   Assign the result to tibble `summary_long`.
#   Feel free to use `gather()` and `spread()` instead of `pivot_longer()`,
#   `everything()` and `separate()` if you feel more comfortable with the former.
#   (dimensions should be `summary_long (24x3)`)
#   To check your solution, `summary_long` prints to:
#   # A tibble: 24 x 3
#   variable     stat    value
#   <chr>        <chr>   <dbl>
#    1 Sepal.Length Min.      4.3
#    2 Sepal.Width  Min.      2
#    3 Petal.Length Min.      1
#    4 Petal.Width  Min.      0.1
#    5 Sepal.Length 1st Qu.   5.1
#    6 Sepal.Width  1st Qu.   2.8
#    7 Petal.Length 1st Qu.   1.6
#    8 Petal.Width  1st Qu.   0.3
#    9 Sepal.Length Median    5.8
#   10 Sepal.Width  Median    3
#   # … with 14 more rows
## Do not modify this line!
library(tidyr)
summary_long <- summary_stats %>%
  pivot_longer(everything(), names_to = "key", values_to = "value") %>%
  separate(key, into = c("variable", "stat"), sep = "_")
summary_long 



#  7. From `summary_long`, extract the stats as column names to obtain the tibble
#   in which each row is a variable (one of `Petal.Length`, `Petal.Width`,
#   `Sepal.Length` and `Sepal.Width`) and each column is a summary stat computed
#   for each variable (`Min.`, `1st Qu.`, `Median`, `Mean`, `3rd Qu.` and `Max.`).
#   One efficient way to do that is to use `pivot_wider()`.
#   Assign the result to tibble `summary_stats_tidy`.
#   (dimensions should be `summary_stats_tidy (4x7)`)
#   To check your solution, the first two lines of `summary_stats_tidy` print to:
#   # A tibble: 4 x 7
#   variable      Min. `1st Qu.` Median  Mean `3rd Qu.`  Max.
#   <chr>        <dbl>     <dbl>  <dbl> <dbl>     <dbl> <dbl>
#    1 Sepal.Length   4.3       5.1   5.8   5.84       6.4   7.9
#    2 Sepal.Width    2         2.8   3     3.06       3.3   4.4
## Do not modify this line!
summary_stats_tidy <- summary_long %>%
  pivot_wider(names_from = stat, values_from = value)
summary_stats_tidy



#  8. We are getting closer! We need to transpose our tibble to obtain one
#   similar to that of `summary(iris)`.
#   Transpose `summary_stats_tidy`, into a tibble `summary_stats_transposed`.
#   It should have five columns: the first, named `Stat` containing the type
#   of summary stat computed and the others containing each variable.
#   You can pipe operations to transpose `summary_stats_tidy`:
#   - first using `pivot_longer`
#   - and chaining it with a `pivot_wider` call.
#   Hint: you can use `pivot_longer(-variable, ...)` where `...` should be
#   replaced with the appropriate arguments, to pivot all columns but the
#   `variable` one.
#   Feel free to use `gather()` and `spread()` instead of `pivot_longer()` and
#   `pivot_wider()` if you are more comfortable.
#   (dimensions should be `summary_stats_transposed (6x5)`)
#   To check your solution, the first three lines of `summary_stats_transposed`
#   print to:
#   # A tibble: 6 x 5
#   Stat    Sepal.Length Sepal.Width Petal.Length Petal.Width
#   <chr>          <dbl>       <dbl>        <dbl>       <dbl>
#    1 Min.            4.3         2            1           0.1
#    2 1st Qu.         5.1         2.8          1.6         0.3
#    3 Median          5.8         3            4.35        1.3
## Do not modify this line!
summary_stats_transposed <- summary_stats_tidy %>%
  pivot_longer(-variable, names_to = "Stat", values_to = "value") %>%
  pivot_wider(names_from = variable, values_from = value)
summary_stats_transposed



