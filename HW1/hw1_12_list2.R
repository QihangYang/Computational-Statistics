# HW1: list7
#
# 1. Create a list `l1` consist of 52 components from 'a' to 'z' and 'A' to 'Z'. (hint: check variables letters and LETTERS)
# 2. Convert the list `l1` into a 13 x 4 matrix `l2` filling by column.
# 3. Convert the list `l1` into a vector `x1`.
# 4. Convert the list `l1` into an atomic vector `x2`. (hint: `x1` should be different with `x2`)

## Do not modify this line! ## Write your code for 1. after this line! ##
l1 <- as.list(c(letters[1:26], LETTERS[1:26]))
## Do not modify this line! ## Write your code for 2. after this line! ##
l2 <- matrix(l1, nrow = 13, ncol = 4)
## Do not modify this line! ## Write your code for 3. after this line! ##
x1 <- as.vector(l1)
## Do not modify this line! ## Write your code for 4. after this line! ##
x2 <- as.vector(l1, mode ="character")