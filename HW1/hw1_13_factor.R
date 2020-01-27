# HW1: factor8
#
# 1. Create an ordered factor `f1` consist of letters 'a' to 'z' ordered alphabetically.
# 2. Create an ordered factor `f2` consist of letters 'a' to 'z' in descending alphabetical order.
# 3. Create a 30 elements, ordered factor `f3` consist of letters 'a' to 'z' followed by 4 NA. The order of `f3` is 'a'<...<'z'<NA.
# 4. Delete the element 'c' with the level 'c' and assign it to `f4`.

## Do not modify this line! ## Write your code for 1. after this line! ##
f1 <- factor(letters[1:26], order = TRUE)
## Do not modify this line! ## Write your code for 2. after this line! ##
f2 <- factor(letters[1:26], levels = letters[26:1], order = TRUE)
## Do not modify this line! ## Write your code for 3. after this line! ##
f3 <- factor(c(letters[1:26], NA, NA, NA, NA), order = TRUE)
f3 <- addNA(f3)
## Do not modify this line! ## Write your code for 4. after this line! ##
f4 <- factor(f3[-3], levels = levels(f3)[-3])
f4 <- addNA(f4)