# HW2: function
#
# 1. Create a function `f` that takes two positive integers `m` and `n` as input,
#    output a named list including the quotient `q` and the reminder `r`, such that `m = qn + r` if `m` is greater than `n`,
#    or `n = qm +r` if `n` is greater than `m`.
# 2. Create a function `gcd` that takes two positive integers `m` and `n` as input,
#    output their greatest common divisor. The function must include a `while` loop (hint: use Euclid algorithm).
# 3. Create a function `co_prime` that takes two positive integers `m` and `n` as input,
#    and output whether they are coprime numbers or not, return `TRUE` if they are coprime,
#    return `FALSE` if they have common divisors. For example: `co_prime(3,6) = FALSE`, `co_prime(20,9) = TRUE`
#    (hint: use the function defined previously).
# 4. Create a function `lcm` that takes two positive integers `m` and `n` as input,
#    output their lowest common multiple. (hint: use the function defined previously).

## Do not modify this line! ## Write your code for 1. after this line! ##
f <- function(m, n){
	minn <- min(m, n)
	maxx <- max(m, n)
	q <- floor(maxx / minn)
 	r <- maxx - q * minn
	res <- list(
		q = q,
		r = r
	)
	return(res)
}
## Do not modify this line! ## Write your code for 2. after this line! ##
gcd <- function(m, n){
	while(f(m,n)$r != 0){
		return(gcd(min(m,n), f(m,n)$r))
	}
	return(min(m,n))
}
## Do not modify this line! ## Write your code for 3. after this line! ##
co_prime <- function(m, n){
	if (gcd(m, n) == 1)
		return(TRUE)
	else
		return(FALSE)
}
## Do not modify this line! ## Write your code for 4. after this line! ##
lcm <- function(m, n){
	return(m * n / gcd(m,n))
}