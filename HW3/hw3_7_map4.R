#' HW3: map4
#'
#' In this exercise, we will use the `map` function to perform data analysis on the `mtcars` dataset.
#'
#' 1. Load the `purrr` package. Compute the standard deviation of every column in `mtcars` and store the result
#' in a variable `mtcars_sd` using `map_dbl()`.
## Do not modify this line!
library(purrr)
mtcars_sd <- map_dbl(mtcars, sd)


#' 2. Copy data `mtcars` into `mtcars_factor`. Using `as.factor` and `modify_at`, change the column `cyl` and `gear`
#' of `mtcars_factor` from type `numeric` to type `factor`.
## Do not modify this line!
mtcars_factor <- modify_at(mtcars, c("cyl", "gear"), as.factor)



#' 3. Compute the standard deviation of every `numeric` column of `mtcars_factor` and store the result into a mixed data
#' frame called `mtcars_numeric_sd` using `map_if()` and `is.numeric`.
## Do not modify this line!
mtcars_numeric_sd <- map_if(mtcars_factor, is.numeric, sd)


#' 4. Compute the number of levels in each `factor` column of `mtcars_factor` and store the result into a mixed data frame
#' called `mtcars_factor_level` using `map_if()` and `is.factor`.
#' (Hint: to get of levels in factor `x`, use `levels(x)`; to get the unique elements of a list `x`, use `unique(x)`;
#' to get the length of a list `x`, use `length(x)`)
## Do not modify this line!
mtcars_factor_level <- map_if(mtcars_factor, is.factor, ~ length(levels(.x)))


