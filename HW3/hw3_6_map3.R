#' HW3: map3
#'
#' Consider the `diamonds` dataset from the `ggplot2` package. For this exercise, you are not allowed to use `for`, `while`, or `repeat` loops.
#'
#' 1. Find the highest price for each color in the dataset using function `map_dbl` and `split`. Save the result to an atomic vector `max_price`.
## Do not modify this line!
library(ggplot2)
library(purrr)
library(tibble)

max_price <- map_dbl(split(diamonds$price, diamonds$color), max)


#' 2. Describe the highest price for each color using the following format: 'The highest price of color D is 18693'. Save the sentences in a character vector `max_price_sentence`.
#'    You are required to use function `imap_chr` in your solution.
## Do not modify this line!
max_price_sentence <- imap_chr(max_price, ~ paste("The highest price of color", .y, "is", .x))



#' 3. Copy `diamonds` to a tibble `t1` and replace every row by the first row using function `modify`.
## Do not modify this line!
t1 <- as_tibble(diamonds)
t1 <- modify(t1, ~ .x[1])


#' 4. Copy `diamonds` to a tibble `t2` and replace all numeric columns of each row by the mean value of every numeric column.
#'    You are required to use function `modify_if` in your solution.
## Do not modify this line!
t2 <- as_tibble(diamonds)
t2 <- modify_if(t2, is.numeric, mean)


