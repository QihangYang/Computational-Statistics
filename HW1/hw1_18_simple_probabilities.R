# HW1: simple probabilities
#
# Estimate the probability to have 5 'heads' in a row
#
# 1. Set the random seed to zero and save the random seed vector to `seed`. (hint: use the command `seed <- .Random.seed`).
# 2. Create a vector `random_seq` of n = 50000 random numbers equal to 0 ('heads') or 1 ('tails').
# 3. Reshape `random_seq` into a matrice `random_mat` of shape 5 x 10000.
# 4. Sum `random_mat` over its rows, to get a vector `random_sum`. (hint : check the functions `rowSums` and `colSums`).
# 5. Assign to a variable `prob` the number of elements of `random_sum` equal to 0 and divide it by 10000. You get an estimate of the probability of having 5 heads in a row!
#    For higher n, you will get even better estimates. Try different values of n to see how prob evolves, but make sure that your final solution uses 50000.

## Do not modify this line! ## Write your code for 1. after this line! ##
set.seed(0)
seed <- .Random.seed
## Do not modify this line! ## Write your code for 2. after this line! ##
random_seq <- sample(0:1, size = 50000, replace = TRUE)
## Do not modify this line! ## Write your code for 3. after this line! ##
random_mat <- matrix(random_seq, nrow = 5, ncol = 10000)
## Do not modify this line! ## Write your code for 4. after this line! ##
random_sum <- colSums(random_mat)
## Do not modify this line! ## Write your code for 5. after this line! ##
prob <- sum(random_sum == 0) / 10000
