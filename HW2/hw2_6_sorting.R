# HW2: Sorting
#
# In this exercise, we will write a function to sort the input vector.
#
# 1. Use a `for` loop to go over the `qsec` column in `mtcars` dataset and assign to integer `n1` the position of the smallest number.
#    Note: if there are multiple smallest numbers, find the first occurrence.
# 2. Write a function `min_position(vec)` to return the position of the first occurrence of the smallest number. You should not use the `min` or `which` functions.
# 3. Write a function `my_sort(vec)` to return a sorted vector using the `min_position` function and a `while` loop. You should not use the `sort` or `order` functions.
# 4. Apply the `my_sort` function to the `qsec` column in `mtcars` dataset and store the sorted vector in `vec1`

## Do not modify this line! ## Write your code for 1. after this line! ##
mini <- mtcars$qsec[1]
n1 <- 1
for (i in 1L : nrow(mtcars)){
	if (mtcars$qsec[i] < mini){
		mini <- mtcars$qsec[i]
		n1 <- i
	}
}
## Do not modify this line! ## Write your code for 2. after this line! ##
min_position <- function(vec){
	mi <- vec[1]
	pos <- 1
	for (i in 1: length(vec)){
		if (vec[i] < mi){
			mi <- vec[i]
			pos <- i
		}
	}
	return(pos)
}
## Do not modify this line! ## Write your code for 3. after this line! ##
my_sort <- function(vec){
  i <- 1
  while(i <= length(vec)){
    minpos <- min_position(vec[i : length(vec)]) + i - 1
    vec[c(i, minpos)] <- vec[c(minpos, i)]
    i <- i+1
  }
  return(vec)
}
## Do not modify this line! ## Write your code for 4. after this line! ##
vec1 <- my_sort(mtcars$qsec)