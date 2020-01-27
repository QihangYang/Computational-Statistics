# HW1: array5
#
# 1. Create a 10 x 10 matrix `m1` such that the i-th row j-th column element is the max(i,j).
# 2. Create a 10 x 10 matrix `m2` such that the i-th row j-th column element is the min(i,j).
# 3. Combine `m1` as the first slice and `m2` as the second slice to a 10 x 10 x 2 array `a1`.
# 4. Turn the array `a1` into a 10 x 2 matrix `m3` by summing over the second dimension.
#   (hint: you can calculate directly from `m1` and `m2` or use the function apply)

## Do not modify this line! ## Write your code for 1. after this line! ##
m1 <- matrix(0, nrow = 10, ncol = 10)
for (i in 1:10){
	for(j in 1:10){
		m1[i,j] <- max(i,j)
	}
}
## Do not modify this line! ## Write your code for 2. after this line! ##
m2 <- matrix(0, nrow = 10, ncol = 10)
for (i in 1:10){
	for(j in 1:10){
		m2[i,j] <- min(i,j)
	}
}
## Do not modify this line! ## Write your code for 3. after this line! ##
a1 <- array(0, c(10,10,2))
a1[,,1] <- m1
a1[,,2] <- m2
## Do not modify this line! ## Write your code for 4. after this line! ##
m3 <- matrix(0, nrow = 10, ncol = 2)
for (i in 1: 10){
	m3[i,1] <- sum(m1[i,])
	m3[i,2] <- sum(m2[i,])
}