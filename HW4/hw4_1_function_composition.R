# HW3: Function composition
#'
# An important way of combining functions is through composition: `f(g(x))`. Composition takes a list of functions
# and applies them sequentially to the input.
#'
# We will work with the Iris dataset. The Iris dataset contains the results of multiple measurements on Iris
# flowers used to quantify the morphologic variation of Iris flowers of three related species. The dataset consists
# of 50 samples from each of three species of Iris (Iris Setosa, Iris virginica, and Iris versicolor). Four
# features were measured from each sample: the length and the width of the sepals and petals, in centimeters. This
# dataset became a typical test case for many statistical classification techniques in machine learning.
#'
# 1. Load the `purrr` package and the `tibble` package. Load the Iris dataset into the namespace using `data(iris)`.
# This essentially loads the variable `iris` as a data frame containing the iris data.  Turn it into a tibble using
# `as_tibble`.
# Note: the tibble should be named `iris`.
## Do not modify this line!
library(purrr)
library(tibble)
data(iris)
iris <- as_tibble(iris)


# 2. Use `map_dbl` and `compose` from the `purrr` package to return the square root of the number of unique values in
# each column of the `iris` tibble. Assign the result to a variable `squ_n_unique`. Use the built-in `sqrt`,
# `length` and `unique` functions.
## Do not modify this line!
squ_n_unique <- map_dbl(iris, compose(sqrt, length, unique))


# 3. Now build your own custom `compose_2` function operator that takes in two inputs `f` and `g` and returns
# the function `f(g(...))`
# Note: we assume that the input/output of `f` and `g` match such that the composition makes sense. Make
# sure you use `force()`. You are not allowed to use `compose` from the `purrr` package here.
## Do not modify this line!
compose_2 <- function(f, g){
	force(c(f,g))
	function(...){
		return(f(g(...)))
	}
}



# 4. Use `compose_2` to build your own custom `compose_3` function operator that takes in three input
# functions `f`, `g` and `h` of functions and returns the composition of those (a function itself).
# Note: Use only one call to `compose_2` to do so. Again, we assume that the input/output of the functions match
# such that the composition makes sense. Make sure you use `force()`. You are not allowed to use `compose` from the
# `purrr` package here.
## Do not modify this line!
compose_3 <- function(f, g, h){
	force(c(f, g, h))
	function(...){
		f(compose_2(g, h)(...))
	}
}



# 5. Use `custom_3` and `map_dbl` to replicate the results you obtained using `purrr::compose` in question 2. Assign the result to a
# variable `squ_n_unique_custom`.
# Hint: again, use the built-in `sqrt`, `length` and `unique` functions.
#'
## Do not modify this line!
squ_n_unique_custom <- map_dbl(iris, compose_3(sqrt, length, unique))



