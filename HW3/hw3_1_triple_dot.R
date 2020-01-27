#' HW2: triple_dot
#'
#' This exercise is to help you understand `...` arguments in function (Advanced R Ch6.6).
#'
#' 1. Create a function `f1` with an argument arg so that `f1(name)` will print some fixed message followed by the content of `name`.
#' For instance, `f1(name = "Bob")` will print
#' Hello Bob!
#' Notes: punctuation mark after the name(Bob here).
#' Hint: try `cat()`and`paste0(xxx,"!\n")`.
#'
## Do not modify this line!
f1 <- function(name){
	cat(paste0("Hello ", name, "!\n"))
}


#' 2. Create a function `f2(places)` so that the result of `f2(place)` are the following:
#' `f2("Columbia")` will output
#' From Columbia
#' `f2(c("Columbia", "MIT"))` will output
#' From Columbia and MIT
#' `f2(c("Columbia", "MIT", "Harvard"))` will output
#' From Columbia, MIT and Harvard
#' `f2(c("Columbia", "MIT", "Harvard", "Berkeley"))` will output
#' From Columbia, MIT, Harvard and Berkeley
#' Notes:
#' 1) Take care of the space ' ' and comma ','.
#' 2) The length of input will exceed 4.
#' Hints:
#' 1) You need to consider the length of `places` (1, 2, >=3).
#' 2) If `msg = 'From'` then try something like `msg <- paste0(msg, collapse = ", ")` of course, you need some modification :).
#' 3) You can retrieve `'MIT'` like `places[2]` if `places = c("Columbia", "MIT", "Harvard", "Berkeley")`.
#'
#'
## Do not modify this line!
f2 <- function(places){
	res <- "From "
	if (length(places) == 1){
		res <- paste0(res, places)
	}
	else if (length(places) == 2){
		res <- paste0(res, places[1], " and ", places[2])
	}
	else{
		res <- paste0(res, places[1])
		for (i in 2: (length(places) - 1)){
			res <- paste0(res, ", ", places[i], collapse = ",")
		}
		res <- paste0(res, " and ", places[length(places)])
	}
	cat(res)
}


#' 3. Create a function `f3` with `...` argument,i.e.`f3(...)` , so that
#' `f3()` will output nothing while `f3(places)` is the same as `f2(places)`.
#' Hint: try `mising(...)` and `unlist(list(...))`.
#'
## Do not modify this line!
f3 <- function(...){
	if (!missing(...))
		f2(...)
}


#' 4.Let's combine everything together.
#' Create `f4(name, ...)` so that
#' `f4("Bob")` will print the same is `f1("Bob")`
#' `f4(name, places)` will print have two lines' output
#' The first line will be the same as `f1("Bob")`
#' The second line will be the same as `f3(places)`
#' For example
#' `f4("Bob", "Columbia", "MIT", "Berkeley")`
#' Hello Bob!
#' From Columbia, MIT and Berkeley
#' Hint: try to make use of the functions you made above.
#'
## Do not modify this line!
f4 <- function(name, ...){
	f1(name)
	if (!missing(...)){
		f2(...)
	}
}


