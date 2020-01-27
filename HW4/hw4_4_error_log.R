# HW4: Error log
#'
# In this exercise, we will focus on functions to capture errors.
#'
# 1. Load the `purrr` package and the Iris dataset into the namespace
#    using `data(iris)`.
#    Use `map_dbl`, `keep`, `is.numeric` and `max` to calculate the
#    maximum of each numerical column, save the answer into `m1`.
## Do not modify this line!
library(purrr)
data(iris)
m1 <- map_dbl(keep(iris, is.numeric), max)


# 2. Now think about a case when we don't know exaxctly which column
#    can we calculate the maximum,
#    which column we can't, what should we do?
#    Use `map` to calculate the maximum of each column, this time,
#    including the invalid columns as well.
#    Use `safely` to make sure the code can run successfully,
#    save the result into `y`.
#    Then use `transpose`, `map_lgl` and `is_null` to check which column
#    can we calculate the maximum value in the iris dataset.
#    Create a logical vector `is_ok` of length 5 (number of columns in iris
#    dataset). If the maximum of one column can be calculated,
#    the value should be `TRUE`, otherwise `FALSE`.
## Do not modify this line!
y <- map(iris, safely(max))
is_ok <- vector(mode = "logical", length = 5)
is_ok <- !map_lgl(transpose(y)$result, is_null)


# 3. Now use `is_ok` to output the name of the column on which we cannot
#    have the maximum, save it to `invalid_column`.
#    Then, use the function `flatten_dbl` and `y` from the previous exercise
#    to extract the maximum for the valid columns, save the answer into a
#    vector `m2`.
## Do not modify this line!
invalid_column <- names(y[which(is_ok == FALSE)])
m2 <- flatten_dbl(transpose(y[which(names(y) != invalid_column)])$result)




# 4. Create a vector `m` of length equal to the number of columns in `iris`
#    and filled with numerical `NA` (i.e. `NA_real_`).
#    For the elements of `m` corresponding to the numberical
#    columns of `iris`, put the calculated maximums.
## Do not modify this line!
m <- vector(mode = "numeric", length = ncol(iris))
for (i in 1: ncol(iris)){
	if (is_ok[i] == TRUE)
		m[i] <- transpose(y)$result[i]
	else
		m[i] <- as.numeric(NA)
}



# 5. Use `possibly` and `map_dbl` to compute a vector similar to `m` and
#    save the resulting vector into `m3`.
## Do not modify this line!
m3 <- map_dbl(iris, possibly(max, NA))


# 6. Now use `map_dbl` and `mean` to calculate the mean of all the columns in
#    `iris`, save the answer into a vector `s`.
## Do not modify this line!
s <- map_dbl(iris, mean)



# 7. Notice that there's an `NA` value in `s`. We can use `quietly` to further
#    investigate the warning message, to find out why `NA` is generated.
#    This exercise is similar to exercise 2 and exercise 3, so when you follow
#    the instructions, you might want to compare your code and the output
#    result with exercise 2 and 3.
#    First, use `map` and `quietly` to get the mean of each column, assign the
#    result to a list `y2`.
#    Then, use `transpose` and save the `warnings` sublist in a new list
#    called `warning_log`.
#    Finally, use `map_lgl` to check for which columns we can
#    calculate the standard error without warning message,
#    and save the logical vector into `is_ok2`.
#    Its length should be equal to the number of columns
#    in the iris dataset: if there's no warning message,
#    the value for the corresponding columnb should be `TRUE`,
#    otherwise `FALSE`.
#    Hint: the following function might be useful to check whether
#    an element of `warning_log` is a warning.
#    ```
#    warning_indicator <- function(x) {
#        identical(x, character(0))
#    }
#    ```
#    Now use `is_ok2` to extract the warning message for column
#    representing the `NA` value in `s`, save the message into a
#    vector `warning`. You should use `flatten_chr` to get `warning`.
#'
## Do not modify this line!
y2 <- map(iris, quietly(mean))
warning_log <- transpose(y2)$warnings
warning_indicator <- function(x){
	identical(x, character(0))
}
is_ok2 <- map_lgl(warning_log, warning_indicator)
warning <- flatten_chr(warning_log)

