#' HW2: Apply with anonymous function.
#'
#' In this exercise, you will learn how to use an anonymous function in `apply()`.
#'
#' 1. Create an integer vector `v` with 1:25.
#' 2. Convert the vector `v` to a 5x5 matrix `m`, the matrix should be filling by row.
#' 3. Write a function `f` that computes the square of the mean of a given vector, for example `f(c(1,2,3)) = ((1+2+3)/3)^2 = 4`.
#' 4. Use `apply()` to compute the sum of each row of `m` and store it in an integer vector `m_row_sum`.
#' 5. Erase the function `f` (hint: use `rm`) and use `apply()` along with an equivalent but anonymous function
#'  to compute the square of the mean of each of the columns of `m` and store the result in a vector `m_col`.
#' @name hw2_apply_anonymous_fun


## Do not modify this line! ## Write your code for 1. after this line! ##
v <- 1L:25L
## Do not modify this line! ## Write your code for 2. after this line! ##
m <- t(matrix(v, nrow = 5, ncol = 5)) 
## Do not modify this line! ## Write your code for 3. after this line! ##
f <- function(vec){
	return((mean(vec)^2))
}
## Do not modify this line! ## Write your code for 4. after this line! ##
m_row_sum <- apply (m, 1, sum)
## Do not modify this line! ## Write your code for 5. after this line! ##
m_col <- apply(m, 2, f)
rm(f)