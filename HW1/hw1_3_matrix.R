# HW1: matrix2
#
# 1. Create a 10 x 10 matrix `m1` whose i-th row,j-th column element is (i+1)/(j+1). (hint: check the `outer`` function)
# 2. Copy `m1` into a matrix `m2` and replace the non-integer value by 0.
# 3. Flatten the matrix `m2` row-vise and assign it to `v1`.
# 4. Copy `v1` to `v2`, remove the duplicated value and sort it in decreasing order. (hint: check the `unique` function)

## Do not modify this line! ## Write your code for 1. after this line! ##
i <- 1:10
j <- 1:10
m1 <- outer(i+1, j+1, '/')
## Do not modify this line! ## Write your code for 2. after this line! ##
m2 <- m1
for (i in 1:10){
	for (j in 1:10){
		if(m2[i,j] %% 1 != 0)
			m2[i,j] <- 0
	}
}
## Do not modify this line! ## Write your code for 3. after this line! ##
v1 <- t(m2)[1:100]
## Do not modify this line! ## Write your code for 4. after this line! ##
v2 <- sort(unique(v1), decreasing = TRUE)
