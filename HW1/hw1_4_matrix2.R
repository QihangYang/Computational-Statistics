# HW1: matrix3
#
# 1. Set the random seed as 5206. (hint: check the set.seed function)
#    Save the random seed vector to `seed`.(hint: use the command seed <- .Random.seed)
# 2. Create a vector `v1` of length 30 by sampling from 1 to 30 without replacement.(hint: check the sample function)
# 3. Convert the vector `v1` into a 5 x 6 matrix `m1` filled by row.
# 4. Calculate the L-1 norm of matrix `m1` defined as the the maximum absolute column sum of the matrix and assign it to `n1`.
# 5. Calculate the L-infinity norm of matrix `m1` defined as the maximum absolute row sum of the matrix and assign it to `n2`.
# 6. Calculate the Frobenius norm of matrix `m1` defined as the square root of the sum of the squares of its elements and assign it to `n3`.

## Do not modify this line! ## Write your code for 1. after this line! ##
set.seed(5206)
seed <- .Random.seed
## Do not modify this line! ## Write your code for 2. after this line! ##
v1 <- sample(1:30, size = 30, replace = FALSE)
## Do not modify this line! ## Write your code for 3. after this line! ##
m1 <- t(matrix(v1, nrow = 6, ncol = 5))
## Do not modify this line! ## Write your code for 4. after this line! ##
n1 <- norm(m1, type = "1")
## Do not modify this line! ## Write your code for 5. after this line! ##
n2 <- norm(m1, type = "i")
## Do not modify this line! ## Write your code for 6. after this line! ##
n3 <- norm(m1, type = "f")