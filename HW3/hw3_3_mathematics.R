#' HW3: mathematics
#'
#' In this exercise, we will use the different `map` functions from the `purrr` package.
#' DO NOT use any `for`, `while` or `repeat` loop.
#'
#' 1. Load the `purrr` package. Create a list `list_fun` containing three elements: the functions `linear = function(x) x`,
#' `quadratic = function(x) (x - pi/2)^2 - pi/2`,  `sinusoidal = function(x) sin(x)`.
## Do not modify this line!
library(purrr)
list_fun <- list(
	linear = function(x) x,
	quadratic = function(x) (x - pi/2)^2 - pi/2,
	sinusoidal = function(x) sin(x)
)


#' 2. Use `map_dbl` along with `integrate` to compute the value of the integrals between `-3*pi/4` and `3*pi/4` of each of the three functions in `list_fun`.
#' Assign this result to a vector `integral_values` having the same names as `list_fun`.
## Do not modify this line!
integral_values <- map_dbl (list_fun, ~ integrate(.x, lower = -3*pi/4, upper = 3*pi/4)$value)

#' 3. Use `map_dbl` along with `uniroot` to compute the root between `-3*pi/4` and `3*pi/4` of each of the three functions in `list_fun`.
#' Assign this result to a vector `root_values` having the same names as `list_fun`.
## Do not modify this line!
root_values <- map_dbl (list_fun, ~ uniroot(.x, c(-3*pi/4, 3*pi/4))$root)


#' 4. Use `map_dbl` along with `optimise` to find the minimizer between `-3*pi/4` and `3*pi/4` of each of the three functions in `list_fun`.
#' Assign the value of each function at the minimum to a vector `min_values` having the same names as `list_fun`.
#' Assign the value of each function at the minimum's minimizer to a vector `min_position` having the same names as `list_fun`.
## Do not modify this line!
min_values <- map_dbl (list_fun, ~ optimise(.x, c(-3*pi/4, 3*pi/4))$objective)
min_position <- map_dbl (list_fun, ~ optimise(.x, c(-3*pi/4, 3*pi/4))$minimum)


