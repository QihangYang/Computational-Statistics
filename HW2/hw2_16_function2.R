# HW2: function2
#
# 1. Create a function `f1` that takes an input vector `v` and an integer `a`, and returns `TRUE` if `a` appears in `v`, otherwise `FALSE`.
#    The answer should include a `for` loop.
# 2. Create a function `f2` that takes an input vector `v` and an integer `a`, and returns how many times `a` appears in `v`,
#    if `a` does not appear in `v`, return `0`. The answer should include a `for` loop.
# 3. Create a function `f3` that takes an input vector `v` and an integer `a`, and returns where does `a` appear in `v`.
#    For example `f3(v = c(1,1,2,3,1,5), a = 1) = c(1,2,5)`. if `a` does not appear in `v`, return `NULL`. The answer should include a `for` loop.
# 4. Create a function `f4` that takes an input vector `v` and an integer `a`, and returns the `TRUE` if there are two numbers in `v` sum up to `a`, otherwise `FALSE`.
#    For example, `f4(v = c(1,4,9,5,15), a = 10) = TRUE`, because `1 + 9 = 10`. The answer should include a `for` loop.

## Do not modify this line! ## Write your code for 1. after this line! ##
f1 <- function(v, a){
	flag <- 0
	for (i in 1: length(v))
		if (v[i] == a)
			flag <- 1
	if (flag == 1)
		return(TRUE)
	else
		return(FALSE)
}
## Do not modify this line! ## Write your code for 2. after this line! ##
f2 <- function(v,a){
	num <- 0
	for (i in 1: length(v))
		if (v[i] == a)
			num <- num+1
	return(num)
}
## Do not modify this line! ## Write your code for 3. after this line! ##
f3 <- function(v, a){
	if (f1(v, a)){
		pos <- c();
		for (i in 1: length(v))
			if (v[i] == a)
				pos <- c(pos, i)
		return(pos)
	}
	else
		return(NULL)

}
## Do not modify this line! ## Write your code for 4. after this line! ##
f4 <- function(v, a){
	flag <- 0
	for (i in 1: length(v))
		for (j in 1: length(v))
			if (v[i] + v[j] == a)
				flag <- 1
	if (flag == 1)
		return(TRUE)
	else
		return(FALSE)
}