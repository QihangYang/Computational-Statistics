# HW4: oop weight
#'
# In this exercise, we will create a class `weight`.
#'
# 1. Create a constructor `new_weight(x = double(), units = "kg")` that:
#       - takes in a double `x` of length one,
#       - a `units` attribute,
#       - and initiates an object of class `weight` using `structure`.
#    Don't forget to use `stopifnot` to check that `x` has the correct type and length.
#    Because `units` might include `"lbs"` and `"kg"`, use `match.arg` to check the
#    validy of the second argument.
## Do not modify this line!
new_weight <- function(x = double(), units = "kg"){
	stopifnot(is.double(x) & length(x) == 1)
	match.arg(units, c("lbs", "kg"))
	structure(x, class = "weight", "units" = units)
}


# 2. Create a helper function `weight` for `new_weight`,
#    which will convert `x` into a double using `as.double`.
## Do not modify this line!
weight <- function(x, units){
	x <- as.double(x)
	new_weight(x, units)
}


# 3. Write a new `print` method for class `weight` that prints
#    `"The weight is <weight> <units>"` using `print`.
#    The `print` method should return the input invisibly.
#    Create an instance of `weight` called `d1` using `x = 50`,
#    `units = "lbs"` and then print `d1`.
## Do not modify this line!
print.weight <- function(x, ...){
	print(paste0("The weight is ",x , " ", attr(x,"units")))
	invisible(x)
}
d1 <- weight(x = 50, units = "lbs")
print.weight(d1)



# 4. Write a generic function called `convert(x)` :
#    If the units of `x` is `"lbs"`, it should return a weight object using `weight()`
#    corresponding to `x` converted to `"kg"`.
#    If the units of `x` is `"kg"`, it should return a weight object using `weight()`
#    corresponding to `x` converted to `"lbs"`.
#    For this exercise, assume that 1 kilogram corresponds to 2.2 pounds.
#    Call this new method to instance `d1`, save the return object into `d2`.
## Do not modify this line!
convert <- function(x){
	UseMethod("convert")
}
convert.weight <- function(x){
	if (attr(x, "units") == "lbs")
		return(weight(x/2.2, "kg"))
	else if (attr(x, "units") == "kg")
		return(weight(x*2.2, "lbs"))
}
d2 <- convert.weight(d1)



# 5. Write a `+` method for the `weight` class.
#    Note that arithmetic operators take two arguments: `x` and `y`.
#    Assume that the return units is the unit of `x`.
#    In other words, if `x` is in `"kg"`, then `x + y` should be an object of class
#    weight in `"kg"`. Take care of this by converting `y` to the right units if
#    necessary.
#    In this exercise, after `y` as been converted if necessary,
#    you should NOT use `unclass()`. Instead, delegate the work to the `+`
#    operators of the base type (`double`) using `NextMethod("+")`.
#'
## Do not modify this line!
`+.weight` <- function(x, y){
	if (attr(y, "units") != attr(x, "units"))
		y <- convert.weight(y)
	z <- weight(x+y, attr(x, "units"))
	return(z)
}
`+.weight` <- function(x, y){
	NextMethod("+")
}


