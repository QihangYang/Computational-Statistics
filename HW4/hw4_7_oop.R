# HW4: Object Oriented Programming
#'
# In this exercise, we will create a class `shape` and a child class `rectangle`.
#'
# 1. Create a constructor `new_shape(x)` that takes in a string and instantiates
#    an object of class `shape` using `structure`. Don't forget to use `stopifnot` to check the input.
#    Create a helper function `shape(x)` that coerces the input
#    to a string with `as.character` and then calls the constructor.
## Do not modify this line!
new_shape <- function(x){
	stopifnot(is.character(x))
	structure(x, class = "shape")
}
shape <- function(x){
	x <- as.character(x)
	new_shape(x)
}


# 2. Write a new `print` method for class `shape` that prints `"My name is <shape>."` using the function `print`.
#    The `<shape>` should be substituted by the string in the instance of `shape`.
#    Make sure that the method returns the object invisibly by adding `invisible(x)` at the end.
#    Create an instance of `shape` called `s1` of shape `unknown` and then print `s1`.
## Do not modify this line!
print.shape <- function(x, ...){
	print(paste0("My name is ", x, "."))
	invisible(x)
}

s1 <- shape("unknown")
print.shape(s1)

# 3. Write a generic function called `area(x)` that does nothing. Don't forget to use `UseMethod`.
#    Write a default method `area` that prints `"My area is not defined."` using the function `print`.
#    Test this new method using instance `s1`.
## Do not modify this line!
area <- function(x){
	UseMethod("area")	
}
area.default <- function(x){
	print("My area is not defined.")
}
area.default(s1)




# 4. Create a constructor `new_rectangle(x, l, w)` that takes as input a string `x`,
#    and two numbers `l` and `w`, and instantiates an object `rectangle` of class `shape`.
#    Use the function `class()`. The constructor should give two attributes to `rectangle` :
#    `length`, equal to `l` and `width`, equal to `w`. Use `attr()` to create the attributes.
#    Use the line of code `rectangle <- function (x, l, w) new_rectangle(x, l, w)` to create a helper.
## Do not modify this line!
new_rectangle <- function(x, l, w){
	attr(x, "length") <- l
	attr(x, "width") <- w
	class(x) <- c("rectangle", "shape")
	x
}
rectangle <- function(x, l, w) new_rectangle(x, l, w)


# 5. Write a new method `area` for the class `rectangle` that prints `My area is <area>.` using `print`.
#    The `<area>` should be substituted by the area of a rectangle of length `length` and width `width`.
#    Use `attr()` to access these two parameters.
## Do not modify this line!
area.rectangle <- function(x){
	area <- attr(x, "length") * attr(x, "width")
	print(paste0("My area is ", area, "."))
}




# 6. Write a method `print` for the class `rectangle` that prints `"My name is <shape>.\nI am a rectangle."`
#    using `print.shape` and `print`. The `<shape>` should be substituted by the string in the instance of `rectangle`.
#    Make sure that the method returns the object invisibly by adding `invisible(x)` at the end.
## Do not modify this line!
print.rectangle <- function(x, ...){
	print.shape(x)
	print("I am a rectangle.")
	invisible(x)
}




# 7. Create an instance `r1` of `rectangle` with name `rect`, length 10, and width 5.
#    Call `area` and `print` method to instance `r1`.
## Do not modify this line!
r1 <- rectangle("rect", 10, 5)
area.rectangle(r1)
print.rectangle(r1)



