#' HW3: Bisection.
#'
#' In this exercise, you will implement a functional on your own: a root-finding algorithm called the bisection method.
#' For details, check the wikipedia page for 'Bisection Method': https://en.wikipedia.org/wiki/Bisection_method
#'
#' 1. Implement the bisection method using iteration and the scaffold given below.
#'    Argument `f` is the function of which we want to find the root.
#'    Argument `a` and `b` are two evaluated points.
#'    Argument `n` is the max number of iterations.
#'    Argument `tol` is the desired tolerence.
## Do not modify this line!

bisection <- function(f, a, b, n = 1000, tol = 1e-7) {
  for (i in 1:n) {
    # Calculate midpoint
    mid <- (a + b) / 2
    # If the function equals 0 at the midpoint or the midpoint is below the desired tolerance, stop the
    # function and return the root.
    if (f(mid) == 0 | (b - a) / 2 < tol)
      return(mid)
    # If another iteration is required,
    # check the signs of the function at the points c and a and reassign
    # a or b accordingly as the midpoint to be used in the next iteration.
    else{
      if (sign(f(mid)) == sign(f(a)))
        a <- mid
      else
        b <- mid
      next
    }
  }
}

#' 2. Modify the function `bisection` such that if the signs of the function at the evaluated points are the same, throw an error with message
#'    `"The signs of f evaluated at the endpoints are the same."`.
#'    Also if the max number of iterations is reached and no root has been found, throw an error with message `"Max number of iterations reached."`.
## Do not modify this line!

bisection <- function(f, a, b, n = 1000, tol = 1e-7) {
  # If the signs of the function at the evaluated points, a and b, are the same, throw an error.
  if (sign(f(a)) == sign(f(b)))
    stop("The signs of f evaluated at the endpoints are the same.")
  for (i in 1:n) {
    # Calculate midpoint
    mid <- (a + b) / 2
    # If the function equals 0 at the midpoint or the midpoint is below the desired tolerance, stop the
    # function and return the root.
    if (f(mid) == 0 | (b - a) / 2 < tol)
      return(mid)
    # If another iteration is required,
    # check the signs of the function at the points c and a and reassign
    # a or b accordingly as the midpoint to be used in the next iteration.
    else{
      if (sign(f(mid)) == sign(f(a)))
        a <- mid
      else
        b <- mid
      next
    }
  }
  # If the max number of iterations is reached and no root has been found, throw an error.
  if (i == n)
    stop("Max number of iterations reached.")
}




