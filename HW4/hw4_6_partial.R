# HW4: cp
#'
# Last time we learned how to combine functions together in hw3,
# this time we will introduce partial() function, which can fix some parameters and
# help us write shorter codes. We will also use compose() and partial() together
# in this exercise.
#'
# 1. Load the `purrr` package. Use `compose` from the `purrr` package to create a
# function named `mean_sqrt_fun` that computes the square-root of the mean of the a vector
# by combining the `sqrt` and `mean` functions.
# Note: Use compose directly to create `mean_sqrt_fun`, so that its arguments are the same 
#       as the arguments of `mean`.
# Then, use `map_dbl` to apply `mean_sqrt_fun` to each column of `airquality` and assign
# the result to a vector named `mean_sqrt_na`.
# Notice that one could use `mean_sqrt_fun(x, na.rm = TRUE)` to take care of the
# `NA` that appear for the mean of some columns, but you don't need to do it here.
## Do not modify this line!
library(purrr)
mean_sqrt_fun <- compose(sqrt, mean)
mean_sqrt_na <- map_dbl(airquality, mean_sqrt_fun)


# 2. Create a new function named `mean_sqrt_fun_narm` that fixes the parameter
# `na.rm` as `TRUE` by making use of the `partial()` function from `purrr`.
# Use `map_dbl` to apply `mean_sqrt_fun_narm` to each column of `airquality` and save the
# result in a vector named `mean_sqrt_narm`.
## Do not modify this line!
mean_sqrt_fun_narm <- partial(mean_sqrt_fun, na.rm = TRUE)
mean_sqrt_narm <- map_dbl(airquality, mean_sqrt_fun_narm)


# 3. Now build your own `partial_2(f, ...)` function operator that takes in as input
# `f` (the function to be partially applied) and `...` (the arguments to be fixed).
# The function `partial_2` should return the function `f(x, ...)`, that is the function
# from the input with some arguments fixed.
# Note: make sure that you use `force()`.
# You are not allowed to use `partial` from the `purrr` package here.
## Do not modify this line!
partial_2 <- function(f, ...){
	force(c(f, ...))
	function(x){
		f(x, ...)
	}
}



# 4. Use `compose` from the `purrr` package to create a
# function named `sum_abs_fun` that computes the absolute value of the sum of a vector
# by combining the `abs` and `sum` functions.
# Note: Use compose directly to create `sum_abs_fun`, so that its arguments are the same 
#       as the arguments of `sum`.
# Then, use `map_dbl` to apply `sum_abs_fun` to each column of `airquality` and assign
# the result to a vector named `sum_abs_na`.
# Notice that one could again use `sum_abs_fun(x, na.rm = TRUE)` to take care of the
# `NA` that appear for the mean of some columns, but you don't need to do it here.
## Do not modify this line!
sum_abs_fun <- compose(abs, sum)
sum_abs_na <- map_dbl(airquality, sum_abs_fun)




# 5. Create a new function named `sum_abs_fun_narm` that fixes the parameter
# `na.rm` as `TRUE` by making use of your own the `partial_2()` function from `purrr`.
# Use `map_dbl` to apply `sum_abs_fun_narm` to each column of `airquality` and save the
# result in a vector named `sum_abs_narm`.
#'
## Do not modify this line!
sum_abs_fun_narm <- partial_2(sum_abs_fun, na.rm = TRUE)
sum_abs_narm <- map_dbl(airquality, sum_abs_fun_narm)

