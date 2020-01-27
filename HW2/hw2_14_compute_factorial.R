# HW2: Compute factorial
#
# Review: factorial of n is equal to n x (n-1) x ... x 1.
#
# 1. Please write a function `my_factorial(n)` to compute factorial of n.
#    If the input `n` is a positive integer, this function returns factorial of `n`. Otherwise, this function should return `NA`.
#    Please use `if` and `else` inside your function to judge whether it should return `NA` or not.
#    Please write a recursive function i.e. this function calls itself inside the body.
#    Note: DO NOT use `factorial` function from the base package.
# 2. Set the random seed to zero and save the random seed vector to `seed`. (hint: use the command `seed <- .Random.seed`)
#    Then use `sample` function to randomly sample 50 integers from 1 to 100 without replacement. Store the result in vector `vec1`.
# 3. Use `sapply` to compute the factorial for each element in `vec1` with the help of the function `factorial` you just wrote. Store the result in a vector `vec2`.
#    Hint: `sapply` is similar to `lappy`. It will return a vector whenever possible. You can use `?sapply` to see documentation.

## Do not modify this line! ## Write your code for 1. after this line! ##
my_factorial <- function(n){
	if (n == 0)
		return(1)
	if (n > 0 && n %% 1 == 0){
		return(my_factorial(n-1) * n)
	}
	else{
		return(NA)
	}
}
## Do not modify this line! ## Write your code for 2. after this line! ##
set.seed(0)
seed <- .Random.seed
vec1 <- sample(1:100, size = 50, replace = FALSE)
## Do not modify this line! ## Write your code for 3. after this line! ##
vec2 <- sapply(vec1, my_factorial)