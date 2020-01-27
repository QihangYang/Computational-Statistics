# HW1: distributions
#
# In this exercise, you'll learn how to work with distributions in R.
#
# 0. Read the documentation regarding distributions, which you can access using `?Distributions`.
# 1. Set the random seed to zero and save the random seed vector to `seed`. (hint: use the command `seed <- .Random.seed`).
# 2. Assign to a variable `prob1` the probability that 5 students in the class have the same birthday. (hint: as of the writing of this exercise, there are 285 registered students)
# 3. Let X have a normal distribution with a mean of 0 and a variance of 2. Assign to a variable `prob2` the probability that X is betwee 0 and 3.
# 4. Let Y have an exponential distribution with mean equal to 3. Assign to `sample_exp` a sample of 10 random variates drawn from the distribution of Y.

## Do not modify this line! ## Write your code for 1. after this line! ##
set.seed(0)
seed <- .Random.seed
## Do not modify this line! ## Write your code for 2. after this line! ##
prob1 <- pbirthday(285, classes = 365, coincident = 5)
## Do not modify this line! ## Write your code for 3. after this line! ##
prob2 <- pnorm(3, mean = 0, sd = sqrt(2)) - pnorm(0, mean = 0, sd = sqrt(2))
## Do not modify this line! ## Write your code for 4. after this line! ##
sample_exp <- rexp(10, rate = 1/3)