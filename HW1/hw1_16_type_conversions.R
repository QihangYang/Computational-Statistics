# HW1: type_conversions
#
# 1. Create a list `l` containing :
#       - a vector containing the first 20 numbers in increasing order,
#       - a vector containing the first 20 numbers in decreasing order,
#       - a list of 2 'a' and 2 'b' repeated 5 times (hint : lookup the function `rep()`).
# 2. Convert `l` to a tibble t1 of dimension 20 x 3
# 3. Rename the columns of the tibble `t1` to ('X1', 'X2', 'letters').
# 4. Copy `t1` into a tibble `t2` and delete the rows of `t2` with letter 'b'.
# 5. Create a matrix `m` containing the first two columns of `t2`
# 6. Compute the product `m_prod` of `m` and its transpose.

## Do not modify this line! ## Write your code for 1. after this line! ##
library(tibble)
l <- list(c(1:20), c(20:1), rep(c("a","a","b","b"),5))
## Do not modify this line! ## Write your code for 2. after this line! ##
t1 <- tibble(
	l[[1]],
	l[[2]],
	l[[3]]
)
## Do not modify this line! ## Write your code for 3. after this line! ##
names(t1) <- c("X1", "X2", "letters")
## Do not modify this line! ## Write your code for 4. after this line! ##
t2 <- t1[-which(t1["letters"] == "b"), ]
## Do not modify this line! ## Write your code for 5. after this line! ##
m <- as.matrix(t2[1:2])
## Do not modify this line! ## Write your code for 6. after this line! ##
m_prod = m %*% t(m)