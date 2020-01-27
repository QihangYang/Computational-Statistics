# HW1: sampling
#
# In this exercise, you'll compute the probability of getting a double six exactly three times in a row when throwing consecutive six faced dices.
# While it could be solved by hand, the goal is to learn how to use sampling.
#
# 1. Set the random seed to zero and save the random seed vector to `seed`. (hint: use the command `seed <- .Random.seed`).
# 2. Assign to `sample_space` a data frame with 36 rows and columns named `dice1` and `dice2`.
# Each row should contain a different combination of the results for the two dices, e.g. the first row is (1, 1), the second row is (2, 1), ... up to (6, 6).
# (Hint: look at the function `expand.grid`)
# 3. Assign to `sampled_rows` a vector of 100'000 uniformly sampled numbers between 1 and 36.
# (Hint: look at the functions `sample` and  `sample.int`)
# 4. Assign to `sampled_events` the data frame obtained by selecting the 100'000 rows in `sampled_rows` from the `sample_space` data frame.
# 5. Assign to `double_six` a `logical` vector of dimension 100'000 where each element is `TRUE`
# if the corresonding row of `sampled_events` is a double six and `FALSE` otherwise.
# 6. Assign to `double_six_run_length` an `integer` vector corresponding to the length of each run of double six.
# (Hint: look at the function `rle`)
# 7. Assign to `probability` the probability to obtain a double six exactly two times in a row
# by counting the number of times such an event happens in `double_six` and dividing by 100'000.

## Do not modify this line! ## Write your code for 1. after this line! ##
set.seed(0)
seed <- .Random.seed
## Do not modify this line! ## Write your code for 2. after this line! ##
sample_space <- data.frame(expand.grid(1:6,1:6))
names(sample_space) <- c("dice1", "dice2")
## Do not modify this line! ## Write your code for 3. after this line! ##
sampled_rows <- sample(1:36, size = 100000, replace = TRUE)
## Do not modify this line! ## Write your code for 4. after this line! ##
sampled_events <- data.frame(sample_space[sampled_rows, ])
## Do not modify this line! ## Write your code for 5. after this line! ##
double_six <- vector(length = 100000)
for (i in 1: nrow(sampled_events)){
	if (sampled_events[i,1] == 6 & sampled_events[i,2] == 6){
		double_six[i] <- TRUE
	}
}
## Do not modify this line! ## Write your code for 6. after this line! ##
double_six_run_length <- rle(double_six)$lengths[which(rle(double_six)$values == TRUE)]
## Do not modify this line! ## Write your code for 7. after this line! ##
probability <- sum(double_six_run_length == 2) / 100000