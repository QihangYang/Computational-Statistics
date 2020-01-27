# HW1: warm-up
#
# 1. Create a vector `x` that will contain integers between 21 and 29 included.
# 2. Copy `x` row-wise into a 3 x 3 matrix `y`.
# 3. Create a matrix `z` as the matrix square of `y` (hint: think about the difference between `^` and `%*%`).
# 4. Change the row names of `z` and  the columns of `y` to `c("a", "b", "c")`.
# 5. Assign the matrix product between the transpose of `z` and the entry-wise square of `y` to a new matrix called `w`.

## Do not modify this line! ## Write your code for 1. after this line! ##
x <- c(21L, 22L, 23L, 24L, 25L, 26L, 27L, 28L, 29L)
## Do not modify this line! ## Write your code for 2. after this line! ##
y <- t(matrix(x, c(3,3)))
## Do not modify this line! ## Write your code for 3. after this line! ##
z <- y %*% y
## Do not modify this line! ## Write your code for 4. after this line! ##
rownames(z) <- c("a", "b", "c")
colnames(y) <- c("a", "b", "c")
## Do not modify this line! ## Write your code for 5. after this line! ##
w <- t(z) %*% (y * y)