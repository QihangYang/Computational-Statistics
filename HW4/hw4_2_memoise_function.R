# HW3: Memoise function
#'
# In this exercise, we will compare the performance of an algorithm with and without using `memoise`.
#'
# Problem description:
#    You are climbing a stair case. It takes n steps to reach to the top. Each time you can either climb 1 or 2 steps.
#    In how many distinct ways can you climb to the top?
# Example :
# There are three ways to climb to the top of 3 stairs :
# 		1. 1 step + 1 step + 1 step
# 		2. 1 step + 2 steps
# 		3. 2 steps + 1 step
# Hint: Dynamic programming means that when a problem with a larger size uses the result of the same problem with a smaller size,
#    we can speed up the algorithm by saving the result of the smaller-sized subproblem and using these result to infer the result of
#    a larger-sized subproblem.
#    It is often very efficient compared to the naive recursive solutions.
# 		For example, in this stair case problem, we factor the problem of climbing n-step stairs into n problems of climbing 1, 2, ..., n-step stairs.
# 		If we want to climb n stairs, we can either start with 1 step and and then climb the n-1 other steps or start with 2 steps
# 		and then climb the n-2 other steps.
#    Thus N(n)=N(n-1)+N(n-2). We have decomposed the problem in two subproblems. In order to do that efficiently we need to store
#    the result of all the different subproblems.
#    In R, we use memoise function to cache the result of each subproblem.
# 1. Implement `climb()` in a plain recursive way and report the time for calculating `climb(10)` in variable `time1`.
#    (Hint: use `Sys.time()` to calculate the current system time. Create a variable `startime` to store the system time
#    before the calculation and a variable 'endtime' after the calculation. The duration of the calculation is `endtime-startime`.)
## Do not modify this line!
library(memoise)
climb <- function(n){
	if (n == 0)
		return(1)
	if (n == 1)
		return(1)
	return(climb(n-1) + climb(n-2))
}

startime <- Sys.time()
climb(10)
endtime <- Sys.time()
time1 <- endtime - startime



# 2. Write a function named `climb2()` to calculate the climbing stairs problem using the `memoise()` function.
#    Report the running time for calculating `climb2(10)` in variable `time2`.
#    (Hint: use `Sys.time()` to calculate the current system time. Create a variable `startime` to store the system time
#    before the calculation and a variable 'endtime' after the calculation. The duration of the calculation is `endtime-startime`.)
## Do not modify this line!
climb2 <- memoise(climb)
startime <- Sys.time()
climb2(10)
endtime <- Sys.time()
time2 <- endtime - startime



