# HW2: Swapping numbers in an array between every odd-even positional pairs.
# (For instance: 345678 would be turned into 436587, 975467 would be turned into 794576)
# (Note: Assume the array's length is even)
# 
# 1. Set the random seed to 2019 and save the random seed vector to `seed`. (hint: use the command `seed <- .Random.seed`).
#
# 2. Create a vector called `num` of length 100 randomly sampled between digits 0-9 using function `sample`.
#
# 3. Use a for loop to swap the digits between positions 1-2, 3-4, 5-6...99-100 and save as a new vector `new_num`.
#"
# 4. Now write a function named `swap` that takes in a vector set of digits and swap every odd-even positional pairs.
#   (Note: the only argument should be the vector argument and it will have to pass through three test cases)
#


## Do not modify this line! ## Write your code for 1. after this line! ##
set.seed(2019)
seed <- .Random.seed
## Do not modify this line! ## Write your code for 2. after this line! ##
num <- sample(0:9, size = 100, replace = TRUE)
## Do not modify this line! ## Write your code for 3. after this line! ##
new_num <- vector(length = 100)
for (i in 1 : 50){
	new_num[2*i-1] <- num[2*i]
	new_num[2*i] <- num[2*i-1]
}
## Do not modify this line! ## Write your code for 4. after this line! ##
swap <- function(vec){
	i <- 1
	while(i + 1 <= length(vec)){
		tmp <- vec[i+1]
		vec[i+1] <- vec[i]
		vec[i] <- tmp
		i <- i+2
	}
}