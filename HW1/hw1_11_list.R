# HW1: list6
#
# 1. Create a list `l1` consist of 26 components from 'a' to 'z'. (hint: check the variable letters)
# 2. Create a list `l2` consist of 26 components from 1 to 26.
# 3. Combine `l1` and `l2` to a new list `l3`. `l3` has 2 elements as `l1` and `l2`.
# 4. Combine `l1` and `l2` to a new list `l4`. `l4` has 52 elements as the elements of `l1` and `l2`.

## Do not modify this line! ## Write your code for 1. after this line! ##
l1 <- as.list(letters[1:26])
## Do not modify this line! ## Write your code for 2. after this line! ##
l2 <- as.list(1:26)
## Do not modify this line! ## Write your code for 3. after this line! ##
l3 <- list(l1, l2)
## Do not modify this line! ## Write your code for 4. after this line! ##
l4 <- as.list(c(l1,l2))