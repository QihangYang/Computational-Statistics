# HW2: Choice
#
# Instructions:
# Create a function to do unit conversion between lb and kg. The function should have two arguments,
# `mass` (first) and `unit` (second), where `mass` is a number and `unit` is a string in `"kg"`, `"lb"`.
# Do not change the name and position of these two parameters.
# For the purpose of exercise, 1 lb = 0.45 kg.
# For example, the output of calling the function with `mass = 20, unit = "lb"` should be `20 * 0.45 = 9`,
#              the output of `mass = 45, unit = "kg"` should be `45 / 0.45 = 100`.
#
# Problem:
# 1. Write a function `f1` with such property using `if`,`else`.
# 2. Write a function `f2` similar to `f1` but will raise `"Invalid Unit Error"`if neither `"kg", "lb"` is given (hint: look up the function `stop()`).
# For example, the error message will be the following if `f2(15, "meter")` is inputed:
# `Error in f2(15, "meter") : Invalid Unit`
# 3. Write a function `f3` similar to `f2` but will raise `"Negative Mass Error"` if the `mass` is negative.
# The negative mass error should be prior to the invalid unit error.
# For instance, the error message will be the following if `f3(-3, "kg")` is inputed:
# `Error in f3(-3, "kg") : Negative Mass Error`
# Similarly, the error message will be the following if `f3(-3, "bananas")` is inputed:
# `Error in f3(-3, "bananas") : Negative Mass Error`

## Do not modify this line! ## Write your code for 1. after this line! ##
f1 <- function(mass, unit){
	if (unit == "kg"){
		return(mass/0.45)
	}
	else if (unit == "lb"){
		return(mass*0.45)
	}
}
## Do not modify this line! ## Write your code for 2. after this line! ##
f2 <- function(mass, unit){
	if (unit == "kg"){
		return(mass/0.45)
	}
	else if (unit == "lb"){
		return(mass*0.45)
	}
	else{
		stop("Invalid Unit Error")
	}
}
## Do not modify this line! ## Write your code for 3. after this line! ##
f3 <- function(mass, unit){
	if (mass < 0){
		stop ("Negative Mass Error")
	}
	if (unit == "kg"){
		return(mass/0.45)
	}
	else if (unit == "lb"){
		return(mass*0.45)
	}
	else{
		stop ("Invalid Unit Error")
	}
}