# HW4: Author and Book OOP
#'
# In this exercise we will create an `author` class to model a book's author.
#'
# 1. Create a constructor `new_author` for an `author` class to model a book's
# author.
# It should take as input two strings: `name`, `email`.
# It should check that the inputs are both strings (using `stopifnot`).
# Also check that the `email` contains a `@` sign (using `stopifnot` and
# `grepl`).
# The constructor should then create a named list with the two strings (first
# element is the name - called `"name"` and second element is the email -
# called `"email"`) and use `structure` with this list to create an object of
# class `author`.
## Do not modify this line!
new_author <- function(name, email){
	stopifnot(is.character(name))
	stopifnot(is.character(email))
	stopifnot(grepl("@", email))
	list <- list("name" = name, "email" = email)
	structure(list, class = "author")
}



# 2. Create a helper `author` that wraps `new_author`. It should have default
# values for `name` (`"John Doe"`) and `email` (`"unknown@unknown"``), return
# an error if the length of the arguments is not 1 and cast them to characters
# before calling `new_author` using `as.character`.
# Create an author object using the `author` helper with name `Susan Barker`
# and email `susan.barker@mail.com` and store it in variable `author_example`.
## Do not modify this line!
author <- function(name = "John Doe", email = "unknown@unknown"){
	stopifnot(length(name) == 1)
	stopifnot(length(email) == 1)
	name <- as.character(name)
	email <- as.character(email)
	new_author(name, email)
}
author_example <- author("Susan Barker", "susan.barker@mail.com")



# 3. Create 2 functions `get_name` and `get_email` which take an `author`
# object named `author_object` as input: `get_name` should return the name
# of the author, `get_email` should return the email address of the author.
# Then, create a generic `change_email` which takes an `author` object named
# `author_object` along with a string `email` as inputs. Implement the method
# for objects of the class author (i.e., write `change_email.author`) so that
# the method returns a new `author` object with the name of the input `author_object`
# and the input email address.
## Do not modify this line!
get_name <- function(author_object){
	author_object$name
}
get_email <- function(author_object){
	author_object$email
}
change_email <- function(author_object, email){
	UseMethod("change_email")
}
change_email.author <- function(author_object, email){
	return(author(get_name(author_object), email))
}



# 4. Change the email address of `author_example` to `s.barker@mail.com`
## Do not modify this line!
author_example <- change_email.author(author_example, "s.barker@mail.com")


# 5. Create a method `print.author` that prints the string
# `"Author <name>, e-mail: <email>"` where `<name>` and `<email>` are the
# strings corresponding to name and email of the `author` object. You should
# use the functions `print` and `paste0` to do so. Note that:
#    - the arguments of print are `x` and `...`, but `...` won't be used
#    in the body of `print.author`,
#    - print.author` method should return the first argument invisibly.
#'
## Do not modify this line!
print.author <- function(x, ...){
	print(paste0("Author ", x$name, ", e-mail: ", x$email))
	invisible(x)
}


