# HW1: random order
#
# 1. Set the random seed to zero and save the random seed vector to `seed`. (hint: use the command `seed <- .Random.seed`).
# 2. Create a vector `random_seq` of 200 random numbers, selected between 1 and 10 included.
# 3. Create a factor `random_factor` containing the sequence and the corresponding levels 1 to 10.
# 4. Create a table `tab` that gives the number of appearance of each number in the sequence.
# 5. Create a vector `random_order` containing the numbers 1 to 10 in increasing number of appearance in `random_seq`.
# 6. Create a vector `top3` containing the 3 numbers appearing the most often in decreasing order.

## Do not modify this line! ## Write your code for 1. after this line! ##
set.seed(0)
seed <- .Random.seed
## Do not modify this line! ## Write your code for 2. after this line! ##
random_seq <- sample(10, 200, replace =TRUE)
## Do not modify this line! ## Write your code for 3. after this line! ##
random_factor <- factor(random_seq, levels = c(1:10))
## Do not modify this line! ## Write your code for 4. after this line! ##
tab <- table(random_factor)
## Do not modify this line! ## Write your code for 5. after this line! ##
random_order <- as.vector(names(sort(table(random_seq))), mode = "integer")
## Do not modify this line! ## Write your code for 6. after this line! ##
top3 <- random_order[10:8]