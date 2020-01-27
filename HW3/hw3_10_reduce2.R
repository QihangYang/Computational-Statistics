#' HW3: reduce4
#'
#' 1. Load library `purrr`. Set the random seed as 5206. Save the random seed vector to `seed`.
#'    Use `map` to create a list `l1` with 5 elements, where each element is a vector of 20 random integers
#'    between `1:10` sampled with replacements (i.e., use the `sample` function and let `replace` be `TRUE`).
## Do not modify this line!
library(purrr)
set.seed(5206)
seed <- .Random.seed

l1 <- map(1:5, ~ sample(1:10, 20, replace = TRUE))


#' 2. Use `reduce` to get intersection of the 5 elements of `l1`, and assign the values to a vector `r1`.
#'    Similarly, use `reduce` to get union of `l1`, and store returned values to a vector `r2`.
## Do not modify this line!
r1 <- reduce(l1, intersect)
r2 <- reduce(l1, union)


#' 3. Create a data frame called `df1` with first column `A` and values `letters[1:5]`,
#'    second column `B` with values `1:5`, third column `C` with values `2:6`.
#'    Note that, when using `data.frame`, the first column will be automatically converted as a factor (i.e., do NOT use `stringsAsFactors = FALSE`).
#'    Then, use the `detect` function to find which column has factor values and save its result as `df1_factor`.
## Do not modify this line!
df1 <- data.frame(
	A <- letters[1:5],
	B <- 1:5,
	C <- 2:6
)
df1_factor <- detect(df1, is.factor)



#' 4. Similarly as in 3, create a data frame called `df2` with first column `A` and values `letters[1:5]`, second column `D` with values `3:7`, third column `E` with values `4:8`.
#'    Create yet another data frame called `df3` with first column `A` and values `letters[1:5]`, second column `G` with values `5:9`, third column `H` with values `6:10`.
#'    Again, do NOT use `stringsAsFactors = FALSE` when you create the two data frames.
#'    Then, combine three data frames into a list and call it `df_list`.
#'    Finally, use `reduce` and `merge` functions to bind all columns with different names.
#'    Store the returned data frame, which should be of dimension `5x7`, into `merged_df`.
## Do not modify this line!
df2 <- data.frame(
	A <- letters[1:5],
	D <- 3:7,
	E <- 4:8
)
df3 <- data.frame(
	A <- letters[1:5],
	G <- 5:9,
	H <- 6:10
)
df_list <- list(df1, df2, df3)
merged_df <- reduce(df_list, merge)



