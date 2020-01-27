# HW1: missing values
#
# 1. Set the random seed to zero (The code won't pass the test if you don't!) and save the random seed vector to `seed`. (hint: use the command `seed <- .Random.seed`).
# 2. Load `mtcars` and transform it into a tibble called `mtcars_tibble`.
# 3. Select randomly 1 row and 5 columns and store their corresponding numbers into two vectors `list_row` (containing 1 number) and `list_col` (containing 5 numbers). (hint: look at the command `sample`)
# 4. Copy `mtcars_tibble` into `mtcars_tibble_missing` and replace its corresponding values by missing values.
# 5. Create a vector `mean_mtcars` containing the means of each column of `mtcars_tibble`.
# 6. Copy `mtcars_tibble_missing` into `mtcars_bis` and replace the missing values of `mtcars_bis` by the means of the corresponding columns.
# 7. Copy `mtcars_bis` into a tibble `mtcars_rounded` and make sure that its column 'gear' contains only integers by rounding its values to the closest integer.

## Do not modify this line! ## Write your code for 1. after this line! ##
library(tibble)
set.seed(0)
seed <- .Random.seed
## Do not modify this line! ## Write your code for 2. after this line! ##
mtcars_tibble <- as_tibble(mtcars)
## Do not modify this line! ## Write your code for 3. after this line! ##
list_row <- sample(nrow(mtcars_tibble), 1)
list_col <- sample(ncol(mtcars_tibble), 5)
## Do not modify this line! ## Write your code for 4. after this line! ##
mtcars_tibble_missing <- mtcars_tibble
for (i in list_row){
	for (j in list_col){
		mtcars_tibble_missing[i, j] <- NA
	}
}
## Do not modify this line! ## Write your code for 5. after this line! ##
mean_mtcars <- as.vector(colMeans(mtcars_tibble))
## Do not modify this line! ## Write your code for 6. after this line! ##
mtcars_bis <- mtcars_tibble_missing
for (i in 1: nrow(mtcars_bis)){
	for (j in 1: ncol(mtcars_bis)){
		if (is.na(mtcars_bis[i,j])){
			mtcars_bis[i,j] <- mean_mtcars[j]
		}
	}
}
## Do not modify this line! ## Write your code for 7. after this line! ##
mtcars_rounded <- mtcars_bis
mtcars_rounded["gear"] <- round(mtcars_rounded["gear"])