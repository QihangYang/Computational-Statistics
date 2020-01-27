# HW1: tibble4
#
# 1. Consider the data frame `airquality`. Convert it into a tibble `t1`.
# 2. Calculate the total number of 'NA' for each variable and summarize it into a vector `v1`.
#    Make sure the vector has the same names as the column names of `t1`.
# 3. Omit all rows which have 'NA' values and assign it to `t2`.
# 4. Sort the new data frame `t2` by column Temp(ascending) and then by column Ozone(ascending). Assign it to `t3`.(hint: check the order function)

## Do not modify this line! ## Write your code for 1. after this line! ##
library(tibble)
t1 <- as_tibble(airquality)
## Do not modify this line! ## Write your code for 2. after this line! ##
v1 <- vector(length = ncol(t1))
for (i in 1: ncol(t1)){
	v1[i] <- sum(is.na(t1[,i]))
}
names(v1) <- names(t1)
## Do not modify this line! ## Write your code for 3. after this line! 
t2 <- na.omit(t1)
## Do not modify this line! ## Write your code for 4. after this line! ##
t3 <- t2[order(t2$Temp, t2$Ozone),]
