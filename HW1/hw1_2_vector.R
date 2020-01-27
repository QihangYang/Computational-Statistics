# HW 1: vector1
#
# 1. Create a vector `v1` that will contain integers from -30 to 60.
# 2. Copy `v1` into a vector `v2` and add names 'odd' or 'even' based on the value.
# 3. Copy `v1` into a vector `v3` and if the number can be divided by 3, replace it by 'NA'.
# 4. Assign the mean of `v3` to `v4` ignoring the 'NA'.

## Do not modify this line! ## Write your code for 1. after this line! ##
v1 <- -30L:60L
## Do not modify this line! ## Write your code for 2. after this line! ##
v2 <- v1
for (i in 1:length(v1)){
	if (v2[i] %% 2 == 0)
		names(v2)[i] <- c("even")
	else
		names(v2)[i] <- c("odd")
}
## Do not modify this line! ## Write your code for 3. after this line! ##
v3 <- v1
for (i in 1:length(v1)){
	if(v3[i] %% 3 == 0)
		v3[i] <- NA
}
## Do not modify this line! ## Write your code for 4. after this line! ##
v4 <- mean(v3, na.rm = TRUE)