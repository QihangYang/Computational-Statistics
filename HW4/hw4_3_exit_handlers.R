# HW4: Exit handlers
#'
# 1. Write a function `print_row` that takes a data.frame `df` and an integer
# `row` and prints the corresponding row of `df`.
# Use `capture.output` and `print_row` to assign the printed first row of the
# data.frame `mtcars` to the variable `first_row`.
## Do not modify this line!
print_row <- function(df, row){
	print(mtcars[row, ])
}
first_row <- capture.output(print_row(mtcars, 1))



# 2. Implement your own `capture.output2` that takes as arguments `code` and
# `file`, a piece of R code and a file path (string) respectively.
# Use `sink()` to divert the output to the file at path `file`.
# Use an exit handler to reset the default output using `on.exit()` and
# `sink()` (don't pass any argument to `sink()` here). Make sure you set
# arguments `add` and `after` to `TRUE`.
# Your function should also force the code execution (use `force()`) and read
# the file at `file` before exiting (using `readLines()`).
## Do not modify this line!
capture.output2 <- function(code, file){
	sink(file, type = "output")
	on.exit(sink(), add = TRUE, after = TRUE)

	force(code)
	readLines(file)
}	




# 3. Now write a function `capture.output3` that only takes in one argument
# `code`. Your function should create a temp file using `tempfile()` - and make
# sure the file is removed upon exiting the function call using `on.exit` and
# `file.remove`. Use `sink()` to divert the output to this file - and make sure
# you reset the default output upon exiting using `on.exit`. Then force the
# `code` execution and read the temp file.
# Make sure you set arguments `add` and `after` to `TRUE` of your `on.exit`
# calls.
## Do not modify this line!
capture.output3 <- function(code){
	file <- tempfile()
	sink(file, type = "output")
	on.exit(sink(), add = TRUE, after = TRUE)
	on.exit(file.remove(file), add = TRUE, after = TRUE)
	
	force(code)
	readLines(file)	
}


# 4. Write a function `capture.output4` that takes as inputs `code` and `file`
# (`file`'s default value should be set to `NULL`).
# Your function should check if `file` is `NULL`: if yes, assign a new tempfile
# to variable `temp` and if not assign the non-null `file` to `temp` - make
# sure to remove the file when exiting if a tempfile was created.
# Then it should implement the same functionality as before:
# - divert the output to `temp` using `sink()`,
# - force the `code` execution using `force()`
# - read the file using `readLines()`
# Make sure to re-divert the default output upon exiting using `sink()` with
# no argument.
#'
## Do not modify this line!
capture.output4 <- function(code, file = NULL){
	if (is.null(file)){
		file <- tempfile()
		on.exit(file.remove(file), add = TRUE, after = TRUE)
	}
	sink(file, type = "output")
	on.exit(sink(), add = TRUE, after = TRUE)

	force(code)
	readLines(file)

}



