#' HW3: Map Reduce
#'
#' In this exercise, we will use `map-reduce` to efficiently calculate means of large vectors from the `MplsStops` dataset, contained in
#' the package `carData`. The `MplsStops` dataset records all stops made by the Minneapolis Police Department for the year 2017.
#' It contains 51857 observations with 14 variables.(Docs: https://vincentarelbundock.github.io/Rdatasets/doc/carData/MplsStops.html).
#'
#'
#' 1. Load the packages `carData` and `purrr`. Select all the numeric columns from `MplsStops` dataset and store them in a variable `mpls_num`.
#'    (Hint: use the `keep(.x, .p)` function to select the correponding columns from dataset `.x` that satisfies the contraints defined in `.f`).
## Do not modify this line!
library(carData)
library(purrr)
mpls_num <- keep(MplsStops, is.numeric)


#' 2. Calculate the mean of each column and store them in a list `mpls_mean`. (Hint: Use `map_dbl()` and `mean()`.)
#'    Calculate the time it takes to calculate the mean and store it in a variable called `time1`.
#'    (Hint: use `Sys.time()` to calculate the current system time. Create a variable `startime` to store the system time before the
#'    calculation and a variable 'endtime' after the calculation. The duration of the calculation is `endtime-startime`.)
## Do not modify this line!
startime <- Sys.time()
mpls_mean <- map_dbl(mpls_num, mean)
endtime <- Sys.time()
time1 <- endtime - startime


#' 3. Use `reduce()` to calculate the mean of `mpls_mean`(which is the overall mean of the three columns `lat`, `long` and `policePrecinct`)
#'    and store the result in `mpls_reduce`. (Hint: `reduce(x, f)` conducts an operation `f` on all the elements in the vector `x`.
#'    You can use `reduce` to calculate the sum of `mpls_mean` and then calculate the mean by dividing by the length.)
## Do not modify this line!
mpls_reduce <- reduce(mpls_mean, sum) / length(mpls_mean)


#' 4. Use a `for` loop to manually calculate the overall mean of the three columns `lat`, `long` and `policePrecinct` and store the
#'    result in a variable `naive_calculation` (it should be the mean of the three colums, not the mean of each column).
#'    Do NOT use the function `mean()`.
#'    Store the calculation time in variable `time2`(Hint: calculate the OVERALL mean of the three columns, not columnwise mean.
#'    Calulation time can be calculated in same way as question 2).
## Do not modify this line!
startime <- Sys.time()
mpls_sum <- 0
for (i in 1 : nrow(mpls_num)){
	for (j in 1 : ncol(mpls_num)){
		mpls_sum <- mpls_sum + mpls_num[i,j]
	}
}
naive_calculation <- mpls_sum / (nrow(mpls_num) * ncol(mpls_num))
endtime <- Sys.time()
time2 <- endtime - startime


