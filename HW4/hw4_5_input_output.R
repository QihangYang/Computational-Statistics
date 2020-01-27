# HW4: Input/Output
#'
# In this exercise, we will get familiar with the different types of outputs such as `print`, `sprintf`, `message`, etc.
#'
# 1. Compute the mean miles per gallon (`mpg`) from the `mtcars` data set and store it in a scalar `mean_mpg`.
#    Using the function `mean`. Use `format` to format the `mean_mpg` with 4 significant digits.
#    Store formatted value in scalar `formatted_mean`.
#    Write a function `my_print(x)` that uses the function `print()` to print `"The mean of mpg is <mean>."`.
#    Substitue `<mean>` by parameter `x` and uses the function `paste0`.
#    Note: There is no space between `<mean>` and period.
## Do not modify this line!
mean_mpg <- mean(mtcars$mpg)
formatted_mean <- format(mean_mpg, digits = 4)
my_print <- function(x){
	print(paste0("The mean of mpg is ", x, "."))
}
my_print(formatted_mean)


# 2. Set the random seed to zero and save the random seed vector to `seed`. (hint: use the command `seed <- .Random.seed`)
#    Use `sample` to sample 5 integers from 1 to 30 without replacement. Store the samples in `my_sample`.
#    Use the samples in `my_sample` as indices and change the according values in mpg column to `NA`.
#    Store the modified data in vector `my_mpg`.
#    Write a function `my_print2(x)` to use `print` to print the vector with 3 digits and replace `NA` by `N/A`.
#    (Hint : lookup `na.print`).
## Do not modify this line!
set.seed(0)
seed <- .Random.seed
my_sample <- sample(1:30, size = 5, replace = FALSE)
my_mpg <- mtcars$mpg
my_mpg[my_sample] <- NA
my_print2 <- function(x){
	print(x, digit = 3, na.print = "N/A")
}


# 3. Write a function `wake_up(hour, minute, AMPM)` that takes in two integers `hour` and `minute`,
#    a string `AMPM` and returns a string `"I wake up at <hour>:<minute> <AMPM>."` using `sprintf`.
#    Note: Make sure `<hour>` and `<minute>` have 2 significant digits.
## Do not modify this line!
wake_up <- function(hour, minute, AMPM){
	sprintf("I wake up at %02i:%02i %s.", hour, minute, AMPM)
}



# 4. Write a function `convert(x)` that converts the string `x` into numeric values and returns the converted values.
#    Note: If the type of input is not character, use `stop()` to cast an error message: `Input is not character.`.
#          After converting the input to its corresponding numerical value,
#          the function should print the message `Converted successfully.`.
#          Use the functions `message()` and `as.numeric`.
#          You can assume the input will always be convertible.
## Do not modify this line!
convert <- function(x){
	if(!is.character(x))
		stop("Input is not character.")
	message("Converted successfully.")
	return(as.numeric(x))
}


# 5. Load the `readr` package.
#    Use the function `write_csv()` to write `mtcars` data set into a .csv file called `mtcars.csv`.
#    Use `read_csv` to read the `mtcars.csv` and store the data in data frame `my_mtcars`.
## Do not modify this line!
library(readr)
write_csv(mtcars, path = "mtcars.csv")
my_mtcars <- read_csv("mtcars.csv")




