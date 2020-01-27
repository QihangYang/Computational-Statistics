#' HW3: Normal distribution factory
#'
#' 1. Set the random seed to zero and save the random seed vector to `seed`. (hint: use the command `seed <- .Random.seed`).
## Do not modify this line!
set.seed(0)
seed <- .Random.seed


#' 2. Write a function `norm_factory` that takes as input two arguments `mu` and `var` and returns a function
#' that takes a number `n` as argument and returns `n` samples from a normal distribution with mean `mu` and
#' variance `var`. Use `rnorm` to simulate the sampling.
#' Note: you should use `force()` in `norm_factory`.
## Do not modify this line!
norm_factory <- function(mu, var){
	force(c(mu, var))
	function(n){
		rnorm(n, mu, sqrt(var))
	}
}


#' 3. Use `norm_factory` to create two functions allowing to sample from distributions with the following
#' characteristics:
#' - `d0_1`: from a normal distribution with mean zero and standard deviation 1
#' - `d0_2`: from a normal distribution with mean zero and standard deviation 2
#' Then, use the two functions to generate two vectors of 1000 samples from each distributions,
#' and store them respectively in `s0_1` and `s0_2`.
#' Note 1: respect the order when you sample (i.e., use `d0_1` and only then use `d0_2`), otherwise the automated won't work.
#' Note 2: you can't call `rnorm` directly in this question.
## Do not modify this line!
d0_1 <- norm_factory(0, 1)
s0_1 <- d0_1(1000)
d0_2 <- norm_factory(0, 4)
s0_2 <- d0_2(1000)


#' 4. Compute the empirical mean and variance of each vector and assign them to `m_s0_1`, `m_s0_2`, `v_s0_1`,
#' `v_s0_2`. You should use the built-in functions `mean` and `var`.
## Do not modify this line!
m_s0_1 <- mean(s0_1)
v_s0_1 <- var(s0_1)
m_s0_2 <- mean(s0_2)
v_s0_2 <- var(s0_2)



#' 5. Write a function `m_norm_factory` that takes as input three arguments `m`, `mu` and `var` where `m` is
#' a positive integer, `mu` is a vector of size `m` and `var` is a positive real number. It should return a
#' function that takes a number `n` as argument and returns `n` samples from a multivariate normal distribution
#' with `m` components, mean `mu` and a diagonal covariance matrix in which the variance of each component is
#' `var` if `var` is smaller than 2 and 2 otherwise. To do so, load the package `MASS` and use its function
#' `mvrnorm` to simulate the sampling.
#' Note: you should use `force()` in `m_norm_factory`.
#'
## Do not modify this line!
library(MASS)
multivariate_norm_factory <- function(m, mu, var){
	force(c(m, mu, var))
	function(n){
		if (var < 2)
			mvrnorm(n, mu, diag(var, m))
		else 
			mvrnorm(n, mu, diag(2, m))
		
	}
}


